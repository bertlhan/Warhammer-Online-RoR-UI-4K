local _G = _G
local Shinies = _G.Shinies

local mod = Shinies:NewModuleType("Aggregator", 
	{
		global = 
		{
			enabled = true,
		},
	} 
)