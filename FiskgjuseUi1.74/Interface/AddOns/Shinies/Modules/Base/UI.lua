local _G = _G
local Shinies = _G.Shinies

local mod = Shinies:NewModuleType("UI", 
{
	global = 
	{
		enabled = true,
	},
} 
)

function mod:GetUserInterface() 
	--[[
		config = 
		{
			name		= L"",				-- The name displayed to the user for the UI (tab name)
			windowId	= "", 				-- The window that is being registered
			right		= false,			-- Identifies if the tab is right justified on the window
			idx			= nil,				-- Internal index used to seed the Core modules order
												-- This should not be used by non Core modules
			default		= false,			-- Internal member used to determine which Core module
												-- gets initial focus
			config		= false,			-- Internal member used to identify the configuration tab
		}
	--]]
	return nil
end