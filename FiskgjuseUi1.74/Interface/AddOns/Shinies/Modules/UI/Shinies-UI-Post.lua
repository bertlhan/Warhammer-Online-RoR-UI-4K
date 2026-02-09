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
local MODNAME 			= "Shinies-UI-Post"
local ShiniesPostUI 	= Shinies : NewModule( MODNAME )
_G.ShiniesPostUI 		= ShiniesPostUI
ShiniesPostUI:SetModuleType( "UI" )
ShiniesPostUI:SetName( T["Shinies Post UI"] )
ShiniesPostUI:SetDescription(T["Provides a user interface for posting auctions."])
ShiniesPostUI:SetDefaults( {} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )
local ShiniesConstants 	= ShiniesConstants

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local SPA

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local string_format 		= string.format

local config	= {
	name			= T["Post"],
	windowId		= "ShiniesPostUI",
	idx				= 3,
}

local window
local windowItem			= config.windowId .. "_Item"
local windowAuction			= config.windowId .. "_Auction"
local windowResults 		= config.windowId .. "_Results"
local windowSearchingAnim 	= config.windowId .. "_SearchingAnim"

local positiveColor			= { 0, 200, 0 }
local negativeColor			= { 200, 0, 0 }

local sortColumnNum 		= 0				
local sortColumnName 		= ""		
local shouldSortIncreasing 	= true
local MAX_VISIBLE_ROWS 		= 20
local displayOrder 			= new()
local reverseDisplayOrder 	= new()

ShiniesPostUI.listDisplayData = new()

local queryResultsData		= new()
local activeQueryId			= 0
local activeCreateId		= 0

local function sellerComparator( a, b )				return( WStringsCompare( a.Seller, b.Seller ) == -1 ) end
local function stackComparator( a, b )				return( a.Stack < b.Stack ) end
local function timeLeftComparator( a, b )			return( a.TimeLeft < b.TimeLeft ) end
local function curPerComparator( a, b )				return( a.CurrentPer < b.CurrentPer ) end
local function curComparator( a, b )				return( a.Current < b.Current ) end
local function pricePerComparator( a, b )			return( a.PricePer < b.PricePer ) end
local function priceComparator( a, b )				return( a.Price < b.Price ) end

local sortHeaderData =
{
	[0] = { sortFunc=pricePerComparator, },
	{ column = "Seller",		text=T["Seller"],		sortFunc=sellerComparator,		},
	{ column = "Stack",			text=T["Stack"],		sortFunc=stackComparator,		},
	{ column = "TimeLeft",		text=T["Time"],			sortFunc=timeLeftComparator,	},
	{ column = "PricePer",		text=T["Price/Per"],	sortFunc=pricePerComparator,	},
	{ column = "Price",			text=T["Price"],		sortFunc=priceComparator,		},
}

local activeItemData	= nil
local activeItemPrice	= 0
local mouseOverAuction	= nil

local tooltipWindow 	= nil

local Auction_AddKeyTabWindow, Auction_OnKeyTab, CheckPostAuctionEnable
local ClearResultsDisplay, ClearSortButton, DisplaySortedData
local GeneratePrice, GetActiveItemData, GetActiveItemPrice, GetPrice, GetSlotRowNumForActiveListRow
local GetStacks, GetStackSize  
local InitializeAuctionUI, InitializeItemUI, InitializeUI 
local RefreshResultsDisplay, SetActiveItemData, SetActiveItemPrice, SetListDisplayItem, SetPrice 
local SetStacks, SetStackSize, ShowResults, ShowItemTooltip, SortResults, StartSearchingAnimation 
local StopSearchingAnimation, UpdatePricingDisplay, UpdateSellingCountDisplay
local UpdateTotalItemCountDisplay, UninitializeUI

local uiInitialized		= false

local handlePriceChange	= true

function ShiniesPostUI:OnInitialize()
	Shinies:Debug( "ShiniesPostUI:OnInitialize" )
	
	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesPostUI:OnEnable()
	Shinies:Debug( "ShiniesPostUI:OnEnable" )
	
	-- If our UI isnt initialized, initialize it	
	InitializeUI()
	
	-- Clear the results display
	ClearResultsDisplay()
	
	-- Register our callback handlers
	ShiniesAPI.RegisterCallback( self, "OnAuctionBuySuccess", 		"OnAuctionBuySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCancelSuccess", 	"OnAuctionCancelSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateFailure", 	"OnAuctionCreateFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateSuccess", 	"OnAuctionCreateSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess", 	"OnAuctionQuerySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryFailure", 	"OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryTimeout", 	"OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionHouseAvailabilityChanged", "OnAuctionHouseAvailabilityChanged" )
	
	-- Check the AH availibility from the start
	self:OnAuctionHouseAvailabilityChanged( "OnAuctionHouseAvailabilityChanged", ShiniesAPI:IsServerAvailable() )

	RegisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 	"ShiniesPostUI.OnPlayerInventorySlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 	"ShiniesPostUI.OnPlayerCraftingSlotUpdated" )
	RegisterEventHandler( SystemData.Events.PLAYER_MONEY_UPDATED, 			"ShiniesPostUI.OnPlayerMoneyUpdated" )
	
	-- Set our active item to nil to get all our display cleaned up
	SetActiveItemData( nil )
end

function ShiniesPostUI:OnDisable()
	Shinies:Debug( "ShiniesPostUI:OnDisable" )

	UnregisterEventHandler( SystemData.Events.PLAYER_INVENTORY_SLOT_UPDATED, 	"ShiniesPostUI.OnPlayerInventorySlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_CRAFTING_SLOT_UPDATED, 	"ShiniesPostUI.OnPlayerCraftingSlotUpdated" )
	UnregisterEventHandler( SystemData.Events.PLAYER_MONEY_UPDATED, 			"ShiniesPostUI.OnPlayerMoneyUpdated" )
	
	ShiniesAPI.UnregisterCallback( self, "OnAuctionBuySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCancelSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryTimeout" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionHouseAvailabilityChanged" )
	
	-- Stop/hide our animation window
    StopSearchingAnimation()
	
	UninitializeUI()
end

function ShiniesPostUI:GetUserInterface()
	return config
end

--
-- START ALPHABETICAL ORDERING OF FUNCTIONS HERE
--
function ShiniesPostUI:OnAuctionBuySuccess( eventName, identifier, auction )
	-- TODO:  Remove only the auction that was bought out
	RefreshResultsDisplay()
end

function ShiniesPostUI:OnAuctionCancelSuccess( eventName, identifier, auction )
	-- TODO:  Remove only the auction that was cancelled
	RefreshResultsDisplay()
end

function ShiniesPostUI:OnAuctionCreateFailure( eventName, identifier, auction, results, failure )
	Shinies:Debug( failure )
	DialogManager.MakeOneButtonDialog( failure, T["Ok"], nil )
end

function ShiniesPostUI:OnAuctionCreateSuccess( eventName, identifier, auction )
	-- Once we see the last auction Id we are expected, refresh our results
	if( activeCreateId == identifier ) then
		RefreshResultsDisplay()
	end
end

function ShiniesPostUI:OnAuctionHouseAvailabilityChanged( eventName, serverAvailable )
	if( not serverAvailable ) then
		window.Auction.E.PostAuction_Button:SetEnabled( false )
	else
		CheckPostAuctionEnable()
	end
	window.Item.E.Refresh_Button:SetEnabled( serverAvailable )	
end

function ShiniesPostUI:OnAuctionQueryFailure( eventName, identifier, query, results, failure )
	if( activeQueryId == identifier ) then
		-- Reset our query ID
    	activeQueryId = 0
    	
    	StopSearchingAnimation()
		
		if( failure ~= nil ) then
			Shinies:Debug( failure )
			DialogManager.MakeOneButtonDialog( failure, T["Ok"], nil )
		end
	end
end

function ShiniesPostUI:OnAuctionQuerySuccess( eventName, identifier, query, results )
	-- Make sure the results are for the query we more recently executed
	if( activeQueryId == identifier ) then
		local data = GetActiveItemData()
		
		-- Reset our query ID
    	activeQueryId = 0
    	
		-- Hide our searching animation
		StopSearchingAnimation()
		
		-- Clear our current display data
		wipe( ShiniesPostUI.listDisplayData )
		
		--
		-- Verify that the names are exact, as some items have prefix/suffix that 
		-- are still returned in the results
		--
		wipe( queryResultsData )
		
		-- Sanity check we have active item data
		if( data ~= nil ) then
			for k, v in pairs( results )
			do
				-- Do an explicit item
				
				
				--
				-- There are items with the same name and different stats, so we will do an
				-- explicity uniqueID check here vs a name compare
				--
				if( v.itemData.uniqueID == data.uniqueID ) then
					tinsert( queryResultsData, v )
				end
				
				--
				--if( WStringsCompare( v.itemData.name, query.itemName ) == 0 ) then
				--	tinsert( queryResultsData, v )
				--end
			end
		end
		
		-- Prepare our results data
		for slotNum, auction in pairs( queryResultsData ) 
		do
			SetListDisplayItem( slotNum, auction )
    	end
    	
    	-- Display the results data
    	ShowResults()
    	
    	-- Generate a price based off of the results
    	GeneratePrice()
    	
    	-- Kick off this check as we no longer have an outstanding query
		CheckPostAuctionEnable()    	
    end
    
    return true
end

function ShiniesPostUI.OnHidden()
	if( not uiInitialized ) then return end
	ClearResultsDisplay()
end

function ShiniesPostUI.OnLButtonUp_SortButton()
	if( sortColumnName == SystemData.ActiveWindow.name ) then
		if shouldSortIncreasing then
			shouldSortIncreasing = ( not shouldSortIncreasing )
		else
			ClearSortButton()
		end
    else
        ClearSortButton()
        sortColumnName = SystemData.ActiveWindow.name
        sortColumnNum = WindowGetId( SystemData.ActiveWindow.name )
    end

	if( sortColumnNum > 0 ) then
		WindowSetShowing( sortColumnName.."DownArrow", shouldSortIncreasing )
		WindowSetShowing( sortColumnName.."UpArrow", not shouldSortIncreasing )
	end
	
    ShowResults()
end

function ShiniesPostUI.OnLButtonUp_PostAuctionButton()
	-- Check if the button is disabled as button presses still go through to a disabled button
	if( not window.Auction.E.PostAuction_Button:Enabled() ) then return end

	local data = GetActiveItemData()
	-- Verify we have a valid item
	if( not ShiniesAPI:Item_IsValid( data ) ) then return end
	
	local restriction = ShiniesConstants.AUCTION_RESTRICTIONS[window.Auction.E.Restriction_Combo:SelectedIndex()].value
	local price = GetActiveItemPrice()
	
	-- Sanity check
	if( price <= 0 or restriction == nil ) then return end
	
	local stackSize = GetStackSize()
	local stacks = GetStacks()  
	
	-- If the fixed price box is checked, store the fixed price
	if( window.Auction.E.FixedPrice_CheckBox:GetValue() ) then
		SPA:SetFixedItemPrice( data, price )
	else
		-- otherwise remove any fixed price that is saved
		SPA:ClearFixedItemPrice( data )
	end
	
	-- Create an auction for each of the stack 
	for i= 1, stacks
	do
		activeCreateId = ShiniesAPI:Auction_Create( data, stackSize, price * stackSize, restriction )
		
		-- If we did not receive a valid ID, stop trying to create auctions
		if( activeCreateId == 0 ) then
			break
		end
	end
end

function ShiniesPostUI:OnAllModulesEnabled()
	-- Get the SPA
		-- TODO: What to do if we do not find the SPA?
	SPA	= Shinies : GetModule( "Shinies-Aggregator-Price" )
end

function ShiniesPostUI.OnMouseOver_Results_ListItem()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, true )
	end
end

function ShiniesPostUI.OnMouseOverEnd_Results_ListItem()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, false )
	end
end

function ShiniesPostUI.OnShown()
	if( not uiInitialized ) then return end
	
	-- If there is an item slotted, update its current auctions
	-- and inventory count
	if( GetActiveItemData() ~= nil ) then
		UpdateTotalItemCountDisplay()
		
		RefreshResultsDisplay()
	end
end

function ShiniesPostUI.OnStackSizeChange()
	local formattedVendorPrice 		= L""
	local formattedDepositPrice 	= L""
	local data						= GetActiveItemData()
	
	if( data ~= nil ) then	
		local size = GetStackSize()
		
		-- Check if the user entered in a stack size that exceeds the items capacity
		if( data.capacity < size ) then
			SetStackSize( data.capacity )
		--elseif( size <= 0 ) then
		--	SetStackSize( 1 )
		end
	
		local depositPrice = ShiniesAPI:Item_GetAuctionDeposit( data ) * size  
    	if depositPrice < 1 then depositPrice = 1 end
    	formattedDepositPrice = ShiniesAPI:Display_GetFormattedMoney( depositPrice, true, true )
    	
    	local vendorPrice = ShiniesAPI:Item_GetVendorPrice( data ) * size
		if( vendorPrice < 0 ) then vendorPrice = 0 end
    	formattedVendorPrice = ShiniesAPI:Display_GetFormattedMoney( vendorPrice, true, true )
    end
	
	window.Auction.E.AuctionFee_Label:SetText( formattedDepositPrice )
	window.Auction.E.VendorSell_Label:SetText( formattedVendorPrice )
	
	-- Update our pricing display
	UpdatePricingDisplay()
	
	-- Update the selling count display
	UpdateSellingCountDisplay()
	
	-- Check to see if we can enable the post auction button
	CheckPostAuctionEnable()	
end

function ShiniesPostUI.OnStackChange()
	-- Update the selling count display
	UpdateSellingCountDisplay()
	
	-- Check to see if we can enable the post auction button
	CheckPostAuctionEnable()
end

function ShiniesPostUI.OnRButtonMenu_BuyAuction()
	if( mouseOverAuction ~= nil ) then
		ShiniesAPI:Auction_Buy( mouseOverAuction )
	end
end

function ShiniesPostUI.OnRButtonMenu_CancelAuction()
	if( mouseOverAuction ~= nil ) then
		ShiniesAPI:Auction_Cancel( mouseOverAuction )
	end
end

function ShiniesPostUI.OnRButtonMenu_UsePricePer()
	if( mouseOverAuction ~= nil ) then
		SetPrice( mouseOverAuction.buyOutPrice / mouseOverAuction.itemData.stackCount * GetStackSize() )
	end
end

function ShiniesPostUI.OnRButtonUp_Results_ListItem()
	local slot, row, auction = GetSlotRowNumForActiveListRow()
	
	-- Add right click menu support here
	if( auction ~= nil ) then
		mouseOverAuction = auction
		
		-- Create the menu
		EA_Window_ContextMenu.CreateContextMenu( SystemData.ActiveWindow.name )
			 
		-- Menu items dependent upon the seller
		if( WStringsCompare( mouseOverAuction.sellerName, GameData.Player.name ) == 0 ) then
		 	EA_Window_ContextMenu.AddMenuItem( T[towstring("Cancel Auction")]  .. L":  " .. mouseOverAuction.itemData.name, ShiniesPostUI.OnRButtonMenu_CancelAuction, false, true )	
		else
			EA_Window_ContextMenu.AddMenuItem( T[towstring("Buy Item")] .. L":  " .. mouseOverAuction.itemData.name, ShiniesPostUI.OnRButtonMenu_BuyAuction, false, true )
		end
		
		-- General menu items
		EA_Window_ContextMenu.AddMenuItem( T[(towstring"Use Price Per")], ShiniesPostUI.OnRButtonMenu_UsePricePer, false, true )
		
		EA_Window_ContextMenu.Finalize()
	end
end

function ShiniesPostUI.OnPlayerCraftingSlotUpdated( updatedSlots )
	if( not WindowGetShowing( config.windowId ) ) then return end
	-- Update the total item count display
	UpdateTotalItemCountDisplay()
	
	-- Update the selling count display
	UpdateSellingCountDisplay()
	
	-- Check if we can enable the post auction button
	CheckPostAuctionEnable()
end

function ShiniesPostUI.OnPlayerInventorySlotUpdated( updatedSlots )
	-- If we are not visible we do not care about this event
	if( not WindowGetShowing( config.windowId ) ) then return end
	-- Update the total item count display
	UpdateTotalItemCountDisplay()
	
	-- Update the selling count display
	UpdateSellingCountDisplay()
	
	-- Check if we can enable the post auction button
	CheckPostAuctionEnable()
end

function ShiniesPostUI.OnPlayerMoneyUpdated()
	if( not WindowGetShowing( config.windowId ) ) then return end 
	CheckPostAuctionEnable()
end

function ShiniesPostUI.PopulateResultsDisplay()
	local dx, dy = WindowGetDimensions( windowResults .. "Seller" )
	 
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesPostUI_ResultsList.PopulatorIndices ) 
	do
		local rowName = windowResults .. "ListRow".. row
		
		local displayData = ShiniesPostUI.listDisplayData[data]
		
		if( displayData ~= nil ) then
			WindowSetDimensions( rowName .. "Seller", dx, dy )
			
			LabelSetText( rowName .. "Seller", 				displayData.Seller )
			LabelSetText( rowName .. "Stack", 				displayData.StackFormatted )
			LabelSetText( rowName .. "TimeLeft",			towstring(displayData.TimeLeftFormatted) )
			LabelSetText( rowName .. "PricePer",			displayData.PricePerFormatted )
			LabelSetText( rowName .. "Price", 				displayData.PriceFormatted )
			
			WindowSetShowing( rowName .. "Mouseover", false )
		end
	end
end

function ShiniesPostUI.OnPriceChange()
	if( handlePriceChange ) then
		-- The user has entered in their own price, update our local item price
		SetActiveItemPrice( GetPrice() / GetStackSize() )
	
		-- Check if we can enable the post button
		CheckPostAuctionEnable()
	end
end

--
-- BEGIN LOCAL FUNCTION DEFINITION
--

function Auction_AddKeyTabWindow( e )
	-- Add the window to our list
	tinsert( window.Auction.TabOrder, e.name )

	-- Add the reverse lookup
	window.Auction.TabOrderLookup[e.name] = #window.Auction.TabOrder
	
	-- Setup the function
	e.OnKeyTab = 
		function()
			Auction_OnKeyTab( e.name )
		end
	e:RegisterEvent( "OnKeyTab" )
end

function Auction_OnKeyTab( focusWindow )
	-- Get this windows index
	local idx =  window.Auction.TabOrderLookup[focusWindow]
	
	-- We have received an appropriate window Id
	if( idx ~= nil ) then
		local nextWindow = window.Auction.TabOrder[idx+1]
		
		-- If the next window is nil, attempt the first window
		if( nextWindow == nil ) then
			nextWindow = window.Auction.TabOrder[1]	   	
		end
		
		if( nextWindow ~= nil and DoesWindowExist( nextWindow ) ) then
		    WindowAssignFocus( nextWindow, true)
		end
	end
end

function CheckPostAuctionEnable()
	local enableCreateButton 	= false
	local data					= GetActiveItemData()
	
	if( data ~= nil ) then
	 	local totalStackCount 		= GetStacks() * GetStackSize()
		local totalItemCount 		= ShiniesAPI:Inventory_TotalItemCount( data.uniqueID )
		local depositPrice 			= ShiniesAPI:Item_GetAuctionDeposit( data )    
    	
    	
    	-- 1) There is no active query
		-- 2) The user is looking to sell more than 1 items
    	-- 3) The user has enough of the items in the inventory to fulfill the requirement
    	-- 4) The user has enough money to fullfil the deposit required to create the auctions
    	-- 5) The user has set a price for the item
		if( activeQueryId == 0 and
			( totalStackCount > 0 ) and 
			( totalItemCount >= totalStackCount ) and
			( Player.GetMoney() >= depositPrice * totalStackCount ) and
			( GetActiveItemPrice() > 0 ) and
			ShiniesAPI:IsServerAvailable() ) then
			enableCreateButton = true
		end
	end
	window.Auction.E.PostAuction_Button:SetEnabled( enableCreateButton )
end

function ClearResultsDisplay()
	wipe( queryResultsData )
	wipe( ShiniesPostUI.listDisplayData )
	ListBoxSetDisplayOrder( windowResults .. "List", new() )
end

function ClearSortButton()
    if( sortColumnName == "" ) then return end

    WindowSetShowing( sortColumnName .. "DownArrow", false )
    WindowSetShowing( sortColumnName .. "UpArrow", false )
    
    sortColumnName = "" 
    sortColumnNum = 0
    shouldSortIncreasing = true
end

function DisplaySortedData()
	if( shouldSortIncreasing ) then
        ListBoxSetDisplayOrder( windowResults .. "List", displayOrder )
    else
        ListBoxSetDisplayOrder( windowResults .. "List", reverseDisplayOrder )
    end 
end

function GeneratePrice()
	local profitOverVendor	= 0
	local pricingMod 		= L""
	local price				= 0
	local data				= GetActiveItemData()
	
	-- Verify we have an active item first
	if( data ~= nil ) then
		-- Ask the pricing module for the price
		price, _, pricingMod = SPA:GetItemPrice( data, queryResultsData )
	end
	
	-- Update the active item price
	SetActiveItemPrice( price )
end

function GetActiveItemData()
	return activeItemData
end

function GetActiveItemPrice()
	return activeItemPrice
end

function GetSlotRowNumForActiveListRow()
	local rowNumber, slowNumber, auction = 0, 0
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowResults .. "List", rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	slotNumber = ShiniesPostUI.listDisplayData[dataIndex].slotNum
    
	    -- Get the data
	    if( slotNumber ~= nil ) then
	    	auction = queryResultsData[slotNumber]
	    end
	end
    
	return slotNumber, rowNumber, auction
end

function GetPrice()
	local g, s, b
	
	g = tonumber( window.Auction.E.Gold_TextBox:GetText() ) or 0
	s = tonumber( window.Auction.E.Silver_TextBox:GetText() ) or 0
	b = tonumber( window.Auction.E.Brass_TextBox:GetText() ) or 0
	
	return ( g * 10000 ) + ( s * 100 ) + b
end

function GetStacks()
	return tonumber( window.Auction.E.Stacks_TextBox:GetText() ) or 0
end

function GetStackSize()
	return tonumber( window.Auction.E.StackSize_TextBox:GetText() ) or 0
end

function InitializeAuctionUI()
	local e
	local w
	
	-- Auction Window
	w = LibGUI( "window", windowAuction, "ShiniesWindowDefault" )
	w:Resize( 260, 200 )
	w:Show()
	w:Parent( config.windowId )
	w.TabOrder = new()
	w.TabOrderLookup = new()
	w.E = new()
	window.Auction = w
	
	-- Price Label
    e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 300, 20 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Auction, "topleft", "topleft", 5, 10 )
    e:SetText( T["Price:"] )
    window.Auction.E.Price_Label = e
	
	-- Gold Textbox
    e = window.Auction( "Textbox", nil, "ShiniesPostUI_GoldCoin_EditBox_DefaultFrame" )
    e:Resize( 70, 27 )
    e:AddAnchor( window.Auction.E.Price_Label, "bottomleft", "topleft", 0, 0 )
    Auction_AddKeyTabWindow( e )	
	window.Auction.E.Gold_TextBox = e
	
	-- Gold Coin Window
	e = window.Auction( "window", nil, "Shinies_GoldCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Auction.E.Gold_TextBox, "right", "left", 2, 0 )
    window.Auction.E.GoldCoin_Window = e
    
    -- Silver Textbox
    e = window.Auction( "Textbox", nil, "ShiniesPostUI_SilverCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Auction.E.GoldCoin_Window, "right", "left", 4, 0 )
    Auction_AddKeyTabWindow( e )	
	window.Auction.E.Silver_TextBox = e
	
	-- Silver Coin Window
	e = window.Auction( "window", nil, "Shinies_SilverCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Auction.E.Silver_TextBox, "right", "left", 2, 0 )
    window.Auction.E.SilverCoin_Window = e
    
    -- Brass Textbox
    e = window.Auction( "Textbox", nil, "ShiniesPostUI_BrassCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( window.Auction.E.SilverCoin_Window, "right", "left", 4, 0 )
    Auction_AddKeyTabWindow( e )	
	window.Auction.E.Brass_TextBox = e
	
	-- Brass Coin Window
	e = window.Auction( "window", nil, "Shinies_BrassCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( window.Auction.E.Brass_TextBox, "right", "left", 2, 0 )
    window.Auction.E.BrassCoin_Window = e
    
    -- Restriction Label
    e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AnchorTo( window.Auction.E.Gold_TextBox, "bottomleft", "topleft", 0, 5 )
    e:SetText( T["Restriction:"] )
    window.Auction.E.Restriction_Label = e
    
	-- Restriction Combo
    e = window.Auction( "combobox", nil, "Shinies_ComboBox_DefaultResizableLarge" )
    e:AnchorTo( window.Auction.E.Restriction_Label, "bottomleft", "topleft", 0, 0 )
    for _, item in ipairs( ShiniesConstants.AUCTION_RESTRICTIONS ) 
	do 
		e:Add( item.text )
	end
	e.Reset =
		function()
			window.Auction.E.Restriction_Combo:SelectIndex( 1 )
		end
	e:SelectIndex( 1 )
    window.Auction.E.Restriction_Combo = e    
    
    -- Stacks Label
    e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AnchorTo( window.Auction.E.Restriction_Combo, "bottomleft", "topleft", 0, 5 )
    e:SetText( T["Stacks: (number x size)"] )
    window.Auction.E.Stacks_Label = e
     
    -- Stacks Textbox
    e = window.Auction( "Textbox", nil, "ShiniesPostUI_Stacks_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AnchorTo( window.Auction.E.Stacks_Label, "bottomleft", "topleft", 0, 0 )
    Auction_AddKeyTabWindow( e )	
	window.Auction.E.Stacks_TextBox = e
    
    -- Stacks Multiplier Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 20, 20 )
    e:Align( "center" )
    e:SetText( L"x" )
    e:AddAnchor( window.Auction.E.Stacks_TextBox, "right", "left", 2, 0 )
    window.Auction.E.StacksMultiplier_Label = e
    
    -- Stack Size Textbox
    e = window.Auction( "Textbox", nil, "ShiniesPostUI_StackSize_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AnchorTo( window.Auction.E.StacksMultiplier_Label, "right", "left", 2, 0 )
    Auction_AddKeyTabWindow( e )	
	window.Auction.E.StackSize_TextBox = e
    
    -- Stacks Equals Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 20, 20 )
    e:Align( "center" )
    e:SetText( L"=" )
    e:AddAnchor( window.Auction.E.StackSize_TextBox, "right", "left", 2, 0 )
    window.Auction.E.StacksEquals_Label = e
    
    -- Stacks Total Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 80, 20 )
    e:Align( "leftcenter" )
    e:AddAnchor( window.Auction.E.StacksEquals_Label, "right", "left", 2, 0 )
    window.Auction.E.StacksTotal_Label = e
    
    -- Auction Fee Description Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Auction.E.Stacks_TextBox, "bottomleft", "topleft", 0, 10 )
    e:SetText( T["Auction Fee:"] )
    window.Auction.E.AuctionFeeDescription_Label = e
    
    -- Auction Fee Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "center" )
    e:AddAnchor( window.Auction.E.AuctionFeeDescription_Label, "bottomleft", "topleft", 0, 0 )
    e:Color( 255, 255, 255 )
	window.Auction.E.AuctionFee_Label = e
	
	-- Vendor Sell Description Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Auction.E.AuctionFee_Label, "bottomleft", "topleft", 0, 5 )
    e:SetText( 	T["Vendor Sell Price:"] )
    window.Auction.E.VendorSellDescription_Label = e
    
    -- Vendor Sell Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "center" )
    e:AddAnchor( window.Auction.E.VendorSellDescription_Label, "bottomleft", "topleft", 0, 0 )
    e:Color( 255, 255, 255 )
	window.Auction.E.VendorSell_Label = e
	
	-- Profit Over Vendor Description Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Auction.E.VendorSell_Label, "bottomleft", "topleft", 0, 25 )
    e:SetText( 	T["Profit Over Vendor:"] )
    window.Auction.E.ProfitOverVendorDescription_Label = e
    
    -- Profit Label
	e = window.Auction( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 255, 20 )
    e:Align( "center" )
    e:AddAnchor( window.Auction.E.ProfitOverVendorDescription_Label, "bottomleft", "topleft", 0, 0 )
    e:Color( 255, 255, 255 )
	window.Auction.E.ProfitOverVendor_Label = e
	
	-- Post Auction Button
    e = window.Auction( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 250 )
    e:Show( )
    e:AnchorTo( window.Auction, "bottom", "bottom", 0, -5 )
    e:SetText( T["Post Auction(s)"] )
    e:SetEnabled( false )
    e.OnLButtonUp = 
		function()
			ShiniesPostUI.OnLButtonUp_PostAuctionButton()
		end
    window.Auction.E.PostAuction_Button = e
    
    -- Fixed Price Checkbox
	e = window.Auction( "Checkbox" )
	e:AnchorTo( window.Auction.E.PostAuction_Button, "topleft", "bottomleft", 10, -10 )
	window.Auction.E.FixedPrice_CheckBox = e
	
	-- Fixed Price Label
    e = window.Auction( "Label" )
    e:Resize( 250 )
    e:Align( "leftcenter" )
    e:AnchorTo( window.Auction.E.FixedPrice_CheckBox, "right", "left", 10, 0 )
    e:Font( "font_chat_text" )
    e:SetText( T["Remember Fixed Price"] )
    window.Auction.E.FixedPrice_Label = e
end

function InitializeItemUI()
	local e
	local w
	
	-- Item Window
	w = LibGUI( "window", windowItem, "ShiniesWindowDefault" )
	w:Resize( 800, 100 )
	w:Show()
	w:Parent( config.windowId )
	w.E = {}
	window.Item = w
	
	-- Item Button
    e = window.Item( "Button", windowItem .. "ItemButton", "Shinies_IconButton" )
    e:Resize( 64, 64 )
    e:AnchorTo( window.Item, "left", "left", 15, 0 )
    e.OnRButtonUp =
    	function()
    		SetActiveItemData( nil )
    	end
    e.OnLButtonUp = 
    	function()
    		-- User has dropped something to be sold
			if( Cursor.IconOnCursor() and Cursor.Data and ShiniesAPI:Item_IsValidCursorSource( Cursor.Data.Source ) and Cursor.Data.SourceSlot ) then
				local itemData = DataUtils.GetItemData( Cursor.Data.Source, Cursor.Data.SourceSlot )
				SetActiveItemData( itemData )
				Cursor.Clear()
				
				-- If the tooltip window is showing, update it for this item
				if( tooltipWindow ~= nil and DoesWindowExist( tooltipWindow ) ) then
					ShowItemTooltip()
				end
			else
				SetActiveItemData( nil )
				ShowItemTooltip()
			end
    	end
    e.OnMouseOver =
    	function()
    		ShowItemTooltip()
    	end
    window.Item.E.Item_Button = e
	
	--Item Button Overlay
	e = window.Item( "Button", windowItem .. "ItemButtonOverlay", "Shinies_IconButton_Overlay" )
    e:Resize( WindowGetDimensions( window.Item.E.Item_Button.name ) )
    e:AnchorTo( window.Item.E.Item_Button, "center", "center", 0, 0 )
    e:Layer( "popup" )
    e:Tint( 222, 192, 50 )
    window.Item.E.ItemOverlay_Button = e
    
    -- Item Count
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 64, 30 )
    e:Align( "bottom" )
    e:AddAnchor(window.Item.E.Item_Button, "bottom", "bottom", 0, -5 )
    e:Layer( "secondary" )
    window.Item.E.ItemCount_Label = e
    
    -- Item Name
    e = window.Item( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 800, 30 )
    e:Align( "leftcenter" )
    e:AddAnchor(window.Item.E.Item_Button, "topright", "topleft", 10, 0 )
    window.Item.E.ItemName_Label = e
    
    -- Refresh Button
    e = window.Item( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 160 )
    e:Show( )
    e:AnchorTo( window.Item, "bottomright", "bottomright", 0, -5 )
    e:SetText( T["Refresh"] )
    e.OnLButtonUp = 
		function()
			-- Check if the button is disabled as button presses still go through to a disabled button
			if( not window.Item.E.Refresh_Button:Enabled() ) then return end
	
			RefreshResultsDisplay()
		end
    window.Item.E.Refresh_Button = e
end
	
function InitializeUI()
	if( uiInitialized == true ) then return end
	
	-- We are now considered initialized
	uiInitialized = true
	
	-- Create our config window here, so that Shinies can use it
	CreateWindow( config.windowId, false )
	
	-- Create a table for our windows
	window = new()
	
	-- Initialize the windows sections
	InitializeAuctionUI()
	InitializeItemUI()
	
	-- Reanchor the user interface elements of this module
	WindowClearAnchors( windowItem )
	WindowClearAnchors( windowAuction )
	WindowClearAnchors( windowResults )
	
	-- Anchor the item window to the top portion of the window
	WindowAddAnchor( windowItem, "topleft", config.windowId, "topleft", 0, 0 )
	WindowAddAnchor( windowItem, "topright", config.windowId, "topright", 0, 0 )
	
	-- Anchor the auction window to the lower left portion of the window
	WindowAddAnchor( windowAuction, "bottomleft", windowItem, "topleft", 0, 0 )
	WindowAddAnchor( windowAuction, "bottomleft", config.windowId, "bottomleft", 0, 0 )
	
	-- Anchor the results window in the lower right portion of the window
	WindowAddAnchor( windowResults, "topright", windowAuction, "topleft", 0, 0 )
	WindowAddAnchor( windowResults, "bottomright", config.windowId, "bottomright", 0, 0 )
	
	-- Results Window
	for i, data in ipairs( sortHeaderData ) do
        local buttonName = windowResults .. data.column
        ButtonSetText( buttonName, towstring(data.text) )
        WindowSetShowing( buttonName .. "DownArrow", false )
        WindowSetShowing( buttonName .. "UpArrow", false )
    end
    DataUtils.SetListRowAlternatingTints( windowResults .. "List", MAX_VISIBLE_ROWS )
    
    -- Stop/hide our animation window
    StopSearchingAnimation()
end

function RefreshResultsDisplay()
	-- Clear any displayed results
	ClearResultsDisplay()
	
	local data = GetActiveItemData()
	
	-- If we do not have an item there is nothing to do
	if( data == nil ) then return end
	
	-- Start the query
	activeQueryId = ShiniesAPI:Query_SingleItem( data.name )
	
	if( activeQueryId > 0 ) then
		-- Display our start animation
		StartSearchingAnimation()
	end
	
	-- Hit the post auction enable check, seeing we have a new query
	CheckPostAuctionEnable()
end

function SetActiveItemData( itemData )
	local stacks 			= 0
	local size	 			= 0
	local texture			= ""
	local textureDx			= 0
	local textureDy			= 0
	local itemName			= L""
	local color				= { r=255, g=255, b=255 } 
	local fixedPrice		= false
	
	-- Clear our results display
	ClearResultsDisplay()
	
	-- Update our active item data	
	activeItemData = itemData
	SetActiveItemPrice( 0 )
	
	if( activeItemData ~= nil ) then
		stacks 		= 1
		size 		= activeItemData.stackCount
		fixedPrice 	= SPA:GetFixedItemPrice( activeItemData, {} ) > 0 	
	end
	
	-- Update the fixed price checkmark for the user
	window.Auction.E.FixedPrice_CheckBox:SetValue( fixedPrice )
	
	-- Set our stacks/size
	SetStacks( stacks )
	SetStackSize( size )
	
	-- If an item was passed, lookup the appropriate data 
	if( activeItemData ~= nil ) then
		texture, textureDx, textureDy = GetIconData( activeItemData.iconNum )
		color = DataUtils.GetItemRarityColor( activeItemData )
		itemName = activeItemData.name
	end
	
	-- Update the display items accordingly
	DynamicImageSetTexture( window.Item.E.Item_Button.name .. "Icon", texture, textureDx, textureDy )
	window.Item.E.ItemOverlay_Button:Tint( color.r, color.g, color.b )
	
	window.Item.E.ItemName_Label:SetText( itemName )
	window.Item.E.ItemName_Label:Color( color.r, color.g, color.b )
	
	-- Update the total item display
	UpdateTotalItemCountDisplay()
	
	-- Refresh the current results
	RefreshResultsDisplay()
end

function SetActiveItemPrice( price )
	if( price == nil or price < 0 ) then 
		activeItemPrice = 0
	else
		activeItemPrice = price 
	end
	-- Update the price displayed
	UpdatePricingDisplay()	
end

function SetListDisplayItem( slotNum, auction )
	local listDisplayItem = new()
	
	listDisplayItem.slotNum 				= slotNum
	listDisplayItem.selfBid 				= auction.highBidderName == GameData.Player.name
	
	listDisplayItem.Seller					= auction.sellerName
	
    listDisplayItem.Stack					= auction.itemData.stackCount
	listDisplayItem.StackFormatted			= towstring( auction.itemData.stackCount )
	
	listDisplayItem.TimeLeft				= auction.timeLeft
	listDisplayItem.TimeLeftFormatted		= ShiniesConstants.AUCTION_DURATIONS[auction.timeLeft].text
    
    listDisplayItem.Price					= auction.buyOutPrice
	listDisplayItem.PriceFormatted			= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice, true, true )
    
    listDisplayItem.PricePer				= auction.buyOutPrice / auction.itemData.stackCount
	listDisplayItem.PricePerFormatted		= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice / auction.itemData.stackCount, true, true )
    
    ShiniesPostUI.listDisplayData[slotNum] 	= listDisplayItem
end

function SetStacks( size )
	window.Auction.E.Stacks_TextBox:SetText( towstring( size ) )
end

function SetStackSize( count )
	window.Auction.E.StackSize_TextBox:SetText( towstring( count ) )
end

function SetPrice( price )
	local g, s, b = ShiniesAPI:Display_GetGSBFromMoney( price )
	
	window.Auction.E.Gold_TextBox:SetText( towstring( g ) )
	window.Auction.E.Silver_TextBox:SetText( towstring( s ) )
	window.Auction.E.Brass_TextBox:SetText( towstring( b ) )
end

function ShowResults()
	-- Clear our current display data
	wipe(displayOrder)
    wipe(reverseDisplayOrder)
    
	-- Sort before displaying
    SortResults()
    
    -- Create the list we will use to display
    for index,_ in ipairs( ShiniesPostUI.listDisplayData )
    do
    	-- Add this to the end of our display
    	table.insert( displayOrder, index )
    	
    	-- Add this to the beginning of our display
    	table.insert( reverseDisplayOrder, 1, index )
    end
    
    -- Display the sorted data
    DisplaySortedData()
end

function ShowItemTooltip()
	local data = GetActiveItemData()
	if( ShiniesAPI:Item_IsValid( data ) ) then
		tooltipWindow = Tooltips.CreateItemTooltip( data, 
                                SystemData.MouseOverWindow.name,
                                Tooltips.ANCHOR_WINDOW_RIGHT, 
                                flags ~= SystemData.ButtonFlags.SHIFT, 
                                nil, nil, true )
    else
    	Tooltips.ClearTooltip()
    	tooltipWindow = nil
    end
end

function SortResults()
	if( sortColumnNum >= 0 ) then
        local comparator = sortHeaderData[sortColumnNum].sortFunc
        table.sort( ShiniesPostUI.listDisplayData, comparator )
    end
end

function StartSearchingAnimation()
	WindowSetShowing( windowSearchingAnim, true )
	AnimatedImageStartAnimation( windowSearchingAnim, 0, true, false, 0 )
end

function StopSearchingAnimation()
	WindowSetShowing( windowSearchingAnim, false )
	AnimatedImageStopAnimation( windowSearchingAnim )
end

function UninitializeUI()
	if( uiInitialized == false ) then return end
	
	-- Stop/hide our animation window
    StopSearchingAnimation()
	
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

function UpdatePricingDisplay()
	local profitOverVendor	= 0
	local pricingMod 		= L""
	local color				= positiveColor
	local data				= GetActiveItemData()
	local price				= GetActiveItemPrice()
	
	-- Verify we have an active item first
	if( data ~= nil and price > 0 ) then
		profitOverVendor = ShiniesAPI:Item_GetProfitOverVendor( data, price )
	end
	
	-- Display the price
	handlePriceChange = false
	SetPrice( price * GetStackSize() )
	handlePriceChange = true
	
	-- Display the profit over vendor
	window.Auction.E.ProfitOverVendor_Label:SetText( ShiniesAPI:Display_GetFormattedMoney( profitOverVendor * GetStackSize(), true, true ) )
	if( profitOverVendor < 0 ) then
		color = negativeColor	
	end
	window.Auction.E.ProfitOverVendor_Label:Color( unpack( color ) )
end

function UpdateSellingCountDisplay()
	local stacksTotalColor 			= positiveColor
	local totalStackCount			= 0
	local data						= GetActiveItemData()
	
	if( data ~= nil ) then
		totalStackCount 		= GetStacks() * GetStackSize()
		local totalItemCount 	= ShiniesAPI:Inventory_TotalItemCount( data.uniqueID )
		
		-- If the stacks total exceeds what the user has in their inventory color it red
    	if( totalStackCount > totalItemCount or totalStackCount == 0 ) then
    		stacksTotalColor = negativeColor
    	end
    end
	
	window.Auction.E.StacksTotal_Label:SetText( towstring( totalStackCount ) )
	window.Auction.E.StacksTotal_Label:Color( unpack( stacksTotalColor ) )	
end

function UpdateTotalItemCountDisplay()
	local totalItemCount = L""
	local data = GetActiveItemData()
	if( data ~= nil ) then
		totalItemCount = towstring( ShiniesAPI:Inventory_TotalItemCount( data.uniqueID ) )
	end
	window.Item.E.ItemCount_Label:SetText( totalItemCount )
end