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
local MODNAME 		= "Shinies-Tooltip-Debug"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Tooltip" )
mod:SetName( T["Shinies Debug Tooltip"] )
mod:SetDescription(T["Provides debug information for a given item."])
mod:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

function mod:GetItemToolTipInformation( itemData )
	local id = itemData.uniqueID
	
	local ret = new()
	-- Add the header row
	ret[1] =
	{
		cols = 
		{
			[2] = 
			{
				text 			= T["Debug Information"],
				color 			=						 
				{
					r = 222,
					g = 92,
					b = 50,
				},
			},
		},
	}
	
	ret[2] =
	{
		cols = 
		{
			[1] = 
			{
				text 			= T["Item Unique ID"],
			},
			[3] = 
			{
				text 			= towstring( id ),
			},
		},
	}
	return ret
end

function mod:OnAllModulesEnabled()
	SDI	= Shinies : GetModule( "Shinies-Data-Inventory" )
end