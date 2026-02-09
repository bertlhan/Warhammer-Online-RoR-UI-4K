Enemy.Settings = 
{
	combatLogIgnoreAbilityMinValue = 20000,
	combatLogTargetDefenseShow = 
	{
		false,
		false,
		false,
		false,
		false,
		false,
	},
	prevVersion = 279,
	combatLogTargetDefenseHideTimeout = 10,
	guardMarkEnabled = true,
	groupIconsOtherGroupsAlpha = 0.5,
	debug = false,
	combatLogTargetDefenseTotalEnabled = false,
	unitFramesDirection1 = 4,
	groupIconsPetScale = 1,
	unitFramesMyGroupOnly = false,
	soundOnNewTarget = false,
	guardDistanceIndicatorAlphaNormal = 0.75,
	talismanAlerterColorWarning = 
	{
		255,
		255,
		100,
	},
	talismanAlerterAnimation = false,
	combatLogIDSRowPadding = L"3",
	killSpamKilledByYouSound = 219,
	combatLogTargetDefenseSize = 
	{
		60,
		20,
	},
	guardDistanceIndicatorWarningDistance = 30,
	combatLogTargetDefenseTotalBackgroundAlpha = 0.5,
	groupIconsPetLayer = 0,
	combatLogIDSDisplayTime = 20,
	combatLogTargetDefenseTotalCalculate = 
	{
		false,
		false,
		false,
		false,
		false,
		false,
	},
	groupIconsEnabled = false,
	groupIconsBGColor = 
	{
		200,
		255,
		0,
	},
	groupIconsOffset = 
	{
		0,
		220,
	},
	combatLogTargetDefenseBackgroundAlpha = 0.5,
	combatLogIDSType = "dps",
	groupIconsPetIconColor = 
	{
		255,
		100,
		200,
	},
	combatLogIDSRowBackgroundAlpha = 0.7,
	clickCastings = 
	{
	},
	unitFramesDetachMyGroup = false,
	unitFramesHideWhenSolo = true,
	groupIconsBGAlpha = 0.5,
	effectsIndicators = 
	{
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 3,
					type = "guard",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 2,
					filterName = L"MyGuard",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 10,
			icon = "guard",
			canDispell = 1,
			isCircleIcon = false,
			id = "19927",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 5,
			isEnabled = false,
			name = L"My guard",
			color = 
			{
				b = 127,
				g = 243,
				r = 191,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = true,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			anchorTo = 5,
			scale = 0.8,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 8,
			icon = "guard",
			canDispell = 1,
			isCircleIcon = false,
			id = "19928",
			alpha = 1,
			archetypeMatch = 2,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Other guard",
			isEnabled = false,
			playerType = 3,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 3,
					type = "guard",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 3,
					filterName = L"NotMyGuard",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			color = 
			{
				b = 255,
				g = 181,
				r = 127,
			},
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					descriptionMatch = 2,
					castedByMe = 1,
					durationType = 2,
					hasDurationLimit = false,
					filterName = L"Any",
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -25,
			icon = "dot",
			canDispell = 2,
			isCircleIcon = false,
			id = "19929",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 9,
			anchorTo = 9,
			isEnabled = false,
			name = L"Any dispellable",
			color = 
			{
				b = 119,
				g = 60,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					type = "isHealing",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 2,
					filterName = L"MyHealing",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -14,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19930",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 9,
			anchorTo = 9,
			isEnabled = false,
			name = L"HoT",
			color = 
			{
				b = 0,
				g = 191,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					durationType = 2,
					type = "isBuff",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 2,
					filterName = L"MyBuff",
					nameMatch = 1,
					descriptionMatch = 2,
				},
				
				{
					durationType = 2,
					type = "isHealing",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 2,
					filterName = L"MyHealing",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -3,
			logic = L"MyBuff and not MyHealing",
			canDispell = 1,
			isCircleIcon = false,
			icon = "dot",
			id = "19931",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = true,
			isEnabled = false,
			anchorTo = 9,
			name = L"Buff",
			color = 
			{
				b = 255,
				g = 200,
				r = 50,
			},
			playerType = 1,
			offsetY = 0,
			anchorFrom = 9,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					durationType = 2,
					type = "isBlessing",
					filterName = L"MyBlessing",
					descriptionMatch = 2,
					castedByMe = 2,
					durationMax = 59,
					nameMatch = 1,
					hasDurationLimit = true,
					typeMatch = 1,
				},
				
				{
					durationType = 2,
					type = "isHealing",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 2,
					filterName = L"MyHealing",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -3,
			logic = L"MyBlessing and not MyHealing",
			canDispell = 1,
			isCircleIcon = false,
			icon = "dot",
			id = "19932",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = false,
			anchorTo = 9,
			name = L"Blessing",
			color = 
			{
				b = 255,
				g = 200,
				r = 50,
			},
			playerType = 1,
			offsetY = 0,
			anchorFrom = 9,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					type = "healDebuffOut50",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 3,
					filterName = L"OutHealDebuff",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -53,
			icon = "heal",
			canDispell = 1,
			isCircleIcon = false,
			id = "19933",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 8,
			isEnabled = false,
			name = L"Outgoing 50% heal debuff",
			color = 
			{
				b = 64,
				g = 255,
				r = 191,
			},
			playerType = 1,
			offsetY = -5,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					type = "healDebuffIn50",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 3,
					filterName = L"InHealDebuff",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -40,
			icon = "heal",
			canDispell = 1,
			isCircleIcon = false,
			id = "19934",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 8,
			isEnabled = false,
			name = L"Incomming 50% heal debuff",
			color = 
			{
				b = 64,
				g = 64,
				r = 255,
			},
			playerType = 1,
			offsetY = -5,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			anchorTo = 5,
			scale = 0.75,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 5,
			icon = "stagger",
			canDispell = 1,
			isCircleIcon = false,
			id = "19935",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Stagger",
			isEnabled = false,
			playerType = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					type = "stagger",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 1,
					filterName = L"Stagger",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			color = 
			{
				b = 128,
				g = 255,
				r = 255,
			},
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DoK_WP_Regen",
					abilityIds = L"9561, 8237",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9561] = true,
						[8237] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -65,
			icon = "disabled",
			canDispell = 1,
			isCircleIcon = false,
			id = "19936",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 8,
			isEnabled = false,
			name = L"DoK/WP regen",
			color = 
			{
				b = 128,
				g = 64,
				r = 255,
			},
			playerType = 1,
			offsetY = -5,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"ID",
					abilityIds = L"613",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[613] = true,
					},
					hasDurationLimit = false,
					durationType = 2,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 5,
			customIcon = 23175,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19937",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Immaculate Defense",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"FM",
					abilityIds = L"653, 674, 695, 3882",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3882] = true,
						[674] = true,
						[653] = true,
						[695] = true,
					},
					hasDurationLimit = false,
					durationType = 2,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 5,
			customIcon = 23153,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19938",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Focused Mind",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"TODB",
					abilityIds = L"9616",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9616] = true,
					},
					hasDurationLimit = false,
					durationType = 2,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 5,
			customIcon = 10965,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19939",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"1001 Dark Blessings",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"GOF",
					abilityIds = L"8308",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8308] = true,
					},
					hasDurationLimit = false,
					durationType = 2,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 5,
			customIcon = 8042,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19940",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Gift of Life",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			anchorTo = 9,
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -36,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19941",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 9,
			exceptMe = false,
			name = L"My marks/runes",
			isEnabled = false,
			playerType = 3,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"AnyMarkOrRune",
					abilityIds = L"3746, 8551, 8617, 3748, 8560, 8619, 20458, 3747, 8556, 8618, 3038, 3773, 8567, 8620, 1591, 3670, 20476, 1588, 1600, 3570, 1608, 3650, 3671",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8560] = true,
						[1608] = true,
						[3746] = true,
						[3748] = true,
						[20458] = true,
						[8617] = true,
						[3570] = true,
						[8556] = true,
						[3671] = true,
						[20476] = true,
						[1588] = true,
						[8619] = true,
						[1600] = true,
						[3650] = true,
						[3773] = true,
						[8620] = true,
						[3670] = true,
						[3038] = true,
						[8551] = true,
						[3747] = true,
						[8567] = true,
						[1591] = true,
						[8618] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			color = 
			{
				b = 221,
				g = 255,
				r = 0,
			},
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					filterName = L"WordOfPain",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"9475, 20535",
					durationMax = 5,
					hasDurationLimit = true,
					abilityIdsHash = 
					{
						[9475] = true,
						[20535] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 6,
			customIcon = 10908,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19942",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Improved Word of Pain",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					filterName = L"BoilingBlood",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"8165",
					durationMax = 5,
					hasDurationLimit = true,
					abilityIdsHash = 
					{
						[8165] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 6,
			customIcon = 8015,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19943",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Improved Boiling Blood",
			isEnabled = false,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 2,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			anchorTo = 5,
			scale = 1.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 3,
			icon = "guard",
			canDispell = 1,
			isCircleIcon = false,
			id = "19944",
			alpha = 1,
			archetypeMatch = 2,
			anchorFrom = 5,
			exceptMe = false,
			name = L"Other guard f",
			isEnabled = false,
			playerType = 3,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 3,
					type = "guard",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 3,
					filterName = L"NotMyGuard",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			color = 
			{
				b = 255,
				g = 181,
				r = 127,
			},
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"Buff",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"1600,8556,8269,1928,9272",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1600] = true,
						[8556] = true,
						[9272] = true,
						[1928] = true,
						[8269] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 8042,
			icon = "FiskgjuseUiSideBuffTop",
			canDispell = 1,
			isCircleIcon = false,
			id = "19945",
			archetypeMatch = 1,
			alpha = 0.7582580447197,
			anchorFrom = 7,
			anchorTo = 7,
			isEnabled = true,
			name = L"Buffs - SideBuff",
			color = 
			{
				b = 0,
				g = 0,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					durationType = 1,
					filterName = L"Buff",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"1910,8560,1588,9248",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1910] = true,
						[8560] = true,
						[1588] = true,
						[9248] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Aura",
					abilityIds = L"8008,8321",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8008] = true,
						[8321] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 1,
			anchorFrom = 3,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 90,
			logic = L"Buff or Aura",
			canDispell = 1,
			isCircleIcon = false,
			icon = "FiskgjuseUiSideBuffBot",
			id = "19946",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = false,
			anchorTo = 3,
			name = L"Resist - SideBuff",
			color = 
			{
				b = 0,
				g = 255,
				r = 0,
			},
			playerType = 3,
			offsetY = -8,
			left = 0,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"RN",
					abilityIds = L"6040",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[6040] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 5365,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 1,
			id = "19947",
			anchorFrom = 1,
			alpha = 0.10885863006115,
			width = 150,
			exceptMe = false,
			height = 49,
			name = L"RN",
			anchorTo = 1,
			playerType = 3,
			isEnabled = true,
			scale = 1,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"RC",
					abilityIds = L"6039",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[6039] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 1,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 4560,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 1,
			anchorFrom = 1,
			id = "19948",
			isEnabled = true,
			alpha = 0.17267245054245,
			width = 150,
			height = 49,
			anchorTo = 1,
			name = L"RC",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					descriptionMatch = 2,
					castedByMe = 1,
					durationType = 2,
					hasDurationLimit = false,
					filterName = L"Any",
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 2,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -10,
			customIcon = 29989,
			icon = "effect",
			canDispell = 2,
			isCircleIcon = false,
			id = "19949",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Any dispellable f",
			color = 
			{
				b = 133,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 18,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DoK_WP_Regen",
					abilityIds = L"9561, 8237",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9561] = true,
						[8237] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -20,
			icon = "disabled",
			canDispell = 1,
			isCircleIcon = false,
			id = "19950",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"DoK/WP regen f",
			color = 
			{
				b = 128,
				g = 64,
				r = 255,
			},
			playerType = 1,
			offsetY = 5,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"BG",
					abilityIds = L"1850,20356",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1850] = true,
						[20356] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -65,
			customIcon = 2608,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19951",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Bad Gas!",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"SL",
					abilityIds = L"1464",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1464] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -65,
			customIcon = 4686,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19952",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Shatter Limbs",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Nidf",
					abilityIds = L"1691, 23133",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1691] = true,
						[23133] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -65,
			customIcon = 2566,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19953",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Not in da face!",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					filterName = L"WordOfPain",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"9475, 20535",
					durationMax = 5,
					hasDurationLimit = true,
					abilityIdsHash = 
					{
						[9475] = true,
						[20535] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = -45,
			customIcon = 10908,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19954",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Improved Word of Pain f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					filterName = L"BoilingBlood",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"8165",
					durationMax = 5,
					hasDurationLimit = true,
					abilityIdsHash = 
					{
						[8165] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = -45,
			customIcon = 8015,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19955",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Improved Boiling Blood f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"FM",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"653, 674, 695, 3882",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3882] = true,
						[674] = true,
						[653] = true,
						[695] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -25,
			customIcon = 23153,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19956",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Focused Mind f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"DP",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"696",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[696] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -5,
			customIcon = 23152,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19957",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Divine Protection",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"TODB",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"9616",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[9616] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -5,
			customIcon = 10965,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19958",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"1001 Dark Blessings f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"GOF",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"8308",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[8308] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -5,
			customIcon = 8042,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19959",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Gift of Life f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"ID",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"613",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[613] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -5,
			customIcon = 23175,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "19960",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Immaculate Defense f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					typeMatch = 1,
					filterName = L"RP",
					abilityIds = L"1607, 3305, 20477, 20478",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1607] = true,
						[3305] = true,
						[20478] = true,
						[20477] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BW",
					abilityIds = L"5093, 8174, 20579",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20579] = true,
						[8174] = true,
						[5093] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WP",
					abilityIds = L"3754, 8256, 20516, 20517",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8256] = true,
						[20516] = true,
						[3754] = true,
						[20517] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WH",
					abilityIds = L"8100, 20331",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8100] = true,
						[20331] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"AM",
					abilityIds = L"9253, 20495, 20496, 23139",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20496] = true,
						[20495] = true,
						[23139] = true,
						[9253] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SW",
					abilityIds = L"9095, 20396, 20397",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9095] = true,
						[20396] = true,
						[20397] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WL",
					abilityIds = L"3958, 9177, 20637, 20638, 20679, 20680",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20679] = true,
						[20680] = true,
						[20638] = true,
						[9177] = true,
						[3958] = true,
						[20637] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BO",
					abilityIds = L"1683, 20148, 1722",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1683] = true,
						[20148] = true,
						[1722] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Sham",
					abilityIds = L"1917, 3218, 20416, 20417",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20416] = true,
						[3218] = true,
						[20417] = true,
						[1917] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SH",
					abilityIds = L"1839, 20345, 20346",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20345] = true,
						[20346] = true,
						[1839] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Chosen",
					abilityIds = L"3762, 8350",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3762] = true,
						[8350] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Zeal",
					abilityIds = L"8565, 20456, 20457, 8607",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8565] = true,
						[20456] = true,
						[20457] = true,
						[8607] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"DOK",
					abilityIds = L"9565, 20437, 20438",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20437] = true,
						[9565] = true,
						[20438] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Sorc",
					abilityIds = L"9489, 20539",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9489] = true,
						[20539] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WE",
					abilityIds = L"3616, 6018, 9409, 20272",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[6018] = true,
						[9409] = true,
						[3616] = true,
						[20272] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorFrom = 4,
			isTimer = false,
			ticked = 0,
			offsetX = 18,
			customIcon = 8037,
			logic = L"RP or BW or WP or WH or AM or SW or WL or BO or Sham or SH or Chosen or Zeal or DOK or Sorc or WE",
			canDispell = 1,
			isCircleIcon = true,
			id = "19961",
			icon = "other",
			alpha = 1,
			archetypeMatch = 1,
			left = 0,
			playerType = 1,
			name = L"Silence",
			anchorTo = 5,
			isEnabled = true,
			exceptMe = false,
			scale = 0.4,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					typeMatch = 1,
					filterName = L"Kotbs",
					abilityIds = L"8018, 20250",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8018] = true,
						[20250] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"IB",
					abilityIds = L"1369, 20209",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1369] = true,
						[20209] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SM",
					abilityIds = L"3541, 9028",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3541] = true,
						[9028] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SW",
					abilityIds = L"3565,9108,20404",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20404] = true,
						[9108] = true,
						[3565] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WL",
					abilityIds = L"3959, 9193",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3959] = true,
						[9193] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BW",
					abilityIds = L"8186",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8186] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Engi",
					abilityIds = L"1525",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1525] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SL",
					abilityIds = L"1443, 20618",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1443] = true,
						[20618] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WH",
					abilityIds = L"8115, 20332, 2995, 8110",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20332] = true,
						[8110] = true,
						[2995] = true,
						[8115] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Chosen",
					abilityIds = L"8346, 20188",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8346] = true,
						[20188] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Mag",
					abilityIds = L"8481, 21655",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8481] = true,
						[21655] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Mara",
					abilityIds = L"8423, 20288, 8412",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8423] = true,
						[20288] = true,
						[8412] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BO",
					abilityIds = L"1688, 20147",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1688] = true,
						[20147] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"CH",
					abilityIds = L"1755, 20598",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1755] = true,
						[20598] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SH",
					abilityIds = L"1835",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1835] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BG",
					abilityIds = L"2888, 3482, 9321, 20170, 20171",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[2888] = true,
						[20170] = true,
						[20171] = true,
						[9321] = true,
						[3482] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WE",
					abilityIds = L"6029, 9427, 20273, 3581, 3582, 3583, 3584, 3585, 6024, 9422",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3585] = true,
						[9427] = true,
						[20273] = true,
						[6024] = true,
						[3582] = true,
						[3583] = true,
						[3581] = true,
						[3584] = true,
						[6029] = true,
						[9422] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			anchorFrom = 4,
			isTimer = false,
			ticked = 0,
			offsetX = 18,
			customIcon = 2528,
			logic = L"Kotbs or IB or SM or SW or WL or BW or Engi or SL or WH or Chosen or Mag or Mara or BO or CH or SH or BG or WE",
			canDispell = 1,
			isCircleIcon = true,
			icon = "other",
			id = "19962",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = true,
			anchorTo = 5,
			name = L"KD",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			left = 0,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"CI",
					abilityIds = L"1384",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1384] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 18,
			customIcon = 4593,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19963",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 4,
			exceptMe = false,
			name = L"Cave-In",
			isEnabled = true,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 5,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 2,
					type = "stagger",
					typeMatch = 1,
					hasDurationLimit = false,
					castedByMe = 1,
					filterName = L"Stagger",
					nameMatch = 1,
					descriptionMatch = 2,
				},
			},
			scale = 0.8,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 18,
			icon = "stagger",
			canDispell = 1,
			isCircleIcon = false,
			id = "19964",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Stagger f",
			color = 
			{
				b = 128,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"SE",
					abilityIds = L"671, 3168",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[671] = true,
						[3168] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 18,
			customIcon = 23169,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19965",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 4,
			exceptMe = false,
			name = L"Scintillating Energy",
			isEnabled = true,
			playerType = 3,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			anchorTo = 5,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1.1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"immovable",
					abilityIds = L"408,416,2876,3249",
					castedByMe = 1,
					name = L"immovable",
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3249] = true,
						[416] = true,
						[408] = true,
						[2876] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 54,
			customIcon = 5007,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19966",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Immovable",
			color = 
			{
				b = 191,
				g = 255,
				r = 191,
			},
			playerType = 3,
			offsetY = -25,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1.1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"unstoppable",
					abilityIds = L"402,403,404,405,406,407,412,413,414,2877",
					castedByMe = 1,
					name = L"unstoppable",
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[412] = true,
						[413] = true,
						[414] = true,
						[402] = true,
						[403] = true,
						[404] = true,
						[405] = true,
						[406] = true,
						[407] = true,
						[2877] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 54,
			customIcon = 5006,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19967",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 4,
			anchorTo = 5,
			isEnabled = true,
			name = L"Unstoppable",
			color = 
			{
				b = 255,
				g = 191,
				r = 191,
			},
			playerType = 3,
			offsetY = 6,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"Buff",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"3746,8551,8617,8619,3747,8556,8618,3038,3773,8567,8620,1591,3670,1600,3570,1608,3650,3671,8269",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3670] = true,
						[1608] = true,
						[3746] = true,
						[8617] = true,
						[3570] = true,
						[8269] = true,
						[8618] = true,
						[3671] = true,
						[1591] = true,
						[3650] = true,
						[8619] = true,
						[3747] = true,
						[3773] = true,
						[3038] = true,
						[8551] = true,
						[1600] = true,
						[8567] = true,
						[8620] = true,
						[8556] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 1.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			customIcon = 8042,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19968",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Buffs",
			color = 
			{
				b = 0,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"Buff",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"1600,8556",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1600] = true,
						[8556] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 1.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			customIcon = 8042,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19969",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Buffs - Clense/Wounds",
			color = 
			{
				b = 0,
				g = 0,
				r = 255,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"Buff",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"1910,8560,1588,9248",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1910] = true,
						[8560] = true,
						[1588] = true,
						[9248] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 1.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			customIcon = 90,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = true,
			id = "19970",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Buffs - Resist",
			color = 
			{
				b = 0,
				g = 255,
				r = 0,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"healing_hand",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"3365",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3365] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 7960,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19971",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"wp_healing_hand",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"pious_rest",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"8232,8265",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[8232] = true,
						[8265] = true,
					},
					nameMatch = 2,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 62,
			customIcon = 8035,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19972",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"wp_pious_rest",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"united_in_prayer",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"32104",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[32104] = true,
					},
					nameMatch = 2,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 40,
			customIcon = 22695,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19973",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"wp_united_in_prayer",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Prayer",
					abilityIds = L"8242,8243,8249",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8243] = true,
						[8242] = true,
						[8249] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 1.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19974",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"wp_aura",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 8,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"rune_of_regeneration",
					abilityIds = L"1590,20474",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[1590] = true,
						[20474] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 4561,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19975",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"rp_rune_of_regeneration",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"blessing_of_grungni",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"3410",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3410] = true,
					},
					nameMatch = 2,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 40,
			customIcon = 22704,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19976",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"rp_blessing_of_grungni",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"lambent_aura",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"3914, 9238, 20494",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[20494] = true,
						[9238] = true,
						[3914] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 13342,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19977",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"am_lambent_aura",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"magical_infusion",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"9272",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[9272] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 45,
			customIcon = 13413,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19978",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"am_magical_infusion",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"phoenixs_rejuvenation",
					descriptionMatch = 2,
					castedByMe = 2,
					abilityIds = L"32083",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[32083] = true,
					},
					nameMatch = 2,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 62,
			customIcon = 13466,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19979",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"am_phoenix's_rejuvenation",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"soul_infusion",
					abilityIds = L"3366",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3366] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 10937,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19980",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"dok_soul_infusion",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"khaines_vigor",
					abilityIds = L"9573",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9573] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 62,
			customIcon = 10956,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19981",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"dok_khaines_vigor",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"khaines_vivification",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"32115",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[32115] = true,
					},
					nameMatch = 2,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 40,
			customIcon = 22708,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19982",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"dok_khaine's_vivification",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Covenant",
					abilityIds = L"9559,9563,9567",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9563] = true,
						[9559] = true,
						[9567] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 1.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			icon = "dot",
			canDispell = 1,
			isCircleIcon = false,
			id = "19983",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"dok_aura",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"tzench_cordial",
					abilityIds = L"8558",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[8558] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 5142,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			archetypeMatch = 1,
			anchorFrom = 5,
			id = "19984",
			isEnabled = true,
			alpha = 1,
			width = 60,
			height = 60,
			anchorTo = 5,
			name = L"zealot_tzenchs_coordial",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"boc",
					abilityIds = L"3426, 3777",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[3426] = true,
						[3777] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 40,
			customIcon = 22704,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19985",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"zealot_blessing_of_chaos",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"quitbleedin",
					abilityIds = L"3908",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[3908] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.5,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 40,
			customIcon = 2576,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19986",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"sham_quit_bleedin",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 21,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"do_sumfin_useful",
					abilityIds = L"1926",
					castedByMe = 3,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[1926] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 25,
			customIcon = 2501,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19987",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"sham_do_sumfin_useful",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0.8,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"do_sumfin_useful",
					abilityIds = L"1926",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 2,
					abilityIdsHash = 
					{
						[1926] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 25,
			customIcon = 2501,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19988",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"sham_do_sumfin_useful_me",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0,
			effectFilters = 
			{
				[1] = 
				{
					durationType = 1,
					filterName = L"shrug_it_off",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"1928",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1928] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 45,
			customIcon = 2463,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19989",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"sham_shrug_it_off",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"YNSB",
					abilityIds = L"1911",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1911] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -35,
			customIcon = 2581,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19990",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Yer Not So Bad",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DM",
					abilityIds = L"3023183, 3244, 9249, 20498, 23053",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9249] = true,
						[20498] = true,
						[3023183] = true,
						[3244] = true,
						[23053] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -35,
			customIcon = 13353,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19991",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Drain Magic",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"ES",
					abilityIds = L"3082",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3082] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 13325,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19992",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Eye Shot",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"WB",
					abilityIds = L"1823,20343",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1823] = true,
						[20343] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 2613,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19993",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"What Blocka?",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"WS",
					abilityIds = L"8491",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8491] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 5308,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19994",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Withered Soul",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"CC",
					abilityIds = L"8418",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8418] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 5196,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19995",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Cutting Claw",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"FO",
					abilityIds = L"9192",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9192] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 13445,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19996",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Force Opportunity",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"SB",
					abilityIds = L"32122",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[32122] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 11047,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19997",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Serrated Blade",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"V",
					abilityIds = L"32113",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[32113] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 8093,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19998",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Vanquish",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Demo",
					abilityIds = L"606",
					castedByMe = 1,
					name = L"demolishing strike",
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[606] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -35,
			customIcon = 23172,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "19999",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Demo",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					descriptionMatch = 2,
					castedByMe = 1,
					name = L"cannon smash",
					durationType = 1,
					nameMatch = 1,
					filterName = L"Csmash",
					hasDurationLimit = false,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -35,
			customIcon = 4621,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20000",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Csmash",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"talon",
					abilityIds = L"8605",
					castedByMe = 1,
					name = L"tzeentch's talon",
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[8605] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.3,
			anchorFrom = 5,
			exceptMe = false,
			ticked = 0,
			offsetX = -35,
			customIcon = 5118,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20001",
			alpha = 1,
			archetypeMatch = 1,
			left = 0,
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			name = L"Talon",
			isEnabled = true,
			playerType = 1,
			offsetY = 2,
			anchorTo = 5,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"champ",
					abilityIds = L"608,3245,3331",
					castedByMe = 1,
					name = L"champion's challenge",
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3245] = true,
						[608] = true,
						[3331] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -45,
			customIcon = 23174,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20002",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Champ",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DB",
					abilityIds = L"610",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[610] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -65,
			customIcon = 23173,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20003",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Distracting Bellow",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"NS",
					abilityIds = L"1444, 20615",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1444] = true,
						[20615] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -20,
			customIcon = 4672,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20004",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Numbing Strike",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DDB",
					abilityIds = L"1756",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1756] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -20,
			customIcon = 2644,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20005",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Drop Da Basha",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0.8,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Ex",
					abilityIds = L"8153",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8153] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = -20,
			customIcon = 7978,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20006",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Excommunicate",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 0.8,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"shadow",
					abilityIds = L"9701,9700",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9701] = true,
						[9700] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 0,
			customIcon = 10997,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20007",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Shadow/Purgatory",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DA",
					abilityIds = L"8302",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8302] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 25,
			customIcon = 7949,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20008",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Divine Aegis",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"AP",
					abilityIds = L"28303",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[28303] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 62,
			customIcon = 20065,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20009",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Absolute Preservation",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"EtW",
					abilityIds = L"8622",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8622] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 5260,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20010",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Embrace the Warp - Gurad",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"GS",
					abilityIds = L"1592",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1592] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 4628,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20011",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Grimnir's Shield - Gurad",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"V",
					abilityIds = L"8034",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8034] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 8097,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20012",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Vigilance - Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"TA",
					abilityIds = L"8372",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8372] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 5213,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20013",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Tzeentch's Amplification",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"CM",
					abilityIds = L"631",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[631] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 23157,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20014",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Confusing Movements",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Concealment",
					abilityIds = L"652",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[652] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 23162,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20015",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Concealment",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Untouchable",
					abilityIds = L"1493",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1493] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 32.5,
			customIcon = 4688,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20016",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Untouchable",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -10,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"Res",
					abilityIds = L"1598,8248,1908,8555,9558,930,4070,9246",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8555] = true,
						[1908] = true,
						[8248] = true,
						[9246] = true,
						[1598] = true,
						[930] = true,
						[4070] = true,
						[9558] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 20456,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20017",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Res",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				true,
			},
			labelScale = 0,
			effectFilters = 
			{
				
				{
					typeMatch = 1,
					filterName = L"IB",
					abilityIds = L"1410, 3166, 3469",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1410] = true,
						[3166] = true,
						[3469] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					type = "isDebuff",
					filterName = L"WH",
					abilityIds = L"3002, 3784, 8099",
					castedByMe = 1,
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[3002] = true,
						[3784] = true,
						[8099] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WL",
					abilityIds = L"9191",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9191] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"BG",
					abilityIds = L"3372",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3372] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					type = "isDebuff",
					filterName = L"WE",
					abilityIds = L"3598, 3811, 6016, 6054, 6055, 9407, 20263",
					castedByMe = 1,
					descriptionMatch = 2,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[6016] = true,
						[3598] = true,
						[9407] = true,
						[20263] = true,
						[6055] = true,
						[3811] = true,
						[6054] = true,
					},
					nameMatch = 1,
					durationType = 1,
				},
			},
			scale = 0.8,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 8,
			logic = L"IB or WH or WL or BG or WE",
			canDispell = 1,
			isCircleIcon = false,
			icon = "heal",
			id = "20018",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = true,
			anchorTo = 5,
			name = L"Outgoing HD 50%",
			color = 
			{
				b = 64,
				g = 255,
				r = 191,
			},
			playerType = 1,
			offsetY = 18,
			anchorFrom = 5,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				
				{
					typeMatch = 1,
					filterName = L"RP",
					abilityIds = L"1633, 3393",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1633] = true,
						[3393] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SL",
					abilityIds = L"1434, 6045, 1501",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[6045] = true,
						[1434] = true,
						[1501] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WP",
					abilityIds = L"2200, 8270",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[2200] = true,
						[8270] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WH",
					abilityIds = L"8112, 20324",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8112] = true,
						[20324] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"AM",
					abilityIds = L"3915, 9247",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3915] = true,
						[9247] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SW",
					abilityIds = L"9109",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9109] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Choppa",
					abilityIds = L"1746, 3292, 20593, 1803",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[20593] = true,
						[1746] = true,
						[3292] = true,
						[1803] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Shaman",
					abilityIds = L"1905, 3352",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1905] = true,
						[3352] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"SH",
					abilityIds = L"1853",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1853] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Mara",
					abilityIds = L"8401",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8401] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Zealot",
					abilityIds = L"3075, 8596",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3075] = true,
						[8596] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"DoK",
					abilityIds = L"32124",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[32124] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"WE",
					abilityIds = L"6026, 9424",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[6026] = true,
						[9424] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.8,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 16,
			logic = L"RP or SL or WP or WH or AM or SW or Choppa or Shaman or SH or Mara or Zealot or DoK or WE",
			canDispell = 1,
			isCircleIcon = false,
			id = "20019",
			icon = "heal",
			alpha = 1,
			archetypeMatch = 1,
			anchorTo = 5,
			isEnabled = true,
			name = L"Incomming HD 50%",
			color = 
			{
				b = 0,
				g = 0,
				r = 255,
			},
			playerType = 1,
			offsetY = 18,
			left = 0,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"1008,1363",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1008] = true,
						[1363] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 4515,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20020",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"IB Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"8013",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8013] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 8078,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20021",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"Kotbs Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"8325",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8325] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 5172,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20022",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"Chosen Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"9008",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9008] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 13373,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20023",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"SM Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"9325",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9325] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 11018,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20024",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"BG Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				true,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"G",
					abilityIds = L"1674",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1674] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.45,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 2558,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			archetypeMatch = 2,
			id = "20025",
			anchorFrom = 5,
			alpha = 1,
			width = 50,
			anchorTo = 5,
			isEnabled = true,
			name = L"BO Guard",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 0,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"DF",
					abilityIds = L"8561",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8561] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 10,
			customIcon = 5240,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20026",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Daemonic Fortitude - Wound",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"PotA",
					abilityIds = L"1606",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[1606] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 10,
			customIcon = 4636,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20027",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Protection of the Ancestors - Wound",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
		
		{
			archetypes = 
			{
				false,
				false,
				false,
			},
			labelScale = 1,
			effectFilters = 
			{
				[1] = 
				{
					typeMatch = 1,
					filterName = L"AoOF",
					abilityIds = L"8501",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[8501] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 10,
			customIcon = 5285,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "20028",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Aegis of Orange Fire - Wound",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = 2,
			exceptMe = false,
			playerTypeMatch = 1,
		},
	},
	groupIconsPetHPBGColor = 
	{
		100,
		0,
		0,
	},
	unitFramesDirection2 = 4,
	guardMarkTemplate = 
	{
		scale = 0.8,
		unique = false,
		firstLetters = 4,
		showCareerIcon = false,
		canClearOnClick = false,
		permanentTargets = 
		{
		},
		id = 1220,
		layer = 3,
		alpha = 1,
		targetOnClick = true,
		color = 
		{
			65,
			150,
			255,
		},
		font = "font_default_text_giant",
		name = L"",
		text = L"G",
		display = 1,
		offsetY = 75,
		neverExpire = true,
		permanent = false,
	},
	groupIconsOtherGroupsHPBGColor = 
	{
		50,
		100,
		100,
	},
	unitFramesSorting = 
	{
		1,
		2,
		3,
	},
	objectWindowsInactiveTimeout = 1200,
	unitFramesGroupsCount1 = 1,
	killSpamEnabled = true,
	groupIconsParts = 
	{
	},
	groupIconsOtherGroupsOffset = 
	{
		0,
		220,
	},
	CombatLogStats = 
	{
		[1] = 
		{
			name = L"Default",
			eps = 
			{
				[4] = 
				{
					valueAoeMaxData = 
					{
						
						{
							overheal = 1038,
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538887,
							crit = false,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
						},
						
						{
							overheal = 439,
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538888,
							crit = false,
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538889,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 172,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538890,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
						},
						
						{
							overheal = 658,
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538891,
							crit = true,
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538892,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 1038,
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
					},
					total = 2651,
					objectTime = 64926538896,
					data = 
					{
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538889,
							value = 0,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							crit = false,
							object = L"you",
						},
						
						{
							overheal = 172,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538890,
							value = 0,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
							crit = true,
							object = L"you",
						},
						
						{
							overheal = 658,
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							time = 64926538891,
							value = 0,
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
							crit = true,
							object = L"you",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538892,
							value = 0,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							crit = false,
							object = L"you",
						},
						
						{
							overheal = 1038,
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							time = 64926538893,
							value = 0,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							crit = false,
							object = L"you",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538893,
							value = 0,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							crit = false,
							object = L"you",
						},
						
						{
							overheal = 165,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538894,
							value = 0,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (165 overhealed)",
							crit = true,
							object = L"you",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538895,
							value = 0,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							crit = false,
							object = L"you",
						},
						
						{
							overheal = 170,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538896,
							value = 0,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (170 overhealed)",
							crit = true,
							object = L"you",
						},
					},
					totalAoe = 2651,
					valueMaxData = 
					{
						
						{
							overheal = 1038,
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538887,
							crit = false,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
						},
						
						{
							overheal = 439,
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538888,
							crit = false,
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538889,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 172,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538890,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
						},
						
						{
							overheal = 658,
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538891,
							crit = true,
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538892,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 1038,
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
					},
					valueAoe = 379,
					valueMax = 614,
					value = 379,
					valueAoeMax = 614,
					object = L"you",
				},
				[3] = 
				{
					total = 2651,
					objectTime = 64926538896,
					data = 
					{
						
						{
							overheal = 112,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538889,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 172,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538890,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
						},
						
						{
							overheal = 658,
							type = 3,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538891,
							crit = true,
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
						},
						
						{
							overheal = 112,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538892,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 1038,
							type = 3,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
						},
						
						{
							overheal = 112,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538893,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 165,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538894,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (165 overhealed)",
						},
						
						{
							overheal = 112,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538895,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 170,
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							time = 64926538896,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (170 overhealed)",
						},
					},
					totalAoe = 0,
					valueMaxData = 
					{
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 3,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538887,
						},
						
						{
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
							type = 3,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 439,
							crit = false,
							time = 64926538888,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538889,
						},
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 172,
							crit = true,
							time = 64926538890,
						},
						
						{
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
							type = 3,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 658,
							crit = true,
							time = 64926538891,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538892,
						},
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 3,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538893,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538893,
						},
					},
					object = L"Ybilla",
					valueMax = 614,
					value = 379,
					valueAoe = 0,
				},
			},
			data = 
			{
				[4] = 
				{
					[L"Divine Mend"] = 
					{
						normal = 
						{
							overheal = 2076,
							total = 0,
							max = 1038,
							min = 1038,
							count = 2,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 0,
							total = 0,
							count = 0,
							abs = 0,
							mit = 0,
						},
						parry = 0,
					},
					[L"Lingering Divine Aid"] = 
					{
						normal = 
						{
							overheal = 448,
							total = 0,
							max = 112,
							min = 112,
							count = 4,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 507,
							total = 0,
							max = 172,
							min = 165,
							count = 3,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						parry = 0,
					},
					[L"Divine Aid"] = 
					{
						normal = 
						{
							overheal = 439,
							total = 0,
							max = 439,
							min = 439,
							count = 1,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 658,
							total = 0,
							max = 658,
							min = 658,
							count = 1,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						parry = 0,
					},
				},
				[3] = 
				{
					[L"Ybilla - Lingering Divine Aid"] = 
					{
						normal = 
						{
							overheal = 448,
							total = 0,
							max = 112,
							min = 112,
							count = 4,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 507,
							total = 0,
							max = 172,
							min = 165,
							count = 3,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						parry = 0,
					},
					[L"Ybilla - Divine Aid"] = 
					{
						normal = 
						{
							overheal = 439,
							total = 0,
							max = 439,
							min = 439,
							count = 1,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 658,
							total = 0,
							max = 658,
							min = 658,
							count = 1,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						parry = 0,
					},
					[L"Ybilla - Divine Mend"] = 
					{
						normal = 
						{
							overheal = 2076,
							total = 0,
							max = 1038,
							min = 1038,
							count = 2,
							abs = 0,
							maxObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
							mit = 0,
							minObject = 
							{
								isNpc = false,
								type = "selffriendlytarget",
								isFriendly = true,
								career = 12,
								id = 116,
								level = 40,
								hp = 100,
								name = L"Ybilla",
							},
						},
						dodge = 0,
						disrupt = 0,
						block = 0,
						crit = 
						{
							overheal = 0,
							total = 0,
							count = 0,
							abs = 0,
							mit = 0,
						},
						parry = 0,
					},
				},
			},
			dt = 
			{
				minutes = 19,
				year = 2019,
				month = 12,
				day = 24,
				hours = 13,
				seconds = 29,
				totalSeconds = 64926537569,
			},
		},
	},
	groupIconsOtherGroupsBGColor = 
	{
		200,
		255,
		255,
	},
	unitFramesGroupsPadding2 = 1,
	talismanAlerterEnabled = false,
	autoAssist = false,
	groupIconsPetHPColor = 
	{
		255,
		225,
		255,
	},
	combatLogIDSTimeframe = 7.5,
	unitFramesHideMyGroup = false,
	groupIconsHPBGColor = 
	{
		0,
		100,
		0,
	},
	stopwatchEnabled = false,
	timerEnabled = true,
	killSpamListBottomUp = false,
	groupIconsScale = 0.7,
	playerKills = 2524,
	combatLogIDSMaxRows = L"5",
	groupIconsPetAlpha = 0.5,
	combatLogTargetDefenseTimeframe = 7.5,
	combatLogTargetDefenseEnabled = false,
	markNewTarget = true,
	unitFramesTooltipMode = "alt",
	unitFramesGroupsDirection1 = 2,
	combatLogEPSTimeframe = 7.5,
	combatLogEPSMaxValueMinTime = 4.5,
	combatLogTargetDefenseTotalBackground = 
	{
		0,
		0,
		0,
	},
	objectWindowsTimeout = 20,
	combatLogIgnoreWhenPolymorphed = true,
	combatLogIDSRowBackground = 
	{
		225,
		50,
		50,
	},
	unitFramesPadding2 = 2,
	combatLogEPSEnabled = 
	{
		false,
		false,
		false,
		false,
	},
	unitFramesLayer = 1,
	groupIconsOtherGroupsScale = 0.6,
	targetShowDelay = 8,
	assistTargetOnNotifyClick = true,
	scenarioInfoReplaceStandardWindow = false,
	lastIntercomName = L"officer",
	unitFramesTestMode = false,
	markTemplates = 
	{
		
		{
			scale = 0.6,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = false,
			canClearOnClick = true,
			permanentTargets = 
			{
			},
			id = 1,
			targetOnClick = false,
			alpha = 1,
			text = L"",
			color = 
			{
				10,
				103,
				163,
			},
			font = "font_clear_large_bold",
			name = L"T",
			layer = 0,
			display = 2,
			offsetY = 180,
			neverExpire = false,
			permanent = false,
		},
		
		{
			scale = 0.45,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = false,
			canClearOnClick = true,
			permanentTargets = 
			{
			},
			id = 2,
			targetOnClick = false,
			alpha = 1,
			text = L"",
			color = 
			{
				255,
				142,
				0,
			},
			font = "font_clear_large_bold",
			name = L"D",
			layer = 0,
			display = 2,
			offsetY = 260,
			neverExpire = false,
			permanent = false,
		},
		
		{
			scale = 0.55,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = false,
			canClearOnClick = true,
			permanentTargets = 
			{
			},
			id = 3,
			targetOnClick = false,
			alpha = 1,
			text = L"",
			color = 
			{
				0,
				178,
				92,
			},
			font = "font_clear_large_bold",
			name = L"H",
			layer = 0,
			display = 2,
			offsetY = 200,
			neverExpire = false,
			permanent = false,
		},
		
		{
			scale = 0.7,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = false,
			canClearOnClick = true,
			permanentTargets = 
			{
			},
			id = 4,
			targetOnClick = false,
			alpha = 1,
			text = L"",
			color = 
			{
				255,
				255,
				0,
			},
			font = "font_clear_large_bold",
			name = L"L",
			layer = 0,
			display = 2,
			offsetY = 145,
			neverExpire = false,
			permanent = false,
		},
		
		{
			scale = 0.7,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = true,
			canClearOnClick = true,
			permanentTargets = 
			{
				[L"Valutzius"] = false,
				[L"Lutziavelli"] = false,
				[L"Brogn"] = false,
				[L"Brogyn"] = false,
				[L"Khaled"] = false,
				[L"Olethros"] = false,
				[L"Highelvesbest"] = false,
				[L"Keraza"] = false,
				[L"Fullsovwb"] = false,
				[L"Brutality"] = false,
				[L"Wamma"] = false,
				[L"Brodda"] = false,
				[L"Arwhin"] = false,
				[L"Burgon"] = false,
				[L"Garamar"] = false,
				[L"Chopling"] = false,
				[L"Smellz"] = false,
				[L"Kalervo"] = false,
				[L"Openose"] = false,
				[L"Notcluclu"] = false,
				[L"Veretta"] = false,
				[L"Puppychoppa"] = false,
				[L"Zorbastank"] = false,
				[L"Fastarhymes"] = false,
				[L"Xrealming"] = false,
				[L"Huurl"] = false,
				[L"Grufrip"] = false,
				[L"Deprivation"] = false,
				[L"Perdutoi"] = false,
				[L"Brogun"] = false,
				[L"Lutzgaroth"] = false,
				[L"Ailune"] = false,
				[L"Choppalin"] = false,
			},
			id = 5,
			targetOnClick = true,
			alpha = 1,
			text = L"",
			color = 
			{
				255,
				1,
				1,
			},
			font = "font_heading_huge_no_shadow",
			name = L"WD",
			layer = 0,
			display = 2,
			offsetY = 220,
			neverExpire = false,
			permanent = true,
		},
		
		{
			scale = 0.7,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = true,
			canClearOnClick = true,
			permanentTargets = 
			{
				[L"Knutbiter"] = false,
				[L"Hellogigi"] = false,
				[L"Bitterbreaker"] = false,
				[L"Lutzenberg"] = false,
				[L"Elvicino"] = false,
				[L"Zunig"] = false,
				[L"Troma"] = false,
				[L"Rolgrom"] = false,
				[L"Evilspinnray"] = false,
				[L"Lesti"] = false,
				[L"Trippie"] = false,
				[L"Kaliwyn"] = false,
				[L"Trippiaim"] = false,
				[L"Arwwhin"] = false,
				[L"Lutzgarath"] = false,
				[L"Rathra"] = false,
				[L"Puppyslayer"] = false,
				[L"Cluclu"] = false,
				[L"Ibal"] = false,
				[L"Broppee"] = false,
				[L"Xbrodda"] = false,
				[L"Grafferwl"] = false,
				[L"Samson"] = false,
				[L"Atticus"] = false,
				[L"Wam"] = false,
				[L"Iba"] = false,
				[L"Clycly"] = false,
				[L"Knutkrusher"] = false,
			},
			id = 6,
			targetOnClick = true,
			alpha = 1,
			text = L"",
			color = 
			{
				0,
				0,
				255,
			},
			font = "font_heading_huge_no_shadow",
			name = L"WO",
			layer = 0,
			display = 2,
			offsetY = 220,
			neverExpire = false,
			permanent = true,
		},
		
		{
			scale = 0.5,
			unique = false,
			firstLetters = L"4",
			showCareerIcon = true,
			canClearOnClick = true,
			permanentTargets = 
			{
				[L"Ugorth"] = false,
				[L"Celiana"] = false,
				[L"Dolphlundgren"] = false,
				[L"Whazuup"] = false,
				[L"Yvasishiir"] = false,
				[L"Ffs"] = false,
				[L"Teinhala"] = false,
				[L"Zedzaa"] = false,
				[L"Okpoxa"] = false,
				[L"Hyronen"] = false,
				[L"Roelan"] = false,
				[L"Choppeur"] = false,
				[L"Gloom"] = false,
				[L"Syrna"] = false,
				[L"Wamba"] = false,
				[L"Scaurge"] = false,
				[L"Elaira"] = false,
				[L"Teefz"] = false,
				[L"Msa"] = false,
				[L"Winona"] = false,
				[L"Behemot"] = false,
				[L"Themadchoppa"] = false,
				[L"Bambee"] = false,
				[L"Qep"] = false,
				[L"Tormentor"] = false,
				[L"Nashdragonn"] = false,
				[L"Salao"] = false,
				[L"Bomg"] = false,
				[L"Mesger"] = false,
				[L"Ragondin"] = false,
				[L"Blackmattt"] = false,
				[L"Pokkitz"] = false,
				[L"Arvar"] = false,
				[L"Grzegorz"] = false,
				[L"Cla"] = false,
				[L"Gaijin"] = false,
				[L"Kykyxa"] = false,
				[L"Hirzodrin"] = false,
				[L"Nervensaege"] = false,
				[L"Tosate"] = false,
				[L"Cature"] = false,
				[L"Lllaraa"] = false,
				[L"Azeyune"] = false,
				[L"Kodiak"] = false,
				[L"Shannyn"] = false,
				[L"Fluffyplatypus"] = false,
				[L"Alienist"] = false,
				[L"Zuglub"] = false,
				[L"Msalaba"] = false,
				[L"Viscerya"] = false,
				[L"Puppychoppa"] = false,
				[L"Neurontin"] = false,
				[L"Aradonna"] = false,
				[L"Xburnx"] = false,
				[L"Nod"] = false,
				[L"Theoddone"] = false,
				[L"Llaraa"] = false,
				[L"Xergom"] = false,
				[L"Coldlara"] = false,
				[L"Gitrate"] = false,
				[L"Bejkon"] = false,
				[L"Hotlara"] = false,
			},
			id = 7,
			targetOnClick = true,
			alpha = 1,
			text = L"",
			color = 
			{
				1,
				1,
				1,
			},
			font = "font_clear_large_bold",
			name = L"Nerd",
			layer = 0,
			display = 2,
			offsetY = 230,
			neverExpire = false,
			permanent = true,
		},
	},
	groupIconsAlpha = 0.5,
	unitFramesEnabled = true,
	unitFramesSize = 
	{
		150,
		57,
	},
	guardDistanceIndicatorScaleWarning = 1.5,
	unitFramesSortingEnabled = true,
	timerInactiveColor = 
	{
		255,
		255,
		255,
	},
	groupIconsOtherGroupsHPColor = 
	{
		200,
		255,
		255,
	},
	stateMachineThrottle = 0.3,
	groupIconsPetBGAlpha = 0.5,
	unitFramesMyGroupFirst = true,
	unitFramesScale = 1,
	combatLogEnabled = false,
	soundOnNewTargetId = 500,
	guardDistanceIndicator = 2,
	timerActiveColor = 
	{
		255,
		1,
		25,
	},
	scenarioInfoData = 
	{
		maxTimer = 120,
		startingScenario = 0,
		destructionPoints = 3,
		id = 2004,
		queuedWithGroup = false,
		activeQueue = 0,
		orderPoints = 500,
		mode = 2,
		pointMax = 500,
		timeLeft = 119.96697520092,
	},
	combatLogTargetDefenseScale = 1,
	guardDistanceIndicatorClickThrough = false,
	groupIconsTargetOnClick = false,
	chatThrottleDelay = 10,
	combatLogIDSEnabled = false,
	scenarioInfoSelection = 
	{
		
		{
			sortColumn = "value1",
			columns = 
			{
				"db",
				"deaths",
			},
			sortDirection = false,
			id2 = "1",
			id = "All",
		},
		
		{
			sortColumn = "value1",
			columns = 
			{
				"db",
				"deaths",
			},
			sortDirection = false,
			id2 = "2",
			id = "All",
		},
	},
	combatLogLogParseErrors = false,
	unitFramesIsVertical = false,
	version = 279,
	guardDistanceIndicatorScaleNormal = 1,
	guardDistanceIndicatorAnimation = true,
	intercomPrivate = true,
	playerDeaths = 1468,
	guardEnabled = false,
	groupIconsShowOnMarkedPlayers = false,
	killSpamReparseChunkSize = 20,
	groupIconsHPColor = 
	{
		200,
		255,
		0,
	},
	groupIconsOtherGroupsLayer = 0,
	chatDelay = 2,
	combatLogStatisticsEnabled = false,
	combatLogIDSRowSize = 
	{
		250,
		30,
	},
	guardDistanceIndicatorAlphaWarning = 1,
	unitFramesParts = 
	{
		
		{
			archetypeMatch = 1,
			id = "19914",
			data = 
			{
				offlineHide = true,
				anchorTo = "center",
				color = 
				{
					200,
					200,
					0,
				},
				layer = 0,
				alpha = 1,
				pos = 
				{
					0,
					0,
				},
				deadHide = false,
				anchorFrom = "center",
				vertical = false,
				scale = 1,
				distHide = false,
				size = 
				{
					156,
					65,
				},
				texture = "rect",
			},
			exceptMe = false,
			name = L"Selection",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "selectionFrame",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19915",
			data = 
			{
				offlineColor = 
				{
					150,
					150,
					150,
				},
				anchorTo = "center",
				color = 
				{
					255,
					255,
					255,
				},
				deadAlpha = 0.9,
				anchorFrom = "center",
				vertical = false,
				distHide = false,
				texture = "default",
				distColor = 
				{
					255,
					255,
					255,
				},
				distAlpha = 0.2,
				deadColor = 
				{
					250,
					20,
					20,
				},
				layer = 0,
				alpha = 1,
				deadHide = false,
				textureFullResize = false,
				size = 
				{
					150,
					57,
				},
				offlineHide = true,
				scale = 1,
				pos = 
				{
					0,
					0,
				},
			},
			exceptMe = false,
			name = L"Background",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "panel",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19916",
			data = 
			{
				anchorTo = "right",
				color = 
				{
					30,
					30,
					30,
				},
				anchorFrom = "left",
				vertical = false,
				distHide = false,
				texture = "default",
				healColor = 
				{
					45,
					50,
					80,
				},
				distColor = 
				{
					0,
					0,
					0,
				},
				distAlpha = 0.4,
				textureFullResize = false,
				layer = 1,
				alpha = 1,
				scale = 1,
				deadHide = true,
				dpsColor = 
				{
					66,
					71,
					105,
				},
				wrap = false,
				tankColor = 
				{
					112,
					119,
					161,
				},
				size = 
				{
					150,
					57,
				},
				offlineHide = false,
				pos = 
				{
					-150,
					0,
				},
			},
			exceptMe = false,
			name = L"HP",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "hpbar",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19917",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					255,
					255,
				},
				anchorFrom = "bottomleft",
				vertical = false,
				distHide = false,
				size = 
				{
					28,
					28,
				},
				offlineHide = false,
				distAlpha = 1,
				textureFullResize = true,
				wrap = false,
				alpha = 1,
				maxLength = 10,
				layer = 4,
				deadHide = false,
				scale = 1,
				texture = "aluminium",
				distColor = 
				{
					190,
					225,
					255,
				},
				align = "bottomleft",
				font = "font_clear_small_bold",
				pos = 
				{
					0,
					0,
				},
			},
			exceptMe = false,
			name = L"Icon",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "careerIcon",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19918",
			data = 
			{
				color22 = 
				{
					255,
					255,
					255,
				},
				color24 = 
				{
					255,
					255,
					255,
				},
				color6 = 
				{
					255,
					255,
					255,
				},
				color23 = 
				{
					255,
					255,
					255,
				},
				anchorFrom = "topleft",
				color12 = 
				{
					255,
					255,
					255,
				},
				color11 = 
				{
					255,
					255,
					255,
				},
				distHide = false,
				size = 
				{
					150,
					8,
				},
				healColor = 
				{
					0,
					178,
					92,
				},
				color14 = 
				{
					255,
					255,
					255,
				},
				align = "bottomleft",
				wrap = false,
				color2 = 
				{
					255,
					255,
					255,
				},
				color21 = 
				{
					255,
					255,
					255,
				},
				color9 = 
				{
					255,
					255,
					255,
				},
				pos = 
				{
					0,
					50,
				},
				scale = 1,
				color15 = 
				{
					255,
					255,
					255,
				},
				color10 = 
				{
					255,
					255,
					255,
				},
				color13 = 
				{
					255,
					255,
					255,
				},
				color20 = 
				{
					255,
					255,
					255,
				},
				color18 = 
				{
					255,
					255,
					255,
				},
				texture = "bantobar",
				vertical = false,
				color4 = 
				{
					255,
					255,
					255,
				},
				color3 = 
				{
					255,
					255,
					255,
				},
				color16 = 
				{
					255,
					255,
					255,
				},
				color8 = 
				{
					255,
					255,
					255,
				},
				offlineHide = true,
				color7 = 
				{
					255,
					255,
					255,
				},
				color17 = 
				{
					255,
					255,
					255,
				},
				tankColor = 
				{
					10,
					103,
					164,
				},
				color19 = 
				{
					255,
					255,
					255,
				},
				distAlpha = 1,
				textureFullResize = false,
				layer = 1,
				alpha = 1,
				maxLength = 10,
				color1 = 
				{
					255,
					255,
					255,
				},
				distColor = 
				{
					190,
					225,
					255,
				},
				dpsColor = 
				{
					255,
					142,
					0,
				},
				deadHide = true,
				color = 
				{
					255,
					255,
					255,
				},
				anchorTo = "topleft",
				color5 = 
				{
					255,
					255,
					255,
				},
				font = "font_clear_small_bold",
			},
			exceptMe = false,
			name = L"classhp",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "hpacbar",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19919",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					255,
					0,
				},
				farValue = 151,
				anchorFrom = "bottomleft",
				vertical = false,
				prefix = L"",
				suffix = L"",
				distHide = false,
				texture = "3dots",
				offlineHide = true,
				layer = 4,
				distAlpha = 0.5,
				align = "center",
				wrap = false,
				alpha = 1,
				maxLength = 10,
				deadHide = true,
				font = "font_clear_medium_bold",
				textureFullResize = false,
				size = 
				{
					30,
					30,
				},
				farText = L"FAR",
				scale = 1.15,
				distColor = 
				{
					190,
					225,
					255,
				},
				pos = 
				{
					-9,
					-4,
				},
			},
			exceptMe = false,
			name = L"Morale",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "moraleText",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19920",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					220,
					100,
				},
				anchorFrom = "bottomleft",
				vertical = false,
				distHide = false,
				size = 
				{
					128,
					3,
				},
				offlineHide = true,
				distAlpha = 0.5,
				textureFullResize = true,
				layer = 2,
				alpha = 1,
				deadHide = true,
				font = "font_clear_small_bold",
				scale = 1,
				texture = "plain",
				align = "center",
				pos = 
				{
					35,
					0,
				},
			},
			exceptMe = false,
			name = L"AP",
			playerType = 3,
			isEnabled = false,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "apbar",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19921",
			data = 
			{
				anchorTo = "bottomleft",
				scale = 0.8,
				layer = 2,
				anchorFrom = "bottomleft",
				pos = 
				{
					12,
					5,
				},
				vertical = false,
				size = 
				{
					30,
					20,
				},
				align = "center",
				font = "font_clear_small_bold",
				color = 
				{
					255,
					255,
					255,
				},
				alpha = 1,
				texture = "aluminium",
			},
			exceptMe = false,
			name = L"Level",
			playerType = 1,
			isEnabled = false,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "levelText",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19922",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					255,
					0,
				},
				anchorFrom = "bottomleft",
				vertical = false,
				prefix = L"M ",
				suffix = L"",
				distHide = false,
				size = 
				{
					12,
					12,
				},
				distColor = 
				{
					255,
					255,
					0,
				},
				distAlpha = 1,
				align = "bottomleft",
				wrap = false,
				alpha = 1,
				maxLength = 10,
				textureFullResize = true,
				deadHide = false,
				texture = "star",
				scale = 1,
				offlineHide = false,
				font = "font_clear_small_bold",
				layer = 4,
				pos = 
				{
					17,
					-12,
				},
			},
			exceptMe = false,
			name = L"Leader",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "groupLeaderIcon",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19923",
			data = 
			{
				anchorTo = "bottomleft",
				scale = 0.8,
				farValue = 151,
				anchorFrom = "bottomleft",
				vertical = false,
				prefix = L"M ",
				suffix = L"",
				distHide = false,
				size = 
				{
					50,
					30,
				},
				distColor = 
				{
					190,
					225,
					255,
				},
				farText = L"FAR",
				distAlpha = 0.5,
				align = "bottomleft",
				layer = 4,
				alpha = 1,
				maxLength = 4,
				color = 
				{
					255,
					255,
					255,
				},
				deadHide = false,
				wrap = false,
				offlineHide = false,
				texture = "aluminium",
				font = "font_clear_default",
				textureFullResize = false,
				pos = 
				{
					1,
					0,
				},
			},
			exceptMe = false,
			name = L"Name",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "nameText",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19924",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					255,
					250,
				},
				farValue = 151,
				anchorFrom = "bottomleft",
				level2 = 100,
				prefix = L"",
				suffix = L"",
				distHide = false,
				texture = "aluminium",
				size = 
				{
					30,
					30,
				},
				scale = 0.85,
				offlineHide = true,
				textureFullResize = false,
				deadHide = true,
				align = "right",
				layer = 4,
				alpha = 1,
				color1 = 
				{
					255,
					150,
					50,
				},
				color2 = 
				{
					255,
					50,
					50,
				},
				font = "font_clear_small_bold",
				color3 = 
				{
					255,
					50,
					50,
				},
				farText = L"",
				level3 = 150,
				level1 = 65,
				vertical = false,
				pos = 
				{
					30,
					12,
				},
			},
			exceptMe = true,
			name = L"Distance",
			playerType = 1,
			isEnabled = true,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "distanceText",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19925",
			data = 
			{
				anchorTo = "topright",
				color = 
				{
					190,
					255,
					50,
				},
				level1 = 65,
				anchorFrom = "topright",
				vertical = false,
				prefix = L"",
				suffix = L"%",
				distHide = false,
				texture = "4dots",
				offlineHide = true,
				level2 = 100,
				align = "rightcenter",
				textureFullResize = false,
				layer = 2,
				alpha = 1,
				color1 = 
				{
					255,
					150,
					50,
				},
				color2 = 
				{
					255,
					50,
					50,
				},
				deadHide = true,
				color3 = 
				{
					255,
					50,
					50,
				},
				size = 
				{
					40,
					10,
				},
				level3 = 150,
				scale = 1,
				font = "font_clear_small_bold",
				pos = 
				{
					-3,
					4,
				},
			},
			exceptMe = false,
			name = L"Distance bar",
			playerType = 1,
			isEnabled = false,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "distanceBar",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "19926",
			data = 
			{
				anchorTo = "right",
				color = 
				{
					255,
					255,
					255,
				},
				anchorFrom = "right",
				vertical = false,
				prefix = L"",
				suffix = L"%",
				distHide = false,
				size = 
				{
					50,
					30,
				},
				offlineHide = true,
				textureFullResize = false,
				layer = 2,
				alpha = 1,
				deadHide = true,
				scale = 0.7,
				texture = "3dots",
				align = "rightcenter",
				font = "font_clear_small_bold",
				pos = 
				{
					-3,
					1,
				},
			},
			exceptMe = false,
			name = L"HP %",
			playerType = 1,
			isEnabled = false,
			archetypes = 
			{
				false,
				false,
				false,
			},
			type = "hppText",
			playerTypeMatch = 1,
		},
	},
	unitFramesPadding1 = 0,
	guardDistanceIndicatorColorWarning = 
	{
		255,
		50,
		50,
	},
	scenarioAlerterEnabled = false,
	groupIconsOtherGroupsBGAlpha = 0.5,
	playerKDRDisplayMode = 5,
	groupIconsShowOtherGroups = false,
	groupIconsHideOnSelf = true,
	guardDistanceIndicatorColorNormal = 
	{
		127,
		181,
		255,
	},
	combatLogIDSRowScale = 1,
	unitFramesCount1 = 1,
	combatLogEPSShow = 
	{
		false,
		false,
		false,
		false,
	},
	scenarioInfoPlayers = 
	{
		
		{
			deaths = 1,
			renown = 2157,
			healing = 2923,
			soloKills = 3530,
			realm = 2,
			kills = 1,
			name = L"Madwok",
			career = 6,
			db = 0,
			level = 40,
			exp = 39619,
			damage = 30020,
		},
		
		{
			deaths = 0,
			renown = 3916,
			healing = 43570,
			soloKills = 27883,
			realm = 1,
			kills = 2,
			name = L"Fiskgjuse",
			career = 3,
			db = 0,
			level = 40,
			exp = 79297,
			damage = 1600,
		},
		
		{
			deaths = 1,
			renown = 2046,
			healing = 4392,
			soloKills = 375,
			realm = 2,
			kills = 1,
			name = L"Chopplin",
			career = 6,
			db = 1,
			level = 40,
			exp = 39619,
			damage = 22977,
		},
		
		{
			deaths = 1,
			renown = 4236,
			healing = 0,
			soloKills = 0,
			realm = 1,
			kills = 2,
			name = L"Hican",
			career = 9,
			db = 2,
			level = 40,
			exp = 79297,
			damage = 24548,
		},
	},
	groupIconsLayer = 0,
	talismanAlerterDisplayMode = 2,
	groupIconsPetBGColor = 
	{
		255,
		225,
		255,
	},
	unitFramesGroupsPadding1 = 13,
	scenarioInfoEnabled = false,
	combatLogTargetDefenseBackground = 
	{
		0,
		0,
		0,
	},
	groupIconsPetOffset = 
	{
		0,
		20,
	},
	newTargetMarkTemplate = 
	{
		color = 
		{
			20,
			250,
			250,
		},
		unique = false,
		firstLetters = 4,
		showCareerIcon = true,
		canClearOnClick = true,
		permanentTargets = 
		{
		},
		id = 1218,
		layer = 3,
		alpha = 1,
		scale = 1,
		text = L"Stay Away",
		font = "font_clear_large_bold",
		name = L"Watchout",
		targetOnClick = true,
		display = 1,
		offsetY = 50,
		neverExpire = false,
		permanent = false,
	},
	combatLogIgnoreNpc = false,
	unitFramesGroupsDirection2 = 2,
	guardDistanceIndicatorMovable = true,
}



