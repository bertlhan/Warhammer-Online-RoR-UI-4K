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
local MODNAME 			= "Shinies-UI-Browse"
local ShiniesBrowseUI 	= Shinies : NewModule( MODNAME )
_G.ShiniesBrowseUI 		= ShiniesBrowseUI
ShiniesBrowseUI:SetModuleType( "UI" )
ShiniesBrowseUI:SetName( T["Shinies Browse UI"] )
ShiniesBrowseUI:SetDescription(T["Provides a user interface for searching the auction house."])
ShiniesBrowseUI:SetDefaults( 
{ 
	global = 
	{
		searches 				= 
		{
			show				= false,
			data				= {},
		},
	},
} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )
local ShiniesConstants 	= ShiniesConstants

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local tremove				= table.remove
local string_format 		= string.format
local wstring_len			= wstring.len

local config	= {
	name			= T["Browse"],
	windowId		= "ShiniesBrowseUI",
	idx				= 1,
	default			= true,
}

local window			

local MAX_RESULTS_ROWS 	= 24
local MAX_SEARCHES_ROWS = 15

local windowCriteria		= config.windowId .. "_Criteria"
local windowResults 		= config.windowId .. "_Results"
local windowSearches		= config.windowId .. "_Searches"
local windowSearchingAnim 	= config.windowId .. "_SearchingAnim"

local Results_SortColumnNum 		= 0				
local Results_SortColumnName 		= ""		
local Results_ShouldSortIncreasing 	= true
local Results_DisplayOrder			= new()
local Results_ReverseDisplayOrder	= new()

local Searches_SortColumnNum 		= 0				
local Searches_SortColumnName 		= ""		
local Searches_ShouldSortIncreasing = true
local Searches_DisplayOrder			= new()
local Searches_ReverseDisplayOrder	= new()

ShiniesBrowseUI.listResultsData = new()
ShiniesBrowseUI.listSearchesData = new()

local queryResultsData		= new()
local activeQueryId			= 0
local currentSummary		= L""

local function itemComparator( a, b )				return( WStringsCompare( a.Item, b.Item ) == -1 ) end
local function sellerComparator( a, b )				return( WStringsCompare( a.Seller, b.Seller ) == -1 ) end
local function stackComparator( a, b )				return( a.Stack < b.Stack ) end
local function pricePerComparator( a, b )			return( a.PricePer < b.PricePer ) end
local function priceComparator( a, b )				return( a.Price < b.Price ) end

local function nameComparator( a, b )				return( a.Name < b.Name ) end

local classComboData
local classComboDataLookup

local sortResultHeaderData =
{
	[0] = { sortFunc = pricePerComparator, },
	{ column = "Item",			text=T["Item"],				sortFunc=itemComparator,		},
	{ column = "Seller",		text=T["Seller"],			sortFunc=sellerComparator,		},
	{ column = "Stack",			text=T["Stack"],			sortFunc=stackComparator,		},
	{ column = "PricePer",		text=T["Price/Per"],		sortFunc=pricePerComparator,	},
	{ column = "Price",			text=T["Price"],			sortFunc=priceComparator,		},
}

local sortSearchHeaderData =
{
	[0] = { sortFunc = nameComparator, },
	{ column = "Name",			text=T["Name"],			sortFunc=nameComparator,		},
}

local Results_RightClickAuction	= nil
local Searches_RightClickSearch = nil

local InitializeUI, InitializeCriteriaUI, InitializeResultsUI, InitializeSearchesUI, UninitializeUI

local Criteria_AddKeyTabWindow, Criteria_BuildQuery, Criteria_LoadQuery, Criteria_OnKeyEnter, Criteria_OnKeyTab
local Criteria_RefreshComboBox, Criteria_Reset, Criteria_SubmitQuery, Criteria_UpdateComboBoxTextDisplay

local Results_ClearDisplay, Results_ClearSortButton, Results_DisplaySortedData, Results_GetSlotRowNumForActiveListRow
local Results_GetSlotRowNumForActiveListRow, Results_SetListDisplayItem, Results_Show, Results_Sort

local Searches_ClearDisplay, Searches_ClearSortButton, Searches_DisplaySortedData
local Searches_GetSlotRowNumForActiveListRow, Searches_SetListDisplayItem, Searches_Show
local Searches_Sort, Searches_ToggleDisplay, Searches_UpdateDisplay, Searches_UpdateWindowDisplay 

local StartSearchingAnimation, StopSearchingAnimation

local hook_EA_Window_Backpack_EquipmentLButtonDown

local defaultSearch =
{
	name						= L"",
	query						= {}
}

local comboSelected_Modifiers = new()
local comboSelected_ItemTypes = new()
local comboSelected_ItemSlots = new()

local lastComboSelected

local uiInitialized = false

-- generic deepcopy
local function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return new_table
    end
    return _copy(object)
end

function ShiniesBrowseUI:OnInitialize()
	Shinies:Debug( "ShiniesBrowseUI:OnInitialize" )

	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesBrowseUI:OnEnable()
	Shinies:Debug( "ShiniesBrowseUI:OnEnable" )
	
	-- Initialize the user interface
	InitializeUI()
	
	-- Clear the results display
	Results_ClearDisplay()
	Searches_ClearDisplay()
	
	-- Register our callback handlers
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess",  	"OnAuctionQuerySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryFailure",  	"OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryTimeout",  	"OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionBuySuccess",		"OnAuctionBuySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateSuccess", 	"OnAuctionCreateSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCancelSuccess", 	"OnAuctionCancelSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionHouseAvailabilityChanged", "OnAuctionHouseAvailabilityChanged" )
	
	-- Check the AH availibility from the start
	self:OnAuctionHouseAvailabilityChanged( "OnAuctionHouseAvailabilityChanged", ShiniesAPI:IsServerAvailable() )
		
	-- Load our saved searches
	self:Searches_UpdateDisplay()
	
	-- Hook the backback, so we can handle shift click
	hook_EA_Window_Backpack_EquipmentLButtonDown 				= EA_Window_Backpack.EquipmentLButtonDown
	EA_Window_Backpack.EquipmentLButtonDown						= ShiniesBrowseUI.EA_Window_Backpack_EquipmentLButtonDown
end

function ShiniesBrowseUI:OnDisable()
	Shinies:Debug( "ShiniesBrowseUI:OnDisable" )
	
	-- Remove the hook
	EA_Window_Backpack.EquipmentLButtonDown						= hook_EA_Window_Backpack_EquipmentLButtonDown
	
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryTimeout" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCancelSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionBuySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionHouseAvailabilityChanged" )
	
	UninitializeUI()
end

function ShiniesBrowseUI:GetUserInterface()
	return config
end

--
-- START ALPHABETICAL ORDERING OF FUNCTIONS HERE
--
function ShiniesBrowseUI:OnAuctionBuySuccess( eventName, identifier, auction )
	if( not ShiniesAPI:Auction_HasQueuedBuyAuctions() and WindowGetShowing( config.windowId ) ) then
		Criteria_SubmitQuery()
	end
end

function ShiniesBrowseUI:OnAuctionCancelSuccess( eventName, identifier, auction )
	if( not ShiniesAPI:Auction_HasQueuedCancelAuctions() and WindowGetShowing( config.windowId ) ) then
		Criteria_SubmitQuery()
	end
end

function ShiniesBrowseUI:OnAuctionCreateSuccess( eventName, identifier, auction )
	if( not ShiniesAPI:Auction_HasQueuedCreateAuctions() and WindowGetShowing( config.windowId ) ) then
		Criteria_SubmitQuery()
	end
end

function ShiniesBrowseUI:OnAuctionHouseAvailabilityChanged( eventName, serverAvailable )
	window.Criteria.E.Search_Button:SetEnabled( serverAvailable )
end

function ShiniesBrowseUI:OnAuctionQueryFailure( eventName, identifier, query, results, failure )
	if( activeQueryId == identifier ) then
		StopSearchingAnimation()
		
		if( failure ~= nil ) then
			Shinies:Debug( failure )
			DialogManager.MakeOneButtonDialog( failure, T["Ok"], nil )
		end
	end
end

function ShiniesBrowseUI:OnAuctionQuerySuccess( eventName, identifier, query, results )
	-- Make sure the results are for the query we more recently executed
	if( activeQueryId == identifier ) then
		-- Hide our searching animation
		StopSearchingAnimation()
		
		-- Clear our current display data
		wipe( ShiniesBrowseUI.listResultsData )
		
		-- Store our query results
		queryResultsData = results
	
		-- Prepare our results data
		for slotNum, auction in pairs( results ) 
		do
			Results_SetListDisplayItem( slotNum, auction )
    	end
    	
    	-- Reset our query ID
    	activeQueryId = 0
    	
    	-- Display the results data
    	Results_Show()
    end
end

function ShiniesBrowseUI.Criteria_ReopenComboBox()
	if( lastComboSelected:len() > 0 ) then
		ComboBoxExternalOpenMenu( lastComboSelected )
		WindowUnregisterEventHandler( lastComboSelected, SystemData.Events.L_BUTTON_UP_PROCESSED )
		lastComboSelected = ""
	end
end

function ShiniesBrowseUI.EA_Window_Backpack_EquipmentLButtonDown(...)
	-- Call the hook first
	hook_EA_Window_Backpack_EquipmentLButtonDown(...)
	
	-- Only process if we are showing
	if( WindowGetShowing( config.windowId ) ) then
		local slot, flags = ...
		if( flags == ( SystemData.ButtonFlags.SHIFT + SystemData.ButtonFlags.CONTROL ) ) then
			local inventory = EA_Window_Backpack.GetItemsFromBackpack( EA_Window_Backpack.currentMode )
			if( inventory ~= nil ) then
    			ShiniesBrowseUI:SearchForItem( inventory[slot] )
    		end
		end
	end 
end

function ShiniesBrowseUI:LoadQuery( query )
	Criteria_LoadQuery(query)
end

function ShiniesBrowseUI.OnHidden()
	if( not uiInitialized ) then return end
	
	-- Clear any results that are displayed to free up memory
	-- TODO: Do we want this here for this UI module?
	Results_ClearDisplay()
	
	-- Explicitly hide our search window, as it is not our child
	WindowSetShowing( windowSearches, false )
end

function ShiniesBrowseUI.OnLButtonUp_Results_ListItem()
	-- Get the auction the user clicked
	local slot, row, auction = Results_GetSlotRowNumForActiveListRow()
	
	-- Search for the item
	ShiniesBrowseUI:SearchForItem( auction.itemData )
end

function ShiniesBrowseUI.OnLButtonUp_Results_SortButton()
	if( Results_SortColumnName == SystemData.ActiveWindow.name ) then
		if Results_ShouldSortIncreasing then
			Results_ShouldSortIncreasing = ( not Results_ShouldSortIncreasing )
		else
			Results_ClearSortButton()
		end
    else
        Results_ClearSortButton()
        Results_SortColumnName = SystemData.ActiveWindow.name
        Results_SortColumnNum = WindowGetId( SystemData.ActiveWindow.name )
    end

	if( Results_SortColumnNum > 0 ) then
		WindowSetShowing( Results_SortColumnName.."DownArrow", Results_ShouldSortIncreasing )
		WindowSetShowing( Results_SortColumnName.."UpArrow", not Results_ShouldSortIncreasing )
	end
	
    Results_Show()
end

function ShiniesBrowseUI.OnLButtonUp_Searches()
	local slot, row, query = Searches_GetSlotRowNumForActiveListRow()
	
	-- Load the query
	Criteria_LoadQuery(query.query)
	
	-- Execute the query
	Criteria_SubmitQuery()
end

function ShiniesBrowseUI.OnLButtonUp_Searches_SortButton()
	if( Searches_SortColumnName == SystemData.ActiveWindow.name ) then
		if Searches_ShouldSortIncreasing then
			Searches_ShouldSortIncreasing = ( not Searches_ShouldSortIncreasing )
		else
			Searches_ClearSortButton()
		end
    else
        Searches_ClearSortButton()
        Searches_SortColumnName = SystemData.ActiveWindow.name
        Searches_SortColumnNum = WindowGetId( SystemData.ActiveWindow.name )
    end

	if( Searches_SortColumnNum > 0 ) then
		WindowSetShowing( Searches_SortColumnName.."DownArrow", Searches_ShouldSortIncreasing )
		WindowSetShowing( Searches_SortColumnName.."UpArrow", not Searches_ShouldSortIncreasing )
	end
	
    Searches_Show()
end

function ShiniesBrowseUI.OnMouseOver_Results_ListItem( flags, x, y )
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, true )
	end
	
	local slot, row, auction = Results_GetSlotRowNumForActiveListRow()
	
	if( auction ~= nil ) then
		if( ShiniesAPI:Item_IsValid( auction.itemData ) ) then
			Tooltips.CreateItemTooltip( auction.itemData, 
                                SystemData.MouseOverWindow.name,
                                Tooltips.ANCHOR_WINDOW_RIGHT, 
                                flags ~= SystemData.ButtonFlags.SHIFT, 
                                nil, nil, true )
        else
    		Tooltips.ClearTooltip()
        end
    else
    	Tooltips.ClearTooltip()
    end
end

function ShiniesBrowseUI.OnMouseOverEnd_Results_ListItem()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, false )
	end
end

function ShiniesBrowseUI.OnMouseOver_Searches()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, true )
	end
end

function ShiniesBrowseUI.OnMouseOverEnd_Searches()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, false )
	end
end

function ShiniesBrowseUI.OnRButtonUp_Searches()
	local slot, row, query = Searches_GetSlotRowNumForActiveListRow()
	
	-- Store the query
	Searches_RightClickSearch = slot
	
	-- Create the menu
	EA_Window_ContextMenu.CreateContextMenu( SystemData.ActiveWindow.name )
	
	EA_Window_ContextMenu.AddMenuItem( T["Delete Search"], ShiniesBrowseUI.OnRButtonMenu_Searches_DeleteSearch, false, true )	 
	
	EA_Window_ContextMenu.Finalize()
end

function ShiniesBrowseUI.OnSelChanged_Criteria_ItemSlotCombo()
	ShiniesBrowseUI.OnSelChanged_Criteria_MultiSelCombo( window.Criteria.E.ItemSlot_Combo, comboSelected_ItemSlots )
end

function ShiniesBrowseUI.OnSelChanged_Criteria_ItemTypeCombo()
	ShiniesBrowseUI.OnSelChanged_Criteria_MultiSelCombo( window.Criteria.E.ItemType_Combo, comboSelected_ItemTypes )
end

function ShiniesBrowseUI.OnSelChanged_Criteria_ModifierCombo()
	ShiniesBrowseUI.OnSelChanged_Criteria_MultiSelCombo( window.Criteria.E.Modifier_Combo, comboSelected_Modifiers )
end

function ShiniesBrowseUI.OnSelChanged_Criteria_MultiSelCombo( comboBox, dataProvider )
	if( comboBox.fireSelChange ~= nil and comboBox.fireSelChange ~= true ) then return end

	local idx = comboBox:SelectedIndex()
	if( idx ~= nil ) then
		if( idx > 1 ) then
			dataProvider[idx].isChecked = not dataProvider[idx].isChecked
			Criteria_RefreshComboBox( comboBox, dataProvider )
			lastComboSelected = comboBox.name
			WindowRegisterEventHandler( lastComboSelected, SystemData.Events.L_BUTTON_UP_PROCESSED, "ShiniesBrowseUI.Criteria_ReopenComboBox" )
		else
			comboBox.Load( ShiniesAPI:Query_CreateQueryObject() )	
		end
	end
end

function ShiniesBrowseUI.OnRButtonMenu_Results_BuyAuction()
	if( Results_RightClickAuction ~= nil ) then
		ShiniesAPI:Auction_Buy( Results_RightClickAuction )
		Results_RightClickAuction = nil
	end
end

function ShiniesBrowseUI.OnRButtonMenu_Results_CancelAuction()
	if( Results_RightClickAuction ~= nil ) then
		ShiniesAPI:Auction_Cancel( Results_RightClickAuction )
		Results_RightClickAuction = nil
	end
end

function ShiniesBrowseUI.OnRButtonMenu_Searches_DeleteSearch()
	if( Searches_RightClickSearch ~= nil ) then
		ShiniesBrowseUI:Searches_Delete( Searches_RightClickSearch )
		Searches_RightClickSearch = nil
	end	
end

function ShiniesBrowseUI.OnRButtonUp_Results_ListItem()
	local slot, row, auction = Results_GetSlotRowNumForActiveListRow()

	-- Add right click menu support here
	if( auction ~= nil ) then
		Results_RightClickAuction = auction
		
		-- Create the menu
		EA_Window_ContextMenu.CreateContextMenu( SystemData.ActiveWindow.name )
			 
		-- Menu items dependent upon the seller
		if( WStringsCompare( Results_RightClickAuction.sellerName, GameData.Player.name ) == 0 ) then
		 	EA_Window_ContextMenu.AddMenuItem( T[towstring("Cancel Auction")], ShiniesBrowseUI.OnRButtonMenu_Results_CancelAuction, false, true )	
		else
			EA_Window_ContextMenu.AddMenuItem( T[towstring("Buy Item")] .. L":  " .. Results_RightClickAuction.itemData.name, ShiniesBrowseUI.OnRButtonMenu_Results_BuyAuction, false, true )
		end
		
		EA_Window_ContextMenu.Finalize()
	end
end

function ShiniesBrowseUI.OnShown()
	if( not uiInitialized ) then return end
	Searches_UpdateWindowDisplay()
end

function ShiniesBrowseUI.PopulateResultsDisplay()
	local slotNum, auction
	 
	local dx, dy = WindowGetDimensions( windowResults .. "Item" )
	 
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesBrowseUI_ResultsList.PopulatorIndices ) 
	do
		local rowName = windowResults .. "ListRow".. row
		
		local itemData = ShiniesBrowseUI.listResultsData[data]
		
		if( itemData ~= nil ) then
			
			WindowSetDimensions( rowName .. "Item", dx, dy )
			LabelSetText( rowName .. "Item", 		itemData.Item )
			LabelSetTextColor( rowName.."Item", 	itemData.RarityColor.r, 
													itemData.RarityColor.g, 
													itemData.RarityColor.b )
			LabelSetText( rowName .. "Seller", 		itemData.Seller )
			LabelSetText( rowName .. "Stack", 		itemData.StackFormatted )
			LabelSetText( rowName .. "PricePer", 	itemData.PricePerFormatted )
			LabelSetText( rowName .. "Price", 		itemData.PriceFormatted )
			
			WindowSetShowing( rowName .. "Mouseover", false )
		end
	end
end

function ShiniesBrowseUI.PopulateSearchDisplay()
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesBrowseUI_SearchesList.PopulatorIndices ) 
	do
		local rowName = windowSearches .. "ListRow".. row
		
		local itemData = ShiniesBrowseUI.listSearchesData[data]
		
		if( itemData ~= nil ) then
			LabelSetText( rowName .. "Name", 		itemData.Name )
			WindowSetShowing( rowName .. "Mouseover", false )
		end
	end
end

function ShiniesBrowseUI:SearchForItem( itemData )
	if( itemData == nil ) then return end
	
	-- Create an empty query
	local query = ShiniesAPI:Query_CreateQueryObject()
	
	-- Set the query's item name to the auctions item name
	query.itemName = itemData.name
	
	-- Load the query
	Criteria_LoadQuery(query)
	
	-- Execute the query
	Criteria_SubmitQuery()
end

function ShiniesBrowseUI:Searches_Add( name, query )
	if( name == nil or query == nil or type(query) ~= "table" ) then return false end
	
	local search = deepcopy( defaultSearch )
	
	search.name 	= name
	search.query 	= deepcopy( query )
	
	tinsert( self.db.global.searches.data, search )
	
	self:Searches_UpdateDisplay()
	
	return true
end

function ShiniesBrowseUI:Searches_Delete( idx )
	if( idx == nil ) then return false end
	
	if( self.db.global.searches.data[idx] ~= nil ) then
		tremove( self.db.global.searches.data, idx )
		self:Searches_UpdateDisplay()
		return true
	end
	return false
end

function ShiniesBrowseUI.Searches_OnAddCancel()
	-- noop
end

function ShiniesBrowseUI.Searches_OnAddSuccess( name )
	ShiniesBrowseUI:Searches_Add( name, Criteria_BuildQuery() )
end

function ShiniesBrowseUI:Searches_UpdateDisplay()
	-- Clear our current display data
	wipe( ShiniesBrowseUI.listSearchesData )
	
	-- Prepare our results data
	for slotNum, search in pairs( self.db.global.searches.data ) 
	do
		Searches_SetListDisplayItem( slotNum, search )
	end
	
	-- Display the results data
	Searches_Show()
end

--
-- BEGIN LOCAL FUNCTION DEFINITION
--

--
-- CRITERIA SECTION
--
function Criteria_AddKeyTabWindow( e )
	-- Add the window to our list
	tinsert( window.Criteria.TabOrder, e.name )

	-- Add the reverse lookup
	window.Criteria.TabOrderLookup[e.name] = #window.Criteria.TabOrder
	
	-- Setup the function
	e.OnKeyTab = 
		function()
			Criteria_OnKeyTab( e.name )
		end
	e:RegisterEvent( "OnKeyTab" )
end

function Criteria_BuildQuery()
	local query = ShiniesAPI:Query_CreateQueryObject()
	
	local minItemLevel = window.Criteria.E.LevelMinimum_TextBox:GetText()
	if( wstring_len(minItemLevel) > 0 ) then
		query.minItemLevel = tonumber( minItemLevel ) or ShiniesConstants.MIN_ITEM_LEVEL
	else
	   	query.minItemLevel = ShiniesConstants.MIN_ITEM_LEVEL
	end
	
	local maxItemLevel = window.Criteria.E.LevelMaximum_TextBox:GetText()
	if( wstring_len(maxItemLevel) > 0 ) then
		query.maxItemLevel = tonumber( maxItemLevel ) or ShiniesConstants.MAX_ITEM_LEVEL
	else
	   	query.maxItemLevel = ShiniesConstants.MAX_ITEM_LEVEL
	end
	
	query.career				= classComboData[window.Criteria.E.Class_Combo:SelectedIndex()].value
	query.restrictionType 		= ShiniesConstants.AUCTION_RESTRICTIONS[window.Criteria.E.Restriction_Combo:SelectedIndex()].value
	
	query.minTradeSkillLevel	= 0
	query.maxTradeSkillLevel 	= 0
	
	for k, v in pairs( comboSelected_ItemTypes )
	do
		if( v.isChecked == true and v.value ~= 0 ) then
			tinsert( query.itemTypes, v.value )
			
			--
			-- A the crafting item type is checked set the trade skill level to the item levels,
			-- and move the item levels to their max values, as all crafting items seem to be
			--
			-- This will essentially break item searching if the user has multiple item types
			-- with Crafting, however, its a small drawback for the functionality of searching
			-- for crafting item levels.
			-- 
			if( v.value == GameData.ItemTypes.CRAFTING ) then
				query.minTradeSkillLevel	= query.minItemLevel
				query.maxTradeSkillLevel 	= query.maxItemLevel
				
				query.minItemLevel 			= ShiniesConstants.MIN_ITEM_LEVEL
				query.maxItemLevel			= ShiniesConstants.MAX_ITEM_LEVEL
				
				if( query.minTradeSkillLevel == 0 ) then query.minTradeSkillLevel = ShiniesConstants.MIN_TRADE_SKILL_LEVEL end
				if( query.maxTradeSkillLevel == 0 ) then query.maxTradeSkillLevel = ShiniesConstants.MAX_TRADE_SKILL_LEVEL end
			end
		end	
	end
	query.minRarity				= ShiniesConstants.RARITY[window.Criteria.E.Rarity_Combo:SelectedIndex()].value
	
	for k, v in pairs( comboSelected_ItemSlots )
	do
		if( v.isChecked == true and v.value ~= 0 ) then
			tinsert( query.itemEquipSlots, v.value )
		end	
	end

	for k, v in pairs( comboSelected_Modifiers )
	do
		if( v.isChecked == true and v.value ~= 0 ) then
			tinsert( query.itemBonuses, v.value )
		end	
	end
	
	query.itemName 			= window.Criteria.E.ItemName_TextBox:GetText() or L""
	query.sellerName 		= window.Criteria.E.SellerName_TextBox:GetText() or L""
	
	return query
end

function Criteria_LoadQuery( query )
	for k,v in pairs( window.Criteria.E )
	do
		if( v ~= nil and v.Load ~= nil and type( v.Load ) == "function" ) then
			v.Load( query )
		end
	end
end

function Criteria_OnKeyEnter( e ) 
	e.OnKeyEnter =
		function()
			Criteria_SubmitQuery()	
		end
	e:RegisterEvent( "OnKeyEnter" )
end

function Criteria_OnKeyTab( focusWindow )
	-- Get this windows index
	local idx =  window.Criteria.TabOrderLookup[focusWindow]
	
	-- We have received an appropriate window Id
	if( idx ~= nil ) then
		local nextWindow = window.Criteria.TabOrder[idx+1]
		
		-- If the next window is nil, attempt the first window
		if( nextWindow == nil ) then
			nextWindow = window.Criteria.TabOrder[1]	   	
		end
		
		if( nextWindow ~= nil and DoesWindowExist( nextWindow ) ) then
		    WindowAssignFocus( nextWindow, true)
		end
	end
end

function Criteria_RefreshComboBox( comboBox, dataProvider )
	-- Remove the old info from the combo
	comboBox:Clear()
	
	-- Turn off the fire selection change event
	comboBox.fireSelChange = false
	
	for idx, data in ipairs( dataProvider )
	do
		if( idx == 1 ) then
			comboBox:Add( data.text )
		elseif( data.isChecked == true ) then
			comboBox:Add( ShiniesConstants.ICON_CHECKED .. L" " .. data.text )
		else
			comboBox:Add( ShiniesConstants.ICON_UNCHECKED .. L" " .. data.text )
		end
	end
	
	Criteria_UpdateComboBoxTextDisplay( comboBox, dataProvider )
	
	-- Turn on the fire selection change event
	comboBox.fireSelChange = true
end

function Criteria_Reset()
	Criteria_LoadQuery( ShiniesAPI:Query_CreateQueryObject() )
end

function Criteria_SubmitQuery()
	Results_ClearDisplay()
	
	activeQueryId = ShiniesAPI:Query_Create( Criteria_BuildQuery() )
	
	if( activeQueryId > 0 ) then
		StartSearchingAnimation()
	end
end

function Criteria_UpdateComboBoxTextDisplay( comboBox, dataProvider )
	
	local checkedCount 	= 0
	local mouseOverText = L""
	local buttonText 	= dataProvider[1].text
	local singleText 	= L""
	
	-- If the current selected index isnt the first entry, determine what we have to display
	for idx, data in ipairs( dataProvider )
	do
		-- Ignore the first index, as that is our Any option
		if( idx ~= 1 ) then
			if( data.isChecked == true ) then
				checkedCount = checkedCount + 1
				
				if( mouseOverText:len() > 0 ) then
					mouseOverText = mouseOverText .. L", "
				end
				mouseOverText = mouseOverText .. data.text
				
				singleText = data.text
			end
		end
	end
	
	if( checkedCount > 0 ) then
		if( checkedCount == 1 ) then
			buttonText = singleText
		else
			buttonText = comboBox.SeveralText
		end
		comboBox.mouseOverText = mouseOverText
	else
		comboBox.mouseOverText = L""
	end
	
	ButtonSetText( comboBox.name .. "SelectedButton", towstring(buttonText) )
end


--
-- RESULTS SECTION
--
function Results_ClearDisplay()
	wipe( queryResultsData )
	wipe( ShiniesBrowseUI.listResultsData )
	ListBoxSetDisplayOrder( windowResults .. "List", {} )
end

function Results_ClearSortButton()
    if( Results_SortColumnName == "" ) then return end

    WindowSetShowing( Results_SortColumnName .. "DownArrow", false )
    WindowSetShowing( Results_SortColumnName .. "UpArrow", false )
    
    Results_SortColumnName = "" 
    Results_SortColumnNum = 0
    Results_ShouldSortIncreasing = true
end

function Results_DisplaySortedData()
	if( Results_ShouldSortIncreasing ) then
        ListBoxSetDisplayOrder( windowResults .. "List", Results_DisplayOrder )
    else
        ListBoxSetDisplayOrder( windowResults .. "List", Results_ReverseDisplayOrder )
    end 
end

function Results_GetSlotRowNumForActiveListRow()
	local rowNumber, slowNumber, auction = 0, 0
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowResults .. "List", rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	slotNumber = ShiniesBrowseUI.listResultsData[dataIndex].slotNum
    
	    -- Get the data
	    if( slotNumber ~= nil ) then
	    	auction = queryResultsData[slotNumber]
	    end
	end
    
	return slotNumber, rowNumber, auction
end

function Results_SetListDisplayItem( slotNum, auction )
	local listDisplayItem = new()
	
	listDisplayItem.slotNum 					= slotNum
	
	listDisplayItem.Item						= auction.itemData.name
	
	listDisplayItem.RarityColor					= DataUtils.GetItemRarityColor( auction.itemData )
	
	listDisplayItem.Seller						= auction.sellerName
	
	listDisplayItem.Stack						= auction.itemData.stackCount
	listDisplayItem.StackFormatted				= towstring( auction.itemData.stackCount )
    
    listDisplayItem.Price						= auction.buyOutPrice
	listDisplayItem.PriceFormatted				= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice, true, true )
    
    listDisplayItem.PricePer					= auction.buyOutPrice / auction.itemData.stackCount
	listDisplayItem.PricePerFormatted			= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice / auction.itemData.stackCount, true, true )
    
    ShiniesBrowseUI.listResultsData[slotNum] 		= listDisplayItem
end

function Results_Show()
	-- Clear our current display data
	wipe( Results_DisplayOrder )
    wipe( Results_ReverseDisplayOrder )
    
	-- Sort before displaying
    Results_Sort()
    
    -- Create the list we will use to display
    for index,_ in ipairs( ShiniesBrowseUI.listResultsData )
    do
    	-- Add this to the end of our display
    	table.insert( Results_DisplayOrder, index )
    	
    	-- Add this to the beginning of our display
    	table.insert( Results_ReverseDisplayOrder, 1, index )
    end
    
    -- Display the sorted data
    Results_DisplaySortedData()
end

function Results_Sort()
	if( Results_SortColumnNum >= 0 ) then
        local comparator = sortResultHeaderData[Results_SortColumnNum].sortFunc
        table.sort( ShiniesBrowseUI.listResultsData, comparator )
    end
end


--
-- SEARCHES SECTION
--
function Searches_ClearSortButton()
    if( Searches_SortColumnName == "" ) then return end

    WindowSetShowing( Searches_SortColumnName .. "DownArrow", false )
    WindowSetShowing( Searches_SortColumnName .. "UpArrow", false )
    
    Searches_SortColumnName = "" 
    Searches_SortColumnNum = 0
    Searches_ShouldSortIncreasing = true
end

function Searches_ClearDisplay()
	wipe( ShiniesBrowseUI.listSearchesData )
	ListBoxSetDisplayOrder( windowSearches .. "List", {} )
end

function Searches_DisplaySortedData()
	if( Searches_ShouldSortIncreasing ) then
        ListBoxSetDisplayOrder( windowSearches .. "List", Searches_DisplayOrder )
    else
        ListBoxSetDisplayOrder( windowSearches .. "List", Searches_ReverseDisplayOrder )
    end 
end

function Searches_GetSlotRowNumForActiveListRow()
	local rowNumber, slowNumber, query = 0, 0, nil
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowSearches .. "List", rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	slotNumber = ShiniesBrowseUI.listSearchesData[dataIndex].slotNum
    
	    -- Get the data
	    if( slotNumber ~= nil ) then
	    	query = ShiniesBrowseUI.db.global.searches.data[slotNumber]
	    end
	end
    
	return slotNumber, rowNumber, query
end

function Searches_SetListDisplayItem( slotNum, search )
  	local listDisplayItem = new()
  	
  	listDisplayItem.slotNum 					= slotNum
    listDisplayItem.Name						= search.name
  	
  	ShiniesBrowseUI.listSearchesData[slotNum] 	= listDisplayItem
end

function Searches_Show()
	-- Clear our current display data
	wipe( Searches_DisplayOrder )
    wipe( Searches_ReverseDisplayOrder )
    
	-- Sort before displaying
    Searches_Sort()
    
    -- Create the list we will use to display
    for index,_ in ipairs( ShiniesBrowseUI.listSearchesData )
    do
    	-- Add this to the end of our display
    	table.insert( Searches_DisplayOrder, index )
    	
    	-- Add this to the beginning of our display
    	table.insert( Searches_ReverseDisplayOrder, 1, index )
    end
    
    -- Display the sorted data
    Searches_DisplaySortedData()
end

function Searches_Sort()
	if( Searches_SortColumnNum >= 0 ) then
        local comparator = sortSearchHeaderData[Searches_SortColumnNum].sortFunc
        table.sort( ShiniesBrowseUI.listSearchesData, comparator )
    end
end

function Searches_ToggleDisplay()
	-- toggle our show bit
	ShiniesBrowseUI.db.global.searches.show = not WindowGetShowing( windowSearches ) 

	-- Update the window display
	Searches_UpdateWindowDisplay()
end

function Searches_UpdateWindowDisplay()
	-- We only display if we are flagged to display AND Shinies is displayed
	-- we check this due to how are are parented to root
	WindowSetShowing( windowSearches, ShiniesBrowseUI.db.global.searches.show and Shinies:IsShowing() )
	WindowSetShowing( window.Criteria.E.SavedSearchesShow_Button.name, not ShiniesBrowseUI.db.global.searches.show )
	WindowSetShowing( window.Criteria.E.SavedSearchesHide_Button.name, ShiniesBrowseUI.db.global.searches.show )	
end

function StartSearchingAnimation()
	WindowSetShowing( windowSearchingAnim, true )
	AnimatedImageStartAnimation( windowSearchingAnim, 0, true, false, 0 )
end

function StopSearchingAnimation()
	WindowSetShowing( windowSearchingAnim, false )
	AnimatedImageStopAnimation( windowSearchingAnim )
end

--
-- USER INTERFACE INITIALIZATION LOCAL FUNCTIONS
--
function InitializeUI()
	if( uiInitialized == true ) then return end
	
	-- We are now considered initialized
	uiInitialized = true
	
	-- Create our config window here, so that Shinies can use it
	CreateWindow( config.windowId, false )
	
	-- Create the searches window		 
	CreateWindow( windowSearches, false )
	WindowSetParent( windowSearches, "Root" )
	
	-- Create a table for our windows
	window = new()
	
	-- Initialize the windows sections
	InitializeResultsUI()
	InitializeCriteriaUI()
	InitializeSearchesUI()
	
	-- Reset our criteria
	Criteria_Reset()
	
	-- Clear the anchors of our subwindows
	WindowClearAnchors( windowCriteria )
	WindowClearAnchors( windowResults )
	WindowClearAnchors( windowSearches )
	
	-- Anchor the criteria window to the left side of the window
	WindowSetDimensions( windowCriteria, 260, 0 )
	WindowAddAnchor( windowCriteria, "topleft", config.windowId, "topleft", 0, 0 )
	WindowAddAnchor( windowCriteria, "bottomleft", config.windowId, "bottomleft", 0, 0 )
	
	-- Anchor the searches window to the left of the criteria window
	WindowSetShowing( windowSearches, false )
	WindowAddAnchor( windowSearches, "left", config.windowId, "right", 0, 0 )
	
	-- Anchor the results window in the lower right portion of the window
	WindowAddAnchor( windowResults, "topright", windowCriteria, "topleft", 0, 10 )
	WindowAddAnchor( windowResults, "bottomright", config.windowId, "bottomright", 0, 0 )
	
	-- Stop/hide our animation window
    StopSearchingAnimation()
end

function InitializeCriteriaUI()
	local e
	local w
	
	-- Criteria Window
	w = LibGUI( "window", windowCriteria, "ShiniesWindowDefault" )
	w:Resize( 200, 200 )
	w:Show()
	w:Parent( config.windowId )
	w.E = {}
	w.TabOrder = {}
	w.TabOrderLookup = {}
	w.KeyEnter = {}
	window.Criteria = w
	
	-- Item Name Label
    e = window.Criteria( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 80, 30 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Criteria, "topleft", "topleft", 5, 5 )
    e:AddAnchor( window.Criteria, "topright", "topright", -5, 5 )
    e:SetText( T["Item Name:"] )
    window.Criteria.E.ItemName_Label = e
    
	-- Item Name Textbox
    e = window.Criteria( "Textbox", nil, "Shinies_Default_Editbox_ClearMedium" )
    e:Resize( 65, 30 )
    e:ClearAnchors()
    e:AddAnchor( window.Criteria.E.ItemName_Label, "bottomleft", "topleft", 0, 0 )
    e:AddAnchor( window.Criteria.E.ItemName_Label, "bottomright", "topright", 0, 0 )
    e.Load = 
    	function( query )
    		window.Criteria.E.ItemName_TextBox:SetText( query.itemName )
    	end
    e.OnLButtonDown =
    	function()
        	if( Cursor.IconOnCursor() and Cursor.Data and ShiniesAPI:Item_IsValidCursorSource( Cursor.Data.Source ) and Cursor.Data.SourceSlot ) then
				local itemData = DataUtils.GetItemData( Cursor.Data.Source, Cursor.Data.SourceSlot )
				-- Search for the item				
				ShiniesBrowseUI:SearchForItem( itemData )

				-- Clear whatever is on the cursor
				Cursor.Clear()
			end
    	end
    Criteria_OnKeyEnter( e )
	Criteria_AddKeyTabWindow( e )	
	window.Criteria.E.ItemName_TextBox = e
	
	-- Seller Name Label
    e = window.Criteria( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 80, 30 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Criteria.E.ItemName_TextBox, "bottomleft", "topleft", 0, 5 )
    e:AddAnchor( window.Criteria.E.ItemName_TextBox, "bottomright", "topright", 0, 5 )
    e:SetText( T["Seller Name:"] )
    window.Criteria.E.SellerName_Label = e
    
    -- Seller Name Textbox
    e = window.Criteria( "Textbox", nil, "Shinies_Default_Editbox_ClearMedium" )
    e:Resize( 65, 30 )
    e:ClearAnchors()
    e:AddAnchor( window.Criteria.E.SellerName_Label, "bottomleft", "topleft", 0, 0 )
    e:AddAnchor( window.Criteria.E.SellerName_Label, "bottomright", "topright", 0, 0 )
    e.Load = 
    	function( query )
    		window.Criteria.E.SellerName_TextBox:SetText( query.sellerName )
    	end
    Criteria_OnKeyEnter( e )
    Criteria_AddKeyTabWindow( e )
    window.Criteria.E.SellerName_TextBox = e
    
    -- Level Label
    e = window.Criteria( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 80, 30 )
    e:Align( "center" )
    e:Color( 222, 192, 50 )
    e:AnchorTo( window.Criteria.E.SellerName_TextBox, "bottomleft", "topleft", 0, 3 )
    e:SetText( T["Level:"] )
    window.Criteria.E.Level_Label = e
    
    -- Level Minimum Textbox
    e = window.Criteria( "Textbox", nil, "Shinies_Level_EditBox_DefaultFrame" )
    e:Resize( 50, 30 )
    e:AnchorTo( window.Criteria.E.Level_Label, "right", "left", 4, 0 )
    e.Load = 
    	function( query )
    		window.Criteria.E.LevelMinimum_TextBox:SetText( towstring( query.minItemLevel ) )
    	end
    Criteria_OnKeyEnter( e )
    Criteria_AddKeyTabWindow( e )
    window.Criteria.E.LevelMinimum_TextBox = e
    
    -- Level Seperator Label
    e = window.Criteria( "Label", nil, "EA_Label_DefaultText" )
    e:Resize( 15, 30 )
    e:AnchorTo( window.Criteria.E.LevelMinimum_TextBox, "right", "left", 2, 0 )
    e:SetText( L"-" )
    e:Font( "font_clear_small_bold" )
    e:Align( "center" )
    window.Criteria.E.LevelSeperator_Label = e
    
    -- Level Maximum Textbox
    e = window.Criteria( "Textbox", nil, "Shinies_Level_EditBox_DefaultFrame" )
    e:Resize( 50, 30 )
    e:AnchorTo( window.Criteria.E.LevelSeperator_Label, "right", "left", 2, 0 )
    e.Load = 
    	function( query )
    		window.Criteria.E.LevelMaximum_TextBox:SetText( towstring( query.maxItemLevel ) )
    	end
    Criteria_OnKeyEnter( e )
    Criteria_AddKeyTabWindow( e )
    window.Criteria.E.LevelMaximum_TextBox = e
    
	-- Class Combo
    e = window.Criteria( "combobox", nil, "Shinies_ComboBox_DefaultResizableLarge" )
    e:AnchorTo( window.Criteria.E.Level_Label, "bottomleft", "topleft", 0, 3 )
    
    if( GameData.Player.realm == GameData.Realm.ORDER ) then
    	classComboData 			= ShiniesConstants.CAREERS_ORDER
    	classComboDataLookup 	= ShiniesConstants.CAREERS_ORDER_LOOKUP
    else
    	classComboData 			= ShiniesConstants.CAREERS_DESTRUCTION
    	classComboDataLookup    = ShiniesConstants.CAREERS_DESTRUCTION_LOOKUP
    end
    
    for _, item in ipairs( classComboData ) 
	do 
		e:Add( item.text )
	end
	
	e.Load = 
    	function( query )
    		window.Criteria.E.Class_Combo:Select( classComboDataLookup[query.career] )
    	end
    window.Criteria.E.Class_Combo = e
    
    -- Rarity Combo
    e = window.Criteria( "combobox", nil, "Shinies_ComboBox_DefaultResizableLarge" )
    e:AnchorTo( window.Criteria.E.Class_Combo, "bottomleft", "topleft", 0, 3 )
    
	for _, item in ipairs( ShiniesConstants.RARITY ) 
	do 
		e:Add( item.text )
	end
	
	e.Load = 
    	function( query )
    		window.Criteria.E.Rarity_Combo:Select( ShiniesConstants.RARITY_LOOKUP[query.minRarity] )
    	end
    window.Criteria.E.Rarity_Combo = e
    
    -- Item Types Combo
    e = window.Criteria( "combobox", nil, "ShiniesBrowseUI_ComboBox_Criteria_ItemTypes" )
    e:AnchorTo( window.Criteria.E.Rarity_Combo, "bottomleft", "topleft", 0, 3 )
    e.SeveralText = T["Several Item Types"]
    e.OnMouseOver = 
		function()
			if( window.Criteria.E.ItemType_Combo.mouseOverText:len() > 0 ) then
				local text = window.Criteria.E.ItemType_Combo.mouseOverText
				Tooltips.CreateTextOnlyTooltip( window.Criteria.E.ItemType_Combo.name, nil ) 
	    		Tooltips.SetTooltipText( 1, 1, text )
	    		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_RIGHT )
	    		Tooltips.Finalize()
	    	end
	    end
	e.Load = 
		function(query)
			comboSelected_ItemTypes = DataUtils.CopyTable( ShiniesConstants.ITEM_TYPES )
			for _, item in pairs( comboSelected_ItemTypes ) 
			do 
				for k, v in pairs( query.itemTypes )
				do
					item.isChecked = false
					
					if( item.value == v ) then
						item.isChecked = true
						break
					end
				end
			end
			Criteria_RefreshComboBox( window.Criteria.E.ItemType_Combo, comboSelected_ItemTypes )
		end
	window.Criteria.E.ItemType_Combo = e
	
	-- Item Slot Combo
    e = window.Criteria( "combobox", nil, "ShiniesBrowseUI_ComboBox_Criteria_ItemSlots" )
    e:AnchorTo( window.Criteria.E.ItemType_Combo, "bottomleft", "topleft", 0, 3 )
    e.SeveralText = T["Several Item Slots"]
    e.OnMouseOver = 
		function()
			if( window.Criteria.E.ItemSlot_Combo.mouseOverText:len() > 0 ) then
				local text = window.Criteria.E.ItemSlot_Combo.mouseOverText
				Tooltips.CreateTextOnlyTooltip( window.Criteria.E.ItemSlot_Combo.name, nil ) 
	    		Tooltips.SetTooltipText( 1, 1, text )
	    		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_RIGHT )
	    		Tooltips.Finalize()
	    	end
	    end
	e.Load = 
		function(query)
			comboSelected_ItemSlots = DataUtils.CopyTable( ShiniesConstants.ITEM_SLOTS )
			for _, item in pairs( comboSelected_ItemSlots ) 
			do 
				for k, v in pairs( query.itemEquipSlots )
				do
					item.isChecked = false
					
					if( item.value == v ) then
						item.isChecked = true
						break
					end
				end
			end
			Criteria_RefreshComboBox( window.Criteria.E.ItemSlot_Combo, comboSelected_ItemSlots )
		end
	window.Criteria.E.ItemSlot_Combo = e
	
	-- Modifier Combo
    e = window.Criteria( "combobox", nil, "ShiniesBrowseUI_ComboBox_Criteria_Modifiers" )
    e:AnchorTo( window.Criteria.E.ItemSlot_Combo, "bottomleft", "topleft", 0, 3 )
    e.SeveralText = T["Several Modifiers"]
    e.OnMouseOver = 
		function()
			if( window.Criteria.E.Modifier_Combo.mouseOverText:len() > 0 ) then
				local text = window.Criteria.E.Modifier_Combo.mouseOverText
				Tooltips.CreateTextOnlyTooltip( window.Criteria.E.Modifier_Combo.name, nil ) 
	    		Tooltips.SetTooltipText( 1, 1, text )
	    		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_RIGHT )
	    		Tooltips.Finalize()
	    	end
	    end
	e.Load = 
		function(query)
			comboSelected_Modifiers = DataUtils.CopyTable( ShiniesConstants.MODIFIERS )
			for _, item in pairs( comboSelected_Modifiers ) 
			do 
				for k, v in pairs( query.itemBonuses )
				do
					item.isChecked = false
					
					if( item.value == v ) then
						item.isChecked = true
						break
					end
				end
			end
			Criteria_RefreshComboBox( window.Criteria.E.Modifier_Combo, comboSelected_Modifiers )
		end
	window.Criteria.E.Modifier_Combo = e
    
	-- Restriction Combo
    e = window.Criteria( "combobox", nil, "Shinies_ComboBox_DefaultResizableLarge" )
    e:AnchorTo( window.Criteria.E.Modifier_Combo, "bottomleft", "topleft", 0, 3 )
    for _, item in ipairs( ShiniesConstants.AUCTION_RESTRICTIONS ) 
	do 
		e:Add( item.text )
	end
	e.Reset =
		function()
			window.Criteria.E.Restriction_Combo:SelectIndex( 1 )
		end
	e.Load = 
    	function( query )
    		window.Criteria.E.Restriction_Combo:Select( ShiniesConstants.AUCTION_RESTRICTIONS_LOOKUP[query.restrictionType] )
    	end
    window.Criteria.E.Restriction_Combo = e
    
    -- Save Search Button
    e = window.Criteria( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 175 )
    e:Show( )
    e:AnchorTo( window.Criteria.E.Restriction_Combo, "bottom", "top", 0, 5 )
    e:SetText( T["Save Search"] )
    e.OnLButtonUp = 
		function()
			DialogManager.MakeTextEntryDialog( 
				T["Shinies - Save Search"], 
				T["Please enter a name for the search."], 
				T["New Search"], 
				ShiniesBrowseUI.Searches_OnAddSuccess,
				ShiniesBrowseUI.Searches_OnAddCancel,
				32,
				false )
		end
    window.Criteria.E.SaveCurrent_Button = e
    
    -- Toggle Searches Label
    e = window.Criteria( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 200, 30 )
    e:Align( "center" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Criteria, "bottom", "bottom", 0, -65 )
    e:SetText( T["Show Saved Searches"] )
    window.Criteria.E.SavedSearches_Label = e
    
    -- Saved Searches Show Button
    e = window.Criteria( "Button", nil, "EA_Button_DefaultBigLeftArrow" )
    e:Resize( 30, 56 )
    e:Show()
    e:AnchorTo( window.Criteria.E.SavedSearches_Label, "left", "right", 0, 0 )
    e:Scale( .75 )
    e.OnLButtonUp = 
		function()
			Searches_ToggleDisplay()
		end
	window.Criteria.E.SavedSearchesShow_Button = e
    
    -- Saved Searches Hide Button
    e = window.Criteria( "Button", nil, "EA_Button_DefaultBigRightArrow" )
    e:Resize( 30, 56 )
    e:Hide()
    e:AnchorTo( window.Criteria.E.SavedSearchesShow_Button, "center", "center", 0, 0 )
    e:Scale( .75 )
    e.OnLButtonUp = 
		function()
			Searches_ToggleDisplay()
		end
	window.Criteria.E.SavedSearchesHide_Button = e
    
    -- Search Button
    e = window.Criteria( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Criteria, "bottomleft", "bottomleft", 2, -5 )
    e:SetText( T["Search"] )
    e.OnLButtonUp = 
		function()
			-- Check if the button is disabled as button presses still go through to a disabled button
			if( not window.Criteria.E.Search_Button:Enabled() ) then return end
			
			Criteria_SubmitQuery()
		end
	Criteria_AddKeyTabWindow( e )
    window.Criteria.E.Search_Button = e
    
    -- Reset Button
    e = window.Criteria( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 125 )
    e:Show( )
    e:AnchorTo( window.Criteria, "bottomright", "bottomright", -2, -5 )
    e:SetText( T["Reset"] )
    e.OnLButtonUp = 
		function()
			Criteria_Reset()
		end
    window.Criteria.E.Reset_Button = e
end

function InitializeResultsUI()
	 for i, data in ipairs( sortResultHeaderData ) do
        local buttonName = windowResults .. data.column
        ButtonSetText( buttonName, towstring(data.text) )
        WindowSetShowing( buttonName .. "DownArrow", false )
        WindowSetShowing( buttonName .. "UpArrow", false )
    end
    DataUtils.SetListRowAlternatingTints( windowResults .. "List", MAX_RESULTS_ROWS )
end

function InitializeSearchesUI()
	-- Searches window
	for i, data in ipairs( sortSearchHeaderData ) do
        local buttonName = windowSearches .. data.column
        ButtonSetText( buttonName, towstring(data.text) )
        WindowSetShowing( buttonName .. "DownArrow", false )
        WindowSetShowing( buttonName .. "UpArrow", false )
    end
    DataUtils.SetListRowAlternatingTints( windowSearches .. "List", MAX_SEARCHES_ROWS )
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


