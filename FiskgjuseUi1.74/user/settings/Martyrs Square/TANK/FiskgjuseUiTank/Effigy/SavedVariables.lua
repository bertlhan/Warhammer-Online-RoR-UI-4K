Effigy.WindowSettings = 
{
	SC = 
	{
		disabled = false,
		showgroup = true,
	},
	WB = 
	{
		disabled = false,
		showgroup = true,
	},
}



Effigy.ProfileSettings = 
{
	CastbarShowGCD = false,
	CastbarHookRespawn = false,
}



Effigy.SavedVarsVersion = 2.66

Effigy.Bars = 
{
	FiskgjuseUiFOHP = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Top = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.7,
				width = 130,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 0,
					},
				},
				height = 2,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						r = "inv",
						g = "no",
						b = "no",
					},
					color = 
					{
						r = 255,
						g = 100,
						b = 0,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			Background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.8,
				width = 230,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 14,
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
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "xHUD_VerticalFuzzyBarBG",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.5,
				width = 2,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 8,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						b = "no",
						g = "no",
						r = "inv",
					},
					color = 
					{
						b = 0,
						g = 100,
						r = 255,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = 0,
						point = "bottomright",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "tint_square",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		scale = 1,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		pos_at_world_object = true,
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 124,
					g = 224,
					r = 81,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 0,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "none",
			},
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "left",
					x = -12,
					point = "center",
					parent = "Bar",
					y = 0,
				},
			},
		},
		slow_changing_value = true,
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
					b = 0,
					g = 0,
					r = 0,
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
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiFOHPInvisi",
				y = -50,
			},
		},
		no_tooltip = true,
		state = "FTHP",
		hide_if_zero = false,
		show_with_target_ht = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		layer = "overlay",
		name = "FiskgjuseUiFOHP",
		width = 130,
		show = true,
		visibility_group = "HideIfSelf",
		invValue = false,
		interactive_type = "none",
		height = 8,
		block_layout_editor = true,
		show_with_target = false,
		labels = 
		{
			Name = 
			{
				alpha_group = "none",
				formattemplate = "$title",
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				parent = "Bar",
				follow = "no",
				alpha = 1,
				width = 0,
				clip_after = 14,
				visibility_group = "none",
				scale = 0.9,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 2,
					},
				},
				height = 19,
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
					allow_overrides = false,
					color_group = "archetype-colors",
				},
				show = true,
				layer = "overlay",
			},
			Percent = 
			{
				follow = "no",
				formattemplate = "$per",
				clip_after = 14,
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				scale = 1,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 4,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 16,
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
					color_group = "FiskgjuseUi50Percent",
				},
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
			},
			Lvl = 
			{
				alpha_group = "none",
				formattemplate = "$lvl",
				visibility_group = "none",
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 0,
				clip_after = 12,
				font = 
				{
					align = "right",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 0.65,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = -4,
					},
				},
				height = 19,
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
					allow_overrides = false,
					color_group = "none",
				},
				show = true,
				follow = "no",
			},
		},
	},
	FiskgjuseUiGI2 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 28.5,
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
						b = 124,
						g = 224,
						r = 81,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 43,
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
						g = 187,
						r = 255,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
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
				color_group = "none",
				allow_overrides = false,
			},
			follow_bg_alpha = false,
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "tint_square",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 1,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "tint_square",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					r = 30,
					g = 30,
					b = 30,
				},
				allow_overrides = false,
				color_group = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "tint_square",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		no_tooltip = false,
		width = 0,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI2Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		state = "grp2hp",
		block_layout_editor = true,
		show = true,
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI2",
		interactive_type = "none",
		height = 0,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		pos_at_world_object = true,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				visibility_group = "none",
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				clip_after = 14,
				follow = "no",
				height = 24,
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
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				scale = 1,
			},
			Level = 
			{
				clip_after = 14,
				formattemplate = "$lvl",
				visibility_group = "none",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				layer = "secondary",
				scale = 1,
			},
			Name = 
			{
				clip_after = 14,
				formattemplate = "$title",
				visibility_group = "none",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				layer = "secondary",
				scale = 1,
			},
		},
	},
	FiskgjuseUiFT = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			top = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.7,
				width = 50,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 2,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						b = "no",
						g = "no",
						r = "inv",
					},
					color = 
					{
						b = 0,
						g = 100,
						r = 255,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 2,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.5,
				width = 2,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 16,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						b = "no",
						g = "no",
						r = "inv",
					},
					color = 
					{
						b = 0,
						g = 100,
						r = 255,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = 0,
						point = "bottomleft",
						parent = "Bar",
						y = -2,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientV",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.8,
				width = 150,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 22,
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
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "xHUD_VerticalFuzzyBarFG",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = false,
			padding = 
			{
				top = 2,
				right = 0,
				left = 0,
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
				color_group = "none",
				allow_overrides = false,
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
				name = "tint_square",
				y = 0,
				x = 0,
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
					r = 81,
					g = 224,
					b = 124,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 1,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				slice = "none",
				style = "cut",
				height = 0,
				name = "FiskgjuseGradientV",
				y = 0,
				x = 0,
			},
		},
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
				scale = 1,
				width = 0,
				texture_group = "none",
				slice = "none",
				style = "cut",
				height = 0,
				name = "tint_square",
				y = 0,
				x = 0,
			},
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "left",
					x = -12,
					point = "center",
					parent = "Bar",
					y = 0,
				},
			},
		},
		no_tooltip = false,
		block_layout_editor = false,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "left",
				x = 50,
				point = "left",
				parent = "Root",
				y = 100,
			},
		},
		show_with_target = false,
		show = true,
		width = 50,
		state = "FTHP",
		visibility_group = "none",
		name = "FiskgjuseUiFT",
		interactive_type = "friendly",
		height = 20,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		scale = 1,
		labels = 
		{
			Level = 
			{
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = -10,
					},
				},
				parent = "Bar",
				formattemplate = "$lvl",
				font = 
				{
					align = "right",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				layer = "overlay",
				height = 19,
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
				clip_after = 14,
				scale = 0.65,
			},
			Name = 
			{
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 40,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				parent = "Bar",
				formattemplate = "$title",
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
				always_show = false,
				alpha = 1,
				width = 250,
				show = true,
				visibility_group = "none",
				follow = "no",
				layer = "overlay",
				height = 19,
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
					color_group = "archetype-colors",
				},
				clip_after = 30,
				scale = 0.9,
			},
			Percent = 
			{
				follow = "no",
				formattemplate = "$per",
				clip_after = 14,
				alpha_group = "none",
				layer = "overlay",
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				scale = 1,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 4,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 16,
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
					color_group = "FiskgjuseUi50Percent",
				},
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				parent = "Bar",
			},
		},
	},
	FiskgjuseUiHOHP = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Top = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.7,
				width = 130,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 0,
					},
				},
				height = 2,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						r = "no",
						g = "inv",
						b = "no",
					},
					color = 
					{
						r = 180,
						g = 200,
						b = 10,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			Background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.8,
				width = 230,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 14,
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
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "xHUD_VerticalFuzzyBarBG",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.5,
				width = 2,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 8,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						b = "no",
						g = "inv",
						r = "no",
					},
					color = 
					{
						b = 10,
						g = 200,
						r = 180,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = 0,
						point = "bottomleft",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "tint_square",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		pos_at_world_object = true,
		border = 
		{
			follow_bg_alpha = false,
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
					b = 0,
					g = 0,
					r = 0,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
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
		scale = 1,
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 66,
					g = 81,
					r = 246,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
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
				name = "none",
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
				slice = "none",
				style = "cut",
				height = 0,
				x = 0,
				y = 0,
				name = "tint_square",
			},
		},
		slow_changing_value = true,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "left",
					x = -12,
					point = "center",
					parent = "Bar",
					y = 0,
				},
			},
		},
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		no_tooltip = true,
		state = "HTHP",
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiHOHPInvisi",
				y = -50,
			},
		},
		show_with_target = false,
		name = "FiskgjuseUiHOHP",
		block_layout_editor = true,
		show = true,
		visibility_group = "HideIfSelf",
		invValue = false,
		interactive_type = "none",
		height = 8,
		width = 130,
		layer = "overlay",
		labels = 
		{
			Percent = 
			{
				layer = "overlay",
				formattemplate = "$per",
				clip_after = 14,
				alpha_group = "none",
				follow = "no",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 1,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 4,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 16,
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
					color_group = "FiskgjuseUi50Percent",
				},
				visibility_group = "none",
				parent = "Bar",
			},
			Name = 
			{
				alpha_group = "none",
				formattemplate = "$title",
				visibility_group = "none",
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 0.9,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 2,
					},
				},
				height = 19,
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
					allow_overrides = false,
					color_group = "archetype-colors",
				},
				clip_after = 14,
				follow = "no",
			},
			Lvl = 
			{
				alpha_group = "none",
				formattemplate = "$lvl",
				font = 
				{
					align = "right",
					name = "font_clear_small_bold",
					case = "none",
				},
				parent = "Bar",
				follow = "no",
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				scale = 0.65,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = -4,
					},
				},
				height = 19,
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
					allow_overrides = false,
					color_group = "none",
				},
				clip_after = 12,
				layer = "overlay",
			},
		},
	},
	FiskgjuseUiXP = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
		},
		scale = 0.89999997615814,
		border = 
		{
			padding = 
			{
				top = 2,
				right = 2,
				left = 2,
				bottom = 2,
			},
			follow_bg_alpha = false,
			colorsettings = 
			{
				color = 
				{
					b = 0,
					g = 0,
					r = 0,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					g = 131,
					r = 239,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "SharedMediaSteel",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "bottomleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = false,
		hide_if_zero = true,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "bottomleft",
				x = 0,
				point = "bottomleft",
				parent = "Root",
				y = -12,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		block_layout_editor = false,
		show = true,
		visibility_group = "none",
		name = "FiskgjuseUiXP",
		interactive_type = "none",
		height = 12,
		state = "Exp",
		width = 504,
		labels = 
		{
			Value = 
			{
				layer = "overlay",
				formattemplate = "$value/$max",
				show = true,
				alpha_group = "none",
				follow = "no",
				alpha = 1,
				width = 400,
				clip_after = 70,
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 19,
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
				visibility_group = "none",
				parent = "Bar",
			},
			Name = 
			{
				alpha_group = "none",
				always_show = false,
				formattemplate = "C$title",
				show = true,
				scale = 0.7,
				layer = "secondary",
				alpha = 1,
				width = 0,
				clip_after = 14,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				visibility_group = "none",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
					allow_overrides = false,
					color_group = "none",
				},
				follow = "no",
				parent = "Bar",
			},
			Percent = 
			{
				follow = "no",
				formattemplate = "$per%",
				clip_after = 14,
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 100,
				show = true,
				visibility_group = "none",
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = -120,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
			},
			Missing = 
			{
				follow = "no",
				formattemplate = "$missing<icon 41>",
				clip_after = 40,
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 100,
				show = true,
				visibility_group = "none",
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 120,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
			},
		},
	},
	FiskgjuseUiHP = 
	{
		grow = "up",
		hide_if_target = false,
		images = 
		{
			top = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 15,
				show = true,
				visibility_group = "CombatOrNotFull",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 0,
					},
				},
				height = 2,
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
						r = 50,
						g = 50,
						b = 50,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 2,
				show = true,
				visibility_group = "CombatOrNotFull",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 0,
					},
				},
				height = 160,
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
						r = 50,
						g = 50,
						b = 50,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientV",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		pos_at_world_object = false,
		border = 
		{
			follow_bg_alpha = false,
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
				name = "tint_square",
				y = 0,
				x = 0,
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
					r = 201,
					g = 201,
					b = 201,
				},
				color_group = "FiskgjuseUiHp",
				allow_overrides = false,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 0,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				slice = "none",
				style = "cut",
				height = 0,
				name = "none",
				y = 0,
				x = 0,
			},
		},
		icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "bottomleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
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
					r = 30,
					g = 30,
					b = 30,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				in_combat = 0.3,
				out_of_combat = 0,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				slice = "none",
				style = "cut",
				height = 0,
				name = "FiskgjuseGradientV",
				y = 0,
				x = 0,
			},
		},
		width = 16,
		no_tooltip = false,
		state = "PlayerHP",
		hide_if_zero = false,
		show_with_target_ht = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		show_with_target = false,
		name = "FiskgjuseUiHP",
		block_layout_editor = false,
		show = true,
		visibility_group = "none",
		invValue = false,
		interactive_type = "none",
		height = 160,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "center",
				x = -81,
				point = "center",
				parent = "Root",
				y = 80,
			},
		},
		scale = 1,
		labels = 
		{
			value = 
			{
				follow = "no",
				formattemplate = "$per",
				clip_after = 14,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 50,
				show = true,
				visibility_group = "CombatOrNotFull",
				scale = 1.3,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				height = 24,
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
					color_group = "FiskgjuseUiHp",
				},
				font = 
				{
					align = "right",
					name = "font_clear_large_bold",
					case = "none",
				},
				alpha_group = "none",
			},
		},
	},
	FiskgjuseUiRP = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
		},
		scale = 0.89999997615814,
		border = 
		{
			follow_bg_alpha = false,
			colorsettings = 
			{
				color = 
				{
					r = 0,
					g = 0,
					b = 0,
				},
				allow_overrides = false,
				color_group = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
			},
			padding = 
			{
				top = 2,
				right = 2,
				left = 2,
				bottom = 2,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				name = "tint_square",
				texture_group = "none",
				slice = "none",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
					r = 88,
					g = 45,
					b = 252,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 1,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				name = "SharedMediaSteel",
				texture_group = "none",
				slice = "none",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "bottomleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					r = 30,
					g = 30,
					b = 30,
				},
				allow_overrides = false,
				color_group = "none",
				alter = 
				{
					r = "no",
					g = "no",
					b = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				name = "tint_square",
				texture_group = "none",
				slice = "none",
			},
		},
		no_tooltip = false,
		block_layout_editor = false,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "bottomleft",
				x = 0,
				point = "bottomleft",
				parent = "Root",
				y = 0,
			},
		},
		show_with_target = false,
		show = true,
		width = 504,
		state = "PlayerRenown",
		visibility_group = "none",
		name = "FiskgjuseUiRP",
		interactive_type = "none",
		height = 12,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		pos_at_world_object = false,
		labels = 
		{
			Value = 
			{
				layer = "overlay",
				formattemplate = "$value/$max",
				show = true,
				alpha_group = "none",
				follow = "no",
				alpha = 1,
				width = 400,
				clip_after = 70,
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 19,
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
				visibility_group = "none",
				parent = "Bar",
			},
			Name = 
			{
				parent = "Bar",
				always_show = false,
				formattemplate = "$title",
				clip_after = 14,
				alpha_group = "none",
				follow = "no",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				visibility_group = "none",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
				layer = "secondary",
				scale = 0.7,
			},
			Percent = 
			{
				follow = "no",
				formattemplate = "$per%",
				clip_after = 14,
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 100,
				show = true,
				visibility_group = "none",
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = -120,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
			},
			Missing = 
			{
				follow = "no",
				formattemplate = "$missing<icon 45> ",
				clip_after = 40,
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 100,
				show = true,
				visibility_group = "none",
				scale = 0.7,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 120,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 17,
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
				font = 
				{
					align = "center",
					name = "font_clear_small_bold",
					case = "none",
				},
				alpha_group = "none",
			},
		},
	},
	FiskgjuseUiGI6 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 28.5,
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
						r = 81,
						g = 224,
						b = 124,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 43,
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
						g = 187,
						b = 0,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 255,
					g = 255,
					r = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI6Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 0,
		state = "grp6hp",
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI6",
		interactive_type = "none",
		height = 0,
		show = true,
		block_layout_editor = false,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				scale = 1,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				follow = "no",
				height = 24,
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
				clip_after = 14,
				visibility_group = "none",
			},
			Level = 
			{
				scale = 1,
				formattemplate = "$lvl",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				clip_after = 14,
			},
			Name = 
			{
				scale = 1,
				formattemplate = "$title",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				clip_after = 14,
			},
		},
	},
	FiskgjuseUiHT = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			top = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.7,
				width = 50,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 2,
					},
				},
				height = 2,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						r = "no",
						g = "inv",
						b = "no",
					},
					color = 
					{
						r = 180,
						g = 200,
						b = 10,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.5,
				width = 2,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = 0,
						point = "bottomleft",
						parent = "Bar",
						y = -2,
					},
				},
				height = 16,
				colorsettings = 
				{
					ColorPreset = "none",
					alter = 
					{
						r = "no",
						g = "inv",
						b = "no",
					},
					color = 
					{
						r = 180,
						g = 200,
						b = 10,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientV",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.8,
				width = 150,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 22,
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
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "xHUD_VerticalFuzzyBarFG",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		pos_at_world_object = false,
		border = 
		{
			padding = 
			{
				top = 2,
				right = 0,
				left = 0,
				bottom = 2,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
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
				x = 0,
				texture_group = "none",
				style = "cut",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 66,
					g = 81,
					r = 246,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				slice = "none",
				name = "FiskgjuseGradientV",
				height = 0,
				x = 0,
				texture_group = "none",
				style = "cut",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "left",
					x = -12,
					point = "center",
					parent = "Bar",
					y = 0,
				},
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
				scale = 1,
				width = 0,
				y = 0,
				slice = "none",
				name = "tint_square",
				height = 0,
				x = 0,
				texture_group = "none",
				style = "cut",
			},
		},
		no_tooltip = false,
		scale = 1,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "bottom",
				x = 0,
				point = "bottom",
				parent = "Root",
				y = -230,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 50,
		state = "HTHP",
		visibility_group = "none",
		name = "FiskgjuseUiHT",
		interactive_type = "none",
		height = 20,
		show = true,
		block_layout_editor = false,
		labels = 
		{
			Level = 
			{
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomleft",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = -10,
					},
				},
				show = true,
				formattemplate = "$lvl",
				visibility_group = "none",
				alpha_group = "none",
				always_show = false,
				alpha = 1,
				width = 0,
				clip_after = 14,
				font = 
				{
					align = "right",
					name = "font_clear_small_bold",
					case = "none",
				},
				follow = "no",
				layer = "overlay",
				height = 19,
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
				scale = 0.65,
				parent = "Bar",
			},
			Name = 
			{
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 40,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				show = true,
				formattemplate = "$title",
				visibility_group = "none",
				alpha_group = "none",
				always_show = false,
				alpha = 1,
				width = 250,
				clip_after = 30,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				follow = "no",
				layer = "overlay",
				height = 19,
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
					color_group = "archetype-colors",
				},
				scale = 0.9,
				parent = "Bar",
			},
			Percent = 
			{
				alpha_group = "none",
				formattemplate = "$per",
				visibility_group = "none",
				parent = "Bar",
				layer = "overlay",
				alpha = 1,
				width = 0,
				clip_after = 14,
				font = 
				{
					align = "left",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 1,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "right",
						x = 4,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 16,
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
					color_group = "FiskgjuseUi50Percent",
				},
				show = true,
				follow = "no",
			},
		},
	},
	FiskgjuseUiGI3 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 28.5,
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
						r = 81,
						g = 224,
						b = 124,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 43,
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
						g = 187,
						b = 0,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 255,
					g = 255,
					r = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI3Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 0,
		state = "grp3hp",
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI3",
		interactive_type = "none",
		height = 0,
		show = true,
		block_layout_editor = true,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				scale = 1,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				follow = "no",
				height = 24,
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
				clip_after = 14,
				visibility_group = "none",
			},
			Level = 
			{
				scale = 1,
				formattemplate = "$lvl",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				clip_after = 14,
			},
			Name = 
			{
				scale = 1,
				formattemplate = "$title",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				clip_after = 14,
			},
		},
	},
	FiskgjuseUiGI4 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 28.5,
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
						r = 81,
						g = 224,
						b = 124,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 43,
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
						g = 187,
						b = 0,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 255,
					g = 255,
					r = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI4Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 0,
		state = "grp4hp",
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI4",
		interactive_type = "none",
		height = 0,
		show = true,
		block_layout_editor = true,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				scale = 1,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				follow = "no",
				height = 24,
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
				clip_after = 14,
				visibility_group = "none",
			},
			Level = 
			{
				scale = 1,
				formattemplate = "$lvl",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				clip_after = 14,
			},
			Name = 
			{
				scale = 1,
				formattemplate = "$title",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				clip_after = 14,
			},
		},
	},
	FiskgjuseUiAP = 
	{
		grow = "up",
		hide_if_target = false,
		images = 
		{
			top = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 7,
				show = true,
				visibility_group = "curr-hideWhenZeroMax",
				parent = "Bar",
				scale = 1,
				height = 2,
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
						b = 70,
						g = 70,
						r = 70,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 2,
				show = true,
				visibility_group = "curr-hideWhenZeroMax",
				parent = "Bar",
				scale = 1,
				height = 160,
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
						b = 70,
						g = 70,
						r = 70,
					},
					allow_overrides = false,
					color_group = "none",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 0,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientV",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		scale = 1,
		border = 
		{
			follow_bg_alpha = false,
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
				x = 0,
				name = "tint_square",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
					b = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 0,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "none",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
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
					r = 30,
					g = 30,
					b = 30,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				in_combat = 0.3,
				out_of_combat = 0,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "FiskgjuseGradientV",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "bottomleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		no_tooltip = false,
		block_layout_editor = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "right",
				x = 2,
				point = "left",
				parent = "FiskgjuseUiHP",
				y = 0,
			},
		},
		show_with_target = false,
		show = true,
		width = 8,
		state = "PlayerAP",
		visibility_group = "none",
		name = "FiskgjuseUiAP",
		interactive_type = "none",
		height = 160,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		pos_at_world_object = false,
		labels = 
		{
			Value = 
			{
				parent = "Bar",
				formattemplate = "$value",
				visibility_group = "CombatOrNotFull",
				alpha_group = "none",
				layer = "overlay",
				alpha = 1,
				width = 50,
				show = true,
				font = 
				{
					align = "right",
					name = "font_clear_small_bold",
					case = "none",
				},
				scale = 1.2,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = -10,
						point = "bottomright",
						parent = "Bar",
						y = 0,
					},
				},
				height = 16,
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
						g = 99,
						r = 99,
					},
					allow_overrides = false,
					color_group = "none",
				},
				clip_after = 14,
				follow = "no",
			},
		},
	},
	FiskgjuseUiGI5 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 28.5,
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
						r = 81,
						g = 224,
						b = 124,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 43,
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
						g = 187,
						b = 0,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 255,
					g = 255,
					r = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI5Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 0,
		state = "grp5hp",
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI5",
		interactive_type = "none",
		height = 0,
		show = true,
		block_layout_editor = true,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				scale = 1,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				follow = "no",
				height = 24,
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
				clip_after = 14,
				visibility_group = "none",
			},
			Level = 
			{
				scale = 1,
				formattemplate = "$lvl",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				clip_after = 14,
			},
			Name = 
			{
				scale = 1,
				formattemplate = "$title",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				clip_after = 14,
			},
		},
	},
	FiskgjuseUiCareer = 
	{
		grow = "up",
		hide_if_target = false,
		images = 
		{
			top = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 7,
				show = true,
				visibility_group = "CombatOrNotFull",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topleft",
						x = 0,
						point = "topleft",
						parent = "Bar",
						y = 0,
					},
				},
				height = 2,
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
						r = 70,
						g = 70,
						b = 70,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientH",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			right = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 2,
				show = true,
				visibility_group = "CombatOrNotFull",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "topright",
						x = 0,
						point = "topright",
						parent = "Bar",
						y = 0,
					},
				},
				height = 160,
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
						r = 70,
						g = 70,
						b = 70,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseGradientV",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			valuebackground = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 55,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				scale = 1,
				height = 26,
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
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "LabelValue",
						y = -1,
					},
				},
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "xHUD_VerticalFuzzyBarBG",
					height = 0,
					scale = 1,
					x = 0,
					y = 0,
					width = 0,
				},
			},
		},
		scale = 1,
		border = 
		{
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 0,
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "tint_square",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
		{
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
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				out_of_combat = 0,
				in_combat = 1,
				alter = "no",
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "none",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
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
					r = 30,
					g = 30,
					b = 30,
				},
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 
			{
				in_combat = 0.3,
				out_of_combat = 0,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				texture_group = "none",
				x = 0,
				name = "FiskgjuseGradientV",
				height = 0,
				style = "cut",
				y = 0,
				slice = "none",
			},
		},
		icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "bottomleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		no_tooltip = false,
		block_layout_editor = true,
		hide_if_zero = true,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "right",
				x = 2,
				point = "left",
				parent = "FiskgjuseUiAP",
				y = 0,
			},
		},
		show_with_target = false,
		show = true,
		width = 8,
		state = "PlayerCareer",
		visibility_group = "none",
		name = "FiskgjuseUiCareer",
		interactive_type = "none",
		height = 160,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		pos_at_world_object = false,
		labels = 
		{
			Value = 
			{
				parent = "Bar",
				formattemplate = "$value",
				font = 
				{
					align = "center",
					name = "font_clear_large_bold",
					case = "none",
				},
				alpha_group = "none",
				follow = "no",
				alpha = 1,
				width = 45,
				show = true,
				visibility_group = "none",
				scale = 1.3,
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Root",
						y = 142,
					},
				},
				height = 25,
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
				clip_after = 14,
				layer = "overlay",
			},
		},
	},
	FiskgjuseUiGI1 = 
	{
		grow = "right",
		hide_if_target = false,
		images = 
		{
			Circle = 
			{
				alpha_group = "none",
				layer = "default",
				alpha = 0.4,
				width = 28.5,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 28.5,
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
						r = 81,
						g = 224,
						b = 124,
					},
					allow_overrides = false,
					color_group = "none",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "SharedMediaOrbFill2",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
			background = 
			{
				alpha_group = "none",
				layer = "background",
				alpha = 0.7,
				width = 43,
				show = true,
				visibility_group = "none",
				parent = "Bar",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = -180,
					},
				},
				height = 43,
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
						g = 187,
						b = 0,
					},
					allow_overrides = false,
					color_group = "FiskgjuseUiHp",
				},
				scale = 1,
				texture = 
				{
					texture_group = "none",
					slice = "none",
					name = "FiskgjuseUiCross",
					scale = 1,
					height = 0,
					y = 0,
					x = 0,
					width = 0,
				},
			},
		},
		scale = 0.8,
		border = 
		{
			padding = 
			{
				top = 0,
				right = 0,
				left = 0,
				bottom = 0,
			},
			follow_bg_alpha = false,
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
				color_group = "none",
				allow_overrides = false,
			},
			alpha = 1,
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		rvr_icon = 
		{
			show = false,
			scale = 0.55,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "topleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		status_icon = 
		{
			show = false,
			scale = 1,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "topleft",
					x = 0,
					point = "bottomleft",
					parent = "Bar",
					y = 0,
				},
			},
		},
		fg = 
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
					b = 255,
					g = 255,
					r = 255,
				},
				color_group = "none",
				allow_overrides = true,
			},
			alpha = 
			{
				clamp = 0.2,
				alter = "no",
				in_combat = 1,
				out_of_combat = 1,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		slow_changing_value = false,
		watching_states = 
		{
		},
		icon = 
		{
			show = true,
			scale = 0.6,
			follow_bg_alpha = false,
			alpha = 1,
			anchors = 
			{
				[1] = 
				{
					parentpoint = "center",
					x = 0,
					point = "center",
					parent = "Bar",
					y = -180,
				},
			},
		},
		bg = 
		{
			show = true,
			colorsettings = 
			{
				color = 
				{
					b = 30,
					g = 30,
					r = 30,
				},
				color_group = "none",
				allow_overrides = false,
				alter = 
				{
					b = "no",
					g = "no",
					r = "no",
				},
			},
			alpha = 
			{
				in_combat = 0.7,
				out_of_combat = 0.7,
			},
			texture = 
			{
				scale = 1,
				width = 0,
				y = 0,
				x = 0,
				style = "cut",
				height = 0,
				slice = "none",
				texture_group = "none",
				name = "tint_square",
			},
		},
		no_tooltip = false,
		pos_at_world_object = true,
		hide_if_zero = false,
		show_with_target_ht = false,
		anchors = 
		{
			[1] = 
			{
				parentpoint = "top",
				x = 0,
				point = "center",
				parent = "FiskgjuseUiGI1Invisi",
				y = 0,
			},
		},
		show_with_target = false,
		alphasettings = 
		{
			alpha = 1,
			alpha_group = "none",
		},
		width = 0,
		state = "grp1hp",
		visibility_group = "HideIfSelf",
		name = "FiskgjuseUiGI1",
		interactive_type = "none",
		height = 0,
		show = true,
		block_layout_editor = true,
		labels = 
		{
			Value = 
			{
				formattemplate = "$value",
				scale = 1,
				parent = "Bar",
				layer = "secondary",
				alpha = 1,
				width = 0,
				show = true,
				font = 
				{
					name = "font_clear_medium",
					align = "right",
				},
				anchors = 
				{
					[1] = 
					{
						parentpoint = "bottomright",
						x = -15,
						point = "bottomright",
						parent = "Bar",
						y = -15,
					},
				},
				follow = "no",
				height = 24,
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
				clip_after = 14,
				visibility_group = "none",
			},
			Level = 
			{
				scale = 1,
				formattemplate = "$lvl",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "left",
						x = 0,
						point = "left",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "left",
				},
				clip_after = 14,
			},
			Name = 
			{
				scale = 1,
				formattemplate = "$title",
				layer = "secondary",
				parent = "Bar",
				always_show = false,
				alpha = 1,
				width = 0,
				show = true,
				visibility_group = "none",
				follow = "no",
				anchors = 
				{
					[1] = 
					{
						parentpoint = "center",
						x = 0,
						point = "center",
						parent = "Bar",
						y = 0,
					},
				},
				height = 24,
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
				font = 
				{
					name = "font_clear_medium",
					align = "center",
				},
				clip_after = 14,
			},
		},
	},
}



