local _G = _G
local Shinies = _G.Shinies

local mod = Shinies:NewModuleType("Config", 
	{
		global = 
		{
			enabled = true,
		},
	} 
)

--
-- This function returns an ordered table of windows that make up the configuration
--
-- The config module retains ownership of its windows, and is therefore responsible
-- for cleaning them up
--
function mod:GetUserInterface() 
	--[[
		config = 
		{
			name		= L"",				-- The name displayed to the user for the UI (list name)
			windows		= {}, 				-- An ordered table of LibGUI windows that make up a config
		}
	--]]
	return {}
end