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
local MODNAME 			= "Shinies-UI-Auctions"
local ShiniesAuctionsUI = Shinies : NewModule( MODNAME )
_G.ShiniesAuctionsUI 	= ShiniesAuctionsUI
ShiniesAuctionsUI:SetModuleType( "UI" )
ShiniesAuctionsUI:SetName( T["Shinies Auctions UI"] )
ShiniesAuctionsUI:SetDescription(T["Provides an interface for managing a players auctions."])
ShiniesAuctionsUI:SetDefaults( {} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )
local ShiniesConstants 	= ShiniesConstants

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local string_format 		= string.format

local config	= {
	name			= T["Auctions"],
	windowId		= "ShiniesAuctionsUI",
	idx				= 2
}

local window

local MAX_VISIBLE_ROWS = 21

local windowMenu			= config.windowId .. "_Menu"
local windowResults 		= config.windowId .. "_Results"
local windowSearchingAnim 	= config.windowId .. "_SearchingAnim"

local sortColumnNum 		= 0				
local sortColumnName 		= ""		
local shouldSortIncreasing 	= true

local displayOrder 			= new()
local reverseDisplayOrder 	= new()

ShiniesAuctionsUI.listDisplayData = new()

local queryResultsData		= new()
local activeQueryId			= 0
local activeCancelId		= 0
local currentSummary		= L""

local function itemComparator( a, b )				return( WStringsCompare( a.Item, b.Item ) == -1 ) end
local function stackComparator( a, b )				return( a.Stack < b.Stack ) end
local function timeLeftComparator( a, b )			return( a.TimeLeft < b.TimeLeft ) end
local function pricePerComparator( a, b )			return( a.PricePer < b.PricePer ) end
local function priceComparator( a, b )				return( a.Price < b.Price ) end

local sortHeaderData =
{
	[0] = { sortFunc=itemComparator, },
	{ column = "Item",			text=T["Item"],				sortFunc=itemComparator,		},
	{ column = "Stack",			text=T["Stack"],			sortFunc=stackComparator,		},
	{ column = "TimeLeft",		text=T["Time Remaining"],	sortFunc=timeLeftComparator,	},
	{ column = "PricePer",		text=T["Price/Per"],		sortFunc=pricePerComparator,	},
	{ column = "Price",			text=T["Price"],			sortFunc=priceComparator,		},
}

local initialized		= false
local activeItemData	= nil
local mouseOverAuction	= nil

local ClearResultsDisplay, ClearSortButton, DisplaySortedData, GetSlotRowNumForActiveListRow
local InitializeMenuUI, InitializeUI, RefreshResultsDisplay, SetListDisplayItem, ShowResults 
local SortResults, StartSearchingAnimation, StopSearchingAnimation, UninitializeUI, UpdateSummaryDisplay

local uiInitialized		= false

function ShiniesAuctionsUI:OnInitialize()
	Shinies:Debug( "ShiniesAuctionsUI:OnInitialize" )
	
	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesAuctionsUI:OnEnable()
	Shinies:Debug( "ShiniesAuctionsUI:OnEnable" )
	
	-- Initialize the user interface
	InitializeUI()
	
	-- Clear the results display
	ClearResultsDisplay()
	
	-- Register our callback handlers
	ShiniesAPI.RegisterCallback( self, "OnAuctionQuerySuccess", "OnAuctionQuerySuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryFailure", "OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionQueryTimeout", "OnAuctionQueryFailure" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCreateSuccess", "OnAuctionCreateSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionCancelSuccess", "OnAuctionCancelSuccess" )
	ShiniesAPI.RegisterCallback( self, "OnAuctionHouseAvailabilityChanged", "OnAuctionHouseAvailabilityChanged" )
	
	-- Check the AH availibility from the start
	self:OnAuctionHouseAvailabilityChanged( "OnAuctionHouseAvailabilityChanged", ShiniesAPI:IsServerAvailable() )
end

function ShiniesAuctionsUI:OnDisable()
	Shinies:Debug( "ShiniesAuctionsUI:OnDisable" )
	
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQuerySuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryFailure" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionQueryTimeout" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCreateSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionCancelSuccess" )
	ShiniesAPI.UnregisterCallback( self, "OnAuctionHouseAvailabilityChanged" )
	
	UninitializeUI()
end

function ShiniesAuctionsUI:GetUserInterface()
	return config
end

--
-- START ALPHABETICAL ORDERING OF FUNCTIONS HERE
--

function ShiniesAuctionsUI:OnAuctionCancelSuccess( eventName, identifier, auction )
	if( not ShiniesAPI:Auction_HasQueuedCancelAuctions() and WindowGetShowing( config.windowId ) ) then
		RefreshResultsDisplay()
	end
end

function ShiniesAuctionsUI:OnAuctionCreateSuccess( eventName, identifier, auction )
	if( not ShiniesAPI:Auction_HasQueuedCreateAuctions() and WindowGetShowing( config.windowId ) ) then
		RefreshResultsDisplay()
	end
end

function ShiniesAuctionsUI:OnAuctionHouseAvailabilityChanged( eventName, serverAvailable )
	window.Menu.E.RefreshResults_Button:SetEnabled( serverAvailable )
end

function ShiniesAuctionsUI:OnAuctionQueryFailure( eventName, identifier, query, results, failure )
	if( activeQueryId == identifier ) then
		
		StopSearchingAnimation()
		
		if( failure ~= nil ) then
			Shinies:Debug( failure )
			DialogManager.MakeOneButtonDialog( failure, T["Ok"], nil )
		end
	end
end

function ShiniesAuctionsUI:OnAuctionQuerySuccess( eventName, identifier, query, results )
	-- Make sure the results are for the query we more recently executed
	if( activeQueryId == identifier ) then
		-- Hide our searching animation
		StopSearchingAnimation()
		
		-- Clear our current display data
		wipe( ShiniesAuctionsUI.listDisplayData )
		
		-- Store a copy of the results data
		queryResultsData = ShiniesAPI:DeepCopy( results )
		
		-- Prepare our results data
		for slotNum, auction in pairs( queryResultsData ) 
		do
			SetListDisplayItem( slotNum, auction )
    	end
    	
    	-- Reset our query ID
    	activeQueryId = 0
    	
    	-- Display the results data
    	ShowResults()
    end
end

function ShiniesAuctionsUI.OnHidden()
	if( not uiInitialized ) then return end
	ClearResultsDisplay()
end

function ShiniesAuctionsUI.OnLButtonUp_Results_SortButton()
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

function ShiniesAuctionsUI.OnMouseOver_Results_ListItem( flags, x, y )
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, true )
	end
	
	local slot, row, auction = GetSlotRowNumForActiveListRow()
	
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

function ShiniesAuctionsUI.OnMouseOverEnd_Results_ListItem()
	local window = SystemData.ActiveWindow.name .. "Mouseover"
	
	if( DoesWindowExist( window ) ) then
		WindowSetShowing( window, false )
	end
end

function ShiniesAuctionsUI.OnRButtonMenu_CancelAuction()
	if( mouseOverAuction ~= nil ) then
		activeCancelId = ShiniesAPI:Auction_Cancel( mouseOverAuction )
		mouseOverAuction = nil
	end
end

function ShiniesAuctionsUI.OnRButtonUp_Results_ListItem()
	local slot, row, auction = GetSlotRowNumForActiveListRow()
	
	-- Add right click menu support here
	if( auction ~= nil ) then
		mouseOverAuction = auction
	
		EA_Window_ContextMenu.CreateContextMenu( SystemData.ActiveWindow.name )
		
		-- General menu items 
		EA_Window_ContextMenu.AddMenuItem( T[towstring("Cancel Auction")], ShiniesAuctionsUI.OnRButtonMenu_CancelAuction, false, true )
		
		EA_Window_ContextMenu.Finalize()
	end
end

function ShiniesAuctionsUI.OnRefreshResultsButton()
	-- Check if the button is disabled as button presses still go through to a disabled button
	if( not window.Menu.E.RefreshResults_Button:Enabled() ) then return end
	
	RefreshResultsDisplay()
end

function ShiniesAuctionsUI.OnShown()
	if( not uiInitialized ) then return end
	RefreshResultsDisplay()
end

function ShiniesAuctionsUI.PopulateResultsDisplay()
	local dx, dy = WindowGetDimensions( windowResults .. "Item" )
	 
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesAuctionsUI_ResultsList.PopulatorIndices ) 
	do
		local rowName = windowResults .. "ListRow".. row
		
		if( ShiniesAuctionsUI.listDisplayData[data] ~= nil ) then
			WindowSetDimensions( rowName .. "Item", dx, dy )
			LabelSetText( rowName .. "Item", 		ShiniesAuctionsUI.listDisplayData[data].Item )
			LabelSetTextColor( rowName.."Item", 	ShiniesAuctionsUI.listDisplayData[data].RarityColor.r, 
													ShiniesAuctionsUI.listDisplayData[data].RarityColor.g, 
													ShiniesAuctionsUI.listDisplayData[data].RarityColor.b )
			LabelSetText( rowName .. "Stack", 		ShiniesAuctionsUI.listDisplayData[data].StackFormatted )
			LabelSetText( rowName .. "TimeLeft", 	towstring(ShiniesAuctionsUI.listDisplayData[data].TimeLeftFormatted) )
			LabelSetText( rowName .. "PricePer", 	ShiniesAuctionsUI.listDisplayData[data].PricePerFormatted )
			LabelSetText( rowName .. "Price", 		ShiniesAuctionsUI.listDisplayData[data].PriceFormatted )
			
			WindowSetShowing( rowName .. "Mouseover", false )
		end
	end
end

--
-- BEGIN LOCAL FUNCTION DEFINITION
--

function ClearResultsDisplay()
	wipe( queryResultsData )
	wipe( ShiniesAuctionsUI.listDisplayData )
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

function GetSlotRowNumForActiveListRow()
	local rowNumber, slowNumber, auction = 0, 0
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowResults .. "List", rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	slotNumber = ShiniesAuctionsUI.listDisplayData[dataIndex].slotNum
    
	    -- Get the data
	    if( slotNumber ~= nil ) then
	    	auction = queryResultsData[slotNumber]
	    end
	end
    
	return slotNumber, rowNumber, auction
end

function InitializeMenuUI()
	local e
	local w
	
	-- Menu Window
	w = LibGUI( "window", windowMenu, "ShiniesWindowDefault" )
	w:Resize( 0, 76 )
	w:Show()
	w:Parent( config.windowId )
	w.E = new()
	window.Menu = w
	
	-- Total Auctions Header Label
    e = window.Menu( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 200, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Menu, "topleft", "topleft", 15, 3 )
    e:SetText( T["Total Auctions:"] )
    window.Menu.E.TotalAuctionsHeader_Label = e
    
    -- Total Auctions Label
    e = window.Menu( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 200, 22 )
    e:Align( "leftcenter" )
    e:AddAnchor( window.Menu.E.TotalAuctionsHeader_Label, "right", "left", 5, 0 )
    e:SetText( L"" )
    window.Menu.E.TotalAuctions_Label = e
    
    -- Potential Sales Header Label
    e = window.Menu( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 200, 22 )
    e:Align( "leftcenter" )
    e:Color( 222, 192, 50 )
    e:AddAnchor( window.Menu.E.TotalAuctionsHeader_Label, "bottomleft", "topleft", 0, 2 )
    e:SetText( T["Potential Sales:"] )
    window.Menu.E.PotentialSalesHeader_Label = e
    
    -- Potential Sales Label
    e = window.Menu( "Label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 200, 22 )
    e:Align( "leftcenter" )
    e:AddAnchor( window.Menu.E.PotentialSalesHeader_Label, "right", "left", 5, 0 )
    e:SetText( L"" )
    window.Menu.E.PotentialSales_Label = e
    
    -- Summary EditBox
    e = window.Menu( "textbox", nil, "ShiniesAuctionsUI_EditBox" )
    e:Resize( 800, 22 )
    e:AddAnchor( window.Menu.E.PotentialSalesHeader_Label, "bottomleft", "topleft", 0, 0 )
    e:SetText( L"" )
    window.Menu.E.Summary_EditBox = e
    
    -- Refresh Button
    e = window.Menu( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 160, 39 )
    e:Show()
    e:AnchorTo( window.Menu, "bottomright", "bottomright", 0, -5 )
    e:SetText( T["Refresh"] )
    e.OnLButtonUp = 
		function()
			RefreshResultsDisplay()
		end
	window.Menu.E.RefreshResults_Button = e
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
	InitializeMenuUI()
	
	-- Clear the anchors of our subwindows
	WindowClearAnchors( windowMenu )
	WindowClearAnchors( windowResults )
	
	-- Anchor the menu window to the top portion of the window
	WindowAddAnchor( windowMenu, "topleft", config.windowId, "topleft", 0, 0 )
	WindowAddAnchor( windowMenu, "topright", config.windowId, "topright", 0, 0 )
	
	-- Anchor the results window in the lower right portion of the window
	WindowAddAnchor( windowResults, "bottomleft", windowMenu, "topleft", 0, 0 )
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
	ClearResultsDisplay()
	
	activeQueryId = ShiniesAPI:Query_PlayerAuctions()
	
	if( activeQueryId > 0 ) then
		StartSearchingAnimation()
	end
end

function SetListDisplayItem( slotNum, auction )
	local listDisplayItem = new()
	
	listDisplayItem.slotNum 				= slotNum
	
	listDisplayItem.Item					= auction.itemData.name
	
	listDisplayItem.RarityColor				= DataUtils.GetItemRarityColor( auction.itemData )
	
	listDisplayItem.Stack					= auction.itemData.stackCount
	listDisplayItem.StackFormatted			= towstring( auction.itemData.stackCount )
	
	listDisplayItem.TimeLeft				= auction.timeLeft
	listDisplayItem.TimeLeftFormatted		= ShiniesConstants.AUCTION_DURATIONS[auction.timeLeft].text
    
    listDisplayItem.Price					= auction.buyOutPrice
	listDisplayItem.PriceFormatted			= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice, true, true )
    
    listDisplayItem.PricePer				= auction.buyOutPrice / auction.itemData.stackCount
	listDisplayItem.PricePerFormatted		= ShiniesAPI:Display_GetFormattedMoney( auction.buyOutPrice / auction.itemData.stackCount, true, true )
    
    ShiniesAuctionsUI.listDisplayData[slotNum] 			= listDisplayItem
end

function ShowResults()
	-- Clear our current display data
	wipe( displayOrder ) 
    wipe( reverseDisplayOrder )
    
	-- Sort before displaying
    SortResults()
    
    -- Create the list we will use to display
    for index,_ in ipairs( ShiniesAuctionsUI.listDisplayData )
    do
    	-- Add this to the end of our display
    	table.insert( displayOrder, index )
    	
    	-- Add this to the beginning of our display
    	table.insert( reverseDisplayOrder, 1, index )
    end
    
    -- Display the sorted data
    DisplaySortedData()
    
    -- Update summary display
    UpdateSummaryDisplay()
end

function SortResults()
	if( sortColumnNum >= 0 ) then
        local comparator = sortHeaderData[sortColumnNum].sortFunc
        table.sort( ShiniesAuctionsUI.listDisplayData, comparator )
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

function UpdateSummaryDisplay()
	local totalAuctions = 0
	local potentialSales = 0
	
	for _, auction in pairs( queryResultsData )
	do
		-- Total auction
		totalAuctions = totalAuctions + 1
		
		-- Potential Sales
		potentialSales = potentialSales + auction.buyOutPrice
	end
	
	-- Update our current summary
	local potentialSummary = ShiniesAPI:Display_GetFormattedMoney( potentialSales, true, false )
	
	if( potentialSummary:len() > 0 ) then
		currentSummary = wstring.format( towstring(T["You have %d auction(s), and"]), towstring(totalAuctions), towstring(potentialSummary) )
		currentSummary = towstring(currentSummary) .. L" " .. towstring(potentialSummary) .. L" " .. towstring(T["in potential sales."])
	else
		currentSummary = towstring(T["You do not have any auctions."])
	end
	
	window.Menu.E.TotalAuctions_Label:SetText( towstring( totalAuctions ) )
	window.Menu.E.PotentialSales_Label:SetText( ShiniesAPI:Display_GetFormattedMoney( potentialSales, true, true ) )
	window.Menu.E.Summary_EditBox:SetText( currentSummary )
end