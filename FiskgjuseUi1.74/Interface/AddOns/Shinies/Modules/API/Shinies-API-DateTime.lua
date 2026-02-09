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
local string_gmatch	= string.gmatch

local function strsplit( str, sep )
    local sep, fields = sep or ":", {}
    local pattern = string_format( "([^%s]+)", sep )
    string_gsub( str, pattern, function(c) fields[#fields+1] = c end )
    return fields
end

function ShiniesAPI:DateTime_GetCurrentDate()
	local a = {}
	
	local today = GetTodaysDate()
	
	a.day 	= today.todaysDay
	a.month = today.todaysMonth
	a.year 	= today.todaysYear
	
	return a
end

function ShiniesAPI:DateTime_GetCurrentDateTime()
	local time = self:DateTime_GetCurrentTime()
	local date = self:DateTime_GetCurrentDate()
	
	for k, v in pairs( date )
	do
		time[k] = v	
	end
	
	return time
end

function ShiniesAPI:DateTime_GetCurrentDateTimePack()
	return self:DateTime_PackDateTime( self:DateTime_GetCurrentDateTime() )
end

function ShiniesAPI:DateTime_GetCurrentTime()
	local a = {}
	
	local time = GetComputerTime()
	
	a.second 	= time % 60
	a.minute 	= ( ( time - a.second ) / 60 ) % 60
	a.hour 		= ( ( ( ( time - a.second ) / 60 - a.minute ) / 60 ) % 60 )
	
	return a
end

function ShiniesAPI:DateTime_PackDateTime( dt )
	return string_format( "%s:%s:%s:%s:%s:%s", dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second )
end

function ShiniesAPI:DateTime_UnpackDateTime( dt )
	local data, a = {}, {}
	
	data = strsplit( dt )
	
	a.year 		= data[1]
	a.month 	= data[2]
	a.day 		= data[3]
	a.hour 		= data[4]
	a.minute 	= data[5]
	a.second 	= data[6]
	
	return a
end