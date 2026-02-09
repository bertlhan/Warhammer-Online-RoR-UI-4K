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
local ShiniesAPI 	= Shinies : GetModule( "Shinies-API-Core" )

local math_floor	= math.floor
local math_mod 		= math.mod
local string_gsub 	= string.gsub
local string_format	= string.format

--
-- This function takes a single number and returns the gold, silver and brass
-- counts that make up the value 
--
function ShiniesAPI:Display_GetGSBFromMoney( amount )
	if amount == nil then return nil, nil, nil end
	if( type(amount) ~= "number" ) then amount = tonumber(amount) end
	
	local g = math_floor( amount / 10000 )
    local s = math_floor( ( amount - ( g * 10000 ) ) / 100 )
    local b = math_floor( math_mod( amount, 100 ) )
    
    return g, s, b
end

--
-- This function takes an amount of money and returns a string that can
-- be displayed in a label
--
function ShiniesAPI:Display_GetFormattedMoney( amount, showZeroes, showIcons )
	local format	= ""
	local g, s, b = self:Display_GetGSBFromMoney( amount )
	
	if( g > 0 ) then
		if( showIcons ) then
			format = format .. tostring( g ) .. "<icon00046> "
		else
			format = format .. tostring( g ) .. "g "
		end	
	end
	
	if( s > 0 or ( showZeroes and g > 0 ) ) then
		if( showIcons ) then
			format = format .. string_format( "%02d", s ) .. "<icon00047> "
		else
			format = format .. string_format( "%02d", s ) .. "s "
		end
	end
	
	if( b > 0 or ( showZeroes and ( g > 0 or s > 0 ) ) ) then
		if( showIcons ) then
			format = format .. string_format( "%02d", b ) .. "<icon00048> "
		else
			format = format .. string_format( "%02d", b ) .. "b "
		end
	end
	
	-- Trim the leading/trailing spaces if we arent displaying an icon
	if( not showIcons ) then
		format = self:Display_StringTrim( format )
	end
	
	return towstring( format )	 
end

--
-- This function trims a string of leading and trailing spaces
--
function ShiniesAPI:Display_StringTrim( str )
	return ( string_gsub( str, "^%s*(.-)%s*$", "%1" ) )
end