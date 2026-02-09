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

local LibGUI = LibStub( "LibGUI" )

local Shinies 		= _G.Shinies
local T		    	= Shinies.T
local MODNAME 		= "Shinies-Price-Fixed"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Price" )
mod:SetName( T["Fixed Pricing"] )
mod:SetDescription(T["Provides the last saved auction price."])
mod:SetDefaults( 
{ 
	factionrealm = {
		price = {},
	}, 
} )

local w

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

function mod:ClearItemPrice( item )
	if( item == nil ) then return end
	self.db.factionrealm.price[item.uniqueID] = nil
end

function mod:GetItemPrice( item, results )
	if( item ~= nil and self.db.factionrealm.price[item.uniqueID] ~= nil ) then
		return self.db.factionrealm.price[item.uniqueID]
	end
	return 0
end

function mod:IsFixedPriceModule() 
	return true 
end

function mod:OnDisable()
	if( w ~= nil ) then 
		w:Destory()
		w = nil 
	end
end

function mod:SetItemPrice( item, price )
	if( item == nil or price <= 0 ) then return end
	self.db.factionrealm.price[item.uniqueID] = price
end