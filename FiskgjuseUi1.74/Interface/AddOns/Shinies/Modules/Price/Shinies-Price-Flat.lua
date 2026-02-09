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
local MODNAME 		= "Shinies-Price-Flat"
local mod	 		= Shinies : NewModule( MODNAME )
mod:SetModuleType( "Price" )
mod:SetName( T["Flat Undercut"] )
mod:SetDescription(T["Undercut the lowest current auction by the configured flat rate."])
mod:SetDefaults( 
{ 
	factionrealm = {
		undercut = 1,
	}, 
} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local GetPrice, SetPrice

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
		lowPricePer = lowPricePer - ( self.db.factionrealm.undercut / results[lowIndex].itemData.stackCount )
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
			local price = GetPrice(self)
			if( price < 0 ) then price = 0 end
			self.module.db.factionrealm.undercut = price 
			
			-- Revert to update our display
			self:Revert(self)			
		end
	w.Revert = 
		function(self)
			SetPrice( self, self.module.db.factionrealm.undercut )
		end
	
	-- Name
    e = w( "label", nil, "Shinies_Default_Label_ClearMediumFont" )
    e:Resize( 225, 30 )
    e:AnchorTo( w, "topleft", "topleft", 25, 10 )
    e:Align( "leftcenter" )
    e:SetText( towstring(self:GetDisplayName()) .. L":" )
    w.e.Name = e
    
	-- Gold Textbox
    e = w( "Textbox", nil, "ShiniesPostUI_GoldCoin_EditBox_DefaultFrame" )
    e:Resize( 70, 27 )
    e:AnchorTo( w.e.Name, "right", "left", 5, 0 )
    w.e.Gold_TextBox = e
	
	-- Gold Coin Window
	e = w( "window", nil, "Shinies_GoldCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( w.e.Gold_TextBox, "right", "left", 2, 0 )
    w.e.GoldCoin_Window = e
    
    -- Silver Textbox
    e = w( "Textbox", nil, "ShiniesPostUI_SilverCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( w.e.GoldCoin_Window, "right", "left", 4, 0 )
    w.e.Silver_TextBox = e
	
	-- Silver Coin Window
	e = w( "window", nil, "Shinies_SilverCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( w.e.Silver_TextBox, "right", "left", 2, 0 )
    w.e.SilverCoin_Window = e
    
    -- Brass Textbox
    e = w( "Textbox", nil, "ShiniesPostUI_BrassCoin_EditBox_DefaultFrame" )
    e:Resize( 55, 27 )
    e:AddAnchor( w.e.SilverCoin_Window, "right", "left", 4, 0 )
    w.e.Brass_TextBox = e
	
	-- Brass Coin Window
	e = w( "window", nil, "Shinies_BrassCoin" )
    e:Resize( 16, 16 )
    e:AddAnchor( w.e.Brass_TextBox, "right", "left", 2, 0 )
    w.e.BrassCoin_Window = e
    
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

function GetPrice(window)
	local g, s, b
	
	g = tonumber( window.e.Gold_TextBox:GetText() ) or 0
	s = tonumber( window.e.Silver_TextBox:GetText() ) or 0
	b = tonumber( window.e.Brass_TextBox:GetText() ) or 0
	
	return ( g * 10000 ) + ( s * 100 ) + b
end

function SetPrice( window, price )
	local g, s, b = ShiniesAPI:Display_GetGSBFromMoney( price )
	
	window.e.Gold_TextBox:SetText( towstring( g ) )
	window.e.Silver_TextBox:SetText( towstring( s ) )
	window.e.Brass_TextBox:SetText( towstring( b ) )
end

function mod:OnDisable()
	if( w ~= nil ) then 
		w:Destory()
		w = nil 
	end
end
