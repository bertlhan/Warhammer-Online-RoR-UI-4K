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

local Shinies 		= _G.Shinies
local T		    	= Shinies.T
local MODNAME 		= "Shinies-Tooltip-Inventory"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Tooltip" )
mod:SetName( T["Shinies Inventory Tooltip"] )
mod:SetDescription(T["Provides tooltip information for current item inventories."])
mod:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local wstring_match			= wstring.match
local wstring_format		= wstring.format

local SDI

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

function mod:GetItemToolTipInformation( itemData )
	local data = new()
	
	local id = itemData.uniqueID
	
	data = new()
	
	-- Iterate all of our characters to get the information we need
	for slot, char in ipairs( GameData.Account.CharacterSlot )
	do
		-- Verify a character exists in this slot before beginning
		if( char.Level > 0 ) then
			local name = wstring_match( char.Name, L"([^\^]+).*" )
			
			local newData = new()
			
			-- Store the characters name for display
			newData.name		= name
			
			-- Get the data for the character
			newData.currentInventory, newData.currentTotal = SDI:GetCharacterItemInfo( slot, id )
			
			-- Flag if this character is the current player
			newData.self = WStringsCompare( char.Name, GameData.Player.name ) == 0
			
			-- Only add the character if they have some of the item
			if( newData.currentTotal > 0 ) then
				data[name] = newData
			else
				del(newData)
			end
		end
	end
	
	-- If there isnt any data no need to provide tooltip information
	if( next( data ) == nil ) then return nil end
	
	-- create our return data table
	local ret = new()
	-- Add the header row
	ret[1] =
	{
		cols = 
		{
			[2] = 
			{
				text 			= T["Inventory"],
				color 			=						 
				{
					r = 222,
					g = 92,
					b = 50,
				},
			},
		},
	}
	
	for _, char in orderedPairs( data )
	do
		-- Create the row data
		local rowData = new()
		
		-- Build the row data
		rowData.cols = new()

		-- Handle the left align column		
		rowData.cols[ShiniesAggretatorTooltip.LEFT_ALIGN] = {}
		rowData.cols[ShiniesAggretatorTooltip.LEFT_ALIGN].text = char.name
		if( char.self ) then
			rowData.cols[ShiniesAggretatorTooltip.LEFT_ALIGN].color = { r = 0, g = 200, b = 0 }
		end
		
		-- Handle the right align column
		rowData.cols[ShiniesAggretatorTooltip.RIGHT_ALIGN] = {}
		rowData.cols[ShiniesAggretatorTooltip.RIGHT_ALIGN].text = wstring_format( L"%d (%d)", char.currentInventory, char.currentTotal )
		if( char.self ) then
			rowData.cols[ShiniesAggretatorTooltip.RIGHT_ALIGN].color = { r = 0, g = 200, b = 0 }
		end
		
		-- Add the row data to the tooltip
		tinsert( ret, rowData )
	end

	return ret
end

function mod:OnAllModulesEnabled()
	SDI	= Shinies : GetModule( "Shinies-Data-Inventory" )
end