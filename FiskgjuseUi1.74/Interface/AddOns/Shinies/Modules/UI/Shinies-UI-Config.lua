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

local Shinies 			= _G.Shinies
local T		    		= Shinies.T
local MODNAME 			= "Shinies-UI-Config"
local ShiniesConfigUI 	= Shinies : NewModule( MODNAME )
_G.ShiniesConfigUI 		= ShiniesConfigUI
ShiniesConfigUI:SetModuleType( "UI" )
ShiniesConfigUI:SetName( T["Shinies Config UI"] )
ShiniesConfigUI:SetDescription(T["Provides an interface for configuring Shinies modules."])
ShiniesConfigUI:SetDefaults( {} )

local tsort, tinsert		= table.sort, table.insert

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local config	= {
	name			= T["Config"],
	windowId		= "ShiniesConfigUI",
	idx				= 1,
	right			= true,
}

local window

local MAX_VISIBLE_ROWS 		= 14

local windowModules	 		= config.windowId .. "_Modules"
local windowButtons			= config.windowId .. "_Buttons"
local windowDisplay			= config.windowId .. "_Display"
local windowDisplayChild	= windowDisplay .. "Child"

local displayOrder 				= new()			
ShiniesConfigUI.listDisplayData = new()

local configWindows				= nil			

local InitializeUI, UninitializeUI, ReanchorUI
local InitializeModulesUI, ShowModules
local InitializeButtonsUI

local currentDisplayedConfig	= 0

local uiInitialized 			= false

function ShiniesConfigUI:GetActiveConfigWindowIndex() return currentDisplayedConfig end
 
function ShiniesConfigUI:OnInitialize()
	Shinies:Debug( "ShiniesConfigUI:OnInitialize" )
	
	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesConfigUI:OnEnable()
	Shinies:Debug( "ShiniesConfigUI:OnEnable" )
	
	-- Initialize our UI
	InitializeUI()
end

function ShiniesConfigUI:OnDisable()
	Shinies:Debug( "ShiniesConfigUI:OnDisable" )
	
	-- Uninitialize our UI
	UninitializeUI()
end

function ShiniesConfigUI:GetUserInterface()
	if( configWindows == nil ) then
		-- Create the holder for our config windows
		configWindows = new()
		
		-- Get the UIs from the configuration modules
		for _,module in Shinies:IterateModulesOfType( "Config" ) do
			tinsert( configWindows, module:GetUserInterface() )					 				
		end
		
		-- Update the module display
		self:UpdateModules()
		
		-- Display the first config
		self:UpdateDisplayedConfig( 1 )	
	end

	return config
end

function InitializeUI()
	if( uiInitialized == true ) then return end
	
	-- We are now considered initialized
	uiInitialized = true
	
	-- Create our window
	CreateWindow( config.windowId, false )
	
	-- Create a table for our windows
	window = new()
	
	-- Initialze our sub windows
	InitializeButtonsUI()
	
	-- Clear the anchors of our subwindows
	WindowClearAnchors( windowModules )
	WindowClearAnchors( windowButtons )
	WindowClearAnchors( windowDisplay )
	
	-- We assume the first row exists so we can use it for the sizing of the window
	local _, dy = WindowGetDimensions( "ShiniesConfigUI_ModulesListRow1" )
	
	-- Size the modules window according to row size * rows
	WindowSetDimensions( windowModules, 240, dy * MAX_VISIBLE_ROWS )
	
	-- Anchor the Modules window to the top left portion of the window
	WindowAddAnchor( windowModules, "topleft", config.windowId, "topleft", 0, -8 )
	
	-- Anchor the Buttons window just below the Modules window
	WindowAddAnchor( windowButtons, "bottomright", windowModules, "topright", 0, 0 )
	WindowAddAnchor( windowButtons, "bottomleft", config.windowId, "bottomleft", 4, 0 )
	
	-- Anchor the Display window to the right portion of the window
	WindowAddAnchor( windowDisplay, "topright", windowModules, "topleft", 16, 0 )
	WindowAddAnchor( windowDisplay, "bottomright", config.windowId, "bottomright", 0, 0 )
	
	-- Highlight the modules rows
	DataUtils.SetListRowAlternatingTints( windowModules .. "List", MAX_VISIBLE_ROWS )
end

function UninitializeUI()
	if( uiInitialized == false ) then return end
	
	-- Stop/hide our animation window
    StopSearchingAnimation()
	
	-- Clean up our windows
	for _,w in pairs(window)
	do
		w:Destory()
	end
	window = del(window)
	
	-- We are no longer initialized
	uiInitialized = false
end

function InitializeButtonsUI()
	local e
	local w
	
	-- Buttons Window
	w = LibGUI( "window", windowButtons, "ShiniesWindowDefault" )
	w:Resize( 0, 0 )
	w:Show()
	w:Parent( config.windowId )
	w.E = {}
	window.Buttons = w
	
	-- Revert Button
    e = window.Buttons( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 200 )
    e:AnchorTo( window.Buttons, "bottom", "bottom", 0, -10 )
    e:SetText( T["Revert"] )
    e.OnLButtonUp = 
		function()
			ShiniesConfigUI:OnLButtonUp_Revert()
		end
    window.Buttons.E.Buttons = e
	
	-- Apply Button
    e = window.Buttons( "Button", nil, "Shinies_Default_Button_ClearMediumFont" )
    e:Resize( 200 )
    e:AnchorTo( window.Buttons.E.Buttons, "top", "bottom", 0, -15 )
    e:SetText( T["Apply"] )
    e.OnLButtonUp = 
		function()
			ShiniesConfigUI:OnLButtonUp_Apply()
		end
    window.Buttons.E.Apply_Button = e
end

function ShiniesConfigUI.PopulateDisplay()
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesConfigUI_ModulesList.PopulatorIndices ) 
	do
		if( ShiniesConfigUI.listDisplayData[data].slotNum == currentDisplayedConfig ) then
			LabelSetTextColor( windowModules .. "ListRow".. row .. "Name", DefaultColor.GREEN.r, DefaultColor.GREEN.g, DefaultColor.GREEN.b )
		else
			LabelSetTextColor( windowModules .. "ListRow".. row .. "Name", 255 ,255 ,255 )
		end
	end
end

function ShiniesConfigUI:UpdateModules()
	-- Clear our display order
	wipe( displayOrder )
	wipe( ShiniesConfigUI.listDisplayData )
	
	-- Prepare our display data
	for idx, config in pairs( configWindows ) 
	do
		local listDisplayItem = new()
		
		listDisplayItem.slotNum 	= idx
		listDisplayItem.Name		= config.name
		listDisplayItem.config		= config
		
    	ShiniesConfigUI.listDisplayData[idx] = listDisplayItem
    	
    	-- Hide any of the windows the configs have
    	for _, window in pairs( config.windows )
    	do
    		window:Hide()
    	end
	end
	
	local function _sort( a, b ) 
		if a.config.idx ~= nil and b.config.idx ~= nil then return a.config.idx < b.config.idx end 
		if a.config.idx ~= nil and b.config.idx == nil then return true end 
		if a.config.idx == nil and b.config.idx ~= nil then return false end 
		return a.config.name < b.config.name 
	end
    
    -- Sort our modules
	tsort( ShiniesConfigUI.listDisplayData, _sort )
	
	 -- Create the list we will use to display
    for index, _ in ipairs( ShiniesConfigUI.listDisplayData )
    do
    	table.insert( displayOrder, index )
    end
    
	-- Display the sorted data
	ListBoxSetDisplayOrder( windowModules .. "List", displayOrder )		
end

function ShiniesConfigUI:UpdateDisplayedConfig( newConfig )
	local prevWindow = windowDisplayChild
	
	-- Hide the old config
	self:HideConfig( currentDisplayedConfig )
	
	-- Clear the old config parent
	self:SetConfigParent( currentDisplayedConfig, "Root" )
	
	-- Set the new config parent
	self:SetConfigParent( newConfig, windowDisplayChild )
	
	-- Anchor the configs children
	self:ReanchorConfigDisplay( newConfig, windowDisplayChild )
	
	-- Display the new config
	self:ShowConfig( newConfig )
	
	-- Update our current displayed config
	currentDisplayedConfig = newConfig
	
	-- Tell our scroll window to update its scroll window
	ScrollWindowSetOffset( windowDisplay, 0 )
	ScrollWindowUpdateScrollRect( windowDisplay )

	-- Repopulate our display
	self:PopulateDisplay()
end

function ShiniesConfigUI:GetSlotRowNumForActiveListRow()
	local rowNumber, slowNumber, config
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name ) 

	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( windowModules .. "List" , rowNumber )
    
    -- Get the config from the data
    if( dataIndex ~= nil ) then
    	slotNumber 	= ShiniesConfigUI.listDisplayData[dataIndex].slotNum
    	config 		= ShiniesConfigUI.listDisplayData[dataIndex].config	
	end
    
	return slotNumber, rowNumber, config
end

function ShiniesConfigUI:ShowConfig( index )
	if( configWindows[index] ~= nil and configWindows[index].windows ~= nil ) then
		for _,window in ipairs( configWindows[index].windows )
		do
			window:Show()
		end
	end
end

function ShiniesConfigUI:HideConfig( index )
	if( configWindows[index] ~= nil and configWindows[index].windows ~= nil ) then
		for _, window in ipairs( configWindows[index].windows )
		do
			window:Hide()
		end
	end
end

function ShiniesConfigUI:SetConfigParent( index, parent )
	if( configWindows[index] ~= nil and configWindows[index].windows ~= nil ) then
		for _,window in ipairs( configWindows[index].windows )
		do
			window:Parent( parent )
		end
	end
end

function ShiniesConfigUI:ReanchorConfigDisplay( index, initialParent )
	local prevWindow	= initialParent
	local leftAnchor 	= "topleft"
	local rightAnchor 	= "topright"
	
	if( configWindows[index] ~= nil and configWindows[index].windows ~= nil ) then
		for _, window in ipairs( configWindows[index].windows )
		do
			window:ClearAnchors()
			window:AddAnchor( prevWindow, leftAnchor, "topleft", 0, 0 )
			window:AddAnchor( prevWindow, rightAnchor, "topright", 0, 0 )
			
			prevWindow 		= window.name
			leftAnchor 		= "bottomleft"
			rightAnchor 	= "bottomright"
		end
	end
end

function ShiniesConfigUI.OnLButtonUp_ListItem()
	local slotNum, _, _ = ShiniesConfigUI:GetSlotRowNumForActiveListRow()
	if( slotNum ~= currentDisplayedConfig ) then
		ShiniesConfigUI:UpdateDisplayedConfig( slotNum )	
	end
end

function ShiniesConfigUI.OnLButtonUp_Apply()
	for _,config in ipairs( configWindows )
	do
		for _, window in pairs( config.windows )
		do
			if( window.Apply ~= nil and type(window.Apply) == "function" ) then
				window.Apply(window)
			end	
		end
	end
end

function ShiniesConfigUI.OnLButtonUp_Revert()
	for _, config in ipairs( configWindows )
	do
		for _, window in pairs( config.windows )
		do
			if( window.Revert ~= nil and type(window.Revert) == "function" ) then	
				window.Revert(window)
			end	
		end
	end
end