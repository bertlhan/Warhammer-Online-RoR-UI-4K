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

local LibGUI 			= LibStub( "LibGUI" )
if LibGUI == nil then return end

local Shinies 			= _G.Shinies
local T		    		= Shinies.T
local MODNAME 			= "Shinies-UI-Scan"
local ShiniesScanUI 	= Shinies : NewModule( MODNAME )
_G.ShiniesScanUI 		= ShiniesScanUI
ShiniesScanUI:SetModuleType( "UI" )
ShiniesScanUI:SetName( T["Shinies Scan UI"] )
ShiniesScanUI:SetDescription(T["Allows the user to quickly scan the auction house and build statistical data."])
ShiniesScanUI:SetDefaults( {} )

local ShiniesAPI		= Shinies : GetModule( "Shinies-API-Core" )
local ShiniesConstants 	= ShiniesConstants

local new, del, wipe = Shinies.new, Shinies.del, Shinies.wipe

local SPA

local pairs 				= pairs
local ipairs				= ipairs
local tsort					= table.sort
local tinsert				= table.insert
local string_format 		= string.format

local config	= {
	name			= T["Scan"],
	windowId		= "ShiniesScanUI",
}

local window

local uiInitialized		= false

local InitializeUI, UninitializeUI

function ShiniesScanUI:GetUserInterface()
	return config
end

function ShiniesScanUI:OnEnable()
	Shinies:Debug( "ShiniesScanUI:OnEnable" )
	
	-- If our UI isnt initialized, initialize it	
	InitializeUI()
end

function ShiniesScanUI.OnHidden()
	if( not uiInitialized ) then return end
	--ClearResultsDisplay()
end

function ShiniesScanUI:OnInitialize()
	Shinies:Debug( "ShiniesScanUI:OnInitialize" )
	
	-- We fully initialize our UI here, just incase we end up the default displayed
	-- module.  Should we end up disabled, its a little wasted processing, but
	-- allows us to be ready just in case
	InitializeUI()
end

function ShiniesScanUI.OnShown()
	if( not uiInitialized ) then return end
end


------------------------------------
-- LOCAL FUNCTIONS
------------------------------------

function InitializeUI()
	if( uiInitialized == true ) then return end
	
	-- Create our config window here, so that Shinies can use it
	CreateWindow( config.windowId, false )
	
	-- We are now considered initialized
	uiInitialized = true
end

function UninitializeUI()
	if( uiInitialized == false ) then return end

	-- Clean up our windows
	for _,w in pairs(window)
	do
		if( w.Taborder ~= nil ) then w.TabOrder = del( w.TabOrder ) end
		if( w.TabOrderLookup ~= nil ) then w.TabOrderLookup = del( w.TabOrderLookup ) end	
		
		-- Destroy the window itself
		DestroyWindow( w.name )
	end
	window = del(window)

	-- We are no longer initialized
	uiInitialized = false
end