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
local MODNAME 		= "Shinies-Tooltip-Stats"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Tooltip" )
mod:SetName( T["Shinies Stats Tooltip"] )
mod:SetDescription(T["Provides a tooltip item auction stats."])
mod:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local wstring_match			= wstring.match
local wstring_format		= wstring.format

local SSB

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
	local item = SSB:GetItemStats( itemData )
	
	if( item == nil ) then return nil end
	
	return 
	{
		[1] = 
		{
			cols = 
			{
				[2] = 
				{
					text 			= T["Auction Statistics"],
					color 			=						 
					{
						r = 222,
						g = 92,
						b = 50,
					},
				},
			},
		},
		[2] = 
		{
			cols = 
			{
				[1] = 
				{
					text 			= T["Mean:"],
				},
				[3] = 
				{
					text 			= ShiniesAPI:Display_GetFormattedMoney( itemData.stackCount * item.mean, true, true ),
				},
			},
		},
		[3] = 
		{
			cols = 
			{
				[1] = 
				{
					text 			= T["Median:"],
				},
				[3] = 
				{
					text 			= ShiniesAPI:Display_GetFormattedMoney( itemData.stackCount * item.median, true, true ),
				},
			},
		},
		[4] = 
		{
			cols = 
			{
				[1] = 
				{
					text 			= T["Mode:"],
				},
				[3] = 
				{
					text 			= ShiniesAPI:Display_GetFormattedMoney( itemData.stackCount * item.mode, true, true ),
				},
			},
		},
		[5] = 
		{
			cols = 
			{
				[1] = 
				{
					text 			= T["Auctions Seen:"],
				},
				[3] = 
				{
					text 			= towstring( item.totalCount ),
				},
			},
		},
	}
end

function mod:OnAllModulesEnabled()
	SSB	= Shinies : GetModule( "Shinies-Stat-Basic" )
end