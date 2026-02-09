local _G = _G
local Shinies = _G.Shinies

local mod = Shinies:NewModuleType("Tooltip", 
{
	global = 
	{
		enabled = true,
	},
} 
)

function mod:GetItemToolTipInformation( itemData )
	--[[
		This function returns a table that defines the row structure for the tooltip rows it provides
		
		return {
			-- Row 1
			[1]	= 
			{
				-- Defines the columns for this row
					-- There are 3 columns
						-- 1 = left 		-- this column's text is aligned left
						-- 2 = center 		-- this column's text is aligned center
						-- 3 = right 		-- this column's text is aligned right
				cols = 
				{
					[1] = 
					{
						text 		= L"", 					-- Text defines the localized text to de displayed
						font 		= "",					-- A font override
						wordwrap	= false,				-- Whether or not this label is word wrapped
						color 		=						-- The color for text 
						{
							r = 0,
							g = 0,
							b = 0,
						},
					}
					
					[3] = 
					{
						text 		= L"", 					-- Text defines the localized text to de displayed
						font 		= "",					-- A font override
						wordwrap	= false,				-- Whether or not this label is word wrapped
						color 		=						-- The color for text 
						{
							r = 0,
							g = 0,
							b = 0,
						},
					}
				},
			},
			-- Row 2
			[2] = {
			
			
			},
			-- Row 3
			[3] = {
			
			
			},
	--]]
	return nil
end