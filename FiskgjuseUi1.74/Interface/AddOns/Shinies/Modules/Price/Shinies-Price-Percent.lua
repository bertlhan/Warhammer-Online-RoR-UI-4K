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
local MODNAME 		= "Shinies-Price-Percent"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Price" )
mod:SetName( T["Percent Undercut"] )
mod:SetDescription(T["Undercut the lowest current auction by the configured percentage."])
mod:SetDefaults( 
{ 
	factionrealm = {
		undercut = 1,
	}, 
} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local w

function mod:GetItemPrice( item, results )
	local db = self:GetModuleDB()
	
	local lowIndex		= 0
	local lowPricePer	= 0
	
	for idx, auction in pairs( results )
	do
		if( item.uniqueID == auction.itemData.uniqueID ) then
			if( lowIndex == 0 ) then
				lowIndex 			= idx
				lowPricePer 		= auction.buyOutPrice / auction.itemData.stackCount
			else
				local curPricePer = auction.buyOutPrice / auction.itemData.stackCount
				
				if( curPricePer < lowPricePer ) then
					lowIndex 		= idx
					lowPricePer		= curPricePer
				end
			end
		end
	end
	
	-- If we have a low index and we arent the low bidder, undercut the price
	if( lowIndex ~= 0 and ( WStringsCompare( GameData.Player.name, results[lowIndex].sellerName ) ~= 0 ) ) then
		lowPricePer = lowPricePer - ( lowPricePer * ( self.db.factionrealm.undercut / 100 ) )
	end
	
	if( lowPricePer < 0 ) then lowPricePer = 0 end
	
	return lowPricePer
end

function mod:GetUserInterface()
	if( LibGUI == nil ) then return nil end
	
	-- If our window already exists, return it
	if( w ~= nil ) then return w end
	
	-- Create our base window
	w = LibGUI( "window" , nil, "ShiniesWindowDefault" )
	w:Resize( 700, 85 )
	w.e = new()
	w.module = self
	w.Apply = 
		function(self)
			self.module.db.factionrealm.undercut = tonumber( self.e.Value:GetText() ) or 0
			
			if( self.module.db.factionrealm.undercut < 1 ) then self.module.db.factionrealm.undercut = 1 end			
			if( self.module.db.factionrealm.undercut > 99 ) then self.module.db.factionrealm.undercut = 99 end
			
			-- Revert to update our display
			self:Revert(self)			
		end
	w.Revert = 
		function(self)
			self.e.Value:SetText( tostring( self.module.db.factionrealm.undercut ) )
		end
	
	-- Name
    e = w( "label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 225, 30 )
    e:AnchorTo( w, "topleft", "topleft", 25, 10 )
    e:Align( "leftcenter" )
    e:SetText( towstring(self:GetDisplayName()) .. L":" )
    w.e.Name = e
    
    -- Value
    e = w( "textbox", nil, "Shinies_EditBox_DefaultFrame_TwoNumber" )
    e:Resize( 65, 30 )
    e:AnchorTo( w.e.Name, "right", "left", 5, 0 )
    w.e.Value = e
    
	-- Description
    e = w( "label", nil, "Shinies_Default_Label_ClearSmallFont" )
    e:Resize( 600, 50 )
    e:AnchorTo( w.e.Name, "bottomleft", "topleft", 25, 10 )
    e:WordWrap( true )
    e:Align( "left" )
    e:Color( 222, 192, 50)
    e:SetText( mod:GetDescription() )
    w.e.Description = e
    
   	-- Revert our window before we finish
    w.Revert(w)
    
	return w
end

function mod:OnDisable()
	if( w ~= nil ) then 
		w:Destory()
		w = nil 
	end
end