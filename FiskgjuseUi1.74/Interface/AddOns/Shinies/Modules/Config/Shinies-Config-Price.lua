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
    
    Portions of this class are from: http://lua-users.org/wiki/SortedIteration
--]]

local LibGUI = LibStub( "LibGUI" )
if (not LibGUI) then return end

local towstring 			= towstring

local Shinies 				= _G.Shinies
local T		    			= Shinies.T
local MODNAME 				= "Shinies-Config-Price"
local ShiniesConfigPrice	= Shinies : NewModule( MODNAME )
_G.ShiniesConfigPrice = ShiniesConfigPrice
ShiniesConfigPrice:SetModuleType( "Config" )
ShiniesConfigPrice:SetName( T["Shinies Pricing Configuration"] )
ShiniesConfigPrice:SetDescription(T["Provides a user interface for modifying pricing configuration data."])
ShiniesConfigPrice:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe
local tinsert, tsort = table.insert, table.sort

local SPA

local createBaseWindow, updateDisplayOrder, applyChanges, revertChanges
local setListDisplayData, getSelectedPriorityData, createFillerWindow

local config, baseWindow, modWindows

local displayOrder					= new()
ShiniesConfigPrice.listDisplayData 	= new()
local MAX_VISIBLE_ROWS 				= 4

local sortHeaderData =
{
	[0] = { sortFunc=nil, },
	{ column = "Enable",		text=T[""],},
	{ column = "Module",		text=T["Pricing Module"],},
	{ column = "Decrease",		text=T[""],},
	{ column = "Increase",		text=T[""],},
}

--------------------------------------
-- HELPER FUNCTIONS
--------------------------------------
local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    -- fetch the next value
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

local function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end

-----------------------------------------
-- MODULE FUNCTIONS
-----------------------------------------
function ShiniesConfigPrice:GetUserInterface()
	-- If our config already exists, return that one
	if( config ~= nil ) then return config end
	
	local id = 1

	modWindows = new()
	
	for k,v in pairs( ShiniesConfigPrice.listDisplayData )
	do
		del(v)
	end
	wipe( ShiniesConfigPrice.listDisplayData )
	
	config = 
	{
		name 		= T["Pricing"],
		windows		= new(),
	}

	-- Create our base window
	baseWindow = createBaseWindow()
	tinsert( config.windows, baseWindow )
	
	-- Create the 
	tinsert( config.windows, createFillerWindow() )
	
	-- Iterate the Price modules and get their UIs
	for _, module in Shinies:IterateModulesOfType("Price") 
	do	
		if( not module:IsFixedPriceModule() ) then
			-- Get the modules UI
			local window = module:GetUserInterface()
			
			-- If we have a window, add it to our table
			if( window ~= nil ) then
				modWindows[module:GetName()] = window
			end
		
			-- Set the list display data	
			setListDisplayData( id, module )
			id = id + 1
		end
	end
	
	-- Add the windows based off of their name
	for _, window in orderedPairs( modWindows )
	do
		tinsert( config.windows, window )
	end
	
	-- Update our module display order
	updateDisplayOrder()
	
	-- Clean up our temp tables
	del(modWindows)
	
	return config 
end	

function ShiniesConfigPrice:OnDisable()
	if( baseWindow ~= nil ) then baseWindow:Destory() end
	config = nil
end

function ShiniesConfigPrice.OnLButtonUp_DecreasePriority()
	-- Get the row the user selected
	local config = getSelectedPriorityData()
	
	if( config ~= nil ) then
		-- If this is already the lowest priority do nothing
		if( config.priority == SPA:GetLowestPriority() ) then return end
		
		local oldPriority = config.priority
		local newPriority = oldPriority + 1
		
		-- Find the module with the one this one will replace and bump it
		for _, data in pairs( ShiniesConfigPrice.listDisplayData )
		do
			if( data.priority == newPriority ) then
				data.priority = oldPriority
				break
			end
		end
		
		-- This config gets a new priority
		config.priority = newPriority
		
		-- Update the display order
		updateDisplayOrder()
		
		-- Update the display
		ShiniesConfigPrice.PopulatePriorityDisplay()
	end
end

function ShiniesConfigPrice.OnLButtonUp_EnableModule()
	-- Get the row the user selected
	local config = getSelectedPriorityData()
	
	if( config ~= nil ) then
		-- Toggle the enabled bit
		config.enabled = not config.enabled
		
		-- Update our display
		ShiniesConfigPrice.PopulatePriorityDisplay()
	end
end

function ShiniesConfigPrice.OnLButtonUp_IncreasePriority()
	-- Get the row the user selected
	local config = getSelectedPriorityData()
	
	if( config ~= nil ) then
		-- If this is already the lowest priority do nothing
		if( config.priority == 1 ) then return end
		
		local oldPriority = config.priority
		local newPriority = oldPriority - 1
		
		-- Find the module with the one this one will replace and bump it
		for _, data in pairs( ShiniesConfigPrice.listDisplayData )
		do
			if( data.priority == newPriority ) then
				data.priority = oldPriority
				break
			end
		end
		
		-- This config gets a new priority
		config.priority = newPriority
		
		-- Update the display order
		updateDisplayOrder()
		
		-- Update the display
		ShiniesConfigPrice.PopulatePriorityDisplay()
	end
end

function ShiniesConfigPrice:OnAllModulesEnabled()
	-- Get the SPA
		-- TODO: What to do if we do not find the SPA?
	SPA	= Shinies : GetModule( "Shinies-Aggregator-Price" )
end

function ShiniesConfigPrice.PopulatePriorityDisplay()
	-- Iterate the list of the currently displayed items 
	for row, data in ipairs( ShiniesConfigPrice_PriorityList.PopulatorIndices ) 
	do
		local rowName = baseWindow.e.Priority.name .. "ListRow".. row
		
		local displayData = ShiniesConfigPrice.listDisplayData[data]
		
		if( displayData ~= nil ) then
			ButtonSetPressedFlag( rowName .. "Enable", 	displayData.enabled )
			LabelSetText( rowName .. "Module", 			displayData.name )
			LabelSetText( rowName .. "Priority", 		towstring( displayData.priority ) )
		end
	end
end


-----------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------
function applyChanges()
	-- Iterate through our list data and update the settings for all of the modules
	for _, data in pairs( ShiniesConfigPrice.listDisplayData )
	do
		SPA:SetModuleConfig( data.module, data.priority, data.enabled )	
	end
end

function createBaseWindow()
	-- Create our base window
	w = LibGUI( "window" , nil, "ShiniesWindowDefault" )
	w:Resize( 741, 280 )
	w:Hide()
	w.e = new()
	w.module = self
	
	w.Apply = 
		function()
			applyChanges()
		end
	w.Revert =
		function()
			revertChanges()
		end
	
	e = w( "label", nil, "Shinies_Default_Label_ClearLargeFont" )
    e:Resize( 450, 25 )
    e:Align( "leftcenter" )
    e:AnchorTo( w, "topleft", "topleft", 15, 10 )
    e:SetText( T["Priority"] )
    w.e.Title_Label = e
    
    -- Description
    e = w( "label", nil, "Shinies_Default_Label_ClearSmallFont_WordWrap" )
    e:Resize( 700, 75 )
    e:AnchorTo( w.e.Title_Label, "bottomleft", "topleft", 25, 10 )
    e:Align( "left" )
    e:WordWrap( true )
    e:Color( 222, 192, 50)
    e:SetText( T["The follow list allows you to enable/disable pricing modules, as well as change their priority.  The higher the priority of a pricing module, the more of a likelihood that module will be used for determining the price of an item."] )
    w.e.Description = e
    
    -- Module Priority Window
    e = w( "window", "ShiniesConfigPrice_Priority", "ShiniesConfigPrice_Priority_Template" )
    e:Resize( 455, 118 )
    e:AnchorTo( w, "bottom", "bottom", 0, -25 )
    for i, data in ipairs( sortHeaderData ) do
        local buttonName = e.name .. data.column
        ButtonSetText( buttonName, towstring(data.text) )
    end
    DataUtils.SetListRowAlternatingTints( e.name .. "List", MAX_VISIBLE_ROWS )
    w.e.Priority = e
    
    return w
end

function createFillerWindow()
	-- Create our filler window
	w = LibGUI( "window" , nil, "ShiniesWindowDefault" )
	w:Resize( 741, 120 )
	w:Hide()
	w.e = new()
	w.module = self
	
	e = w( "label", nil, "Shinies_Default_Label_ClearLargeFont" )
    e:Resize( 450, 25 )
    e:Align( "leftcenter" )
    e:AnchorTo( w, "topleft", "topleft", 15, 10 )
    e:SetText( T["Module Configuration"] )
    w.e.Title_Label = e
    
    -- Description
    e = w( "label", nil, "Shinies_Default_Label_ClearSmallFont_WordWrap" )
    e:Resize( 700, 75 )
    e:AnchorTo( w.e.Title_Label, "bottomleft", "topleft", 25, 10 )
    e:Align( "left" )
    e:WordWrap( true )
    e:Color( 222, 192, 50)
    e:SetText( T["Each pricing module has its own set of configuration values.  These values help the module in determining the price they provide for an item."] )
    w.e.Description = e

    return w
end

function getSelectedPriorityData()
	local rowNumber, slowNumber, auction = 0, 0
	
	-- Get the row within the window
	rowNumber = WindowGetId( SystemData.ActiveWindow.name )
	
	-- Get the data index from the list box
    local dataIndex = ListBoxGetDataIndex( baseWindow.e.Priority.name .. "List", rowNumber )
    
    -- Get the slot from the data
    if( dataIndex ~= nil ) then
    	return ShiniesConfigPrice.listDisplayData[dataIndex]
	end
    
	return nil
end

function revertChanges()
	for _, data in pairs( ShiniesConfigPrice.listDisplayData )
	do
		data.priority, data.enabled = SPA:GetModuleConfig( data.module )
	end
	
	ShiniesConfigPrice.PopulatePriorityDisplay()
end

function setListDisplayData( slotNum, module )
	-- Build the list information for this module
	local listDisplayItem = new()
	listDisplayItem.priority, listDisplayItem.enabled 	= SPA:GetModuleConfig( module:GetName() )
	listDisplayItem.module 								= module:GetName()
	listDisplayItem.name 								= module:GetDisplayName()
	ShiniesConfigPrice.listDisplayData[slotNum]			= listDisplayItem
end

function updateDisplayOrder()
	wipe( displayOrder )
	
	local function sort( a, b ) 
		return a.priority < b.priority 
	end
	
	-- Sort our display information
	tsort( ShiniesConfigPrice.listDisplayData, sort )
	
	-- Create the list we will use to display
    for index,_ in ipairs( ShiniesConfigPrice.listDisplayData )
    do
    	-- Add this to the end of our display
    	table.insert( displayOrder, index )
    end
	
	ListBoxSetDisplayOrder( baseWindow.e.Priority.name .. "List", displayOrder )
end