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

local Shinies = LibStub( "WAR-AceAddon-3.0" ) : GetAddon( "Shinies" )

if( Shinies == nil ) then
	d( "Error retrieving Shinies addon." )
	return
end

local MODNAME = "Shinies-Price-Straight"

local lib	= Shinies : NewModule( MODNAME )
if lib == nil then return end

local T 				= Shinies.T

function lib:OnInitialize()
	self:SetEnabledState( Shinies:GetModuleEnabled( MODNAME ) )
end 

function lib:OnEnable()
end

function lib:OnDisable()
end

function lib:OnRefresh()
end

function lib:GetItemPrice( item, results )
	local data = {}
	data.price = average or mean
	data.seen = 0
	data.confidence = confidence
	-- This is additional data
	data.normalized = average
	data.mean = mean
	data.deviation = stdev
	data.variance = variance
	data.processed = count

	return data
end

function lib:GetDescription()
	return T["1 Brass Undercut"]
end