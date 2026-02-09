local _G = _G
local Shinies = _G.Shinies

local mod = Shinies:NewModuleType("Price", 
	{
		global = 
		{
			enabled = true,
		},
	} 
)


function mod:GetItemPrice( item, results ) return 0 end
function mod:SetItemPrice( item, price ) end
function mod:ClearItemPrice( item ) end

--
-- This function is reserved for Shinies-Price-Fixed.  It allows us to special
-- case the module, while also having it accessible for other uses.
--
function mod:IsFixedPriceModule() return false end

--
-- This function returns a LibGUI window or nil if the module does not have 
-- a configuration
--
-- The price module should not retain the user interface
--
function mod:GetUserInterface() 
	return nil
end