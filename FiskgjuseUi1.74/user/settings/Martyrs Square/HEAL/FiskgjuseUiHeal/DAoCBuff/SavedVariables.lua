DAoCBuffVar = 
{
	killbuffs = true,
	Frames = 
	{
		
		{
			glass = false,
			active = true,
			maxBuffCount = 60,
			FA = true,
			update = 0.5,
			rowcount = 4,
			ismine = 0,
			buffTargetType = 6,
			anchor = 
			{
				scale = 0.71776050329208,
				x = 0,
				y = 103.99998298858,
			},
			filters = 
			{
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					icon = "Yakar_dot",
					name = L"Dots",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							1,
							"isDamaging",
							true,
						},
					},
					borderC = 
					{
						101,
						0,
						0,
					},
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					borderC = 
					{
						255,
						255,
						0,
					},
					name = L"HealDebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Healdebuff",
						},
					},
					icon = "Yakar_healdebuff50",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					borderC = 
					{
						128,
						64,
						255,
					},
					name = L"HealOutDebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"HealOutDebuff",
						},
					},
					icon = "Yakar_healoutdebuff",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			divide = 2,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			longtoperma = false,
			font = 4,
			name = L"Self_Debuffs",
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 11,
			growleft = 1,
		},
		
		{
			glass = false,
			active = false,
			maxBuffCount = 32,
			FA = true,
			update = 0.25,
			rowcount = 4,
			ismine = 0,
			buffTargetType = 7,
			anchor = 
			{
				scale = 0.52416306734085,
				x = 1149.0000238135,
				y = 847.0001112329,
			},
			filters = 
			{
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					name = L"A_Battlemaster",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"BattleMaster",
						},
					},
					icon = "Yakar_battlemaster",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					borderC = 
					{
						255,
						255,
						0,
					},
					name = L"B_Healdebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Healdebuff",
						},
					},
					icon = "Yakar_healdebuff50",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					borderC = 
					{
						128,
						64,
						255,
					},
					name = L"C_HealOutDebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"HealOutDebuff",
						},
					},
					icon = "Yakar_healoutdebuff",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isDamaging = true,
					},
					useand = true,
					name = L"D_Dots",
					delete = false,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isDebuff",
							true,
						},
						
						{
							1,
							"isDamaging",
							true,
						},
					},
					icon = "Yakar_dot",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = false,
					name = L"E_Hots",
					useand = true,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isHealing",
							true,
						},
						
						{
							5,
							"duration",
							300,
							false,
						},
						
						{
							1,
							"isBuff",
							true,
						},
					},
					icon = "Yakar_hot",
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"delete selfdebuffs",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							1,
							"castByPlayer",
							true,
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"delete addinfo stuff",
					useand = false,
					condense = false,
					conditions = 
					{
						
						{
							2,
							"abilityId",
							"all the morales",
						},
						
						{
							2,
							"abilityId",
							"Odjira",
						},
						
						{
							2,
							"abilityId",
							"Guard",
						},
						
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Delete Squap filter",
					useand = false,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Resistbuff",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			divide = 0,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			longtoperma = false,
			font = 3,
			name = L"Hostile_All",
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 4,
			growleft = 1,
		},
		
		{
			divide = 1,
			active = false,
			maxBuffCount = 14,
			FA = true,
			update = 0.25,
			rowcount = 2,
			ismine = 1,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.5996955037117,
				x = 1497.9664560744,
				y = 1080.0202216339,
			},
			filters = 
			{
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					icon = "Yakar_battlemaster",
					name = L"BattleMaster",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"BattleMaster",
						},
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					icon = "Yakar_lock_gifts",
					name = L"LockBuffs",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"LockBuffs",
						},
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			glass = true,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			name = L"Friendly_Self_Buff",
			font = 3,
			longtoperma = false,
			showborder = true,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 3,
			growleft = 1,
		},
		
		{
			divide = 2,
			active = false,
			maxBuffCount = 14,
			FA = false,
			update = 0.25,
			rowcount = 2,
			ismine = 1,
			buffTargetType = 7,
			anchor = 
			{
				scale = 0.5974822640419,
				x = 1497.9665138481,
				y = 840.16794198503,
			},
			filters = 
			{
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			growleft = 1,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			font = 3,
			longtoperma = false,
			staticcondense = false,
			name = L"Hostile_Self_Debuff",
			showborder = true,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 3,
			glass = true,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 10,
			FA = true,
			update = 1,
			rowcount = 2,
			ismine = 0,
			buffTargetType = 100,
			anchor = 
			{
				
				{
					scale = 0.60333633422852,
					x = 6.4087038518523,
					y = 34.777574343963,
				},
				
				{
					scale = 0.59437388181686,
					x = 6.4087037101082,
					y = 185.37509064727,
				},
				
				{
					scale = 0.5913337469101,
					x = 6.4087034486397,
					y = 335.57777082569,
				},
				
				{
					scale = 0.59800070524216,
					x = 6.4087037961978,
					y = 481.79996558231,
				},
				
				{
					scale = 0.59567582607269,
					x = 6.4087037272458,
					y = 631.95494647264,
				},
			},
			filters = 
			{
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					name = L"A_Battlemaster",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"BattleMaster",
						},
					},
					icon = "Yakar_battlemaster",
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					icon = "Yakar_hot",
					name = L"C_Hots",
					useand = true,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isHealing",
							true,
						},
						
						{
							5,
							"duration",
							300,
							false,
						},
					},
					borderC = 
					{
						0,
						192,
						0,
					},
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isDamaging = true,
					},
					icon = "Yakar_dot",
					name = L"C_Dots",
					useand = true,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isDamaging",
							true,
						},
						
						{
							1,
							"isDebuff",
							true,
						},
					},
					borderC = 
					{
						149,
						0,
						0,
					},
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					icon = "Yakar_healdebuff50",
					name = L"D_Healdebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Healdebuff",
						},
					},
					borderC = 
					{
						255,
						255,
						0,
					},
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					delete = true,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					icon = "Yakar_healoutdebuff",
					name = L"E_HealOutDebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"HealOutDebuff",
						},
					},
					borderC = 
					{
						128,
						64,
						255,
					},
					notresult = false,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"delete shorttime",
					useand = false,
					condense = false,
					conditions = 
					{
						
						{
							5,
							"duration",
							1800,
							false,
						},
						
						{
							1,
							"isBolster",
							true,
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			growleft = 1,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			font = 3,
			longtimehide = false,
			staticcondense = false,
			name = L"GroupBuffs",
			showborder = true,
			longtoperma = false,
			horizontal = 2,
			buffRowStride = 1,
			glass = true,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 5,
			FA = true,
			update = 0.5,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 6,
			anchor = 
			{
				scale = 0.62745296955109,
				x = 1070.0000730911,
				y = 892.54904076248,
			},
			filters = 
			{
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Staggers",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_stun1",
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"Guard",
					enda = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Guard",
						},
					},
					icon = "Yakar_detaunt",
					notresult = false,
				},
				
				{
					delete = true,
					useand = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"delete_all",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							1,
							"trackerPriority",
							100,
						},
						
						{
							2,
							"abilityId",
							"Odjira",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
			},
			hpte = false,
			type = 1,
			growleft = 1,
			glass = true,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			font = 4,
			staticcondense = false,
			name = L"Self_AddInfo",
			showborder = false,
			longtoperma = false,
			horizontal = 2,
			buffRowStride = 1,
			permabuffs = 1,
		},
		
		{
			divide = 0,
			active = true,
			maxBuffCount = 5,
			FA = true,
			update = 0.25,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 7,
			anchor = 
			{
				scale = 0.62745296955109,
			},
			filters = 
			{
				
				{
					delete = true,
					useand = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"delete",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							2,
							"abilityId",
							"Guard",
						},
						
						{
							1,
							"trackerPriority",
							100,
						},
						
						{
							2,
							"abilityId",
							"AddImmunities",
						},
						
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Staggers",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_stun1",
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"Guard",
					enda = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Guard",
						},
					},
					icon = "Yakar_detaunt",
					notresult = false,
				},
			},
			hpte = false,
			type = 2,
			growleft = 2,
			permabuffs = 1,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			staticcondense = false,
			font = 4,
			longtoperma = false,
			showborder = false,
			name = L"Hostile_AddInfo",
			horizontal = 2,
			buffRowStride = 1,
			glass = false,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 5,
			FA = true,
			update = 0.5,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.63281625509262,
				x = 1279.0611444048,
				y = 1132.5490063951,
			},
			filters = 
			{
				
				{
					delete = true,
					useand = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"delete",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							2,
							"abilityId",
							"Guard",
						},
						
						{
							2,
							"abilityId",
							"Bless",
						},
						
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
				
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Staggers",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_stun1",
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"Guard",
					enda = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Guard",
						},
					},
					icon = "Yakar_detaunt",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			growleft = 2,
			glass = true,
			growup = 1,
			buffsbelow = 2,
			bufforder = 1,
			longtimehide = false,
			font = 3,
			staticcondense = false,
			name = L"Friendly_AddInfo",
			showborder = false,
			longtoperma = false,
			horizontal = 2,
			buffRowStride = 1,
			permabuffs = 1,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 24,
			FA = true,
			update = 0.5,
			rowcount = 3,
			ismine = 0,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.52501779794693,
				x = 770.9998305122,
				y = 977.99996095482,
			},
			filters = 
			{
				
				{
					enda = true,
					active = false,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					icon = "Yakar_battlemaster",
					name = L"A_BattleMaster",
					delete = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"BattleMaster",
						},
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					borderC = 
					{
						255,
						255,
						0,
					},
					name = L"B_Healdebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Healdebuff",
						},
					},
					icon = "Yakar_healdebuff50",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					delete = false,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					borderC = 
					{
						128,
						64,
						255,
					},
					name = L"C_HealOutDebuffs",
					useand = true,
					condense = true,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"HealOutDebuff",
						},
					},
					icon = "Yakar_healoutdebuff",
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isHealing = true,
					},
					active = true,
					name = L"D_Hots",
					enda = true,
					condense = true,
					conditions = 
					{
						
						{
							5,
							"duration",
							300,
							false,
						},
						
						{
							1,
							"isHealing",
							true,
						},
						
						{
							1,
							"isBuff",
							true,
						},
					},
					icon = "Yakar_hot",
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isDebuff = true,
					},
					icon = "Yakar_dot",
					name = L"E_Dots",
					delete = false,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isDamaging",
							true,
						},
						
						{
							1,
							"isDebuff",
							true,
						},
					},
					borderC = 
					{
						192,
						0,
						0,
					},
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = false,
					name = L"Remove Own",
					enda = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							1,
							"castByPlayer",
							true,
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
				
				{
					delete = true,
					useand = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = false,
					name = L"delete_Addinfo_Stuff",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							2,
							"abilityId",
							"Guard",
						},
						
						{
							2,
							"abilityId",
							"Bless",
						},
						
						{
							2,
							"abilityId",
							"all the morales",
						},
						
						{
							2,
							"abilityId",
							"Odjira",
						},
						
						{
							2,
							"abilityId",
							"Staggers",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			growleft = 1,
			glass = false,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			font = 3,
			staticcondense = false,
			name = L"Friendly_All",
			showborder = false,
			longtoperma = false,
			horizontal = 2,
			buffRowStride = 4,
			permabuffs = 1,
		},
		
		{
			divide = 1,
			active = true,
			maxBuffCount = 60,
			FA = false,
			update = 0.5,
			rowcount = 4,
			ismine = 0,
			buffTargetType = 6,
			anchor = 
			{
				scale = 0.71441400051117,
				x = 0,
				y = 0,
			},
			filters = 
			{
				
				{
					delete = true,
					useand = true,
					enda = true,
					icon = "Yakar_battlemaster",
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"BattleMaster",
						},
					},
					name = L"A_BattleMaster",
					active = false,
					condense = true,
					iconC = 
					{
						255,
						255,
						255,
					},
					borderC = 
					{
						149,
						149,
						149,
					},
					notresult = false,
				},
				
				{
					enda = false,
					active = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isHealing = true,
					},
					icon = "Yakar_hot",
					name = L"C_Hots",
					delete = false,
					condense = true,
					conditions = 
					{
						
						{
							1,
							"isHealing",
							true,
						},
						
						{
							5,
							"duration",
							300,
							false,
						},
					},
					borderC = 
					{
						0,
						149,
						0,
					},
					notresult = false,
				},
				
				{
					delete = true,
					useand = false,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = false,
					name = L"delete AddInfoStuff",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							2,
							"abilityId",
							"Odjira",
						},
						
						{
							1,
							"trackerPriority",
							100,
						},
						
						{
							2,
							"abilityId",
							"Guard",
						},
						
						{
							2,
							"abilityId",
							"Staggers",
						},
						
						{
							2,
							"abilityId",
							"all the morales",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
				
				{
					delete = true,
					useand = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					active = true,
					name = L"Keep only Selfhots",
					enda = true,
					condense = false,
					conditions = 
					{
						
						{
							1,
							"isHealing",
							true,
						},
						
						{
							5,
							"duration",
							300,
							false,
						},
						
						{
							1,
							"castByPlayer",
							false,
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			growleft = 1,
			glass = false,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			font = 4,
			staticcondense = false,
			name = L"Self_Buffs",
			showborder = false,
			longtoperma = false,
			horizontal = 2,
			buffRowStride = 11,
			permabuffs = 1,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 5,
			FA = true,
			update = 0.5,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 6,
			anchor = 
			{
				scale = 0.62200063467026,
				x = 569.33309707034,
				y = 892.54914477909,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Morales",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"all the morales",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			glass = true,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			name = L"Self_Morales",
			font = 3,
			longtoperma = false,
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 1,
			growleft = 2,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 5,
			FA = true,
			update = 0.5,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.58705359697342,
				x = 1783.333275299,
				y = 1132.549153215,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Morales",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"all the morales",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			glass = true,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			name = L"Friendly_Morales",
			font = 3,
			longtoperma = false,
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 1,
			growleft = 1,
		},
		
		{
			divide = 0,
			active = false,
			maxBuffCount = 5,
			FA = true,
			update = 0.5,
			rowcount = 1,
			ismine = 0,
			buffTargetType = 7,
			anchor = 
			{
				scale = 0.62333405017853,
				x = 1174.9999872481,
				y = 296.99986785448,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Morales",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"all the morales",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
			},
			hpte = false,
			type = 1,
			permabuffs = 1,
			glass = true,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			name = L"Hostile_Morales",
			font = 3,
			longtoperma = false,
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 1,
			growleft = 1,
		},
		
		{
			glass = false,
			active = true,
			maxBuffCount = 5,
			FA = true,
			update = 0.25,
			rowcount = 1,
			ismine = 0,
			hpte = false,
			anchor = 
			{
				scale = 0.65304434299469,
				x = 118.99999963526,
				y = 432.99989660714,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Resistbuff",
					useand = false,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Resistbuff",
						},
					},
					icon = "DAoC_new_qm",
					notresult = true,
				},
			},
			divide = 0,
			type = 1,
			permabuffs = 1,
			growleft = 2,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			font = 4,
			longtimehide = false,
			longtoperma = true,
			showborder = false,
			name = L"Resistbuff",
			horizontal = 2,
			buffRowStride = 1,
			buffTargetType = 7,
		},
		
		{
			divide = 1,
			active = true,
			maxBuffCount = 30,
			FA = true,
			update = 0.5,
			rowcount = 3,
			ismine = 0,
			buffTargetType = 7,
			anchor = 
			{
				scale = 0.47197666764259,
				x = 300.00007334642,
				y = 443.00023986096,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Delete Resistbuff",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Resistbuff",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			hpte = false,
			type = 1,
			growleft = 1,
			permabuffs = 1,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			staticcondense = false,
			name = L"HostileBuffs",
			font = 4,
			longtoperma = false,
			showborder = false,
			longtimehide = false,
			horizontal = 2,
			buffRowStride = 6,
			glass = false,
		},
		
		{
			glass = false,
			active = true,
			maxBuffCount = 30,
			FA = true,
			update = 0.5,
			rowcount = 3,
			ismine = 0,
			hpte = false,
			anchor = 
			{
				scale = 0.47113889455795,
				x = 299.99999798289,
				y = 491.00024133798,
			},
			filters = 
			{
				[1] = 
				{
					enda = true,
					active = true,
					combathide = false,
					addPrefs = 
					{
						isBuff = true,
					},
					delete = true,
					name = L"Delete Resistbuff",
					useand = true,
					condense = false,
					conditions = 
					{
						[1] = 
						{
							2,
							"abilityId",
							"Resistbuff",
						},
					},
					icon = "DAoC_new_qm",
					notresult = false,
				},
			},
			buffTargetType = 7,
			type = 1,
			growleft = 1,
			permabuffs = 1,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			name = L"HostileDebuffs",
			font = 4,
			longtoperma = false,
			showborder = false,
			staticcondense = false,
			horizontal = 2,
			buffRowStride = 6,
			divide = 2,
		},
		
		{
			divide = 1,
			active = true,
			maxBuffCount = 30,
			FA = false,
			update = 0.5,
			rowcount = 3,
			ismine = 0,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.47011032700539,
				x = 300.00008773947,
				y = 643.00001833963,
			},
			filters = 
			{
			},
			hpte = false,
			type = 1,
			growleft = 1,
			glass = false,
			growup = 2,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			longtoperma = false,
			font = 4,
			name = L"FriendlyBuffs",
			showborder = false,
			staticcondense = false,
			horizontal = 2,
			buffRowStride = 6,
			permabuffs = 1,
		},
		
		{
			divide = 2,
			active = true,
			maxBuffCount = 30,
			FA = false,
			update = 0.5,
			rowcount = 3,
			ismine = 0,
			buffTargetType = 8,
			anchor = 
			{
				scale = 0.47021606564522,
				x = 299.99999279341,
				y = 690.9998813574,
			},
			filters = 
			{
			},
			hpte = false,
			type = 1,
			growleft = 1,
			glass = false,
			growup = 1,
			buffsbelow = 0,
			bufforder = 1,
			longtimehide = false,
			longtoperma = false,
			font = 4,
			name = L"FriendlyDebuffs",
			showborder = false,
			staticcondense = false,
			horizontal = 2,
			buffRowStride = 6,
			permabuffs = 1,
		},
	},
	version = 1.0191,
	Tables = 
	{
		AddImmunities = 
		{
			[406] = 
			{
				iconNum = 2630,
				name = L"Unstoppable^n",
				effectText = L"Immune to Stun, Knockdown, Disarm, and Silence effects.",
			},
			[400] = 
			{
				iconNum = 2630,
				name = L"Root Ward^n",
				effectText = L"50% chance to break roots when Damaged.",
			},
			[14271] = 
			{
				abilityId = 14271,
				name = L"Resolute Defense",
				effectText = L"Immune to CC",
			},
			[403] = 
			{
				iconNum = 2630,
				name = L"Unstoppable^n",
				effectText = L"Immune to Stagger, Knockdown, Disarm, and Silence effects.",
			},
		},
		Bless = 
		{
			[3777] = 
			{
				effectText = L"Incoming heals are 25% more effective.",
				iconNum = 22704,
				name = L"Blessing of Chaos^n",
				abilityId = 3777,
			},
			[3410] = 
			{
				iconNum = 22704,
				name = L"Blessing of Grungni^n",
				effectText = L"Incoming heals are 25% more effective.",
			},
		},
		wrongDebuff = 
		{
		},
		Guard = 
		{
			[9325] = 
			{
				abilityId = 9325,
				name = L"GuardBG",
				effectText = L"",
			},
			[1674] = 
			{
				abilityId = 1674,
				name = L"GuardBO",
				effectText = L"",
			},
			[9008] = 
			{
				abilityId = 9008,
				name = L"GuardSM",
				effectText = L"",
			},
			[1363] = 
			{
				abilityId = 1363,
				name = L"GuardIB",
				effectText = L"",
			},
			[8325] = 
			{
				abilityId = 8325,
				name = L"GuardCH",
				effectText = L"",
			},
			[8013] = 
			{
				abilityId = 8013,
				name = L"GuardKS",
				effectText = L"",
			},
		},
		[6] = 
		{
			[17051] = 
			{
				effectText = L"You are unable to queue for Scenarios or participate in a Contested City siege.",
				name = L"Quitter!^n",
				iconNum = 2490,
			},
		},
		HealOutDebuff = 
		{
			[3811] = 
			{
				abilityId = 3811,
				name = L"Kiss of Death",
				effectText = L"",
			},
			[3002] = 
			{
				abilityId = 3002,
				name = L"Blessed Bullets of Confession",
				effectText = L"",
			},
			[3784] = 
			{
				abilityId = 3784,
				name = L"Blessed Bullets of Confession",
				effectText = L"",
			},
			[9317] = 
			{
				abilityId = 9317,
				name = L"Mind Killer",
				effectText = L"",
			},
			[3598] = 
			{
				abilityId = 3598,
				name = L"Kiss of Death",
				effectText = L"",
			},
			[8036] = 
			{
				abilityId = 8036,
				name = L"Now's Our Chance!",
				effectText = L"",
			},
			[20263] = 
			{
				abilityId = 20263,
				name = L"Kiss of Death",
				effectText = L"",
			},
			[3493] = 
			{
				abilityId = 3493,
				name = L"Now's Our Chance!",
				effectText = L"",
			},
			[8099] = 
			{
				abilityId = 8099,
				name = L"Blessed Bullets of Confession",
				effectText = L"",
			},
			[3372] = 
			{
				abilityId = 3372,
				name = L"Mind Killer",
				effectText = L"",
			},
		},
		[7] = 
		{
			[406] = 
			{
				effectText = L"Immune to Stun, Knockdown, Disarm, and Silence effects.",
				name = L"Unstoppable^n",
				iconNum = 2630,
			},
			[1878] = 
			{
				effectText = L"Periodically suffering 300 Damage.",
				name = L"Squig Goo^n",
				iconNum = 4506,
			},
			[3598] = 
			{
				effectText = L"Your healing abilities are 50% less effective.",
				name = L"Kiss Of Death^n",
				iconNum = 11006,
			},
			[3750] = 
			{
				effectText = L"All resistances reduced by 330.\nArmor reduced by 866.",
				name = L"Ignition^n",
				iconNum = 22704,
			},
		},
		["Kotbs Aura"] = 
		{
			[8008] = 
			{
				abilityId = 8008,
				name = L"Kotbs Aura",
				effectText = L"",
			},
		},
		["all the morales"] = 
		{
			[1649] = 
			{
				abilityId = 1649,
				name = L"Valaya's Shield",
				effectText = L"Rune Priest",
			},
			[8309] = 
			{
				abilityId = 8309,
				name = L"Avatar Of Sigmar",
				effectText = L"Warrior Priest",
			},
			[8310] = 
			{
				abilityId = 8310,
				name = L"Divine Amazement",
				effectText = L"Warrior Priest",
			},
			[606] = 
			{
				abilityId = 606,
				name = L"Demolishing Strike",
				effectText = L"Tank classes",
			},
			[1729] = 
			{
				abilityId = 1729,
				name = L"Yer Nothin",
				effectText = L"Black Orc",
			},
			[9076] = 
			{
				abilityId = 9076,
				name = L"Shadow Blades",
				effectText = L"Swordmaster",
			},
			[630] = 
			{
				abilityId = 630,
				name = L"Frenzied Slaughter",
				effectText = L"Melees",
			},
			[9459] = 
			{
				abilityId = 9459,
				name = L"Death Reaper",
				effectText = L"Witchelf",
			},
			[9075] = 
			{
				abilityId = 9075,
				name = L"Shield of Valor",
				effectText = L"Swordmaster",
			},
			[3029] = 
			{
				abilityId = 3029,
				name = L"Instill Fear",
				effectText = L"Shadow Warrior",
			},
			[8302] = 
			{
				abilityId = 8302,
				name = L"Divine Aegis",
				effectText = L"Warrior Priest",
			},
			[9605] = 
			{
				abilityId = 9605,
				name = L"Life's End",
				effectText = L"Diciple of Khaine",
			},
			[9464] = 
			{
				abilityId = 9464,
				name = L"Blade Spin",
				effectText = L"Witch Elf",
			},
			[9465] = 
			{
				abilityId = 9465,
				name = L"Fling Poison",
				effectText = L"Witch Elf",
			},
			[9466] = 
			{
				abilityId = 9466,
				name = L"Overwhelming Dread",
				effectText = L"Witch Elf",
			},
			[1970] = 
			{
				abilityId = 1970,
				name = L"Feelz No Pain",
				effectText = L"Shaman",
			},
			[1574] = 
			{
				abilityId = 1574,
				name = L"Autoloader",
				effectText = L"Engineer",
			},
			[8068] = 
			{
				abilityId = 8068,
				name = L"Guardian Of Light",
				effectText = L"Knight of the Blazing Sun",
			},
			[8454] = 
			{
				abilityId = 8454,
				name = L"Lashing Power",
				effectText = L"Marauder",
			},
			[8455] = 
			{
				abilityId = 8455,
				name = L"Forked Aggression",
				effectText = L"Marauder",
			},
			[1426] = 
			{
				abilityId = 1426,
				name = L"Earthen Renewal",
				effectText = L"Iron Breaker",
			},
			[1493] = 
			{
				abilityId = 1493,
				name = L"Untouchable",
				effectText = L"Slayer",
			},
			[631] = 
			{
				abilityId = 631,
				name = L"Confusing Movements",
				effectText = L"Melees",
			},
			[3035] = 
			{
				abilityId = 3035,
				name = L"Penance",
				effectText = L"Warrior Priest",
			},
			[1495] = 
			{
				abilityId = 1495,
				name = L"Grievous Harm",
				effectText = L"Slayer",
			},
			[8606] = 
			{
				abilityId = 8606,
				name = L"Eye Of Sheerian",
				effectText = L"Zealot",
			},
			[9224] = 
			{
				abilityId = 9224,
				name = L"Ensnare",
				effectText = L"White Lion",
			},
			[9225] = 
			{
				abilityId = 9225,
				name = L"Flying Axe",
				effectText = L"White Lion",
			},
			[8607] = 
			{
				abilityId = 8607,
				name = L"Suppressing The Fragile Unbelievers",
				effectText = L"Zealot",
			},
			[8074] = 
			{
				abilityId = 8074,
				name = L"Nova Strike",
				effectText = L"Knight of the Blazing Sun",
			},
			[695] = 
			{
				abilityId = 695,
				name = L"Focused Mind",
				effectText = L"Healers",
			},
			[8075] = 
			{
				abilityId = 8075,
				name = L"Flawless Defence",
				effectText = L"Knight of the Blazing Sun",
			},
			[1576] = 
			{
				abilityId = 1576,
				name = L"Cannon Smash",
				effectText = L"Engineer",
			},
			[8215] = 
			{
				abilityId = 8215,
				name = L"Magic Dart",
				effectText = L"Bright Wizzard",
			},
			[9232] = 
			{
				abilityId = 9232,
				name = L"Rampage",
				effectText = L"White Lion",
			},
			[608] = 
			{
				abilityId = 608,
				name = L"Champion's Challenge",
				effectText = L"Tank classes",
			},
			[1727] = 
			{
				abilityId = 1727,
				name = L"Puddle o Muck",
				effectText = L"Black Orc",
			},
			[9616] = 
			{
				abilityId = 9616,
				name = L"1001 Dark Blessings",
				effectText = L"Disciple of Khaine",
			},
			[9617] = 
			{
				abilityId = 9617,
				name = L"Vision of Torment",
				effectText = L"Diciple of Khaine",
			},
			[9618] = 
			{
				abilityId = 9618,
				name = L"Chant of Pain",
				effectText = L"Disciple of Khaine",
			},
			[649] = 
			{
				abilityId = 649,
				name = L"Unshakable Focus",
				effectText = L"Ranged physical DPS",
			},
			[9386] = 
			{
				abilityId = 9386,
				name = L"Khaine's Warding",
				effectText = L"Blackguard",
			},
			[8605] = 
			{
				abilityId = 8605,
				name = L"Tzeentch's Talon",
				effectText = L"Zealot",
			},
			[1972] = 
			{
				abilityId = 1972,
				name = L"Steal Yer Thunder",
				effectText = L"Shaman",
			},
			[3707] = 
			{
				abilityId = 3707,
				name = L"Universal Confusion",
				effectText = L"Diciple of Khaine",
			},
			[1877] = 
			{
				abilityId = 1877,
				name = L"Soothin' Mushroom Wrap",
				effectText = L"Squig Herder",
			},
			[696] = 
			{
				abilityId = 696,
				name = L"Divine Protection",
				effectText = L"Healers",
			},
			[3168] = 
			{
				abilityId = 3168,
				name = L"Scintillating Energy",
				effectText = L"Magical DPS",
			},
			[8611] = 
			{
				abilityId = 8611,
				name = L"Tzeentch's Shielding",
				effectText = L"Zealot",
			},
			[8612] = 
			{
				abilityId = 8612,
				name = L"Tzeentch's Scream",
				effectText = L"Zealot",
			},
			[8613] = 
			{
				abilityId = 8613,
				name = L"Windblock",
				effectText = L"Zealot",
			},
			[9056] = 
			{
				abilityId = 9056,
				name = L"Guard Of Steel",
				effectText = L"Swordmaster",
			},
			[9387] = 
			{
				abilityId = 9387,
				name = L"Blast Of Hatred",
				effectText = L"Blackguard",
			},
			[1878] = 
			{
				abilityId = 1878,
				name = L"Squig Goo",
				effectText = L"Squig Herder",
			},
			[633] = 
			{
				abilityId = 633,
				name = L"Relentless Assault",
				effectText = L"Melees",
			},
			[8372] = 
			{
				abilityId = 8372,
				name = L"Tzeentch's Amplification",
				effectText = L"Chosen",
			},
			[1799] = 
			{
				abilityId = 1799,
				name = L"Dat Tickles!",
				effectText = L"Choppa",
			},
			[9382] = 
			{
				abilityId = 9382,
				name = L"Armor Of Eternal Servitude",
				effectText = L"Black Guard",
			},
			[650] = 
			{
				abilityId = 650,
				name = L"Explosive Shots",
				effectText = L"Ranged physical DPS & Bright Wizzards",
			},
			[673] = 
			{
				abilityId = 673,
				name = L"Misdirection",
				effectText = L"Magical DPS",
			},
			[8153] = 
			{
				abilityId = 8153,
				name = L"Excommunicate",
				effectText = L"Witch Hunter",
			},
			[1879] = 
			{
				abilityId = 1879,
				name = L"Squigbeast",
				effectText = L"Squig Herder",
			},
			[8154] = 
			{
				abilityId = 8154,
				name = L"Expurgation",
				effectText = L"Witch Hunter",
			},
			[9388] = 
			{
				abilityId = 9388,
				name = L"In Malekith's Name!",
				effectText = L"Blackguard",
			},
			[1800] = 
			{
				abilityId = 1800,
				name = L"Tantrum",
				effectText = L"Choppa",
			},
			[8378] = 
			{
				abilityId = 8378,
				name = L"Impenetrable Armor",
				effectText = L"Chosen",
			},
			[1420] = 
			{
				abilityId = 1420,
				name = L"Gromril Plating",
				effectText = L"Iron Breaker",
			},
			[3681] = 
			{
				abilityId = 3681,
				name = L"Bladeshield",
				effectText = L"Sword Master",
			},
			[8377] = 
			{
				abilityId = 8377,
				name = L"Warping Embrace",
				effectText = L"Chosen",
			},
			[1499] = 
			{
				abilityId = 1499,
				name = L"Unleash Power",
				effectText = L"Slayer",
			},
			[1964] = 
			{
				abilityId = 1964,
				name = L"Gork Sez Stop",
				effectText = L"Shaman",
			},
			[9302] = 
			{
				abilityId = 9302,
				name = L"Isha's Ward",
				effectText = L"Archmage",
			},
			[1801] = 
			{
				abilityId = 1801,
				name = L"Supa Chop",
				effectText = L"Choppa",
			},
			[9144] = 
			{
				abilityId = 9144,
				name = L"Penetrating Arrow",
				effectText = L"Shadow Warrior",
			},
			[652] = 
			{
				abilityId = 652,
				name = L"Concealment",
				effectText = L"Ranged physical DPS",
			},
			[1722] = 
			{
				abilityId = 1722,
				name = L"Deafening Bellow!",
				effectText = L"Black Orc",
			},
			[690] = 
			{
				abilityId = 690,
				name = L"Steal Life",
				effectText = L"Healers",
			},
			[1500] = 
			{
				abilityId = 1500,
				name = L"Deadly Determination",
				effectText = L"Slayer",
			},
			[8373] = 
			{
				abilityId = 8373,
				name = L"Sprout Carapace",
				effectText = L"Chosen",
			},
			[8308] = 
			{
				abilityId = 8308,
				name = L"Gift Of Life",
				effectText = L"Warrior Priest",
			},
			[1802] = 
			{
				abilityId = 1802,
				name = L"We'z Fightin' Betta",
				effectText = L"Choppa",
			},
			[9537] = 
			{
				abilityId = 9537,
				name = L"Wind-Woven Shell",
				effectText = L"Sorceress",
			},
			[1580] = 
			{
				abilityId = 1580,
				name = L"Scattershot",
				effectText = L"Engineer",
			},
			[1723] = 
			{
				abilityId = 1723,
				name = L"Walk it off!",
				effectText = L"Black Orc",
			},
			[9536] = 
			{
				abilityId = 9536,
				name = L"Dire Blast",
				effectText = L"Sorceress",
			},
			[1501] = 
			{
				abilityId = 1501,
				name = L"Looks Like A Challenge",
				effectText = L"Slayer",
			},
			[9538] = 
			{
				abilityId = 9538,
				name = L"Darkstar Cloak",
				effectText = L"Sorceress",
			},
			[8148] = 
			{
				abilityId = 8148,
				name = L"Witchfinder's Protection",
				effectText = L"Witch Hunter",
			},
			[651] = 
			{
				abilityId = 651,
				name = L"Hail Of Doom",
				effectText = L"Ranged physical DPS",
			},
			[8528] = 
			{
				abilityId = 8528,
				name = L"Roiling Winds",
				effectText = L"Magus",
			},
			[1581] = 
			{
				abilityId = 1581,
				name = L"Artillery Barrage",
				effectText = L"Engineer",
			},
			[8527] = 
			{
				abilityId = 8527,
				name = L"Grasping Darkness",
				effectText = L"Magus",
			},
			[9544] = 
			{
				abilityId = 9544,
				name = L"Paralyzing Nightmares",
				effectText = L"Sorceress",
			},
			[8529] = 
			{
				abilityId = 8529,
				name = L"Conduit Of Chaos",
				effectText = L"Magus",
			},
			[1645] = 
			{
				abilityId = 1645,
				name = L"Rune of Rebirth",
				effectText = L"Rune Priest",
			},
			[1644] = 
			{
				abilityId = 1644,
				name = L"Mountain Spirit",
				effectText = L"Rune Priest",
			},
			[1803] = 
			{
				abilityId = 1803,
				name = L"Yer Goin Down!",
				effectText = L"Choppa",
			},
			[8533] = 
			{
				abilityId = 8533,
				name = L"Soul Leak",
				effectText = L"Magus",
			},
			[1582] = 
			{
				abilityId = 1582,
				name = L"Fling Explosives",
				effectText = L"Engineer",
			},
			[9543] = 
			{
				abilityId = 9543,
				name = L"Crippling Terror",
				effectText = L"Sorceress",
			},
			[611] = 
			{
				abilityId = 611,
				name = L"Shield Wall",
				effectText = L"Tank classes",
			},
			[628] = 
			{
				abilityId = 628,
				name = L"Force Of Will",
				effectText = L"Melees",
			},
			[8217] = 
			{
				abilityId = 8217,
				name = L"Heart Of Fire",
				effectText = L"Bright Wizzard",
			},
			[674] = 
			{
				abilityId = 674,
				name = L"Focused Mind",
				effectText = L"Magical DPS",
			},
			[1424] = 
			{
				abilityId = 1424,
				name = L"Strength In Numbers",
				effectText = L"Iron Breaker",
			},
			[9303] = 
			{
				abilityId = 9303,
				name = L"Blinding Light",
				effectText = L"Archmage",
			},
			[9304] = 
			{
				abilityId = 9304,
				name = L"Arcane Suppression",
				effectText = L"Archmage",
			},
			[610] = 
			{
				abilityId = 610,
				name = L"Distracting Bellow",
				effectText = L"Tank classes",
			},
			[1721] = 
			{
				abilityId = 1721,
				name = L"Quit Yer Squabblin'",
				effectText = L"Black Orc",
			},
			[1419] = 
			{
				abilityId = 1419,
				name = L"Skin Of Iron",
				effectText = L"Iron Breaker",
			},
			[9308] = 
			{
				abilityId = 9308,
				name = L"Winds' Protection",
				effectText = L"Archmage",
			},
			[9309] = 
			{
				abilityId = 9309,
				name = L"Flames Of The Phoenix",
				effectText = L"Archmage",
			},
			[9310] = 
			{
				abilityId = 9310,
				name = L"Funnel Energy",
				effectText = L"Archmage",
			},
			[9057] = 
			{
				abilityId = 9057,
				name = L"Wings Of Heaven",
				effectText = L"Swordmaster",
			},
			[1965] = 
			{
				abilityId = 1965,
				name = L"Breath of Mork",
				effectText = L"Shaman",
			},
			[613] = 
			{
				abilityId = 613,
				name = L"Immaculate Defense",
				effectText = L"Tank classes",
			},
			[8146] = 
			{
				abilityId = 8146,
				name = L"Exoneration",
				effectText = L"Witch Hunter",
			},
			[629] = 
			{
				abilityId = 629,
				name = L"Broad Swings",
				effectText = L"Melees",
			},
			[1575] = 
			{
				abilityId = 1575,
				name = L"Armored Plating",
				effectText = L"Engineer",
			},
			[1418] = 
			{
				abilityId = 1418,
				name = L"Rock Clutch",
				effectText = L"Iron Breaker",
			},
			[653] = 
			{
				abilityId = 653,
				name = L"Focused Mind",
				effectText = L"Ranged physical DPS",
			},
			[8303] = 
			{
				abilityId = 8303,
				name = L"Divine Replenishment",
				effectText = L"Warrior Priest",
			},
			[669] = 
			{
				abilityId = 669,
				name = L"Siphon Power",
				effectText = L"Magical DPS",
			},
			[1728] = 
			{
				abilityId = 1728,
				name = L"Cant' Touch Us",
				effectText = L"Black Orc",
			},
			[8070] = 
			{
				abilityId = 8070,
				name = L"Emperor's Champion",
				effectText = L"Knight of the Blazing Sun",
			},
			[8069] = 
			{
				abilityId = 8069,
				name = L"No Escape",
				effectText = L"Knight of the Blazing Sun",
			},
			[8449] = 
			{
				abilityId = 8449,
				name = L"Flames Of Fate",
				effectText = L"Marauder",
			},
		},
		[8] = 
		{
			[1910] = 
			{
				effectText = L"All resists increased by 226.",
				name = L"Mork's Buffer^n",
				iconNum = 2472,
			},
		},
		["Chosen Aura"] = 
		{
			[8321] = 
			{
				abilityId = 8321,
				name = L"Chosen Aura",
				effectText = L"",
			},
		},
		Odjira = 
		{
			[10869] = 
			{
				abilityId = 10869,
				name = L"Odjira",
				effectText = L"",
			},
		},
		Healdebuff = 
		{
			[10412] = 
			{
				abilityId = 10412,
				name = L"Guile",
				effectText = L"",
			},
			[8112] = 
			{
				abilityId = 8112,
				name = L"Punish The False",
				effectText = L"",
			},
			[1853] = 
			{
				abilityId = 1853,
				name = L"Rotten Arrer",
				effectText = L"",
			},
			[3428] = 
			{
				abilityId = 3428,
				name = L"Curse Of Khaine",
				effectText = L"",
			},
			[12692] = 
			{
				abilityId = 12692,
				name = L"Deep Wound",
				effectText = L"",
			},
			[20577] = 
			{
				abilityId = 20577,
				name = L"Playing with Fire",
				effectText = L"",
			},
			[1773] = 
			{
				abilityId = 1773,
				name = L"No More Helpin'",
				effectText = L"",
			},
			[3409] = 
			{
				abilityId = 3409,
				name = L"Discordant Turbulence",
				effectText = L"",
			},
			[10717] = 
			{
				abilityId = 10717,
				name = L"Guile",
				effectText = L"",
			},
			[3776] = 
			{
				abilityId = 3776,
				name = L"Discordant Turbulence",
				effectText = L"",
			},
			[3569] = 
			{
				abilityId = 3569,
				name = L"Playing with Fire",
				effectText = L"",
			},
			[9191] = 
			{
				abilityId = 9191,
				name = L"Thin the Herd",
				effectText = L"",
			},
			[9602] = 
			{
				abilityId = 9602,
				name = L"Curse Of Khaine",
				effectText = L"",
			},
			[8401] = 
			{
				abilityId = 8401,
				name = L"Tainted Claw",
				effectText = L"",
			},
			[8440] = 
			{
				abilityId = 8440,
				name = L"Deadly Clutch",
				effectText = L"",
			},
			[1434] = 
			{
				abilityId = 1434,
				name = L"Deep Wound",
				effectText = L"",
			},
			[8153] = 
			{
				abilityId = 8153,
				name = L"Excommunicate",
				effectText = L"",
			},
			[8613] = 
			{
				abilityId = 8613,
				name = L"Windblock",
				effectText = L"",
			},
			[9247] = 
			{
				abilityId = 9247,
				name = L"Scatter the Winds",
				effectText = L"",
			},
			[20324] = 
			{
				abilityId = 20324,
				name = L"Punish The False",
				effectText = L"",
			},
			[1501] = 
			{
				abilityId = 1501,
				name = L"Looks like a Challenge",
				effectText = L"",
			},
			[1905] = 
			{
				abilityId = 1905,
				name = L"Gork's Barbs'",
				effectText = L"",
			},
			[1803] = 
			{
				abilityId = 1803,
				name = L"Yer Goin Down!",
				effectText = L"",
			},
			[3915] = 
			{
				abilityId = 3915,
				name = L"Scatter the Winds",
				effectText = L"",
			},
			[9109] = 
			{
				abilityId = 9109,
				name = L"Shadow Sting",
				effectText = L"",
			},
			[3352] = 
			{
				abilityId = 3352,
				name = L"Gork's Barbs",
				effectText = L"",
			},
			[8348] = 
			{
				abilityId = 8348,
				name = L"Discordant Turbulence",
				effectText = L"",
			},
			[8184] = 
			{
				abilityId = 8184,
				name = L"Playing with Fire",
				effectText = L"",
			},
			[9424] = 
			{
				abilityId = 9424,
				name = L"Black Lotus Blade",
				effectText = L"",
			},
		},
		Resistbuff = 
		{
			[9248] = 
			{
				abilityId = 9248,
				name = L"AM",
				effectText = L"",
			},
			[8321] = 
			{
				abilityId = 8321,
				name = L"Chosen",
				effectText = L"",
			},
			[8560] = 
			{
				effectText = L"",
				name = L"Zealot",
				abilityId = 8560,
			},
			[1588] = 
			{
				effectText = L"",
				name = L"RP",
				abilityId = 1588,
			},
			[8008] = 
			{
				abilityId = 8008,
				name = L"Kotbs",
				effectText = L"",
			},
			[1910] = 
			{
				effectText = L"",
				name = L"Sham",
				abilityId = 1910,
			},
		},
		BattleMaster = 
		{
			[14498] = 
			{
				iconNum = 0,
				effectText = L"All of your Mastery Levels are increased by 1.",
				name = L"Battle Training^n",
				abilityId = 14498,
			},
			[14495] = 
			{
				effectText = L"All of your Mastery Levels are increased by 1.",
				iconNum = 0,
				name = L"Schlachtübermacht^f",
				abilityId = 14495,
			},
			[14492] = 
			{
				effectText = L"All of your Mastery Levels are increased by 1.",
				iconNum = 0,
				name = L"Schlachtprestige^n",
				abilityId = 14492,
			},
			[14496] = 
			{
				effectText = L"",
				iconNum = 0,
				name = L"Battlefield Master^n",
				abilityId = 14496,
			},
			[14493] = 
			{
				effectText = L"All of your Mastery Levels are increased by 1.",
				iconNum = 0,
				name = L"Schlachtvortrefflichkeit^f",
				abilityId = 14493,
			},
			[14497] = 
			{
				iconNum = 0,
				effectText = L"",
				name = L"Advanced Battlefield Master^n",
				abilityId = 14497,
			},
			[14494] = 
			{
				effectText = L"All of your Mastery Levels are increased by 1.",
				iconNum = 0,
				name = L"Schlachtvorherrschaft^f",
				abilityId = 14494,
			},
			[14491] = 
			{
				effectText = L"All of your Mastery Levels are increased by 1.",
				iconNum = 0,
				name = L"Schlachtvollendung^f",
				abilityId = 14491,
			},
		},
		Staggers = 
		{
			[3168] = 
			{
				abilityId = 3168,
				name = L"Scintillating Energy",
				effectText = L"",
			},
			[9396] = 
			{
				abilityId = 9396,
				name = L"Agile Escape",
				effectText = L"",
			},
			[8038] = 
			{
				abilityId = 8038,
				name = L"Heaven's Fury",
				effectText = L"",
			},
			[1525] = 
			{
				abilityId = 1525,
				name = L"Self-Destruct",
				effectText = L"",
			},
			[3027] = 
			{
				abilityId = 3027,
				name = L"Aethyric Shock",
				effectText = L"",
			},
			[3035] = 
			{
				abilityId = 3035,
				name = L"Penance",
				effectText = L"",
			},
			[20249] = 
			{
				abilityId = 20249,
				name = L"Heaven's Fury",
				effectText = L"",
			},
			[20189] = 
			{
				abilityId = 20189,
				name = L"Quake",
				effectText = L"",
			},
			[31] = 
			{
				abilityId = 31,
				name = L"Detonation",
				effectText = L"",
			},
			[3029] = 
			{
				abilityId = 3029,
				name = L"Instill Fear",
				effectText = L"",
			},
			[8304] = 
			{
				abilityId = 8304,
				name = L"Penance",
				effectText = L"",
			},
			[3707] = 
			{
				abilityId = 3707,
				name = L"Universal Confusion",
				effectText = L"",
			},
			[3030] = 
			{
				abilityId = 3030,
				name = L"Heaven's Fury",
				effectText = L"",
			},
			[383] = 
			{
				abilityId = 383,
				name = L"Detonation",
				effectText = L"",
			},
			[21655] = 
			{
				abilityId = 21655,
				name = L"Instability",
				effectText = L"",
			},
			[20461] = 
			{
				abilityId = 20461,
				name = L"Aethyric Shock",
				effectText = L"",
			},
			[3149] = 
			{
				abilityId = 3149,
				name = L"Detonation",
				effectText = L"",
			},
			[3031] = 
			{
				abilityId = 3031,
				name = L"Quake",
				effectText = L"",
			},
			[8094] = 
			{
				abilityId = 8094,
				name = L"Declare Anathema",
				effectText = L"",
			},
			[3630] = 
			{
				abilityId = 3630,
				name = L"Land Mine",
				effectText = L"",
			},
			[9606] = 
			{
				abilityId = 9606,
				name = L"Universal Confusion",
				effectText = L"",
			},
			[3032] = 
			{
				abilityId = 3032,
				name = L"Agile Escape",
				effectText = L"",
			},
			[8349] = 
			{
				abilityId = 8349,
				name = L"Quake",
				effectText = L"",
			},
			[1524] = 
			{
				abilityId = 1524,
				name = L"Land Mine",
				effectText = L"",
			},
			[8571] = 
			{
				abilityId = 8571,
				name = L"Aethyric Shock",
				effectText = L"",
			},
			[3033] = 
			{
				abilityId = 3033,
				name = L"Declare Anathema",
				effectText = L"",
			},
			[3167] = 
			{
				abilityId = 3167,
				name = L"Detonation",
				effectText = L"",
			},
			[8541] = 
			{
				abilityId = 8541,
				name = L"Daemonic Infestation",
				effectText = L"",
			},
			[23065] = 
			{
				abilityId = 23065,
				name = L"Universal Confusion",
				effectText = L"",
			},
			[20480] = 
			{
				abilityId = 20480,
				name = L"Rune of Binding",
				effectText = L"",
			},
			[5879] = 
			{
				abilityId = 5879,
				name = L"Land Mine",
				effectText = L"",
			},
			[671] = 
			{
				abilityId = 671,
				name = L"Scintillating Energy",
				effectText = L"",
			},
			[3034] = 
			{
				abilityId = 3034,
				name = L"Detonation",
				effectText = L"",
			},
			[9139] = 
			{
				abilityId = 9139,
				name = L"Instill Fear",
				effectText = L"",
			},
		},
	},
}



