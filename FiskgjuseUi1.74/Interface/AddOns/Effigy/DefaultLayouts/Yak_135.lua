-- From the lua wiki: http://lua-users.org/wiki/CopyTable
local function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, _copy( getmetatable(object)))
    end
    return _copy(object)
end

-- Future UI accessible Image and Label templates
-- atm no deepcopy, try a "use template" instead of a "load template" semantic
if not UFTemplates then UFTemplates = {} end
if not UFTemplates.Images then UFTemplates.Images = {} end
if not UFTemplates.Labels then UFTemplates.Labels = {} end
if not UFTemplates.Bars then UFTemplates.Bars = {} end
if not UFTemplates.Layouts then UFTemplates.Layouts = {} end

UFTemplates.Bars.YakUI_135_InfoPanel =
{
	grow = "right",
	pos_at_world_object = false,
	hide_if_target = false,
	images = 
	{
		Foreground = 
		{
			pos_x = 0,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.6,
			width = 1200,
			show = true,
			visibility_group = "none",
			layer = "overlay",
			to_anchor = "topleft",
			height = 140,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 180,
					g = 220,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			texture = 
			{
				texture_group = "none",
				x = 0,
				name = "LiquidIPFX",
				slice = "none",
				scale = 1,
				height = 140,
				y = 0,
				width = 1200,
			},
		},
		Background = 
		{
			pos_x = 0,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.8,
			width = 1200,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 140,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 32,
					g = 32,
					b = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			texture = 
			{
				scale = 1,
				width = 1200,
				texture_group = "none",
				x = 0,
				style = "cut",
				height = 140,
				slice = "none",
				y = 0,
				name = "LiquidIPBG",
			},
		},
	},
	scale = 0.99999976158142,
	my_anchor = "top",
	border = 
	{
		padding = 
		{
			top = 0,
			right = 0,
			left = 0,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			color_group = "none",
			allow_overrides = false,
		},
		follow_bg_alpha = false,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		pos_x = 0,
		follow_bg_alpha = true,
		pos_y = 0,
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
	},
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	to_anchor = "top",
	fg = 
	{
		alpha = 
		{
			clamp = 0.2,
			alter = "no",
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			color_group = "none",
			allow_overrides = true,
		},
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 30,
				g = 30,
				r = 30,
			},
			color_group = "none",
			allow_overrides = false,
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	slow_changing_value = true,
	watching_states = 
	{
	},
	icon = 
	{
		scale = 0.5,
		my_anchor = "top",
		alpha = 1,
		show = true,
		to_anchor = "top",
		pos_x = 0,
		follow_bg_alpha = false,
		pos_y = 5,
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
	},
	block_layout_editor = true,
	no_tooltip = true,
	show = false,
	hide_if_zero = false,
	interactive = false,
	visibility_group = "none",
	show_with_target = false,
	width = 1200,
	y = 10,
	x = 0,
	relwin = "Root",
	interactive_type = "none",
	height = 140,
	name = "InfoPanel",
	state = "PlayerHP",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	labels = 
	{
		Guild = 
		{
			anchorTo = "Bar",
			scale = 0.7,
			follow = "no",
			clip_after = 28,
			to_anchor = "center",
			pos_x = 0,
			formattemplate = "[$lvl.GuildXP] $title.GuildXP",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "center",
				name = "font_clear_small_bold",
				case = "upper",
			},
			my_anchor = "center",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 16,
			parent = "Bar",
		},
		Title = 
		{
			anchorTo = "Bar",
			scale = 0.7,
			follow = "no",
			clip_after = 20,
			to_anchor = "center",
			pos_x = 30,
			formattemplate = "$title.Title",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_medium_bold",
				case = "upper",
			},
			my_anchor = "left",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -10,
			parent = "Bar",
		},
		Name = 
		{
			anchorTo = "Bar",
			scale = 0.7,
			my_anchor = "right",
			clip_after = 18,
			to_anchor = "center",
			pos_x = -30,
			formattemplate = "$title",
			follow = "no",
			always_show = false,
			alpha = 1,
			width = 460,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_medium_bold",
				case = "upper",
			},
			visibility_group = "none",
			parent = "Bar",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -10,
			layer = "overlay",
		},
		Level = 
		{
			anchorTo = "",
			scale = 1,
			my_anchor = "left",
			clip_after = 14,
			to_anchor = "left",
			pos_x = 0,
			formattemplate = "$lvl",
			visibility_group = "none",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = false,
			font = 
			{
				name = "font_clear_medium",
				align = "left",
			},
			always_show = false,
			parent = "Bar",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			follow = "no",
		},
		ReownRank = 
		{
			anchorTo = "Bar",
			scale = 0.7,
			follow = "no",
			clip_after = 14,
			to_anchor = "right",
			pos_x = -25,
			formattemplate = "$title.Renown",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_medium_bold",
				case = "none",
			},
			my_anchor = "right",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -10,
			parent = "Bar",
		},
		Rank = 
		{
			anchorTo = "Bar",
			scale = 0.7,
			follow = "no",
			clip_after = 14,
			to_anchor = "left",
			pos_x = 25,
			formattemplate = "$title.Exp",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_medium_bold",
				case = "none",
			},
			my_anchor = "left",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -10,
			parent = "Bar",
		},
	},
}

UFTemplates.Bars.YakUI_135_WorldGroupMember = 
{
	grow = "up",
	scale = 1,
	hide_if_target = false,
	pos_at_world_object = true,
	my_anchor = "center",
	border = 
	{
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 0,
				g = 0,
				r = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		padding = 
		{
			top = 0,
			right = 0,
			left = 0,
			bottom = 0,
		},
		follow_bg_alpha = false,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "SharedMediaYGroupIconShape",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	to_anchor = "center",
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		pos_x = 0,
		follow_bg_alpha = true,
		pos_y = 0,
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.2,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		texture = 
		{
			scale = 0,
			width = 96,
			texture_group = "none",
			slice = "none",
			name = "SharedMediaYGroupIconShape",
			height = 96,
			x = 0,
			y = 0,
			style = "cut",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 160,
				g = 160,
				r = 160,
			},
			color_group = "archetype-colors",
			allow_overrides = false,
		},
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 1,
			out_of_combat = 1,
		},
		texture = 
		{
			scale = 2,
			width = 100,
			texture_group = "none",
			x = 4,
			name = "SharedMediaYGroupIconShape",
			height = 100,
			slice = "none",
			y = 7,
			style = "cut",
		},
	},
	slow_changing_value = false,
	watching_states = 
	{
	},
	icon = 
	{
		scale = 0.8,
		my_anchor = "center",
		alpha = 1,
		show = true,
		to_anchor = "center",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 0,
		pos_x = 0,
	},
	block_layout_editor = true,
	no_tooltip = true,
	show = true,
	hide_if_zero = false,
	interactive = false,
	visibility_group = "none",
	show_with_target = false,
	width = 68,
	state = "grp1hp",
	x = 0,
	relwin = "WorldGroupMember1Invisi",
	interactive_type = "none",
	height = 68,
	name = "WorldGroupMember1",
	y = -100,
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	images = 
	{
		FX = 
		{
			pos_x = 0,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 1,
			width = 72,
			show = true,
			visibility_group = "none",
			layer = "overlay",
			to_anchor = "topleft",
			height = 72,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			texture = 
			{
				y = 0,
				x = 0,
				name = "SharedMediaYGroupIconGloss",
				slice = "none",
				scale = 1,
				texture_group = "none",
				height = 100,
				width = 100,
			},
		},
	},
	labels = 
	{
	},
}

UFTemplates.Bars.YakUI_135_GroupMember = 
{
	grow = "right",
	pos_at_world_object = false,
	hide_if_target = false,
	images = 
	{
		Foreground = 
		{
			pos_x = -6,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.6,
			width = 340,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 180,
					g = 220,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				texture_group = "none",
				slice = "none",
				name = "LiquidUFFX",
				x = 0,
				scale = 1,
				y = 0,
				height = 256,
				width = 1024,
			},
		},
		Background = 
		{
			pos_x = -7,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.8,
			width = 340,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 32,
					g = 32,
					b = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				texture_group = "none",
				slice = "none",
				name = "LiquidUFBG",
				x = 0,
				scale = 1,
				y = 0,
				height = 256,
				width = 1024,
			},
		},
	},
	scale = 0.99999976158142,
	my_anchor = "topleft",
	border = 
	{
		follow_bg_alpha = true,
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "tint_square",
		},
	},
	show = true,
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			allow_overrides = false,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "LiquidBar",
		},
	},
	interactive = true,
	slow_changing_value = false,
	watching_states = 
	{
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 4,
			y = 7,
			name = "tint_square",
		},
	},
	width = 320,
	no_tooltip = false,
	y = 80,
	hide_if_zero = false,
	name = "GroupMember1",
	visibility_group = "none",
	show_with_target = false,
	block_layout_editor = false,
	state = "grp1hp",
	x = 0,
	relwin = "Root",
	interactive_type = "group",
	height = 48,
	icon = 
	{
		scale = 0.64,
		my_anchor = "topleft",
		alpha = 1,
		show = true,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 2,
		pos_x = 30,
	},
	to_anchor = "topleft",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -4,
			formattemplate = "$value",
			my_anchor = "topright",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 2,
			always_show = false,
		},
		Level = 
		{
			anchorTo = "Bar",
			parent = "Bar",
			follow = "no",
			clip_after = 2,
			to_anchor = "bottomleft",
			pos_x = 6,
			formattemplate = "$lvl",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			visibility_group = "none",
			my_anchor = "topleft",
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "none",
			},
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 2,
			scale = 0.9,
		},
		Name = 
		{
			anchorTo = "Bar",
			scale = 0.86,
			follow = "no",
			clip_after = 8,
			to_anchor = "bottom",
			pos_x = 42,
			formattemplate = "$title",
			my_anchor = "top",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "upper",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			always_show = false,
		},
	},
}

UFTemplates.Bars.YakUI_135_PlayerHP = 
{
	grow = "right",
	pos_at_world_object = false,
	hide_if_target = false,
	images = 
	{
		Foreground = 
		{
			pos_x = -6,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.6,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 132,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 180,
					g = 220,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -7,
			texture = 
			{
				y = 0,
				x = 0,
				name = "LiquidUFFX",
				slice = "none",
				scale = 1,
				height = 256,
				texture_group = "none",
				width = 1024,
			},
		},
		Background = 
		{
			pos_x = -8,
			parent = "Root",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.8,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 132,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 32,
					g = 32,
					b = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -9,
			texture = 
			{
				y = 0,
				x = 0,
				name = "LiquidUFBG",
				slice = "none",
				scale = 1,
				height = 256,
				texture_group = "none",
				width = 1024,
			},
		},
	},
	scale = 0.99999976158142,
	my_anchor = "center",
	border = 
	{
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = true,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "tint_square",
		},
	},
	show = true,
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			allow_overrides = false,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "LiquidBar",
		},
	},
	interactive = true,
	slow_changing_value = false,
	watching_states = 
	{
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 4,
			y = 7,
			name = "tint_square",
		},
	},
	width = 420,
	no_tooltip = false,
	y = 100,
	hide_if_zero = false,
	name = "PlayerHP",
	visibility_group = "none",
	show_with_target = false,
	block_layout_editor = false,
	state = "PlayerHP",
	x = -360,
	relwin = "Root",
	interactive_type = "player",
	height = 48,
	icon = 
	{
		scale = 0.64,
		my_anchor = "topleft",
		alpha = 1,
		show = true,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 17,
		pos_x = 31,
	},
	to_anchor = "center",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -4,
			formattemplate = "$value",
			my_anchor = "topright",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 17,
			always_show = false,
		},
		Level = 
		{
			anchorTo = "Bar",
			parent = "Bar",
			follow = "no",
			clip_after = 2,
			to_anchor = "bottomleft",
			pos_x = 6,
			formattemplate = "$lvl",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			visibility_group = "none",
			my_anchor = "topleft",
			scale = 0.9,
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 17,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "none",
			},
		},
		Name = 
		{
			anchorTo = "Bar",
			scale = 0.86,
			follow = "no",
			clip_after = 15,
			to_anchor = "bottom",
			pos_x = 42,
			formattemplate = "$title",
			my_anchor = "top",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "upper",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 18,
			always_show = false,
		},
	},
}

UFTemplates.Bars.YakUI_135_PlayerAP = 
{
	grow = "right",
	scale = 1,
	hide_if_target = false,
	images = 
	{
	},
	pos_at_world_object = false,
	my_anchor = "topleft",
	border = 
	{
		padding = 
		{
			top = 0,
			right = 2, --0,
			left = 2, --0,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = false,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "tint_square",
		},
	},
	y = 1,
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			alter = "no",
			in_combat = 1,
			out_of_combat = 1,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			allow_overrides = true,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			slice = "none",
			name = "LiquidBar",
			height = 0,
			x = 0,
			y = 0,
			style = "cut",
		},
	},
	relwin = "PlayerHP",
	slow_changing_value = false,
	watching_states = 
	{
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				r = 24,
				g = 24,
				b = 24,
			},
			color_group = "none",
			allow_overrides = false,
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			y = 7,
			x = 4,
			style = "cut",
			height = 0,
			name = "tint_square",
			texture_group = "none",
			slice = "none",
		},
	},
	width = 420, --207,
	no_tooltip = true,
	state = "PlayerAP",
	hide_if_zero = false,
	interactive = false,
	visibility_group = "none",
	show_with_target = false,
	block_layout_editor = true,
	show = true,
	x = 0, --2,
	name = "PlayerAP",
	interactive_type = "none",
	height = 20,
	icon = 
	{
		scale = 1.1,
		my_anchor = "center",
		alpha = 1,
		show = false,
		to_anchor = "left",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	to_anchor = "bottomleft",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	labels = 
	{
		Name = 
		{
			anchorTo = "Bar",
			scale = 1,
			follow = "no",
			clip_after = 14,
			to_anchor = "center",
			pos_x = 0,
			formattemplate = "$title",
			my_anchor = "center",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				name = "font_clear_medium_bold",
				align = "center",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			always_show = false,
		},
		Value = 
		{
			anchorTo = "Bar",
			scale = 1,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -2,
			formattemplate = "$value",
			my_anchor = "bottomright",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = false,
			font = 
			{
				name = "font_clear_small",
				align = "right",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 50,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -2,
			always_show = false,
		},
	},
}

UFTemplates.Bars.YakUI_135_PlayerCareer = 
{
	grow = "right",
	scale = 1,
	hide_if_target = false,
	images = 
	{
	},
	pos_at_world_object = false,
	my_anchor = "topleft",
	border = 
	{
		padding = 
		{
			top = 0,
			right = 2,--0,
			left = 2, --0,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = true,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "tint_square",
		},
	},
	to_anchor = "bottomleft",
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			allow_overrides = false,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			slice = "none",
			style = "cut",
			height = 0,
			x = 0,
			y = 0,
			name = "LiquidBar",
		},
	},
	show = true,
	slow_changing_value = false,
	watching_states = 
	{
	},
	icon = 
	{
		scale = 1.1,
		my_anchor = "center",
		alpha = 1,
		show = false,
		to_anchor = "left",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	width = 420,--206,
	no_tooltip = false,
	state = "PlayerCareer",
	hide_if_zero = false,
	interactive = false,
	x = 0,
	show_with_target = false,
	block_layout_editor = true,
	y = 1,
	visibility_group = "none",
	name = "PlayerCareer",
	interactive_type = "none",
	height = 3,
	relwin = "PlayerAP",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				r = 24,
				g = 24,
				b = 24,
			},
			color_group = "none",
			allow_overrides = false,
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			y = 7,
			x = 4,
			style = "cut",
			height = 0,
			name = "tint_square",
			texture_group = "none",
			slice = "none",
		},
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			scale = 1,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -2,
			formattemplate = "$value",
			my_anchor = "bottomright",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = false,
			font = 
			{
				name = "font_clear_small",
				align = "right",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -2,
			always_show = false,
		},
	},
}

UFTemplates.Bars.YakUI_135_HostileTarget = 
{
	name = "HostileTarget",
	state = "HTHP",
	y = 100,
	interactive_type = "none",
	no_tooltip = false,
	
	show = true,
	hide_if_target = false,
	show_with_target = true,
	visibility_group = "none",
	grow = "right",
	scale = 0.99999976158142,
	hide_if_zero = false,
	block_layout_editor = false,
	relwin = "Root",
	my_anchor = "center",
	to_anchor = "center",
	x = 360,
	pos_at_world_object = false,
	width = 420,
	height = 48,
	interactive = true,
	slow_changing_value = false,
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	border = 
	{
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = true,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			texture_group = "none",
			x = 4,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 7,
			style = "cut",
		},
	},

	images = 
	{
		Foreground = 
		{
			pos_x = -6,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.6,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 180,
					g = 220,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				y = 0,
				x = 0,
				name = "LiquidUFFX",
				slice = "none",
				scale = 1,
				height = 256,
				texture_group = "none",
				width = 1024,
				style = "cut",
			},
		},
		Background = 
		{
			pos_x = -7,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.8,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 32,
					g = 32,
					b = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				y = 0,
				x = 0,
				name = "LiquidUFBG",
				slice = "none",
				scale = 1,
				texture_group = "none",
				height = 256,
				width = 1024,
				style = "cut",
			},
		},
	},
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 192,
				g = 48,
				b = 160,
			},
			allow_overrides = false,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "LiquidBar",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	icon = 
	{
		scale = 0.64,
		my_anchor = "topleft",
		alpha = 1,
		show = true,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020197",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 3,
		pos_x = 31,
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -4,
			formattemplate = "$value",
			my_anchor = "topright",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			always_show = false,
		},
		Level = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomleft",
			pos_x = 6,
			formattemplate = "$lvl",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			visibility_group = "none",
			my_anchor = "topleft",
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "none",
			},
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			parent = "Bar",
		},
		Name = 
		{
			anchorTo = "Bar",
			scale = 0.86,
			follow = "no",
			clip_after = 14,
			to_anchor = "bottom",
			pos_x = 42,
			formattemplate = "$title",
			my_anchor = "top",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "upper",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 4,
			always_show = false,
		},
		Range = 
		{
			anchorTo = "Bar",
			parent = "Bar Fill",
			follow = "no",
			clip_after = 14,
			to_anchor = "right",
			pos_x = -4,
			formattemplate = "$rangemax",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = false,
			visibility_group = "HideIfDead",
			my_anchor = "right",
			scale = 0.86,
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 6,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
		},
	},
	watching_states = {},
}

UFTemplates.Bars.YakUI_135_FriendlyTarget = 
{
	name = "FriendlyTarget",
	state = "FTHP",
	y = 340,
	interactive_type = "friendly",
	no_tooltip = true,
	
	show = true,
	hide_if_target = false,
	show_with_target = true,
	visibility_group = "none",	
	grow = "right",
	scale = 0.99999976158142,
	hide_if_zero = false,
	block_layout_editor = false,
	relwin = "Root",
	my_anchor = "center",
	to_anchor = "center",
	x = 360,
	pos_at_world_object = false,
	width = 420,
	height = 48,
	interactive = true,
	slow_changing_value = false,
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	border = 
	{
		follow_bg_alpha = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 0,
				g = 0,
				r = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 0,
		},
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			y = 0,
			slice = "none",
			name = "tint_square",
			height = 0,
			style = "cut",
			texture_group = "none",
			x = 0,
		},
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 0,
				g = 0,
				r = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			y = 7,
			slice = "none",
			name = "tint_square",
			height = 0,
			style = "cut",
			texture_group = "none",
			x = 4,
		},
	},

	images = 
	{
		Foreground = 
		{
			texture = 
			{
				texture_group = "none",
				x = 0,
				name = "LiquidUFFX",
				slice = "none",
				scale = 1,
				y = 0,
				height = 256,
				width = 1024,
				style = "cut",
			},
			scale = 1,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 255,
					g = 220,
					r = 180,
				},
				allow_overrides = false,
				color_group = "none",
			},
			anchorTo = "Bar BG",
			parent = "Bar",
			my_anchor = "topleft",
			alpha = 0.6,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 100,
			follow_bg_alpha = true,
			pos_y = -6,
			pos_x = -7,
		},
		Background = 
		{
			texture = 
			{
				texture_group = "none",
				x = 0,
				name = "LiquidUFBG",
				slice = "none",
				scale = 1,
				y = 0,
				height = 256,
				width = 1024,
				style = "cut",
			},
			scale = 1,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 32,
					g = 32,
					r = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			anchorTo = "Bar BG",
			parent = "Bar",
			my_anchor = "topleft",
			alpha = 0.8,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 100,
			follow_bg_alpha = true,
			pos_y = -6,
			pos_x = -7,
		},
	},
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		pos_x = 0,
		follow_bg_alpha = false,
		pos_y = 0,
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		pos_x = 0,
		follow_bg_alpha = false,
		pos_y = 0,
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			alter = "no",
			in_combat = 1,
			out_of_combat = 1,
		},
		texture = 
		{
			scale = 0,
			width = 0,
			y = 0,
			slice = "none",
			name = "LiquidBar",
			height = 0,
			style = "cut",
			texture_group = "none",
			x = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				b = 160,
				g = 192,
				r = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
	},
	icon = 
	{
		scale = 0.64,
		my_anchor = "topleft",
		alpha = 1,
		show = true,
		to_anchor = "bottomleft",
		pos_x = 31,
		follow_bg_alpha = false,
		pos_y = 3,
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			parent = "Bar",
			follow = "no",
			clip_after = 3,
			to_anchor = "bottomright",
			pos_x = -4,
			formattemplate = "$value",
			layer = "secondary",
			always_show = false,
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			scale = 0.9,
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			my_anchor = "topright",
		},
		Level = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomleft",
			pos_x = 6,
			formattemplate = "$lvl",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			my_anchor = "topleft",
		},
		Name = 
		{
			anchorTo = "Bar",
			parent = "Bar",
			follow = "no",
			clip_after = 14,
			to_anchor = "bottom",
			pos_x = 42,
			formattemplate = "$title",
			layer = "secondary",
			always_show = false,
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "upper",
			},
			scale = 0.86,
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 4,
			my_anchor = "top",
		},
		Range = 
		{
			anchorTo = "Bar",
			parent = "Bar Fill",
			follow = "no",
			clip_after = 14,
			to_anchor = "right",
			pos_x = -4,
			formattemplate = "$rangemax",
			layer = "overlay",
			alpha = 1,
			width = 0,
			show = false,
			visibility_group = "none",
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			scale = 0.86,
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 6,
			my_anchor = "right",
		},
	},
	watching_states = {},
}

UFTemplates.Bars.YakUI_135_Castbar = 
{
	grow = "right",
	pos_at_world_object = false,
	hide_if_target = false,
	images = 
	{
		Foreground = 
		{
			texture = 
			{
				texture_group = "none",
				slice = "none",
				name = "LiquidCBFX",
				x = 0,
				scale = 1,
				height = 0,
				y = 0,
				width = 0,
			},
			scale = 1,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 255,
					g = 220,
					r = 180,
				},
				allow_overrides = false,
				color_group = "none",
			},
			anchorTo = "Bar BG",
			parent = "Bar",
			my_anchor = "topleft",
			alpha = 0.6,
			width = 450,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 40,
			follow_bg_alpha = true,
			pos_y = -5,
			pos_x = -7,
		},
		Background = 
		{
			texture = 
			{
				texture_group = "none",
				slice = "none",
				name = "LiquidCBBG",
				x = 0,
				scale = 1,
				height = 40,
				y = 0,
				width = 450,
			},
			scale = 1,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 32,
					g = 32,
					r = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			anchorTo = "Bar BG",
			parent = "Bar",
			my_anchor = "topleft",
			alpha = 0.8,
			width = 450,
			show = true,
			visibility_group = "none",
			layer = "background",
			to_anchor = "topleft",
			height = 40,
			follow_bg_alpha = true,
			pos_y = -5,
			pos_x = -7,
		},
		CBEnd = 
		{
			pos_x = -10,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar Fill",
			scale = 1,
			my_anchor = "left",
			alpha = 1,
			width = 40,
			show = true,
			visibility_group = "none",
			layer = "secondary",
			to_anchor = "right",
			height = 50,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 255,
					g = 255,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 0,
			texture = 
			{
				texture_group = "none",
				slice = "none",
				name = "LiquidCBBarEnd",
				x = 0,
				scale = 1,
				y = 0,
				height = 50,
				width = 40,
			},
		},
	},
	scale = 0.99999976158142,
	my_anchor = "bottom",
	border = 
	{
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 2,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = false,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			y = 0,
			x = 0,
			style = "cut",
			height = 0,
			name = "SharedMediaYCastbarBG",
			texture_group = "none",
			slice = "none",
		},
	},
	show = true,
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		pos_x = 0,
		follow_bg_alpha = false,
		pos_y = 0,
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 0,
		pos_x = 0,
	},
	fg = 
	{
		alpha = 
		{
			clamp = 0.2,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			color_group = "none",
			allow_overrides = true,
		},
		texture = 
		{
			scale = 1,
			width = 422,
			texture_group = "none",
			slice = "none",
			name = "LiquidCBBar",
			height = 20,
			style = "cut",
			y = 0,
			x = 0,
		},
	},
	interactive = false,
	slow_changing_value = false,
	watching_states = 
	{
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				b = "no",
				g = "no",
				r = "no",
			},
			color = 
			{
				r = 30,
				g = 30,
				b = 30,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			y = 7,
			x = 4,
			style = "cut",
			height = 0,
			name = "SharedMediaYCastbarBG",
			texture_group = "none",
			slice = "none",
		},
	},
	width = 430,
	no_tooltip = true,
	state = "Castbar",
	hide_if_zero = true,
	name = "Castbar",
	x = -130,
	show_with_target = false,
	block_layout_editor = false,
	y = -320,
	visibility_group = "none",
	relwin = "Root",
	interactive_type = "none",
	height = 28,
	icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 0,
		pos_x = 0,
	},
	to_anchor = "bottom",
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	labels = 
	{
		Name = 
		{
			anchorTo = "Bar BG",
			scale = 0.8,
			follow = "no",
			clip_after = 20,
			to_anchor = "bottom",
			pos_x = 0,
			formattemplate = "$title",
			my_anchor = "top",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "center",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 4,
			always_show = false,
		},
	},
}

UFTemplates.Bars.YakUI_135_Pet = 
{
	grow = "right",
	pos_at_world_object = false,
	hide_if_target = false,
	images = 
	{
		Foreground = 
		{
			pos_x = -6,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.6,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 180,
					g = 220,
					b = 255,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				y = 0,
				slice = "none",
				name = "LiquidUFFX",
				x = 0,
				scale = 1,
				height = 256,
				texture_group = "none",
				width = 1024,
			},
		},
		Background = 
		{
			pos_x = -7,
			parent = "Bar",
			follow_bg_alpha = true,
			anchorTo = "Bar BG",
			scale = 1,
			my_anchor = "topleft",
			alpha = 0.8,
			width = 440,
			show = true,
			visibility_group = "none",
			layer = "default",
			to_anchor = "topleft",
			height = 100,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 32,
					g = 32,
					b = 32,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = -6,
			texture = 
			{
				y = 0,
				slice = "none",
				name = "LiquidUFBG",
				x = 0,
				scale = 1,
				height = 256,
				texture_group = "none",
				width = 1024,
			},
		},
	},
	scale = 0.99999976158142,
	my_anchor = "center",
	border = 
	{
		padding = 
		{
			top = 2,
			right = 2,
			left = 2,
			bottom = 0,
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		follow_bg_alpha = true,
		alpha = 0,
		texture = 
		{
			scale = 1,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	y = 320,
	rvr_icon = 
	{
		scale = 1,
		my_anchor = "topleft",
		alpha = 1,
		show = false,
		to_anchor = "topleft",
		texture = 
		{
			y = 0,
			slice = "RvR-Flag",
			name = "EA_HUD_01",
			scale = 0.7,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	to_anchor = "center",
	fg = 
	{
		alpha = 
		{
			clamp = 0.366,
			out_of_combat = 1,
			in_combat = 1,
			alter = "no",
		},
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 220,
				g = 220,
				b = 220,
			},
			allow_overrides = false,
			color_group = "none",
		},
		texture = 
		{
			scale = 0,
			width = 0,
			texture_group = "none",
			x = 0,
			name = "SharedMediaYBarSet5",
			height = 0,
			slice = "none",
			y = 0,
			style = "cut",
		},
	},
	name = "Pet",
	slow_changing_value = false,
	watching_states = 
	{
	},
	icon = 
	{
		scale = 0.6,
		my_anchor = "topleft",
		alpha = 1,
		show = true,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "icon020183",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = false,
		pos_y = 3,
		pos_x = 32,
	},
	width = 420,
	no_tooltip = false,
	show = true,
	hide_if_zero = false,
	interactive = false,
	visibility_group = "none",
	show_with_target = true,
	block_layout_editor = false,
	state = "PlayerPetHP",
	x = -360,
	relwin = "Root",
	interactive_type = "none",
	height = 48,
	alphasettings = {
		alpha = 1,
		alpha_group = "none"
	},
	bg = 
	{
		show = true,
		colorsettings = 
		{
			ColorPreset = "none",
			alter = 
			{
				r = "no",
				g = "no",
				b = "no",
			},
			color = 
			{
				r = 0,
				g = 0,
				b = 0,
			},
			allow_overrides = false,
			color_group = "none",
		},
		alpha = 
		{
			in_combat = 0,
			out_of_combat = 0,
		},
		texture = 
		{
			scale = 2,
			width = 0,
			texture_group = "none",
			x = 4,
			name = "tint_square",
			height = 0,
			slice = "none",
			y = 7,
			style = "cut",
		},
	},
	status_icon = 
	{
		scale = 0.9,
		my_anchor = "bottomleft",
		alpha = 1,
		show = false,
		to_anchor = "bottomleft",
		texture = 
		{
			y = 0,
			slice = "none",
			name = "none",
			scale = 1,
			x = 0,
		},
		follow_bg_alpha = true,
		pos_y = 0,
		pos_x = 0,
	},
	labels = 
	{
		Value = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 5,
			to_anchor = "bottomright",
			pos_x = -4,
			formattemplate = "$value",
			my_anchor = "topright",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "right",
				name = "font_clear_small_bold",
				case = "none",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 30,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 2,
			always_show = false,
		},
		Level = 
		{
			anchorTo = "Bar",
			scale = 0.9,
			follow = "no",
			clip_after = 2,
			to_anchor = "bottomleft",
			pos_x = 6,
			formattemplate = "$lvl",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			visibility_group = "none",
			my_anchor = "topleft",
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "none",
			},
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
				color = 
				{
					r = 220,
					g = 220,
					b = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 2,
			parent = "Bar",
		},
		Name = 
		{
			anchorTo = "Bar",
			scale = 0.86,
			follow = "no",
			clip_after = 14,
			to_anchor = "bottom",
			pos_x = 42,
			formattemplate = "$title",
			my_anchor = "top",
			layer = "secondary",
			alpha = 1,
			width = 0,
			show = true,
			font = 
			{
				align = "left",
				name = "font_clear_small_bold",
				case = "upper",
			},
			parent = "Bar",
			visibility_group = "none",
			height = 48,
			colorsettings = 
			{
				ColorPreset = "none",
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
				color = 
				{
					b = 220,
					g = 220,
					r = 220,
				},
				allow_overrides = false,
				color_group = "none",
			},
			pos_y = 3,
			always_show = false,
		},
	},
}


UFTemplates.Layouts.YakUI_135 = {}

UFTemplates.Layouts.YakUI_135.InfoPanel = UFTemplates.Bars.YakUI_135_InfoPanel

UFTemplates.Layouts.YakUI_135.PlayerHP = UFTemplates.Bars.YakUI_135_PlayerHP
UFTemplates.Layouts.YakUI_135.PlayerAP = UFTemplates.Bars.YakUI_135_PlayerAP
UFTemplates.Layouts.YakUI_135.PlayerCareer = UFTemplates.Bars.YakUI_135_PlayerCareer
UFTemplates.Layouts.YakUI_135.HostileTarget = UFTemplates.Bars.YakUI_135_HostileTarget
UFTemplates.Layouts.YakUI_135.FriendlyTarget = UFTemplates.Bars.YakUI_135_FriendlyTarget
UFTemplates.Layouts.YakUI_135.Castbar = UFTemplates.Bars.YakUI_135_Castbar
UFTemplates.Layouts.YakUI_135.Pet = UFTemplates.Bars.YakUI_135_Pet

UFTemplates.Layouts.YakUI_135.FriendlyTargetRing = deepcopy(UFTemplates.Bars.Yak_TargetRing)
UFTemplates.Layouts.YakUI_135.FriendlyTargetRing.visibility_group = "HideIfSelf"
UFTemplates.Layouts.YakUI_135.HostileTargetRing = deepcopy(UFTemplates.Bars.Yak_TargetRing)
UFTemplates.Layouts.YakUI_135.HostileTargetRing.name = "HostileTargetRing"
UFTemplates.Layouts.YakUI_135.HostileTargetRing.state = "HTHP"
UFTemplates.Layouts.YakUI_135.HostileTargetRing.relwin = "HostileTargetRingInvisi"
UFTemplates.Layouts.YakUI_135.HostileTargetRing.border.colorsettings.color.r = 255
UFTemplates.Layouts.YakUI_135.HostileTargetRing.border.colorsettings.color.g = 0

UFTemplates.Layouts.YakUI_135.GroupMember1 = deepcopy(UFTemplates.Bars.YakUI_135_GroupMember)
UFTemplates.Layouts.YakUI_135.GroupMember2 = deepcopy(UFTemplates.Bars.YakUI_135_GroupMember)
UFTemplates.Layouts.YakUI_135.GroupMember2.name = "GroupMember2"
UFTemplates.Layouts.YakUI_135.GroupMember2.state = "grp2hp"
UFTemplates.Layouts.YakUI_135.GroupMember2.relwin = "Root"
UFTemplates.Layouts.YakUI_135.GroupMember2.to_anchor = "topleft"
UFTemplates.Layouts.YakUI_135.GroupMember2.my_anchor = "topleft"
UFTemplates.Layouts.YakUI_135.GroupMember2.x = 0
UFTemplates.Layouts.YakUI_135.GroupMember2.y = 230
UFTemplates.Layouts.YakUI_135.GroupMember3 = deepcopy(UFTemplates.Bars.YakUI_135_GroupMember)
UFTemplates.Layouts.YakUI_135.GroupMember3.name = "GroupMember3"
UFTemplates.Layouts.YakUI_135.GroupMember3.state = "grp3hp"
UFTemplates.Layouts.YakUI_135.GroupMember3.relwin = "Root"
UFTemplates.Layouts.YakUI_135.GroupMember3.to_anchor = "topleft"
UFTemplates.Layouts.YakUI_135.GroupMember3.my_anchor = "topleft"
UFTemplates.Layouts.YakUI_135.GroupMember3.x = 0
UFTemplates.Layouts.YakUI_135.GroupMember3.y = 380
UFTemplates.Layouts.YakUI_135.GroupMember4 = deepcopy(UFTemplates.Bars.YakUI_135_GroupMember)
UFTemplates.Layouts.YakUI_135.GroupMember4.name = "GroupMember4"
UFTemplates.Layouts.YakUI_135.GroupMember4.state = "grp4hp"
UFTemplates.Layouts.YakUI_135.GroupMember4.relwin = "Root"
UFTemplates.Layouts.YakUI_135.GroupMember4.to_anchor = "left"
UFTemplates.Layouts.YakUI_135.GroupMember4.my_anchor = "left"
UFTemplates.Layouts.YakUI_135.GroupMember4.x = 0
UFTemplates.Layouts.YakUI_135.GroupMember4.y = -254
UFTemplates.Layouts.YakUI_135.GroupMember5 = deepcopy(UFTemplates.Bars.YakUI_135_GroupMember)
UFTemplates.Layouts.YakUI_135.GroupMember5.name = "GroupMember5"
UFTemplates.Layouts.YakUI_135.GroupMember5.state = "grp5hp"
UFTemplates.Layouts.YakUI_135.GroupMember5.relwin = "Root"
UFTemplates.Layouts.YakUI_135.GroupMember5.to_anchor = "left"
UFTemplates.Layouts.YakUI_135.GroupMember5.my_anchor = "left"
UFTemplates.Layouts.YakUI_135.GroupMember5.x = 0
UFTemplates.Layouts.YakUI_135.GroupMember5.y = -104

UFTemplates.Layouts.YakUI_135.WorldGroupMember1 = deepcopy(UFTemplates.Bars.YakUI_135_WorldGroupMember)
UFTemplates.Layouts.YakUI_135.WorldGroupMember1.name = "WorldGroupMember1"
UFTemplates.Layouts.YakUI_135.WorldGroupMember1.state = "grp1hp"
UFTemplates.Layouts.YakUI_135.WorldGroupMember1.relwin = "WorldGroupMember1Invisi"
UFTemplates.Layouts.YakUI_135.WorldGroupMember2 = deepcopy(UFTemplates.Bars.YakUI_135_WorldGroupMember)
UFTemplates.Layouts.YakUI_135.WorldGroupMember2.name = "WorldGroupMember2"
UFTemplates.Layouts.YakUI_135.WorldGroupMember2.state = "grp2hp"
UFTemplates.Layouts.YakUI_135.WorldGroupMember2.relwin = "WorldGroupMember2Invisi"
UFTemplates.Layouts.YakUI_135.WorldGroupMember3 = deepcopy(UFTemplates.Bars.YakUI_135_WorldGroupMember)
UFTemplates.Layouts.YakUI_135.WorldGroupMember3.name = "WorldGroupMember3"
UFTemplates.Layouts.YakUI_135.WorldGroupMember3.state = "grp3hp"
UFTemplates.Layouts.YakUI_135.WorldGroupMember3.relwin = "WorldGroupMember3Invisi"
UFTemplates.Layouts.YakUI_135.WorldGroupMember4 = deepcopy(UFTemplates.Bars.YakUI_135_WorldGroupMember)
UFTemplates.Layouts.YakUI_135.WorldGroupMember4.name = "WorldGroupMember4"
UFTemplates.Layouts.YakUI_135.WorldGroupMember4.state = "grp4hp"
UFTemplates.Layouts.YakUI_135.WorldGroupMember4.relwin = "WorldGroupMember4Invisi"
UFTemplates.Layouts.YakUI_135.WorldGroupMember5 = deepcopy(UFTemplates.Bars.YakUI_135_WorldGroupMember)
UFTemplates.Layouts.YakUI_135.WorldGroupMember5.name = "WorldGroupMember5"
UFTemplates.Layouts.YakUI_135.WorldGroupMember5.state = "grp5hp"
UFTemplates.Layouts.YakUI_135.WorldGroupMember5.relwin = "WorldGroupMember5Invisi"

