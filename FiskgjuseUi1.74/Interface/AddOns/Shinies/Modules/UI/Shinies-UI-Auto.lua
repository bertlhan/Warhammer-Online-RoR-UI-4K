--[[
	This application is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    The applications is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with the applications.  If not, see <http://www.gnu.org/licenses/>.
--]]

local LibGUI 			= LibStub( "LibGUI" )
if LibGUI == nil then return end

local towstring 		= towstring
local Shinies 			= _G.Shinies
local T		    		= Shinies.T
local MODNAME 			= "Shinies-UI-Auto"
local ShiniesAutoUI 	= Shinies : NewModule( MODNAME, "WAR-AceTimer-3.0" )
_G.ShiniesAutoUI 		= ShiniesAutoUI
ShiniesAutoUI:SetModuleType( "UI" )
ShiniesAutoUI:SetName( T["Shinies Auto UI"] )
ShiniesAutoUI:SetDescription(T["Provides a user interface for automatically posting auctions based upon item inventory."])
ShiniesAutoUI:SetDefaults( 
{
	factionrealm = {
		autos 		= 
		{
			["**"] =
			{
				default 			= true,
				enabled				= false,
				itemData			= {},
				priceMod			= "",
				price				= 0,
				minInventory		= 0,
				minModPrice			= 0,
				stackSize			= 0,
			},
		},
		throttle 	= 1,
	},
} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )
local ShiniesConstants 	= ShiniesConstants

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local SPA

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local string_format 		= string.format
local string_len			= string.len
local wstring_format		= wstring.format
local wstring_gsub			= wstring.gsub
local math_floor			= math.floor
local math_min				= math.min

local config	= {
	name			= T["Auto"],
	windowId		= "ShiniesAutoUI",
}

local window

local windowControl			= config.windowId .. "_Control"
local windowItem			= config.windowId .. "_Item"
local windowAuto			= config.windowId .. "_Auto"

local windowList			= windowAuto .. "List"
local windowSummary			= windowAuto .. "Summary"

local summaryLog			= "ShiniesAutoUISummary"

local uiInitialized		= false
local isRunning			= false

local InitializeUI, UninitializeUI, InitializeControlUI, InitializeItemUI
local AddKeyTabWindow, BuildPriceModuleCombo, InitializeListUI, OnKeyTab
local ShowAutoItems, DisplayItem, SaveItem, SetActiveItem, GetActiveItem
local GeneratePricingDescription, GetSlotRowNumForAutoRow, GenerateAutoListItem
local ExecuteAuto, ToggleListSummaryDisplay

local activeItem			= nil
local tooltipWindow 		= nil

local priceModuleLookup		= new()
local priceModuleRevLookup	= new()

local MAX_VISIBLE_ROWS 			= 5
local displayOrder				= new()
ShiniesAutoUI.listDisplayData 	= new()

local autoItems
local autoItemsCount		= 0

local activeAutoQueryId 	= 0
local activeAutoCreateId	= 0
local activeResults			= nil
local activeAuto			= nil
local activeAutoCount		= nil

local function indent()
	return L"    "
end

function ShiniesAutoUI:GetUserInterface()
	return config
end

function ShiniesAutoUI.Macro_StartAuto()
	self = ShiniesAutoUI
	self:StartAuto()
end

function ShiniesAutoUI.Macro_StopAuto()
	self = ShiniesAutoUI
	self:StopAuto()
end

function ShiniesAutoUI:OnAuctionCreateFailure( eventName, identifier, auction, results, failure )
	Shinies:Debug( failure )
	if( activeAutoCreateId == identifier) then
		activeAutoCreateId = 0
	end
end

function ShiniesAutoUI:OnAuctionCreateSuccess( eventName, identifier, auction )
	if( activeAutoCreateId == identifier ) then
		activeAutoCreateId = 0
   	end
end

function ShiniesAutoUI:OnAuctionHouseAvailabilityChanged( eventName, serverAvailable )
	-- If the server is no longer available and we are running stop
	if( not serverAvailable and isRunning ) then
		self:StopAuto()
	end
	
	-- Update the enabled status on the start button
	window.Control.E.Start_Button:SetEnabled( serverAvailable )
end

function ShiniesAutoUI:OnAuctionQueryFailure( eventName, identifier, query, results, failure )
	if( activeAutoQueryId == identifier ) then
		activeAutoQueryId = 0
	end
end

function ShiniesAutoUI:OnAuctionQuerySuccess( eventName, identifier, query, results )
	-- Make sure the results are for the query we more recently executed
	if( activeAutoQueryId == identifier ) then
		-- Reset our query ID
    	activeAutoQueryId = 0
    	
    	activeResults = new()
    	
    	for k, v in pairs( results )
		do
			if( v.itemData.uniqueID == activeAuto.itemData.uniqueID ) then
				tinsert( activeResults, v )
			end
		end
		
		TextLogAddEntry( summaryLog, 1, wstring_format( T["Valid results received:  %d"], #activeReults ) )
    end
end

function ShiniesAutoUI:OnAutoTimer()
	-- If there is an outstanding creation, do nothing this iteration
	if( activeAutoCreateId > 0 ) then return end
	
	-- If there is an outstanding query, do nothing this iteration
	if( activeAutoQueryId > 0 ) then return end
	
	-- If there are active results, process the auto that requires them
	if( activeAuto ~= nil and activeAutoCount ~= nil and activeResults ~= nil ) then
		-- Process the auto
		ExecuteAuto( activeAuto, activeAutoCount, activeResults )
		
		-- Clear all of our active information
		activeAuto = nil
		activeAutoCount = nil
		activeResults = del( activeResults )
		
		return
	end
	
	-- Only if there is no current auto and auto count process the next auto
	if( activeAuto == nil and activeAutoCount == nil ) then
		self:ProcessNextAuto()
	end
end

function ShiniesAutoUI:OnDisable()
	Shinies:Debug( "ShiniesAutoUI:OnDisable" )
	
	ShiniesAPI.UnregisterCallback( self, "OnAuctionHouseAvailabilityChanged" )
	
	UninitializeUI()
end

function ShiniesAutoUI:OnEnable()
	Shinies:Debug( "ShiniesAutoUI:Enable" )
	
	-- If our UI isnt initialized, initialize it	
	InitializeUI()
	
	-- Register our events here
	ShiniesAPI.RegisterCallback( self, "OnAuctionHouseAvailabilityChanged", 	"OnAuctionHouseAvailabilityChanged" )
	
	-- Check the AH availibility from the start
	self:OnAuctionHouseAvailabilityChanged( "OnAuctionHouseAvailabilityChanged", ShiniesAPI:IsServerAvailable() )
	
	-- Display our auto items
	self:ShowAutoItems()
	
	-- Display the active item (will be empty here, but will setup the UI)
	DisplayItem()
end

function ShiniesAutoUI.OnHidden()
	if( not uiInitialized ) then return end
end

function ShiniesAutoUI:OnInitialize()
	Shinies:Debug( "ShiniesAutoUI:OnInitialize" )
	
	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesAutoUI.OnLButtonUp_AutoDelete()
	local slot, row, auto = GetSlotRowNumForAutoRow()
	
	if( auto ~= nil ) then
		self = ShiniesAutoUI
		-- Delete the auto
		self.db.factionrealm.autos[auto.itemData.uniqueID] = nil
				
		-- Update our auto items
		self:ShowAutoItems()	
	end 
end

function ShiniesAutoUI.OnLButtonUp_AutoListRow()
	local slot, row, auto = GetSlotRowNumForAutoRow()
	
	if( auto ~= nil ) then
		SetActiveItemData( auto.itemData )	
	end
end

function ShiniesAutoUI:OnAllModulesEnabled()
	-- Get the SPA
	SPA	= Shinies : GetModule( "Shinies-Aggregator-Price" )
end

function ShiniesAutoUI.OnMouseOver_AutoListRow()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, true )
	end
	
	ShowRowTooltip()
end

function ShiniesAutoUI.OnMouseOverEnd_AutoListRow()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, false )
	end
end

function ShiniesAutoUI.OnPriceChange()
	local g, s, b
	
	g = tonumber( window.Item.E.Gold_TextBox:GetText() ) or 0
	s = tonumber( window.Item.E.Silver_TextBox:GetText() ) or 0
	b = tonumber( window.Item.E.Brass_TextBox:GetText() ) or 0
	
	local price =  ( g * 10000 ) + ( s * 100 ) + b
	
	if( price < 0 ) then price = 0 end
	
	local alpha = 1.0
	
	if( price > 0 ) then alpha = 0.2 end
	
	WindowSetAlpha( window.Item.E.PriceModule_Label.name, alpha )
	WindowSetAlpha( window.Item.E.PriceModule_Combo.name, alpha )
	WindowSetAlpha( window.Item.E.MinPrice_Label.name, alpha )
	WindowSetAlpha( window.Item.E.MinGold_TextBox.name, alpha )
	WindowSetAlpha( window.Item.E.MinSilver_TextBox.name, alpha )
	WindowSetAlpha( window.Item.E.MinBrass_TextBox.name, alpha )
end

function ShiniesAutoUI.OnRButtonUp_AutoItem()
end

function ShiniesAutoUI.OnShown()
	if( not uiInitialized ) then return end
end

function ShiniesAutoUI.PopulateAutoDisplay()
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesAutoUI_AutoList.PopulatorIndices ) 
	do
		local rowName = windowList .. "Row".. row
		
		local displayData = ShiniesAutoUI.listDisplayData[data]
		
		if( displayData ~= nil ) then
			LabelSetText( rowName .. "Name", 					displayData.Name )
			LabelSetTextColor( rowName .. "Name", 				displayData.Color.r,
																displayData.Color.g,
																displayData.Color.b )
			DynamicImageSetTexture( rowName .. "ImageIcon", 	displayData.Texture, displayData.TextureDx, displayData.TextureDy )
			WindowSetTintColor( rowName .. "Overlay", 			displayData.Color.r,
																displayData.Color.g,
																displayData.Color.b )
			LabelSetText( rowName .. "PriceDescription", 		displayData.PricingDescription )
			
			LabelSetText( rowName .. "StackSizeDescription", 	towstring(T["Stack Size:"] ))
			LabelSetText( rowName .. "StackSize", 				displayData.StackSize )
			
			LabelSetText( rowName .. "MinInventoryDescription", towstring(T["Minimum Inventory:"] ))
			LabelSetText( rowName .. "MinInventory", 			towstring(displayData.MinInventory) )
			
			ButtonSetText( rowName .. "Delete", 				towstring(T["Delete"]) )
			
			WindowSetShowing( rowName .. "Mouseover", false )
		end
	end
end

function ShiniesAutoUI:ProcessNextAuto()
	-- Verify the AH is still available
	if( not ShiniesAPI:IsServerAvailable() ) then
		TextLogAddEntry( summaryLog, 1, T[towstring("Auction house is not currently available.")] )
		self:StopAuto()
		return
	end
	
	----------------------------------------------------------------------
	-- Perform all cursory checks here that will cause Auto to stop
	----------------------------------------------------------------------
	if( autoItems == nil ) then
		TextLogAddEntry( summaryLog, 1, T[towstring("No items to process.")] )
		self:StopAuto() 
		return 
	end
	
	-- Get the next item to process
	local idx, auto = next( autoItems )
	
	-- Verify we received an item id
	if( idx == nil or auto == nil ) then
		TextLogAddEntry( summaryLog, 1, T[towstring("No items to process.")] ) 
		self:StopAuto() 
		return 
	end
	
	-- Remove the item from the table
	autoItems[idx] = nil
	autoItemsCount = autoItemsCount - 1
	
	-- Update our item count display
	window.Control.E.ItemsRemaining_Label:SetText( wstring_format( T[towstring("%d items remaining")], autoItemsCount ) )
	TextLogAddEntry( summaryLog, 1, T[towstring("Processing item:  ")] .. auto.itemData.name )
	
	----------------------------------------------------------------------
	-- We check everything we can before hitting the inventory due to the current mem leak
	-- in the inventory code
	----------------------------------------------------------------------
	
	-- Determine the deposit cost of a single stack of items
	local depositPrice = ShiniesAPI:Item_GetAuctionDeposit( auto.itemData ) * auto.stackSize
	
	-- Determine how many auctions can be created with the deposit cost
	local maxAuctions = math_floor( Player.GetMoney() / depositPrice )
	
	-- If the user does not have enough gold for a single auction for this auto move to the next item
	if( maxAuctions <= 0 ) then
		TextLogAddEntry( summaryLog, 1, indent() .. towstring(T["Not enough gold to auction item."]) ) 
		return 
	end
	
	----------------------------------------------------------------------
	-- Perform our inventory checks here
	----------------------------------------------------------------------
	
	-- Obtain the inventory count of the item
	local invCount = ShiniesAPI:Inventory_TotalItemCount( auto.itemData.uniqueID )
	
	-- Determine how many auctions we can create with the given totals
	local inventoryAuctionCount = math_floor( ( invCount - auto.minInventory ) / auto.stackSize )
	
	-- If there isnt enough to create any auctions move to the next item
	if( inventoryAuctionCount < 1 ) then
		TextLogAddEntry( summaryLog, 1, indent() .. T[towstring("Not enough of the item in inventory.")] ) 
		return	
	end
	
	-- Get the number of auctions we will create
	local auctionCount = math_min( maxAuctions, inventoryAuctionCount )
	
	-- If the price is set on the auto, there is no need to query the AH for the pricing modules
	if( auto.price > 0 ) then
		ExecuteAuto( auto, auctionCount, nil )
	else
		TextLogAddEntry( summaryLog, 1, indent() .. T[towstring("Querying auction house for current auctions...")] )
		-- Store the auto and count
		activeAuto 			= auto
		activeAutoCount 	= auctionCount
		
		-- Fire off our item query
		activeAutoQueryId 	= ShiniesAPI:Query_SingleItem( auto.itemData.name )
	end
end

function ShiniesAutoUI:ShowAutoItems()
	wipe( displayOrder )
	wipe( ShiniesAutoUI.listDisplayData )
	
	-- Add the items to the list display data
	local id = 1
	for _, auto in pairs( self.db.factionrealm.autos ) 
	do
		ShiniesAutoUI.listDisplayData[id] 			= GenerateAutoListItem( auto, id )
		id = id + 1
	end
	
	local function sort( a, b ) 
		return a.Name < b.Name 
	end

	-- Sort our display information
	tsort( ShiniesAutoUI.listDisplayData, sort )
	
	-- Create the list we will use to display
    for index,_ in ipairs( ShiniesAutoUI.listDisplayData )
    do
    	-- Add this to the end of our display
    	table.insert( displayOrder, index )
    end
	
	ListBoxSetDisplayOrder( windowList, displayOrder )
end

function ShiniesAutoUI:StartAuto()
	if( isRunning ) then return end
	
	-- Clear the text log, and scroll to the stop
	TextLogClear( summaryLog )
    LogDisplayScrollToTop( windowSummary )
	
	-- Verify the AH is available
	if( not ShiniesAPI:IsServerAvailable() ) then
		TextLogAddEntry( summaryLog, 1, T[towstring("Auction house is not currently available.")] )
		return
	end
	
	-- Register our event handlers
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateFailure", 	"OnAuctionCreateFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateSuccess", 	"OnAuctionCreateSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess", 	"OnAuctionQuerySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryFailure", 	"OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryTimeout", 	"OnAuctionQueryFailure" )
	
	-- Build a list of item ids we need to process
	autoItems = new()
	autoItemsCount = 0
	for k, v in pairs( self.db.factionrealm.autos )
	do
		tinsert( autoItems, v )
		autoItemsCount = autoItemsCount + 1	
	end
	tsort( autoItems, function( a, b ) return a.itemData.name < b.itemData.name end )
	
	TextLogAddEntry( summaryLog, 1, T[towstring("Starting processing...")] )
	
	-- Flag that we are running 
	isRunning = true
	
	-- Start our auto timer
	self:ScheduleRepeatingTimer( "OnAutoTimer", self.db.factionrealm.throttle ) 
	
	-- Start processing the autos
	self:ProcessNextAuto()
	
	-- Update the display of our Start/Stop button
	window.Control.E.Start_Button.UpdateDisplay()
end

function ShiniesAutoUI:StopAuto()
	if( not isRunning ) then return end
	
	TextLogAddEntry( summaryLog, 1, T[towstring("Processing complete!")] )
	
	-- Cancel all of our timers
	self:CancelAllTimers()
	
	-- Unregister our event handlers
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryTimeout" )
	
	-- Clean up our data members
	autoItems = del( autoItems )
	autoItemsCount = 0
	
	-- Flag as no longer running
	isRunning = false
	
	-- Update the display of our Start/Stop button
	window.Control.E.Start_Button.UpdateDisplay()
	
	window.Control.E.ItemsRemaining_Label:SetText( L"" )
end

------------------------------------
-- LOCAL FUNCTIONS
------------------------------------

function AddKeyTabWindow( e )
	-- Add the window to our list
	tinsert( window.Item.TabOrder, e.name )

	-- Add the reverse lookup
	window.Item.TabOrderLookup[e.name] = #window.Item.TabOrder
	
	-- Setup the function
	e.OnKeyTab = 
		function()
			OnKeyTab( e.name )
		end
	e:RegisterEvent( "OnKeyTab" )
end

function BuildPriceModuleCombo( combo )
	-- Clear all the current contents
	combo:Clear()
	
	local modules = new()
	
	-- Clear the module lookup
	wipe( priceModuleLookup )
	wipe( priceModuleRevLookup )
	
	-- Build a list of the pricing modules
	for _, module in Shinies:IterateModulesOfType("Price") 
	do
		tinsert( modules, { name = module:GetName(), display = module:GetDisplayName() } )
	end
	
	-- Sort the pricing modules
	tsort( modules, function( a, b ) return ( a.display < b.display ) end )
	
	-- Add the pricing priority option
	combo:Add( T[towstring("-Use Pricing Priority-")] )
	priceModuleLookup[1]		= ""
    priceModuleRevLookup[""]	= 1
	
	-- Add the modules to our lookups and combo
	for idx, mod in ipairs( modules )
	do
		combo:Add( mod.display )
		priceModuleLookup[idx+1]		= mod.name
    	priceModuleRevLookup[mod.name]	= idx + 1	
	end

	combo:SelectIndex( 1 )
		
	del( modules )
end

function DisplayItem()
	-- Iterate all of the elements of the item window
	-- and if they have a load function call it with the active item
	for k, v in pairs( window.Item.E )
	do
		if( v ~= nil and v.Load ~= nil and type( v.Load ) == "function" ) then
			v.Load( activeItem )
		end
	end
end

function ExecuteAuto( auto, count, results )
	local price = auto.price    -- The price comes in as price per stack
	local mod	= L""
	
	-- The price is determined by a mod, so get that price
	if( price <= 0 and results ~= nil ) then
		if( string_len( auto.priceMod ) == 0 ) then
			price, _, mod = SPA:GetItemPrice( auto.itemData, results )
		else
			price, _, mod = SPA:GetItemPriceForModule( auto.itemData, results, auto.priceMod )
		end
		
		-- The prices above are per item so multiply it by the stack size
		price = math_floor( price * auto.stackSize )
	
		-- We no longer need the results to clear them
		results = del( results )
	
		-- If the price provided by the module pri	
		if( price < auto.minModPrice ) then
			if( mod == L"" ) then
				TextLogAddEntry( summaryLog, 1, indent() .. towstring(T[towstring("Pricing information not available.  Item will not be posted.")]) )			
			else
				TextLogAddEntry( summaryLog, 1, indent() .. towstring( wstring_gsub( T[towstring("Price generated by 'MOD' is below the minimum set for the item.  Item will not be posted.")], L"MOD", towstring( mod  ) ) ) )
			end
			return 
		end
	end
	
	local profitOverVendor = ShiniesAPI:Item_GetProfitOverVendor( auto.itemData, price / auto.stackSize )
	
	if( profitOverVendor < 0 ) then
		TextLogAddEntry( summaryLog, 1, indent() .. T[towstring("Price will not generate any profit over vendoring.  Item will not be posted.")] ) 
		return	
	end
	
	-- Only execute the auction if there is profit to be made
	local display =  T[towstring("    Posting COUNT auction(s) for ITEM with a price of PRICE per stack of SIZE.")]
	
	display = wstring_gsub( display, L"COUNT", towstring( activeAutoCount ) )
	display = wstring_gsub( display, L"ITEM", auto.itemData.name )
	display = wstring_gsub( display, L"PRICE", ShiniesAPI:Display_GetFormattedMoney( price, true, true ) )
	display = wstring_gsub( display, L"SIZE", towstring( auto.stackSize ) )
	
	TextLogAddEntry( summaryLog, 1, indent() .. display )
	
	for i = 1, count
	do
		activeCreateId = ShiniesAPI:Auction_Create( auto.itemData, auto.stackSize, price, GameData.Auction.RESTRICTION_NONE )
	end
end

function GenerateAutoListItem( auto, id )
	local listDisplayItem = new()

	-- Store reference data
	listDisplayItem.auto						= auto
	listDisplayItem.slotNum 					= id
	
	-- Set the display properties
	listDisplayItem.Name						= auto.itemData.name
	listDisplayItem.Color						= DataUtils.GetItemRarityColor( auto.itemData )
	
	listDisplayItem.Texture, listDisplayItem.TextureDx, listDisplayItem.TextureDy = GetIconData( auto.itemData.iconNum )
	
	listDisplayItem.PricingDescription			= GeneratePricingDescription( auto )
	
	listDisplayItem.StackSize					= towstring( auto.stackSize )
	
	if( auto.minInventory == 0 ) then
		listDisplayItem.MinInventory			= T[towstring("None")]
	else
		listDisplayItem.MinInventory			= towstring( auto.minInventory )
	end
	
	return listDisplayItem
end

function GeneratePricingDescription( auto )
	local desc = L""
	
	-- If the user specified a price we will use that price
	if( auto.price > 0 ) then
		desc = T[towstring("Auto will use the following auction price per stack:")] .. L"  " .. ShiniesAPI:Display_GetFormattedMoney( auto.price, true, true )
	elseif( string_len( auto.priceMod ) > 0 ) then
		local mod = Shinies:GetModule( auto.priceMod, true )
		if( mod ) then
			if( auto.minModPrice > 0 ) then
				desc =  T[towstring("Auto will use the price provided by the following pricing module 'MOD', as long as its above:  MINPRICE")]
				desc = wstring_gsub( towstring(desc), L"MOD", mod:GetDisplayName() )
				desc = wstring_gsub( towstring(desc), L"MINPRICE", ShiniesAPI:Display_GetFormattedMoney( auto.minModPrice, true, true ) )
			else
				desc =  T[towstring("Auto will use the price provided by the following pricing module 'MOD'.")]
				desc = wstring_gsub( towstring(desc), L"MOD", mod:GetDisplayName() )
			end
		else
			desc = T[towstring("Auto is not able to find the configured pricing module.")]
		end
	else
		if( auto.minModPrice > 0 ) then
			desc =  T["Auto will use the price provided by the global pricing configuration, as long as its above:  MINPRICE"]
			desc = wstring_gsub( towstring(desc), L"MINPRICE", ShiniesAPI:Display_GetFormattedMoney( auto.minModPrice, true, true ) )
		else
			desc = T["Auto will use the price provided by the global pricing configuration."]
		end
	end
	
	return desc
end

function GetActiveItem()
	return activeItem
end

function GetSlotRowNumForAutoRow()
	local rowNumber, slowNumber, auto = 0, 0, nil
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowList, rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	slotNumber 	= ShiniesAutoUI.listDisplayData[dataIndex].slotNum
    	auto 		= ShiniesAutoUI.listDisplayData[dataIndex].auto
	end
    
	return slotNumber, rowNumber, auto
end

function InitializeControlUI()
	local e
	local w
	
	-- Control Window
	w = LibGUI( "window", windowControl, "ShiniesWindowDefault" )
	w:Resize( 160, 168 )
	w:Show()
	w:Parent( config.windowId )
	w.E = {}
	window.Control = w
	
	-- Start Button
    e = window.Control( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Control, "top", "top", 0, 25 )
    e:SetText( T["Start"] )
    e.OnLButtonUp = 
		function()
			-- Check if the button is disabled as button presses still go through to a disabled button
			if( not window.Control.E.Start_Button:Enabled() ) then return end
			
			self = ShiniesAutoUI
			
			if( isRunning ) then
				self:StopAuto()
			else
				self:StartAuto()
			end
			window.Control.E.Start_Button.UpdateDisplay()
		end
	e.UpdateDisplay =
		function()
			local text = T["Start"]
			if( isRunning ) then
				text = T["Stop"]
			end	
			window.Control.E.Start_Button:SetText( text )
		end
    window.Control.E.Start_Button = e
    
    -- Summary Button
    e = window.Control( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Control.E.Start_Button, "bottom", "top", 0, 5 )
    e:SetText( T["Start"] )
    e.OnLButtonUp = 
		function()
			ToggleListSummaryDisplay()			
		end
	e:SetText( T["Summary"] )
	window.Control.E.Summary_Button = e
	
	-- Stack Size Label
    e = window.Control( "Label", nil, "Shinies_Default_Label_ClearSmallFont" )
    e:Resize( 175, 40 )
    e:Align( "center" )
    e:Color( 222, 192, 50 )
    e:WordWrap( true )
    e:AddAnchor( window.Control.E.Summary_Button, "bottom", "top", 0, 5 )
    e:SetText( T[""] )
    window.Control.E.ItemsRemaining_Label = e	
end

function InitializeItemUI()
	local e
	local w
	
	-- Item Window
	w = LibGUI( "window", windowItem, "ShiniesWindowDefault" )
	w:Resize( 775, 168 )
	w:Show()
	w:Parent( config.windowId )
	w.E = {}
	w.TabOrder = {}
	w.TabOrderLookup = {}
	w.KeyEnter = {}
	window.Item = w
	
	-- Item Name 
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 675, 22 )
    e:Align( "leftcenter" )
    e:AddAnchor( window.Item, "topleft", "topleft", 10, 10 )
    e.Load =
    	function( auto )
    		local text 				= L""
    		local color				= { r=255, g=255, b=255 }
    		
			if( auto ~= nil ) then
    			text = auto.itemData.name
    			color = DataUtils.GetItemRarityColor( auto.itemData )
    		end
				
			window.Item.E.ItemName_Label:SetText( text )
			window.Item.E.ItemName_Label:Color( color.r, color.g, color.b )
    	end
    window.Item.E.ItemName_Label = e
	
	-- Item Button
    e = window.Item( "Button", windowItem .. "ItemButton", "Shinies_IconButton" )
    e:Resize( 64, 64 )
    e:AnchorTo( window.Item.E.ItemName_Label, "bottomleft", "topleft", 0, 10 )
    e:Layer( "secondary" )
    e.OnRButtonUp =
    	function()
    		if( isRunning ) then return	end
    		
    		SetActiveItemData( nil )
    	end
    e.OnLButtonUp = 
    	function()
    		-- If we are running, we do not want to change anything at this time
    		if( isRunning ) then
				Cursor.Clear() 
				return
			end
			
    		-- User has dropped something to be sold
			if( Cursor.IconOnCursor() and Cursor.Data and ShiniesAPI:Item_IsValidCursorSource( Cursor.Data.Source ) and Cursor.Data.SourceSlot ) then
				local itemData = DataUtils.GetItemData( Cursor.Data.Source, Cursor.Data.SourceSlot )
				if( itemData ~= nil ) then
					SetActiveItemData( itemData )
				end
				
				Cursor.Clear()
			else
				SetActiveItemData( nil )
			end
			
			-- If the tooltip window is showing, update it for this item
			if( tooltipWindow ~= nil and DoesWindowExist( tooltipWindow ) ) then
				ShowItemTooltip()
			end
    	end
    e.OnMouseOver =
    	function()
    		ShowItemTooltip()
    	end
    e.Load =
    	function( auto )
    		local texture			= ""
			local textureDx			= 0
			local textureDy			= 0
			
			-- If an item was passed, lookup the appropriate data 
			if( auto ~= nil ) then
				texture, textureDx, textureDy = GetIconData( auto.itemData.iconNum )
			end
			
			DynamicImageSetTexture( window.Item.E.Item_Button.name .. "Icon", texture, textureDx, textureDy )
		end
    window.Item.E.Item_Button = e
	
	--Item Button Overlay
	e = window.Item( "Button", windowItem .. "ItemButtonOverlay", "Shinies_IconButton_Overlay" )
    e:Resize( WindowGetDimensions( window.Item.E.Item_Button.name ) )
    e:AnchorTo( window.Item.E.Item_Button, "center", "center", 0, 0 )
    e:Layer( "popup" )
    e:Tint( 222, 192, 50 )
    e.Load =
    	function( auto )
    		local color				= { r=255, g=255, b=255 }
    		if( auto ~= nil ) then
    			color = DataUtils.GetItemRarityColor( auto.itemData )
    		end	
			window.Item.E.ItemOverlay_Button:Tint( color.r, color.g, color.b )
    	end
    window.Item.E.ItemOverlay_Button = e
    
	-- Stack Size Label
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 235, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Item.E.Item_Button, "topright", "topleft", 15, 0 )
    e:SetText( T["Stack Size:"] )
    window.Item.E.StackSize_Label = e
    
    -- Stack Size Text Box
    e = window.Item( "Textbox", nil, "Shinies_EditBox_DefaultFrame_ThreeNumber" )
    e:Resize( 65, 32 )
    e:Show()
    e:AddAnchor( window.Item.E.StackSize_Label, "right", "left", 2, 0 )
    e:Layer( "secondary" )
    e:SetText( 0 )
    e.Load = 
    	function( auto )
    		local size = 0
    		if( auto ~= nil ) then
    			size = auto.stackSize
    		end
    		window.Item.E.StackSize_Textbox:SetText( towstring( size ) )
    	end
    e.Save = 
    	function( auto )
    		if( auto ~= nil ) then
    			auto.stackSize = tonumber( window.Item.E.StackSize_Textbox:GetText() ) or 0
    			
    			if( auto.stackSize > auto.itemData.capacity ) then
    				auto.stackSize = auto.itemData.capacity
    			elseif( auto.stackSize < 0 ) then
    				auto.stackSize = 0
    			end
			end 
    	end
    AddKeyTabWindow( e )
    window.Item.E.StackSize_Textbox = e
    
	-- Minimum Inventory Label
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 235, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Item.E.StackSize_Label, "bottomleft", "topleft", 0, 12 )
    e:SetText( T["Minimum Inventory:"] )
    window.Item.E.MinimumInventory_Label = e
    
    -- Minimum Inventory Text Box
    e = window.Item( "Textbox", nil, "Shinies_EditBox_DefaultFrame_ThreeNumber" )
    e:Resize( 65, 32 )
    e:Show()
    e:AddAnchor( window.Item.E.MinimumInventory_Label, "right", "left", 2, 0 )
    e:Layer( "secondary" )
    e:SetText( 0 )
    e.Load = 
    	function( auto )
    		local minInv = 0
    		if( auto ~= nil ) then
    			minInv = auto.minInventory
    		end
    		window.Item.E.MinimumInventory_Textbox:SetText( towstring( minInv ) )
    	end
    e.Save = 
    	function( auto )
    		if( auto ~= nil ) then
    			auto.minInventory = tonumber( window.Item.E.MinimumInventory_Textbox:GetText() ) or 0
    			
    			if( auto.minInventory < 0 ) then
    				auto.minInventory = 0	
    			end
			end 
    	end
    AddKeyTabWindow( e )
    window.Item.E.MinimumInventory_Textbox = e
    
    -- Price Label
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 275, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
   	e:AddAnchor( window.Item.E.MinimumInventory_Label, "bottomleft", "topleft", 0, 8 )
    e:SetText( T["Price:"] )
    window.Item.E.Price_Label = e
    
    -- Gold Textbox
    e = window.Item( "Textbox", nil, "ShiniesAutoUI_GoldCoin_EditBox_DefaultFrame" )
    e:Resize( 70, 27 )
    e:AddAnchor( window.Item.E.Price_Label, "bottomleft", "topleft", 0, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.Gold_TextBox = e
	
	-- Gold Coin Window
	e = window.Item( "window", nil, "Shinies_GoldCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.Gold_TextBox, "right", "left", 2, 0 )
    window.Item.E.GoldCoin_Window = e
    
    -- Silver Textbox
    e = window.Item( "Textbox", nil, "ShiniesAutoUI_SilverCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Item.E.GoldCoin_Window, "right", "left", 4, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.Silver_TextBox = e
	
	-- Silver Coin Window
	e = window.Item( "window", nil, "Shinies_SilverCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.Silver_TextBox, "right", "left", 2, 0 )
    window.Item.E.SilverCoin_Window = e
    
    -- Brass Textbox
    e = window.Item( "Textbox", nil, "ShiniesAutoUI_BrassCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Item.E.SilverCoin_Window, "right", "left", 4, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.Brass_TextBox = e
	
	-- Brass Coin Window
	e = window.Item( "window", nil, "Shinies_BrassCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.Brass_TextBox, "right", "left", 2, 0 )
    window.Item.E.BrassCoin_Window = e
    
    -- Price Module Label
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 275, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
   	e:AddAnchor( window.Item.E.ItemName_Label, "bottomright", "topright", 5, 0 )
    e:SetText( T["Price Module:"] )
    window.Item.E.PriceModule_Label = e
    
    -- Price Module Combox
    e = window.Item( "combobox", nil, "Shinies_ComboBox_DefaultResizableLarge" )
    e:AnchorTo( window.Item.E.PriceModule_Label, "bottomleft", "topleft", 0, 0 )
	e.Load = 
		function( auto )
			-- Handle the combo box here
			local cmbIdx = 1
			if( auto ~= nil and priceModuleRevLookup[auto.priceMod] ~= nil ) then
				cmbIdx = priceModuleRevLookup[auto.priceMod]
			end
			window.Item.E.PriceModule_Combo:SelectIndex( cmbIdx )
			
			local g, s, b = 0, 0, 0
			
			-- Handle the Min Pricing Display
			if( auto ~= nil ) then
				g,s,b = ShiniesAPI:Display_GetGSBFromMoney( auto.minModPrice )
			end
	
			window.Item.E.MinGold_TextBox:SetText( towstring( g ) )
			window.Item.E.MinSilver_TextBox:SetText( towstring( s ) )
			window.Item.E.MinBrass_TextBox:SetText( towstring( b ) )
			
			-- Handle the Pricing Display
			
			g, s, b = 0, 0, 0
			if( auto ~= nil ) then
				g,s,b = ShiniesAPI:Display_GetGSBFromMoney( auto.price )
			end
	
			window.Item.E.Gold_TextBox:SetText( towstring( g ) )
			window.Item.E.Silver_TextBox:SetText( towstring( s ) )
			window.Item.E.Brass_TextBox:SetText( towstring( b ) )
		end
	e.Save = 
		function( auto )
			if( auto ~= nil ) then
				-- Save the price mod information
				local cmbIdx = 	window.Item.E.PriceModule_Combo:SelectedIndex()
				
				local priceMod = ""
				if( priceModuleLookup[cmbIdx] ~= nil ) then
					priceMod = priceModuleLookup[cmbIdx]
				end
				auto.priceMod = priceMod
				
				local g, s, b = 0, 0, 0
				
				-- Save the min price information
				g = tonumber( window.Item.E.MinGold_TextBox:GetText() ) or 0
				s = tonumber( window.Item.E.MinSilver_TextBox:GetText() ) or 0
				b = tonumber( window.Item.E.MinBrass_TextBox:GetText() ) or 0
				
				auto.minModPrice = ( g * 10000 ) + ( s * 100 ) + b
				
				if( auto.minModPrice < 0 ) then
					auto.minModPrice = 0
				end
				
				-- Save the price information
				g = tonumber( window.Item.E.Gold_TextBox:GetText() ) or 0
				s = tonumber( window.Item.E.Silver_TextBox:GetText() ) or 0
				b = tonumber( window.Item.E.Brass_TextBox:GetText() ) or 0
				
				auto.price = ( g * 10000 ) + ( s * 100 ) + b
				
				if( auto.price < 0 ) then
					auto.price = 0
				end
			end
		end
	BuildPriceModuleCombo( e )
	window.Item.E.PriceModule_Combo = e
	
	-- Min Price Label
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 275, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
   	e:AddAnchor( window.Item.E.PriceModule_Combo, "bottomleft", "topleft", 0, 5 )
    e:SetText( T["Minimum Module Price:"] )
    window.Item.E.MinPrice_Label = e
    
    -- Gold Textbox
    e = window.Item( "Textbox", nil, "Shinies_GoldCoin_EditBox_DefaultFrame" )
    e:Resize( 70, 27 )
    e:AddAnchor( window.Item.E.MinPrice_Label, "bottomleft", "topleft", 0, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.MinGold_TextBox = e
	
	-- Gold Coin Window
	e = window.Item( "window", nil, "Shinies_GoldCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.MinGold_TextBox, "right", "left", 2, 0 )
    window.Item.E.MinGoldCoin_Window = e
    
    -- Silver Textbox
    e = window.Item( "Textbox", nil, "Shinies_SilverCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Item.E.MinGoldCoin_Window, "right", "left", 4, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.MinSilver_TextBox = e
	
	-- Silver Coin Window
	e = window.Item( "window", nil, "Shinies_SilverCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.MinSilver_TextBox, "right", "left", 2, 0 )
    window.Item.E.MinSilverCoin_Window = e
    
    -- Brass Textbox
    e = window.Item( "Textbox", nil, "Shinies_BrassCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Item.E.MinSilverCoin_Window, "right", "left", 4, 0 )
    AddKeyTabWindow( e )	
	window.Item.E.MinBrass_TextBox = e
	
	-- Brass Coin Window
	e = window.Item( "window", nil, "Shinies_BrassCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Item.E.MinBrass_TextBox, "right", "left", 2, 0 )
    window.Item.E.MinBrassCoin_Window = e
	
	-- Revert Button
    e = window.Item( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Item, "bottomright", "bottomright", -2, -15 )
    e:SetText( T["Revert"] )
    e.OnLButtonUp = 
		function()
			if( isRunning ) then return end
			-- Redisplay the item
			DisplayItem()
		end
	e.Load =
		function( auto )
			window.Item.E.Revert_Button:SetEnabled( auto ~= nil )
		end
    window.Item.E.Revert_Button = e
    
    -- Save Button
    e = window.Item( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Item.E.Revert_Button, "top", "bottom", 0, -5 )
    e:SetText( T["Save"] )
    e.OnLButtonUp = 
		function()
			-- Save the item
			SaveItem()
		end
	e.Load =
		function( auto )
			window.Item.E.Save_Button:SetEnabled( auto ~= nil )
		end
    window.Item.E.Save_Button = e
end

function InitializeUI()
	if( uiInitialized == true ) then return end
	
	-- Create a table for our windows
	window = new()
	
	-- Create our config window here, so that Shinies can use it
	CreateWindow( config.windowId, false )
	
	InitializeControlUI()
	InitializeItemUI()
	
	-- Initialize our list display
	DataUtils.SetListRowAlternatingTints( windowList, MAX_VISIBLE_ROWS )
	
	-- Reanchor the user interface elements of this module
	WindowClearAnchors( windowControl )
	WindowClearAnchors( windowItem )
	WindowClearAnchors( windowAuto )
	
	-- Anchor the control window to the top right portion of the window
	WindowAddAnchor( windowControl, "topleft", config.windowId, "topleft", 0, 0 )
	--WindowAddAnchor( windowControl, "bottomright", windowItem, "bottomleft", 0, 0 )
	
	-- Anchor the item window to the top left
	WindowAddAnchor( windowItem, "topright",windowControl, "topleft", 0, 0 )
	WindowAddAnchor( windowItem, "topright", config.windowId, "topright", 0, 0 )
	
	-- Anchor the list below the item window
	WindowAddAnchor( windowAuto, "bottomleft", windowControl, "topleft", 0, 0 )
	WindowAddAnchor( windowAuto, "bottomright", config.windowId, "bottomright", 0, -4 )
	
	-- Create our text logs
	TextLogCreate( summaryLog, 4096 )
	TextLogClear( summaryLog )
	
	-- Associate the text logs with our log display
	LogDisplayAddLog( windowSummary, summaryLog, true)
	
	-- Configure the log display
	LogDisplaySetShowTimestamp( windowSummary, false)
    LogDisplaySetShowLogName( windowSummary, false)
    LogDisplayScrollToTop( windowSummary )
    
    -- Initialize the log filters
	LogDisplaySetFilterState( windowSummary, summaryLog, 1, true )
	LogDisplaySetFilterColor( windowSummary, summaryLog, 1, 44, 206, 44 )
	
	-- Show our list and hide our summary
	WindowSetShowing( windowList, true )
	WindowSetShowing( windowSummary, false )
	
	-- Update our display accordingly
	ShiniesAutoUI.OnPriceChange()
	
	-- We are now considered initialized
	uiInitialized = true
end

function OnKeyTab( focusWindow )
	-- Get this windows index
	local idx =  window.Item.TabOrderLookup[focusWindow]
	
	-- We have received an appropriate window Id
	if( idx ~= nil ) then
		local nextWindow = window.Item.TabOrder[idx+1]
		
		-- If the next window is nil, attempt the first window
		if( nextWindow == nil ) then
			nextWindow = window.Item.TabOrder[1]	   	
		end
		
		if( nextWindow ~= nil and DoesWindowExist( nextWindow ) ) then
		    WindowAssignFocus( nextWindow, true)
		end
	end
end

function SaveItem()
	
	self = ShiniesAutoUI
	
	-- Iterate all of the elements of the item window
	-- and if they have a save function call it with the active item
	for k, v in pairs( window.Item.E )
	do
		if( v ~= nil and v.Save ~= nil and type( v.Save ) == "function" ) then
			v.Save( activeItem )
		end
	end
	
	-- The user is saving this item so unflag the item as default
	activeItem.default = false
	
	-- Update the settings for the auto
	self.db.factionrealm.autos[activeItem.itemData.uniqueID] = activeItem
	
	-- Update the item display
	self:ShowAutoItems()
end

function SetActiveItemData( item )
	-- No need to update if the active item doesnt change
	if( item ~= nil and activeItem ~= nil and item.uniqueID == activeItem.itemData.uniqueID ) then return end
	
	self = ShiniesAutoUI
	
	
	-- Check the old active item, if its a default item, remove it from our db
	if( activeItem ~= nil ) then
		if( self.db.factionrealm.autos[activeItem.itemData.uniqueID].default ) then
			 self.db.factionrealm.autos[activeItem.itemData.uniqueID] = nil
		end
	end
	
	-- If we have a new item set it as active
	if( item ~= nil ) then
		activeItem = self.db.factionrealm.autos[item.uniqueID]
		
		-- Update the item data
		activeItem.itemData = item
		
		-- Default the stack size to capacity
		if( activeItem.stackSize == 0 ) then
			activeItem.stackSize = activeItem.itemData.capacity
		end
	else
		activeItem = nil
	end
	 
	-- Display the item
	DisplayItem()	
end

function ToggleListSummaryDisplay()
	WindowSetShowing( windowList, not WindowGetShowing( windowList ) )
	WindowSetShowing( windowSummary, not WindowGetShowing( windowList ) )
end

function ShowItemTooltip()
	local data = GetActiveItem()
	if( data ~= nil and ShiniesAPI:Item_IsValid( data.itemData ) ) then
		tooltipWindow = Tooltips.CreateItemTooltip( data.itemData, 
                                SystemData.MouseOverWindow.name,
                                Tooltips.ANCHOR_WINDOW_RIGHT, 
                                flags ~= SystemData.ButtonFlags.SHIFT, 
                                nil, nil, true )
    else
    	Tooltips.ClearTooltip()
    	tooltipWindow = nil
    end
end

function ShowRowTooltip()
	local _, _, data = GetSlotRowNumForAutoRow()
	if( data ~= nil and ShiniesAPI:Item_IsValid( data.itemData ) ) then
		tooltipWindow = Tooltips.CreateItemTooltip( data.itemData, 
                                SystemData.MouseOverWindow.name,
                                { Point = "topright",     RelativeTo = SystemData.MouseOverWindow.name, RelativePoint = "topleft", XOffset = 4, YOffset = 0 }, 
                                flags ~= SystemData.ButtonFlags.SHIFT, 
                                nil, nil, true )
    else
    	Tooltips.ClearTooltip()
    	tooltipWindow = nil
    end
end

function UninitializeUI()
	if( uiInitialized == false ) then return end

	-- Clean up our windows
	for _,w in pairs(window)
	do
		if( w.Taborder ~= nil ) then w.TabOrder = del( w.TabOrder ) end
		if( w.TabOrderLookup ~= nil ) then w.TabOrderLookup = del( w.TabOrderLookup ) end	
		
		-- Destroy the window itself
		DestroyWindow( w.name )
	end
	window = del(window)

	-- We are no longer initialized
	uiInitialized = false
end