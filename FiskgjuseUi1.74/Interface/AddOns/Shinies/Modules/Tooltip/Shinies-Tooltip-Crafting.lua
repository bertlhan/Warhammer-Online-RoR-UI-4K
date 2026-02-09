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
local MODNAME 		= "Shinies-Tooltip-Crafting"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Tooltip" )
mod:SetName( T["Shinies Crafting Tooltip"] )
mod:SetDescription(T["Provides a tooltip containing crafting information about an item."])
mod:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert

local ShiniesAPI			= Shinies : GetModule( "Shinies-API-Core" )

local lookup				= new()

function mod:GetItemToolTipInformation( itemData )
	-- If this is not a crafting item, provide no data
	if( not ShiniesAPI:Item_IsCraftingItem( itemData ) ) then return nil end

	local data
	if( lookup[itemData.uniqueID] ~= nil ) then
		data = lookup[itemData.uniqueID]
	else
		data = new()
		
		for k,v in pairs( itemData.craftingBonus ) 
		do
			if not data[v.bonusReference] then
		      	data[v.bonusReference]={}
		    end
		    --Bonus values in the itemData table are unsigned 16 bit; convert to signed
		    if( v.bonusValue >32767 ) then
		    	tinsert( data[v.bonusReference], v.bonusValue-65536 )
		    else
		    	data( data[v.bonusReference], v.bonusValue )
		    end
		end
		
		-- Store this information so we do not have to generate it again this runtime
		lookup[itemData.uniqueID] = data
	end

	local ret = new()
	-- Add the header row
	ret[1] =
	{
		cols = 
		{
			[2] = 
			{
				text 			= T["Crafting Information"],
				color 			=						 
				{
					r = 222,
					g = 92,
					b = 50,
				},
			},
		},
	}
	
	--d( itemData )
	
	return ret
end