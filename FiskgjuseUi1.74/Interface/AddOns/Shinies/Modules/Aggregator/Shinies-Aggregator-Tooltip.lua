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

local Shinies 		= _G.Shinies
local T		    	= Shinies.T
local MODNAME 		= "Shinies-Aggregator-Tooltip"
local mod	 		= Shinies : NewModule( MODNAME )
local ShiniesAggretatorTooltip = mod
_G.ShiniesAggretatorTooltip 	= ShiniesAggretatorTooltip
mod:SetModuleType( "Aggregator" )
mod:SetName( T["Shinies Tooltip Aggregator"] )
mod:SetDescription(T["Provides a general interface into modules providing a tooltip."])
mod:SetDefaults( {} )

local tinsert		= table.insert

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local BASE_ROWS				= 16

local addTooltipRow, createTooltipWindow, createTooltipRow, resizeTooltipWindow, reanchorTooltipRows

local tooltipWindowId		= MODNAME
local window		= {}

local hook_Tooltips_CreateItemTooltip

ShiniesAggretatorTooltip.LEFT_ALIGN			= 1
ShiniesAggretatorTooltip.CENTER_ALIGN		= 2
ShiniesAggretatorTooltip.RIGHT_ALIGN		= 3

local LEFT_ALIGN		= ShiniesAggretatorTooltip.LEFT_ALIGN
local CENTER_ALIGN		= ShiniesAggretatorTooltip.CENTER_ALIGN
local RIGHT_ALIGN		= ShiniesAggretatorTooltip.RIGHT_ALIGN

local HEIGHT_OFFSET		= 8
local WIDTH_OFFSET		= 10
local ROW_OFFSET		= 2

local MIN_WIDTH			= 300
local MAX_WIDTH			= 400

local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    if state == nil then
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end

    if key then
        return key, t[key]
    end

    t.__orderedIndex = nil
    return
end

local function orderedPairs(t)
    return orderedNext, t, nil
end

function ShiniesAggretatorTooltip.CreateItemTooltip( ... )
	-- Call the base tooltip function first
	local tooltipWindow = hook_Tooltips_CreateItemTooltip(...)
	
	if( tooltipWindow == nil ) then
		d( "No tooltip received from default UI.  Aborting!" )
		return tooltipWindow
	end
	
	-- Build the item information we need
	local itemData, _, _, disableComparison, _, _, _ = ...
	
	local tooltips = new()
	
	-- Poll the configured tooltip modules for their tooltip information
	local tooltip
	for k, mod in Shinies:IterateModulesOfType( "Tooltip" )
	do
		tooltip = mod:GetItemToolTipInformation( itemData )
		if( tooltip ~= nil ) then
			tooltips[mod:GetDisplayName()] = tooltip
		end 
	end
	
	-- Create a sorted list of tooltips based off of mod display name
	local sortedTooltips = new()
	for k, v in orderedPairs( tooltips )
	do
		tinsert( sortedTooltips, v )	
	end
	
	if( #sortedTooltips > 0 ) then
		-- Get a total count of the number of rows we will need
		local totalCount = 0
		
		for _, modTips in ipairs( sortedTooltips )
		do
			totalCount = totalCount + #modTips
		end
		
		-- Verify we have enough rows created, if not, make them
		if( totalCount > #window.Tooltip.Rows ) then
			local toMake = totalCount - #window.Tooltip.Rows	
			
			for idx = 1, toMake
			do
				addTooltipRow()	
			end
			
			reanchorTooltipRows()
		end
	
		local totalRows = #window.Tooltip.Rows
		local rows = window.Tooltip.Rows
		
		-- Hide any rows that will not be shown
		for i = totalCount + 1, totalRows
		do
			rows[i]:Hide()	
		end
		
		-- Populate the row/column data for the rows that will be shown
		local currentRow = 1
		for _, modTips in ipairs( sortedTooltips )
		do
			for _, row in ipairs( modTips )
			do
				local tooltipRow = window.Tooltip.Rows[currentRow]
				
				tooltipRow:Show()
				
				for idx, label in pairs( tooltipRow.E )
				do
					local config = row.cols[idx]
					
					-- Resize the label to its max possible width here so that the
					-- label can decrease its size according to its content when set
					label:Resize( MAX_WIDTH, 0 )
					
					-- If there is information for this column display it, 
					-- otherwise clear the old information
					if( config ~= nil ) then
						-- Update the text
						label:SetText( config.text )
						-- Update the font
						local font = "font_chat_text"
						if( config.font ) then
							font = config.fong
						end 
						label:Font( font )
						
						-- Update the font color
						local color	= { r=255, g=255, b=255 } 
						if( config.color ) then 
							color = config.color	
						end
						label:Color( color.r, color.g, color.b )
						
						-- Update the word wrap setting
						local wordWrap = false
						if( config.wordwrap ) then
							wordWrap = config.wordwrap
						end
						label:WordWrap( wordWrap )
					else
						label:SetText( L"" )	
					end
				end
				
				-- Increment the row we are working on
				currentRow = currentRow + 1
			end
		end
		
		-- Resize the tooltip to display all of the provided data
		resizeTooltipWindow()
		
		-- Add the tooltip to the items tooltip dipslay
		Tooltips.AddExtraWindow( window.Tooltip.name, tooltipWindow, nil )
		
		--d( Tooltips.GetLeftmostOrRightmostTooltip( window.Tooltip.name, math.min ) )
		--d( Tooltips.GetLeftmostOrRightmostTooltip( window.Tooltip.name, math.max ) )
		
		--d( #Tooltips.curExtraWindows )
		
		-- Make sure the tooltip window is showing
		window.Tooltip:Show()
	end
	
	del(tooltips)
	del(sortedTooltips)
	
	-- return the same value as the base function
	return tooltipWindow 
end

function mod:OnInitialize()
end

function mod:OnEnable()
	-- Create our tooltip window
	createTooltipWindow()
	
	-- Hook our functions last when we are ready to go
	hook_Tooltips_CreateItemTooltip = Tooltips.CreateItemTooltip
	Tooltips.CreateItemTooltip = ShiniesAggretatorTooltip.CreateItemTooltip
end

function mod:OnDisable()
	Tooltips.CreateItemTooltip = hook_Tooltips_CreateItemTooltip
end

function mod:OnAllModulesEnabled()
end

function addTooltipRow()
	-- create the row
	local row = createTooltipRow()
	
	-- Set the tooltip window as the parent
	row:Parent( window.Tooltip )
	
	-- Hide the window 
	row:Hide()

	-- Add the row to the tooltips table of rows		
	tinsert( window.Tooltip.Rows, row )
end

function createTooltipRow()
	local w
	
	-- The base tooltip window
	w = LibGUI( "window", nil, "ShiniesTooltipDefault" )
	w:IgnoreInput()
	w.E = {}
	
	-- Left label
	e = w( "Label", nil, "ShiniesTooltipBaseLabel" )
    e:Align( "left" )
    e:AddAnchor( w, "topleft", "topleft", 0, 0 )
    w.E[1] = e
    
    -- Center label
	e = w( "Label", nil, "ShiniesTooltipBaseLabel" )
    e:Align( "center" )
    e:AddAnchor( w, "top", "top", 0, 0 )
    w.E[2] = e
    
    -- Right label
	e = w( "Label", nil, "ShiniesTooltipBaseLabel" )
    e:Align( "right" )
    e:AddAnchor( w, "topright", "topright", 0, 0 )
    w.E[3] = e
    
    return w
end

function createTooltipWindow()
	local e
	local w
	
	-- Tooltip Window
	w = LibGUI( "window", tooltipWindowId, "ShiniesTooltipWindow" )
	w:Resize( 400, 67 )
	w:Hide()
	w:Parent( "Root" )
	w:Layer( Window.Layers.OVERLAY )
	w.E = {}
	w.Rows = {}
	window.Tooltip = w
	
	-- Create a tooltip row for each of the base rows
	for idx = 1, BASE_ROWS
	do
		addTooltipRow()		
	end 
	
	reanchorTooltipRows()
end

function reanchorTooltipRows()
	local leftAnchor			= {}
	local rightAnchor			= {}
	
	leftAnchor.Point             = "topleft"
	leftAnchor.RelativePoint     = "topleft"
	leftAnchor.RelativeTo        = window.Tooltip
	leftAnchor.XOffset           = WIDTH_OFFSET
	leftAnchor.YOffset           = HEIGHT_OFFSET
	
	rightAnchor.Point             = "topright"
	rightAnchor.RelativePoint     = "topright"
	rightAnchor.RelativeTo        = window.Tooltip
	rightAnchor.XOffset           = WIDTH_OFFSET * -1
	rightAnchor.YOffset           = HEIGHT_OFFSET
	
	for _, row in ipairs( window.Tooltip.Rows )
	do
		row:ClearAnchors()
		
		-- Set the current anchor
		row:AddAnchor( leftAnchor.RelativeTo.name, leftAnchor.RelativePoint, leftAnchor.Point, leftAnchor.XOffset, leftAnchor.YOffset )
		row:AddAnchor( rightAnchor.RelativeTo.name, rightAnchor.RelativePoint, rightAnchor.Point, rightAnchor.XOffset, rightAnchor.YOffset )
		
		-- Update the anchor for the next row
		leftAnchor.RelativeTo 		= row
		leftAnchor.XOffset          = 0
		leftAnchor.YOffset          = ROW_OFFSET
		leftAnchor.Point 			= "topleft"
		leftAnchor.RelativePoint 	= "bottomleft"
		
		-- Update the anchor for the next row
		rightAnchor.RelativeTo 		= row
		rightAnchor.XOffset         = 0
		rightAnchor.YOffset         = ROW_OFFSET
		rightAnchor.Point 			= "topright"
		rightAnchor.RelativePoint 	= "bottomright"
	end 
end

function resizeTooltipWindow()
	local totalHeight 	= 0
	local widestRow		= 0
	
	local columnWidths = new()
    local rowHeights = new()
	
	-- Iterate the rows to determine the widest row, as well as determine the total height of all rows
	for rowIdx, row in ipairs( window.Tooltip.Rows )
	do
		-- Only process visible rows
		if( row:Showing() ) then
			local rowWidth = 0
			local rowHeight = 0
			local colCount = 0
			
			-- Iterate the columns
			for idx, col in pairs( row.E )
			do
				-- Get the dimensions of the text for this label
				local x, y = LabelGetTextDimensions( col.name )
				
				-- Calculate the largest height of label for this row
				if( y > rowHeight ) then
					rowHeight = y
				end
				
				-- Add this column to the rows total width
				-- Keep track of the number of columns we have
				if( x > 0 ) then
					colCount = colCount + 1
					rowWidth = rowWidth + x
				end
				
				-- Store the max column width for each column
				if( columnWidths[idx] == nil or columnWidths[idx] < x ) then
					columnWidths[idx] = x
				end
			end
			
			-- Update the widest row if need be
			if( rowWidth > widestRow ) then
				-- If there is more than one column used in this row, add a small amount of extra space
				if( colCount > 1 ) then
					widestRow = rowWidth + ( colCount * 5 )
				else
					-- Update the widest row
					widestRow = rowWidth	
				end
			end
		
			-- Update the total height
			totalHeight = totalHeight + rowHeight + ROW_OFFSET
			
			-- Store the max row height for this row
			rowHeights[rowIdx] = rowHeight
			
			-- Resize this row
			row:Resize( nil, rowHeight )		
		end
	end
	
	-- Iterate each of the rows and resize the right aligned column
	local rightAlignWidth = columnWidths[RIGHT_ALIGN]
	for rowIdx, row in ipairs( window.Tooltip.Rows )
	do
		if( row:Showing() ) then
			WindowSetDimensions( row.E[RIGHT_ALIGN].name, rightAlignWidth, rowHeights[rowIdx] )
		end
	end
	
	widestRow = widestRow + ( WIDTH_OFFSET * 2 )
	
	if( widestRow < MIN_WIDTH ) then
		widestRow = MIN_WIDTH
	end
	
	if( widestRow > MAX_WIDTH ) then
		widestRow = MAX_WIDTH
	end
	
	-- Resize the tooltip window
	window.Tooltip:Resize( widestRow + ( WIDTH_OFFSET * 2 ), totalHeight + ( HEIGHT_OFFSET ) )
	
	del( columnWidths )
    del( rowHeights )
end

--
-- This is a full replacement of the default UI function.  This is not a proper hook
-- and should be considered temporary till Mythic can get the default UI code fixed
--
-- TODO:  Check periodically if this function needs to be removed
--
function Tooltips.AddExtraWindow (windowName, windowToAnchorTo, extraData)
    local index = 1
    while( Tooltips.curExtraWindows[index] ~= nil ) do
        index = index + 1
    end
    
    WindowSetShowing( windowName, true )
    Tooltips.curExtraWindows[index] = { name = windowName, data = extraData };
    
    -- Anchor the additional tooltip windows differently, depending on which side
    -- of the anchor to window of the anchorToWindow the anchorToWindow is placed.
    if WindowGetAnchorCount( windowToAnchorTo ) > 0
    then
        local _, _, anchorTo, _, _ = WindowGetAnchor (windowToAnchorTo, 1)
    end
    local parentParentX, parentParentY = 0, 0
    if( anchorTo and DoesWindowExist(anchorTo) ) then
        parentParentX, parentParentY = WindowGetScreenPosition(anchorTo)
    end
    
    local anchorWindowX, anchorWindowY          = WindowGetScreenPosition (windowToAnchorTo)
    local anchorWindowWidth, anchorWindowHeight = WindowGetDimensions (windowToAnchorTo)
    local newWindowWidth, newWindowHeight       = WindowGetDimensions (windowName)
    local rootWidth, rootHeight                 = WindowGetDimensions ("Root")
    
    -- WindowGetScreenPosition is returning scaled values, that match "Mouse Point" in the UI Debug window;
    -- we want unscaled, to match WindowGetDimensions.
    anchorWindowX = anchorWindowX/InterfaceCore.GetScale()

    WindowClearAnchors (windowName)
    
    if (anchorWindowX > parentParentX) then
        -- Try to anchor the new tooltip to the right of windowToAnchorTo, if it will fit on the screen.
        if (anchorWindowX + anchorWindowWidth + newWindowWidth < rootWidth) then
        	WindowAddAnchor (windowName, "topright", Tooltips.GetLeftmostOrRightmostTooltip(windowName, math.max), "topleft", 0, 0)
        -- Otherwise anchor it to the left of the leftmost current tooltip window.
        else
        	WindowAddAnchor (windowName, "topleft", Tooltips.GetLeftmostOrRightmostTooltip(windowName, math.min), "topright", 0, 0)
        end
    else
        -- Try to anchor the new tooltip to the left of windowToAnchorTo, if it will fit on the screen.
        if (anchorWindowX - newWindowWidth > 0) then
        	WindowAddAnchor (windowName, "topleft", Tooltips.GetLeftmostOrRightmostTooltip(windowName, math.min), "topright", 0, 0) -- anchor on the left of windowToAnchorTo
            
        -- Otherwise anchor it to the right of the rightmost current tooltip window.
        else
        	WindowAddAnchor (windowName, "topright", Tooltips.GetLeftmostOrRightmostTooltip(windowName, math.max), "topleft", 0, 0)
        end
    end

    WindowSetAlpha( windowName, 1.0 )
end