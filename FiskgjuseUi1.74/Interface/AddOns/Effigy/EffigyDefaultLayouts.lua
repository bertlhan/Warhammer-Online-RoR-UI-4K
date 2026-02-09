-- vim: sw=2 ts=2
if not Effigy then Effigy = {} end
local Addon = Effigy

local default_colorsettings =
{
	color = {r = 0, g = 0, b = 0},
	alter = {r = "no", g = "no", b = "no"},
	allow_overrides = false,
	color_group = "none",
	ColorPreset = "none",
}

local default_texturesettings =
{
	y = 0,
	slice = "none",
	name = "tint_square",
	scale = 1,
	height = 0,
	x = 0,
	width = 0,
	texture_group = "none",
	style = "cut",
}

HUDUF = {}
HUDUF.WBTemplate = 
	{
		name = "WBTemplate",				
		state = "test",
		watching_states = 
		{
		},
		interactive = true,
		interactive_type = "player",
		grow = "right",
		width = 160,
		height = 80,
		pos_at_world_object = false,
		relwin = "Root",
		my_anchor = "center",
		to_anchor = "center",
		x = -348,
		y = 154,
		scale = 0.5,
		show = true,
		show_with_target = false,
		hide_if_zero = false,
		hide_if_target = false,
		visibility_group = "none",
		slow_changing_value = false,
		no_tooltip = false,
		block_layout_editor = false,
		alpha = {
			in_combat = 1,
			out_of_combat = 1,
			alter = "no",
			clamp = 0.2
		},
		tint = {
			r = 255,
			alter_r = "no",
			g = 255,
			alter_g = "no",
			b = 255,
			alter_b = "no",
			allow_overrides = true
		},
		fg = {
			texture = {
				texture_group = "none",
				name = "tint_square",
				scale = 0,
				slice = "none",
				x = 0,
				y = 0,
				width = 0,
				height = 0
			}
		},
		border = {
			alpha = 1,
			follow_bg_alpha = true,
			padding = { top = 2, left = 2, right = 2, bottom = 2}
		}, -- border
		bg = {
			texture = {
				name = "tint_square",
				scale = 15,
				slice = "none",
				x = 4,
				y = 7,
				width = 0,
				height = 0
			},
			alpha = {
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			tint = {
				r = 30,
				alter_r = "no",
				g = 30,
				alter_g = "no",
				b = 30,
				alter_b = "no"
			},
			show = true
		}, -- bg
		-- icons
		rvr_icon = {
			show = true,
			scale = 1,
			my_anchor = "topleft",
			to_anchor = "topleft",
			alpha = 1,
			pos_x = 0,
			pos_y = 0,
			follow_bg_alpha = true,
			texture = {
				name = "EA_HUD_01",
				slice = "RvR-Flag",
				scale = 0.7,
				x = 0,
				y = 0
			}
		},
		icon = {
			show = true,
			texture = {
				name = "none",
				scale = 1,
				slice = "none",
				x = 0,
				y = 0
			},
			to_anchor = "bottomleft",
			my_anchor = "bottomleft",
			scale = 0.9,
			alpha = 1,
			follow_bg_alpha = true,
			pos_x = 0,
			pos_y = 0,

		}, -- icon
		status_icon = {
			show = false,
			texture = {
				name = "none",
				scale = 1,
				slice = "none",
				x = 0,
				y = 0
			},
			to_anchor = "bottomleft",
			my_anchor = "bottomleft",
			scale = 0.9,
			alpha = 1,
			follow_bg_alpha = true,
			pos_x = 0,
			pos_y = 0,
		},
		-- Indicators
		images = {	
			["Indicator1"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "topleft",
				anchorTo = "Bar BG",
				to_anchor = "topleft",
				pos_x = 0,
				pos_y = 0,
				parent = "Bar Fill",
				layer = "overlay",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator2"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "topright",
				anchorTo = "Bar BG",
				to_anchor = "topright",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator3"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "bottomleft",
				anchorTo = "Bar BG",
				to_anchor = "bottomleft",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,
				
				--Size
				width = 20,
				height = 20,
				scale = 1,
				
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator4"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "bottomright",
				anchorTo = "Bar BG",
				to_anchor = "bottomright",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				--Color
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
		},
		-- Labels
		labels = {
			--title
			["title"] = {
				--follow = "no", -- bar | no
				formattemplate = "$title",
				color_group = "none",
				--always_show = false,			--?
				
				show = true,
				alpha = 1,

				my_anchor = "center",
				anchorTo = "",
				to_anchor = "center",
				pos_x = 0,
				pos_y = 0,
				layer = "secondary",
				
				height = 48,
				width = 0,						-- 0: width of Bar
				scale = 1,
				
				font = {
					name = "font_clear_medium",
					align = "center",
				},
				
				color = {
					r = 220,
					g = 220,
					b = 220,
					a = 1
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
			},
		},
	}
HUDUF.WBTemplate.border.texture = default_texturesettings
HUDUF.WBTemplate.border.colorsettings = default_colorsettings
HUDUF.SCTemplate = 
	{		
		name = "SCTemplate",
		state = "test",
		watching_states = 
		{
		},
		interactive = true,
		interactive_type = "player",
		grow = "right",
		width = 160,
		height = 116,
		pos_at_world_object = false,		
		relwin = "Root",
		my_anchor = "center",
		to_anchor = "center",
		x = -340,
		y = 278,
		scale = 0.5,
		show = true,
		show_with_target = false,
		hide_if_zero = false,
		hide_if_target = false,
		visibility_group = "none",
		slow_changing_value = false,
		no_tooltip = false,
		block_layout_editor = false,
		alpha = {
			in_combat = 1,
			out_of_combat = 1,
			alter = "no",
			clamp = 0.2
		},
		tint = {
			r = 255,
			alter_r = "no",
			g = 255,
			alter_g = "no",
			b = 255,
			alter_b = "no",
			allow_overrides = true
		},
		fg = {
			texture = {
				texture_group = "none",
				name = "tint_square",
				scale = 0,
				slice = "none",
				x = 0,
				y = 0,
				width = 0,
				height = 0
			}
		},
		border = {
			alpha = 1,
			follow_bg_alpha = true,
			padding = { top = 2, left = 2, right = 2, bottom = 2}
		}, -- border
		bg = {
			texture = {
				name = "tint_square",
				scale = 15,
				slice = "none",
				x = 4,
				y = 7,
				width = 0,
				height = 0
			},
			alpha = {
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			tint = {
				r = 30,
				alter_r = "no",
				g = 30,
				alter_g = "no",
				b = 30,
				alter_b = "no"
			},
			show = true
		}, -- bg
		-- icons
		rvr_icon = {
			show = true,
			scale = 1,
			my_anchor = "topleft",
			to_anchor = "topleft",
			alpha = 1,
			pos_x = 0,
			pos_y = 0,
			follow_bg_alpha = true,
			texture = {
				name = "EA_HUD_01",
				slice = "RvR-Flag",
				scale = 0.7,
				x = 0,
				y = 0
			}
		},
		icon = {
			show = true,
			texture = {
				name = "none",
				scale = 1,
				slice = "none",
				x = 0,
				y = 0
			},
			to_anchor = "bottomleft",
			my_anchor = "bottomleft",
			scale = 0.9,
			alpha = 1,
			follow_bg_alpha = true,
			pos_x = 0,
			pos_y = 0,

		}, -- icon
		status_icon = {
			show = false,
			texture = {
				name = "none",
				scale = 1,
				slice = "none",
				x = 0,
				y = 0
			},
			to_anchor = "bottomleft",
			my_anchor = "bottomleft",
			scale = 0.9,
			alpha = 1,
			follow_bg_alpha = true,
			pos_x = 0,
			pos_y = 0,
		},
		-- Indicators
		images = {	
			["Indicator1"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "topleft",
				anchorTo = "Bar BG",
				to_anchor = "topleft",
				pos_x = 0,
				pos_y = 0,
				parent = "Bar Fill",
				layer = "overlay",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator2"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "topright",
				anchorTo = "Bar BG",
				to_anchor = "topright",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator3"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "bottomleft",
				anchorTo = "Bar BG",
				to_anchor = "bottomleft",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,
				
				--Size
				width = 20,
				height = 20,
				scale = 1,
				
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
			["Indicator4"] = {
				show = false,
				visibility_group = "none",
				
				my_anchor = "bottomright",
				anchorTo = "Bar BG",
				to_anchor = "bottomright",
				pos_x = 0,
				pos_y = 0,
				layer = "overlay",
				parent = "Bar Fill",
				
				alpha = 1,
				follow_bg_alpha = true,

				--Size
				width = 20,
				height = 20,
				scale = 1,
				--Color
				color = {
					r = 127,
					g = 127,
					b = 127,
					a = 1,
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
				texture_group = "none",
				texture = {
					name = "tint_square",
					scale = 1,
					slice = "none",
					x = 0,
					y = 0,
					width = 0,
					height = 0,
					flipped = false
				}
			},
		},
		-- Labels
		labels = {
			--title
			["title"] = {
				--follow = "no", -- bar | no
				formattemplate = "$title",
				color_group = "none",
				--always_show = false,			--?
				
				show = true,
				alpha = 1,

				my_anchor = "center",
				anchorTo = "",
				to_anchor = "center",
				pos_x = 0,
				pos_y = 0,
				layer = "secondary",
				
				height = 48,
				width = 0,						-- 0: width of Bar
				scale = 1,
				
				font = {
					name = "font_clear_medium",
					align = "center",
				},
				
				color = {
					r = 220,
					g = 220,
					b = 220,
					a = 1
				},
				alter = {
					r = "no",
					g = "no",
					b = "no",
					a = "no",			
				},
			},
		},
	}
HUDUF.SCTemplate.border.texture = default_texturesettings
HUDUF.SCTemplate.border.colorsettings = default_colorsettings

	
	--[[
	Simple = 
	{
		grow = "right",
		rvr_icon = 
		{
			show = true,
			to_anchor = "topleft",
			scale = 1,
			my_anchor = "topleft",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "none",
				name = "none",
				scale = 0,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = true,
			font = 
			{
				r = 220,
				name = "font_clear_medium",
				g = 220,
				b = 220,
			},
			to_anchor = "topleft",
			height = 48,
			my_anchor = "topleft",
			align = "left",
			width = 0,
		},
		icon = 
		{
			show = true,
			to_anchor = "bottomleft",
			scale = 0.9,
			my_anchor = "bottomleft",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020180",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = true,
			font = 
			{
				r = 220,
				name = "font_clear_medium",
				g = 220,
				b = 220,
			},
			height = 48,
			align = "right",
			my_anchor = "bottomright",
			to_anchor = "topright",
			width = 0,
		},
		 = "topleft",
		block_layout_editor = false,
		state = "PlayerHP",
		x = 3,
		name = "PlayerHP",
		interactive_type = "player",
		height = 88,
		my_anchor = "topleft",
		tint = 
		{
			alter_r = "inv",
			r = 255,
			alter_b = "no",
			allow_overrides = true,
			b = 0,
			g = 255,
			alter_g = "perc",
		},
		pos_at_world_object = false,
		border = 
		{
			alpha = 1,
			follow_bg_alpha = true,
			padding = { top = 20, left = 2, right = 2, bottom = 2}
		},
		slow_changing_value = false,
		watching_states = 
		{
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.2,
			out_of_combat = 0.3,
			in_combat = 1,
			alter = "inv",
		},
		width = 482,
		show = true,
		interactive = true,
		bg = 
		{
			show = true,
			texture = 
			{
				y = 241,
				slice = "none",
				name = "EA_HUD_01",
				scale = 0.7,
				height = 40,
				x = 514,
				width = 40,
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.6,
			},
			tint = 
			{
				alter_r = "no",
				r = 30,
				alter_b = "no",
				b = 30,
				g = 30,
				alter_g = "no",
			},
		},
		scale = 0.72357028722763,
		percent_label = 
		{
			align = "right",
			--always_show = true,
			width = 0,
			show = true,
			font = 
			{
				r = 220,
				name = "font_clear_medium",
				g = 220,
				b = 220,
			},
			follow = "top",
			to_anchor = "right",
			height = 48,
			my_anchor = "right",
		},
		relwin = "Root",
		y = 48,
	},
	SimpleBarRedux = 
	{
		grow = "right",
		rvr_icon = 
		{
			show = true,
			to_anchor = "topleft",
			scale = 1,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "none",
				name = "none",
				scale = 0,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = true,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			align = "left",
			height = 48,
			my_anchor = "center",
			to_anchor = "center",
			width = 0,
		},
		icon = 
		{
			show = true,
			to_anchor = "right",
			scale = 0.9,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020180",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = true,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			to_anchor = "topright",
			align = "right",
			my_anchor = "bottomright",
			height = 48,
			width = 0,
		},
		to_anchor = "left",
		block_layout_editor = false,
		y = -242,
		x = 16,
		name = "PlayerHP",
		interactive_type = "player",
		height = 78,
		my_anchor = "left",
		tint = 
		{
			alter_r = "inv",
			r = 255,
			alter_b = "no",
			allow_overrides = true,
			b = 0,
			g = 255,
			alter_g = "perc",
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = true,
			alpha = 1,
			padding = { top = 10, left = 2, right = 2, bottom = 2}
		},
		slow_changing_value = false,
		watching_states = 
		{
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.2,
			alter = "inv",
			in_combat = 1,
			out_of_combat = 0.3,
		},
		width = 422,
		show = true,
		relwin = "Root",
		bg = 
		{
			show = true,
			tint = 
			{
				alter_r = "no",
				r = 30,
				alter_b = "no",
				b = 30,
				g = 30,
				alter_g = "no",
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.6,
			},
			texture = 
			{
				y = 241,
				slice = "none",
				name = "EA_HUD_01",
				scale = 0.7,
				height = 40,
				x = 514,
				width = 40,
			},
		},
		scale = 0.72357028722763,
		percent_label = 
		{
			align = "left",
			--always_show = true,
			width = 0,
			show = true,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			follow = "bottom",
			to_anchor = "right",
			height = 48,
			my_anchor = "right",
		},
		state = "PlayerHP",
		interactive = true,
	},
	SimpleVert = 
	{
		grow = "up",
		rvr_icon = 
		{
			show = true,
			to_anchor = "topleft",
			scale = 1,
			my_anchor = "topleft",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "none",
				name = "none",
				scale = 0,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = false,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			to_anchor = "topleft",
			align = "left",
			my_anchor = "topleft",
			height = 48,
			width = 0,
		},
		icon = 
		{
			show = false,
			to_anchor = "bottomleft",
			scale = 0.9,
			my_anchor = "bottomleft",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020180",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = false,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			to_anchor = "bottomright",
			align = "right",
			my_anchor = "bottomright",
			height = 48,
			width = 0,
		},
		to_anchor = "center",
		block_layout_editor = false,
		y = 171.99998474121,
		x = -252.00003051758,
		name = "PlayerHP",
		interactive_type = "",
		height = 600,
		my_anchor = "center",
		tint = 
		{
			alter_r = "inv",
			r = 255,
			alter_b = "no",
			allow_overrides = true,
			b = 0,
			g = 255,
			alter_g = "perc",
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = true,
			alpha = 1,
			padding = { top = 2, left = 2, right = 2, bottom = 2}
		},
		slow_changing_value = false,
		watching_states = 
		{
			[1] = "Combat",
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.2,
			alter = "inv",
			in_combat = 1,
			out_of_combat = 0,
		},
		width = 60,
		show = true,
		interactive = false,
		bg = 
		{
			show = true,
			tint = 
			{
				alter_r = "no",
				r = 30,
				alter_b = "no",
				b = 30,
				g = 30,
				alter_g = "no",
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0,
			},
			texture = 
			{
				y = 7,
				slice = "none",
				name = "icon_frame_square",
				scale = 15,
				height = 0,
				x = 4,
				width = 0,
			},
		},
		scale = 0.60000026226044,
		percent_label = 
		{
			align = "right",
			follow = "bar",
			width = 0,
			show = true,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			always_show = false,
			to_anchor = "right",
			height = 48,
			my_anchor = "right",
		},
		state = "PlayerHP",
		relwin = "Root",
	},
	Psilike = 
	{
		grow = "right",
		rvr_icon = 
		{
			show = true,
			to_anchor = "left",
			scale = 1.4,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "XP-Fill",
				name = "EA_HUD_01",
				scale = 5,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = true,
			font = 
			{
				b = 255,
				g = 255,
				name = "font_default_sub_heading_no_outline",
				r = 255,
			},
			to_anchor = "topleft",
			height = 48,
			my_anchor = "topleft",
			align = "left",
			width = 0,
		},
		icon = 
		{
			show = true,
			to_anchor = "topright",
			scale = 1.5,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020180",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = true,
			font = 
			{
				b = 255,
				name = "font_heading_target_mouseover_name",
				g = 255,
				r = 255,
			},
			to_anchor = "right",
			align = "right",
			my_anchor = "right",
			height = 48,
			width = 90,
		},
		to_anchor = "center",
		block_layout_editor = false,
		y = 278,
		x = -340,
		name = "PlayerHP",
		interactive_type = "player",
		height = 116,
		my_anchor = "center",
		tint = 
		{
			alter_r = "no",
			r = 0,
			alter_b = "no",
			allow_overrides = true,
			b = 0,
			g = 255,
			alter_g = "no",
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = true,
			alpha = 1,
			padding = { top = 20, left = 4, right = 4, bottom = 8}
		},
		slow_changing_value = false,
		watching_states = 
		{
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.20000000298023,
			alter = "no",
			in_combat = 0.69310128688812,
			out_of_combat = 0.69310128688812,
		},
		width = 684,
		show = true,
		interactive = true,
		state = "PlayerHP",
		relwin = "Root",
		percent_label = 
		{
			align = "left",
			always_show = true,
			width = 0,
			show = true,
			font = 
			{
				b = 255,
				g = 255,
				name = "font_clear_large_bold",
				r = 255,
			},
			follow = "no",
			to_anchor = "bottomleft",
			height = 48,
			my_anchor = "bottomleft",
		},
		scale = 0.54800027608871,
		bg = 
		{
			show = true,
			tint = 
			{
				alter_r = "no",
				r = 0,
				alter_b = "no",
				b = 0,
				g = 0,
				alter_g = "no",
			},
			alpha = 
			{
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				y = 0,
				slice = "none",
				name = "tint_square",
				scale = 1,
				height = 0,
				x = 0,
				width = 0,
			},
		},
	},
	Minimal = 
	{
		grow = "right",
		rvr_icon = 
		{
			show = true,
			to_anchor = "topleft",
			scale = 1,
			my_anchor = "topleft",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "none",
				name = "none",
				scale = 0,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = false,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			align = "left",
			height = 48,
			my_anchor = "center",
			to_anchor = "center",
			width = 0,
		},
		icon = 
		{
			show = false,
			to_anchor = "right",
			scale = 0.9,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020180",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = false,
			font = 
			{
				b = 220,
				g = 220,
				name = "font_clear_medium",
				r = 220,
			},
			to_anchor = "topright",
			align = "right",
			my_anchor = "bottomright",
			height = 48,
			width = 0,
		},
		to_anchor = "left",
		block_layout_editor = false,
		y = -105,
		x = 1,
		name = "PlayerHP",
		interactive_type = "player",
		height = 68,
		my_anchor = "left",
		tint = 
		{
			alter_r = "inv",
			r = 255,
			alter_b = "no",
			allow_overrides = true,
			b = 0,
			g = 255,
			alter_g = "perc",
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = true,
			alpha = 1,
			padding = { top = 4, left = 4, right = 4, bottom = 4}
		},
		slow_changing_value = false,
		watching_states = 
		{
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.2,
			alter = "inv",
			in_combat = 1,
			out_of_combat = 0.3,
		},
		width = 636,
		show = true,
		interactive = true,
		bg = 
		{
			show = true,
			tint = 
			{
				alter_r = "no",
				r = 30,
				alter_b = "no",
				b = 30,
				g = 30,
				alter_g = "no",
			},
			alpha = 
			{
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				y = 241,
				slice = "none",
				name = "EA_HUD_01",
				scale = 0.7,
				height = 40,
				x = 514,
				width = 40,
			},
		},
		scale = 0.54751235246658,
		percent_label = 
		{
			align = "left",
			always_show = true,
			width = 0,
			show = true,
			font = 
			{
				b = 255,
				g = 255,
				name = "font_clear_medium",
				r = 255,
			},
			follow = "bottom",
			to_anchor = "right",
			height = 48,
			my_anchor = "right",
		},
		state = "PlayerHP",
		relwin = "Root",
	},
	Stoic = 
	{
		grow = "right",
		rvr_icon = 
		{
			show = true,
			to_anchor = "left",
			scale = 0.7,
			my_anchor = "topleft",
			texture = 
			{
				y = 0,
				slice = "RvR-Flag",
				name = "EA_HUD_01",
				scale = 0.7,
				x = 0,
			},
		},
		fg = 
		{
			texture = 
			{
				y = 0,
				slice = "none",
				name = "tint_square",
				scale = 5,
				height = 0,
				x = 0,
				width = 0,
			},
		},
		title_label = 
		{
			show = false,
			font = 
			{
				b = 255,
				g = 255,
				name = "font_default_sub_heading_no_outline",
				r = 255,
			},
			to_anchor = "topleft",
			height = 48,
			my_anchor = "topleft",
			align = "left",
			width = 0,
		},
		icon = 
		{
			show = false,
			to_anchor = "topright",
			scale = 1.5,
			my_anchor = "center",
			texture = 
			{
				y = 0,
				slice = "none",
				name = "icon020187",
				scale = 1,
				x = 0,
			},
		},
		level_label = 
		{
			show = false,
			font = 
			{
				b = 255,
				name = "font_heading_target_mouseover_name",
				g = 255,
				r = 255,
			},
			to_anchor = "right",
			align = "right",
			my_anchor = "right",
			height = 48,
			width = 90,
		},
		to_anchor = "bottomleft",
		block_layout_editor = false,
		y = -266,
		x = 238,
		name = "PlayerHP",
		interactive_type = "player",
		height = 116,
		my_anchor = "bottomleft",
		tint = 
		{
			alter_r = "no",
			r = 44.828838348389,
			alter_b = "no",
			allow_overrides = true,
			b = 58.307929992676,
			g = 42.582324981689,
			alter_g = "no",
		},
		scale = 0.54800027608871,
		border = 
		{
			follow_bg_alpha = true,
			alpha = 1,
			padding = { top = 6, left = 3, right = 3, bottom = 6}
		},
		slow_changing_value = false,
		watching_states = 
		{
		},

		hide_if_zero = false,
		show_with_target = false,
		alpha = 
		{
			clamp = 0.20000000298023,
			alter = "no",
			in_combat = 1,
			out_of_combat = 1,
		},
		width = 684,
		show = true,
		interactive = true,
		state = "PlayerHP",
		relwin = "Root",
		percent_label = 
		{
			align = "right",
			follow = "no",
			width = 0,
			show = true,
			font = 
			{
				b = 190.85235595703,
				g = 188.60585021973,
				name = "font_heading_medium_noshadow",
				r = 188.60585021973,
			},
			my_anchor = "right",
			to_anchor = "right",
			height = 48,
			always_show = true,
		},
		pos_at_world_object = false,
		bg = 
		{
			show = true,
			tint = 
			{
				alter_r = "no",
				r = 0,
				alter_b = "no",
				b = 0,
				g = 0,
				alter_g = "no",
			},
			alpha = 
			{
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				y = 0,
				slice = "none",
				name = "tint_square",
				scale = 1,
				height = 0,
				x = 0,
				width = 0,
			},
		},
	}
	]]--

