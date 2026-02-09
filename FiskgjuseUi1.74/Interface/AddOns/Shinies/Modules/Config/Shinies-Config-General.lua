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
    
    Portions of this class are from: http://lua-users.org/wiki/SortedIteration
--]]

local LibGUI = LibStub( "LibGUI" )
if (not LibGUI) then return end

local Shinies 				= _G.Shinies
local T		    			= Shinies.T
local MODNAME 				= "Shinies-Config-General"
local ShiniesConfigGeneral	= Shinies : NewModule( MODNAME )
_G.ShiniesConfigGeneral 	= ShiniesConfigGeneral
ShiniesConfigGeneral:SetModuleType( "Config" )
ShiniesConfigGeneral:SetName( T["Shinies General Configuration"] )
ShiniesConfigGeneral:SetDescription(T["Provides a user interface for modifying general Shinies configuration settings."])
ShiniesConfigGeneral:SetDefaults( {} )

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe
local tinsert, tsort = table.insert, table.sort

local config				= nil

local windowGeneral

local MIN_SCALE				= 0.4
local MAX_SCALE				= 1.2

local initializeUI

-----------------------------------------
-- MODULE FUNCTIONS
-----------------------------------------

function ShiniesConfigGeneral:Apply( window )
	for k, v in pairs( window.E )
	do
		if( v.Apply ~= nil and type( v.Apply ) == "function" ) then
			v.Apply( window )
		end
	end
end

function ShiniesConfigGeneral:GetUserInterface()
	-- If our config already exists, return that one
	if( config ~= nil ) then return config end
	
	config = 
	{
		name 		= T["General"],
		windows		= new(),
	}

	-- Create our base window
	windowGeneral = initializeUI()
	tinsert( config.windows, windowGeneral )
	
	return config 
end	

function ShiniesConfigGeneral:OnDisable()
	if( config ~= nil ) then
		for k, v in pairs( config.windows )
		do
			v:Destroy()
		end
		config = nil
	end
end

function ShiniesConfigGeneral.OnSlide_UIScale()
	local tick = windowGeneral.E.UIScale_Slider:GetValue()
 	windowGeneral.E.UIScale_Textbox:SetText( wstring.format( L"%.2f", towstring( tick ) ) )
end

function ShiniesConfigGeneral:Revert( window )
	for k, v in pairs( window.E )
	do
		if( v.Revert ~= nil and type( v.Revert ) == "function" ) then
			v.Revert( window )
		end
	end
end

-----------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------
function initializeUI()
	local w
	local e
	
	-- Create our general window
	w = LibGUI( "window" , nil, "ShiniesWindowDefault" )
	w:Resize( 741, 280 )
	w:Hide()
	w.E = new()
	w.module = self
	w.Apply = 
		function( window )
			ShiniesConfigGeneral:Apply( window )
		end
	w.Revert =
		function( window )
			ShiniesConfigGeneral:Revert( window )
		end
	
	e = w( "label", nil, "Shinies_Default_Label_ClearLargeFont" )
    e:Resize( 450, 25 )
    e:Align( "leftcenter" )
    e:AnchorTo( w, "topleft", "topleft", 15, 10 )
    e:SetText( T["General"] )
    w.E.Title_Label = e
    
    -- Disable Default AH Checkbox
	e = w( "Checkbox" )
	e:AnchorTo( w.E.Title_Label, "bottomleft", "topleft", 10, 10 )
	e.Apply = 
		function( window )
			Shinies.db.profile.general.disable_auction_house = window.E.DisableDefaultAH_Checkbox:GetValue()
			Shinies:UpdateDefaultAuctionHouseDisable()
		end
	e.Revert = 
		function( window )
			window.E.DisableDefaultAH_Checkbox:SetValue( Shinies.db.profile.general.disable_auction_house )
		end
	w.E.DisableDefaultAH_Checkbox = e
	
	-- Disable Default AH Label
    e = w( "Label" )
    e:Resize( 250 )
    e:Align( "leftcenter" )
    e:AnchorTo( w.E.DisableDefaultAH_Checkbox, "right", "left", 10, 0 )
    e:Font( "font_chat_text" )
    e:SetText( T["Disable Default Auction House"] )
    w.E.DisableDefaultAH_Label = e
    
    -- UI Scale Label
    e = w( "Label" )
    e:Resize( 450 )
    e:Align( "center" )
    e:AnchorTo( w, "top", "top", 0, 85 )
    e:Font( "font_chat_text" )
    e:SetText( T["Shinies UI Scale"] )
    w.E.UIScale_Label = e
    
    -- UI Scale Slider
    e = w( "Slider", nil, "ShiniesConfigGeneralUIScaleSlider" )
    e:AnchorTo( w.E.UIScale_Label, "bottom", "top", 0, 5 )
    e:SetRange( MIN_SCALE, MAX_SCALE )
    e.Apply = 
    	function( window )
    		Shinies:UpdateUIScale( window.E.UIScale_Slider:GetValue() )
    	end
    e.Revert = 
    	function( window )
    		w.E.UIScale_Slider:SetValue( Shinies.db.profile.general.uiscale )
    		w.E.UIScale_Textbox:SetText( wstring.format( L"%.2f", towstring( Shinies.db.profile.general.uiscale ) ) )
    	end
    w.E.UIScale_Slider = e
    
    --UI Scale Label
    e = w( "Label" )
    e:Resize( 200 )
    e:AnchorTo( w.E.UIScale_Slider, "left", "right", -15, 0)
    e:Font( "font_chat_text" )
    e:Align( "rightcenter" )
    e:SetText( T["Scale"] )
    w.E.UIScale_Label = e
    
    -- UI Scale Textbox
    e = w( "Textbox" )
    e:Resize( 65 )
    e:AnchorTo( w.E.UIScale_Slider, "right", "left", 10, 0 )
    e:SetText( 255 )
    e:UnregisterDefaultEvents()
    e:IgnoreInput()
    w.E.UIScale_Textbox = e
    
    -- Revert our settings to get them initialized
    w.Revert( w )
    
    return w
end