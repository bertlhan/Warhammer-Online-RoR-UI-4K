if not BuffIndicators then BuffIndicators = {} end

local Addon = BuffIndicators

function Addon.ResetFactoryPreset(colorName)
	if (Addon.DefaultConfiguration[colorName] ~= nil) then
		for k,v in pairs(Addon.DefaultConfiguration[colorName]) do
			Addon.CurrentConfiguration[colorName][k] = v
		end
	end
end

function Addon.ResetFactoryPresets()
	for _,v in pairs(Addon.DefaultConfiguration) do
		Addon.ResetFactoryPresets(v.name)
	end
end


function Addon.GetFactoryPresets()
	local factoryPresetTable = {}
	factoryPresetTable.default = 
	{
		Actions = 
		{
			Color = 
			{
				enabled = false,
				b = 64,
				r = 255,
				g = 167,
				ColorPreset = "buffs-blessing",
			},
			TargetWindow = "PlayerHPImageIndicator3",
			Visibility = 
			{
				enabled = true,
			},
		},
		Name = "default",
		BuffEvent = 
		{
			Watch = "BUFFTYPE",
			BuffTargetType = "Self",
			Parameter = "selfcasts",
			SelfCast = "--"
		},
	}
	
	local typicalUFNames = {"PlayerHP", "FriendlyTarget", "HostileTarget", "GroupMember1", "GroupMember2", "GroupMember3", "GroupMember4", "GroupMember5"}
	for _,ufBar in ipairs(typicalUFNames) do
		local btt = ""
		if ufBar == "PlayerHP" then
			btt = "Self"
		elseif ufBar == "FriendlyTarget" then
			btt = "Friendly"
		elseif ufBar == "HostileTarget" then
			btt = "Hostile"
		elseif ufBar == "GroupMember1" then
			btt = "Party1"
		elseif ufBar == "GroupMember2" then
			btt = "Party2"
		elseif ufBar == "GroupMember3" then
			btt = "Party3"
		elseif ufBar == "GroupMember4" then
			btt = "Party4"
		elseif ufBar == "GroupMember5" then
			btt = "Party5"
		end
		
		factoryPresetTable[ufBar.."-HD-50"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 0,
					ColorPreset = "HD-50",
					g = 0,
					b = 0,
				},
				TargetWindow = ufBar.."ImageIndicator2",
				Visibility = 
				{
					enabled = true,
				},
			},
			Name = ufBar.."-HD-50",
			BuffEvent = 
			{
				Watch = "HEALDEBUFF",
				BuffTargetType = btt,
				Parameter = "50",
				SelfCast = "--"
			},
		}
		factoryPresetTable[ufBar.."-HD-25"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 190,
					ColorPreset = "HD-25",
					g = 0,
					b = 128,
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator21",
			},
			BuffEvent = 
			{
				Watch = "HEALDEBUFF",
				BuffTargetType = btt,
				Parameter = "25",
				SelfCast = "--"
			},
			Name = ufBar.."-HD-25",
		}
		factoryPresetTable[ufBar.."-HD-out"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 255,
					ColorPreset = "HD-out",
					g = 128,
					b = 64,
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator22",
			},
			BuffEvent = 
			{
				Watch = "HEALDEBUFF",
				BuffTargetType = btt,
				Parameter = "out",
				SelfCast = "--"
			},
			Name = ufBar.."-HD-out",
		}
		factoryPresetTable[ufBar.."-ExtraHot"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					b = 255,
					r = 255,
					g = 255,
					ColorPreset = "none",
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator42",
			},
			BuffEvent = 
			{
				Watch = "HOT",
				BuffTargetType = btt,
				Parameter = "ExtraHot",
				SelfCast = "yes"
			},
			Name = ufBar.."-ExtraHot",
		}
		factoryPresetTable[ufBar.."-Hot"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 255,
					b = 255,
					g = 255,
					ColorPreset = "none",
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator4",
			},
			BuffEvent = 
			{
				Watch = "HOT",
				BuffTargetType = btt,
				Parameter = "15",
				SelfCast = "yes"
			},
			Name = ufBar.."-Hot",
		}
		factoryPresetTable[ufBar.."-HotExtra"] = 
		{
			BuffEvent = 
			{
				Watch = "HOT",
				BuffTargetType = btt,
				Parameter = "Extra",
				SelfCast = "yes"
			},
			Name = ufBar.."-HotExtra",
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 200,
					ColorPreset = "Hot-Extra",
					g = 150,
					b = 200,
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator44",
			},
		}
		factoryPresetTable[ufBar.."-Shield"] = 
		{
			BuffEvent = 
			{
				Watch = "HOT",
				BuffTargetType = btt,
				Parameter = "Shield",
				SelfCast = "--"
			},
			Name = ufBar.."-Shield",
			Actions = 
			{
				Color = 
				{
					enabled = false,
					r = 150,
					ColorPreset = "Hot-Shield",
					g = 150,
					b = 200,
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator43",
			},
		}
		factoryPresetTable[ufBar.."-Dispellable"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					b = 128,
					r = 255,
					g = 128,
					ColorPreset = "none",
				},
				TargetWindow = ufBar.."ImageIndicator1",
				Visibility = 
				{
					enabled = true,
				},
			},
			Name = ufBar.."-Dispellable",
			BuffEvent = 
			{
				Watch = "DISPELLABLE",
				BuffTargetType = btt,
				Parameter = "",
				SelfCast = "--"
			},
		}
		factoryPresetTable[ufBar.."-HealHot"] = 
		{
			Actions = 
			{
				Color = 
				{
					enabled = false,
					b = 255,
					ColorPreset = "none",
					g = 255,
					r = 255,
				},
				Visibility = 
				{
					enabled = true,
				},
				TargetWindow = ufBar.."ImageIndicator41",
			},
			BuffEvent = 
			{
				Watch = "HOT",
				BuffTargetType = btt,
				Parameter = "5",
				SelfCast = "yes"
			},
			Name = ufBar.."-HealHot",
		}

	end
	return factoryPresetTable
end

-- should become something like that isup
--[[BuffEvent = {
				BuffTargetType = "Self",
				Operators = { "AND" },
				Conditions = { 
					{Watch = "BUFFTYPE", Parameter = "selfcasts", Negate = false},
					{Watch = "BUFFTYPE", Parameter = "selfcasts", Negate = false}
				}
			},
]]--