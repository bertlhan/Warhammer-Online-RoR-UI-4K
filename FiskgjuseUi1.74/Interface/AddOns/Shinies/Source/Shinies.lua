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

local _G = _G
local Shinies 		= LibStub( "WAR-AceAddon-3.0" ) : NewAddon( "Shinies" )
_G.Shinies 			= Shinies

local LibGUI 		= LibStub( "LibGUI" )

local pairs 		= pairs
local ipairs		= ipairs
local tonumber 		= tonumber
local tostring 		= tostring
local towstring 	= towstring
local tinsert		= table.insert
local tsort			= table.sort
local tconcat		= table.concat
local string_format = string.format

local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local alpha = false
--[===[@alpha@
alpha = true
--@end-alpha@]===]

local T 				= LibStub( "WAR-AceLocale-3.0" ) : GetLocale( "Shinies", debug )
Shinies.T 				= T

local db

local VERSION 			= { MAJOR = 0, MINOR = 9, REV = 7 }
local DisplayVersion 	= string.format( "%d.%d.%d", VERSION.MAJOR, VERSION.MINOR, VERSION.REV )

if( debug ) then
	DisplayVersion 		= DisplayVersion .. " Dev"
else
	DisplayVersion 		= DisplayVersion .. " r" .. ( tonumber( "149" ) or "0" )
	
	if( alpha ) then
		DisplayVersion = DisplayVersion .. "-alpha"
	end
end

local defaultEventsUnregistered	= false

local isLoaded					= false

local windowId					= "ShiniesWindow"
local tabWindowId				= "ShiniesTabs"

local windowMinWidth			= 1050
local windowMinHeight			= 615

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

do
	local cache = setmetatable({}, {__mode='k'})
	
	--- Return a table
	-- @usage local t = Shinies.new()
	-- @return a blank table
	function Shinies.new()
		local t = next(cache)
		if t then
			cache[t] = nil
			return t
		end
		
		return {}
	end
	
	function Shinies.wipe(t)
		for k,_ in pairs( t )
		do
			t[k] = nil
		end 	
	end
	
	local wipe = Shinies.wipe
	
	--- Delete a table, clearing it and putting it back into the queue
	-- @usage local t = Shinies.new()
	-- t = del(t)
	-- @return nil
	function Shinies.del(t)
		wipe(t)
		cache[t] = true
		return nil
	end
end

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local defaultSettings 	=
{
	profile = 
	{
		general =
		{
			debug					= false,
			disable_auction_house	= false,
			uiscale					= 0.75,
		},
	},
}

local tabs						= new()
local currentTab				= 0
local tabCounter				= 1

local InitializeUI, UpdateUI, CreateUI, AnchorUITabs, OnUITabSelect, ShowUITab, RemoveAllUITabs

--[===[@debug@
function SDT()
	Shinies.db.profile.general.debug = not Shinies.db.profile.general.debug
end
--@end-debug@]===]

function Shinies:Debug(str)	
	if( self.db ~= nil and self.db.profile.general.debug ) then 
		DEBUG(towstring(str)) 
	end 
end

function Shinies:UpdateDefaultAuctionHouseDisable()
	-- Disable the default auction house if needed
	if( self.db.profile.general.disable_auction_house and DoesWindowExist( "AuctionWindow" ) and not defaultEventsUnregistered ) then
		WindowUnregisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_INIT_RECEIVED )
		WindowUnregisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_SEARCH_RESULT_RECEIVED )
		WindowUnregisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_BID_RESULT_RECEIVED )
		WindowUnregisterEventHandler( "AuctionWindow", SystemData.Events.INTERACT_DONE )
		defaultEventsUnregistered = true
	elseif( not self.db.profile.general.disable_auction_house and defaultEventsUnregistered ) then
		-- Register the events should the profile setting change	
		WindowRegisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_INIT_RECEIVED, "AuctionWindow.Show" )
		WindowRegisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_SEARCH_RESULT_RECEIVED, "AuctionWindow.OnSearchResultsReceived" )
		WindowRegisterEventHandler( "AuctionWindow", SystemData.Events.AUCTION_BID_RESULT_RECEIVED, "AuctionWindow.ReceivedBidResult" )
		WindowRegisterEventHandler( "AuctionWindow", SystemData.Events.INTERACT_DONE, "AuctionWindow.Hide" )
		defaultEventsUnregistered = false
	end
end

function Shinies:GetVersion() return DisplayVersion end

function Shinies:Hide()
	WindowSetShowing( windowId, false )
	WindowSetShowing( tabWindowId, false ) 
end

function Shinies:IsShowing()
	return WindowGetShowing( windowId )
end

function Shinies.OnAuctionInitReceived()
	if DoesWindowExist(windowId) == false then
		CreateWindow(windowId, true)
		CreateWindow(tabWindowId, true)
	end
	Shinies:Show()
end

function Shinies:OnDisable()
	-- Unregister our slash handler
	if( LibSlash ~= nil and type( LibSlash.UnregisterSlashCmd ) == "function" ) then
		LibSlash.UnregisterSlashCmd( "shinies" )
	end
	
	UnregisterEventHandler( SystemData.Events.AUCTION_INIT_RECEIVED, 			"Shinies.OnAuctionInitReceived" )
	UnregisterEventHandler( SystemData.Events.INTERACT_DONE, 					"Shinies.OnInteractDone" )
	
	-- Reenable the default AH
	self:DisableDefaultAuctionHouse( false )
end

function Shinies:OnEnable()
	-- Register our event handlers
	RegisterEventHandler( SystemData.Events.AUCTION_INIT_RECEIVED, 				"Shinies.OnAuctionInitReceived" )
	RegisterEventHandler( SystemData.Events.INTERACT_DONE, 						"Shinies.OnInteractDone" )
	
	-- Attempt to register one of our handlers
	if( LibSlash ~= nil and type( LibSlash.RegisterSlashCmd ) == "function" ) then
		LibSlash.RegisterSlashCmd( "shinies", Shinies.Slash )
	end
	
	self:UpdateDefaultAuctionHouseDisable()
end

function Shinies.OnHidden()
	WindowUtils.OnHidden()
	WindowSetShowing( tabWindowId, false )
end

function Shinies:OnInitialize()
	-- Initialize our shinies constants
	ShiniesConstants.Initialize()

	-- Create our configuration objects
	db = LibStub( "WAR-AceDB-3.0" ) : New( "ShiniesDB", defaultSettings, "Default" )
	defaultSettings	= nil
	self.db = db
	
	-- Initialize our UI
	InitializeUI()
	
	-- Start hidden
	self:Hide()
	
	-- Print our initialization usage
	local init = WStringToString( towstring(T["Shinies %s initialized."]) )
	self:Print( init:format( DisplayVersion ) )
	
	d( "Shinies loaded." )
end

function Shinies.OnInteractDone()
	Shinies:Hide()
end

function Shinies.OnLButtonUp_Close()
	Shinies:Hide()
end

function Shinies:OnModuleCreated( module )
	-- When a module is created, let all of our modules know of it
	self:CallMethodOnModules( "OnModuleCreated", module:GetName() )	
end

function Shinies:OnModulesEnabled()

	-- Let all of our enabled modules know that all modules are loaded
	self:CallMethodOnModules( "OnAllModulesEnabled" )
	
	-- Remove any UIs we have configured
	RemoveAllUITabs()
	
	-- Get the UIs from the UI modules
	for _,module in self:IterateModulesOfType("UI") do
		CreateUI( module ) 				
	end
	
	-- Update our UI display
	UpdateUI()
end

function Shinies.OnShown()
	WindowUtils.OnShown()
	WindowSetShowing( tabWindowId, true )
end

function Shinies:Print( wstr )
	EA_ChatWindow.Print( towstring( wstr ), ChatSettings.Channels[SystemData.ChatLogFilters.SAY].id )
end

function Shinies.Script_Toggle()
	Shinies:Toggle()
end

function Shinies:Show()
	WindowSetShowing( windowId, true ) 
	WindowSetShowing( tabWindowId, true )
end

function Shinies.Slash( input )
	Shinies:Toggle()
end

function Shinies:Toggle() 
	local show = WindowGetShowing( windowId )
	WindowSetShowing( windowId, not show ) 
	WindowSetShowing( tabWindowId, not show  )
end

function Shinies:UpdateUIScale( scale )
	-- If the scale is less than zero reset it to 0.1
	if( scale < 0 ) then scale = 0.1 end
	
	-- Store the scale
	self.db.profile.general.uiscale = scale
	
	-- Scale the windows
	WindowSetScale( windowId, scale )
	WindowSetScale( tabWindowId, scale )
end

-------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------
function AnchorUITabs()
	local leftAnchor 	= new()
	local rightAnchor 	= new()
	local leftTabs 		= new()
	local rightTabs		= new()
	
	local function left_sort( a, b ) 
		if a.config.idx ~= nil and b.config.idx ~= nil then return a.config.idx < b.config.idx end 
		if a.config.idx ~= nil and b.config.idx == nil then return true end 
		if a.config.idx == nil and b.config.idx ~= nil then return false end 
		return a.config.name < b.config.name 
	end
	
	local function right_sort( a, b ) 
		if a.config.idx ~= nil and b.config.idx ~= nil then return a.config.idx > b.config.idx end 
		if a.config.idx ~= nil and b.config.idx == nil then return true end 
		if a.config.idx == nil and b.config.idx ~= nil then return false end 
		return a.config.name < b.config.name 
	end
	
	--
	-- Build the left/right justified tabs
	--
	for index, tab in ipairs( tabs )
	do
		if( tab.config.right == true ) then
			tinsert(rightTabs, tab)
		else
		    tinsert(leftTabs, tab)
		end
	end
	
	--
	-- Sort the tabs
	--
	tsort( leftTabs, left_sort )
	tsort( rightTabs, right_sort )
	
	-- Preset our left anchor
	leftAnchor.RelativeTo		= windowId
	leftAnchor.Point 			= "bottomleft"
	leftAnchor.RelativePoint 	= "topleft"
	leftAnchor.XOffset			= 15
	leftAnchor.YOffset			= -7
	
	-- Preset our right anchor
	rightAnchor.RelativeTo		= windowId
	rightAnchor.Point 			= "bottomright"
	rightAnchor.RelativePoint 	= "topright"
	rightAnchor.XOffset			= -15
	rightAnchor.YOffset			= -7
	
	-- Anchor the left tabs
	for index, tab in ipairs( leftTabs )
	do
		-- Set the anchor
		tab:AnchorTo( leftAnchor.RelativeTo, leftAnchor.Point, leftAnchor.RelativePoint, leftAnchor.XOffset, leftAnchor.YOffset )
		
		-- Update the anchor for the next tab
		leftAnchor.RelativeTo		= tab.name
		leftAnchor.Point 			= "topright"
		leftAnchor.RelativePoint 	= "topleft"
		leftAnchor.XOffset			= 5
		leftAnchor.YOffset			= 0
	end
	
	-- Anchor the right tabs
	for index, tab in ipairs( rightTabs )
	do
		tab:AnchorTo( rightAnchor.RelativeTo, rightAnchor.Point, rightAnchor.RelativePoint, rightAnchor.XOffset, rightAnchor.YOffset )
		
		-- Update the anchor for the next tab
		rightAnchor.RelativeTo		= tab.name
		rightAnchor.Point 			= "topleft"
		rightAnchor.RelativePoint 	= "topright"
		rightAnchor.XOffset			= -5
		rightAnchor.YOffset			= 0
	end
	
	del( leftAnchor )
	del( rightAnchor )
	del( leftTabs )
	del( rightTabs )
end

function CreateUI( module )
	if( module == nil  ) then return end
	
	local config = module:GetUserInterface()
	
	-- Sanity check this config
	if( config ~= nil and config.name ~= nil and config.name:len() > 0 and config.windowId ~= nil and DoesWindowExist( config.windowId ) ) then
		-- Create a tab for the window
		local tab = LibGUI( "Button", windowId .. "Tab" .. tostring( tabCounter ), "Shinies_Button_BottomTab" )
	
		-- Add the tab to our tabs and tabDislay tables
		tinsert( tabs, tab )
		
		tab:Resize( 129, 47 )
		tab:SetText( config.name )
		tab:Parent( tabWindowId )
		tab:SetId( tabCounter )
		tab:CaptureInput()
		tab.OnLButtonUp = 
			function()
				OnUITabSelect( tab )
			end
		
		-- Store the config for the window
		tab.config = config

		-- Store the tabs index
		tab.idx	= tabCounter
		
		-- Increment our tab counter
		tabCounter = tabCounter + 1
		
		-- Set the windows parent to ourself
		WindowSetParent( config.windowId, windowId )
		
		-- Set the windows scale appropriately
		WindowSetScale( config.windowId, Shinies.db.profile.general.uiscale )
		
		-- Anchor the window to ourselves
		WindowClearAnchors( config.windowId )
		WindowAddAnchor( config.windowId, "bottomleft", windowId .. "TitleBar", "topleft", 8, 0 )
		WindowAddAnchor( config.windowId, "bottomright", windowId, "bottomright", -8, -8)
		
		-- Hide the window
		WindowSetShowing( config.windowId, false )
	end
end

function InitializeUI()
	self = Shinies
	
	-- Create our tab window first
	if( not DoesWindowExist( tabWindowId ) ) then
		CreateWindow( tabWindowId, false )
	end
	WindowSetShowing( tabWindowId, false )
	
	if( not DoesWindowExist( windowId ) ) then
		CreateWindow( windowId, false )
		WindowSetDimensions( windowId, windowMinWidth, windowMinHeight )
	end
	LabelSetText( windowId .. "TitleBarText", L"Shinies - " .. towstring( DisplayVersion ) )
	
	self:UpdateUIScale( self.db.profile.general.uiscale )
	
	WindowClearAnchors( tabWindowId )
	WindowAddAnchor( tabWindowId, "bottomleft", windowId, "topleft", 0, 0 )
	WindowAddAnchor( tabWindowId, "bottomright", windowId, "topright", 0, 0 )
end

function OnUITabSelect( tab )
	ShowUITab( tab:GetId() )
end

function RemoveAllUITabs()
	for _, tab in pairs( tabs )
	do
		if( DoesWindowExist( tab.name ) ) then
			DestroyWindow( tab.name )
		end
	end
	
	-- Clear our tabs
	wipe(tabs)
end
   
function ShowUITab( index )
	if( currentTab == index ) then return end

	if( currentTab > 0 and tabs[currentTab] ~= nil ) then 
		ButtonSetPressedFlag( tabs[currentTab].name, false )
		ButtonSetStayDownFlag( tabs[currentTab].name, false )
		WindowSetShowing( tabs[currentTab].config.windowId, false )
	end
		
	currentTab = index
	
	if( currentTab > 0 and tabs[currentTab] ~= nil ) then 
		ButtonSetPressedFlag( tabs[currentTab].name, true )
		ButtonSetStayDownFlag( tabs[currentTab].name, true )
		WindowSetShowing( tabs[currentTab].config.windowId, true )
	end
end

function UpdateUI()
	-- Anchor our tabs
	AnchorUITabs()
	
	-- See if we have a default tab to display
	for _, tab in pairs( tabs )
	do
		if( tab.config.default == true ) then
			ShowUITab( tab.idx )
			break
		end	
	end
	
	-- If we got this far there is no default, so show the first tab 
	if( currentTab == 0 ) then
		ShowUITab( 1 )
	end
end
