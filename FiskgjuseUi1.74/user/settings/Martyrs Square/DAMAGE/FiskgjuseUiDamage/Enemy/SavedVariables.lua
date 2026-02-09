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
	unitFramesDirection1 = 2,
	groupIconsPetScale = 0.8,
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
	unitFramesDetachMyGroup = true,
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
			id = "33835",
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
			id = "33836",
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
			id = "33837",
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
			id = "33838",
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
			id = "33839",
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
			id = "33840",
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
			id = "33841",
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
			id = "33842",
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
			id = "33843",
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
			id = "33844",
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
			id = "33845",
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
						[653] = true,
						[695] = true,
						[674] = true,
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
			id = "33846",
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
			id = "33847",
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
			id = "33848",
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
			id = "33849",
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
			id = "33850",
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
			id = "33851",
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
			id = "33852",
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
			id = "33853",
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
			offsetX = 0,
			customIcon = 10908,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33854",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 8,
			isEnabled = true,
			name = L"Improved Word of Pain f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 8015,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33855",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 8,
			anchorTo = 8,
			isEnabled = true,
			name = L"Improved Boiling Blood f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
						[653] = true,
						[695] = true,
						[674] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
			},
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 23153,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33856",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"Focused Mind f",
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
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 13,
			customIcon = 20065,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33857",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"Absolute Preservation",
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
			offsetX = 0,
			customIcon = 23152,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33858",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"Divine Protection",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
			isTimer = true,
			ticked = 0,
			offsetX = 0,
			customIcon = 10965,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33859",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"1001 Dark Blessings f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
			isTimer = true,
			ticked = 0,
			offsetX = 0,
			customIcon = 8042,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33860",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"Gift of Life f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
			isTimer = true,
			ticked = 0,
			offsetX = 0,
			customIcon = 23175,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33861",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 2,
			anchorTo = 2,
			isEnabled = true,
			name = L"Immaculate Defense f",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 1,
			offsetY = -16,
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
					filterName = L"RP",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"1607, 3305, 20477, 20478",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[1607] = true,
						[3305] = true,
						[20478] = true,
						[20477] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
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
						[3754] = true,
						[20516] = true,
						[20517] = true,
						[8256] = true,
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
						[20457] = true,
						[20456] = true,
						[8607] = true,
						[8565] = true,
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
			scale = 0.3,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 8037,
			logic = L"RP or BW or WP or WH or AM or SW or WL or BO or Sham or SH or Chosen or Zeal or DOK or Sorc or WE",
			canDispell = 1,
			isCircleIcon = true,
			icon = "other",
			id = "33862",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = true,
			anchorTo = 5,
			name = L"Silence",
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
				
				{
					durationType = 1,
					filterName = L"Kotbs",
					descriptionMatch = 2,
					castedByMe = 1,
					abilityIds = L"8018, 20250",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[8018] = true,
						[20250] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
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
					abilityIds = L"3565,9108, 20404",
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
			scale = 0.3,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 2528,
			logic = L"Kotbs or IB or SM or SW or WL or BW or Engi or SL or WH or Chosen or Mag or Mara or BO or CH or SH or BG or WE",
			canDispell = 1,
			isCircleIcon = true,
			icon = "other",
			id = "33863",
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
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 4593,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33864",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 5,
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
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			icon = "stagger",
			canDispell = 1,
			isCircleIcon = false,
			id = "33865",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
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
			scale = 0.3,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			customIcon = 23169,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33866",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 5,
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
			labelScale = 1,
			anchorTo = 5,
			scale = 1,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			logic = L"Bw or Sorc",
			canDispell = 1,
			archetypeMatch = 1,
			id = "33867",
			alpha = 1,
			icon = "dot",
			left = 0,
			effectFilters = 
			{
				
				{
					typeMatch = 1,
					filterName = L"Bw",
					abilityIds = L"3629,8161,23015",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3629] = true,
						[8161] = true,
						[23015] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Sorc",
					abilityIds = L"3503,9473",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3503] = true,
						[9473] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			name = L"Buffs2",
			isEnabled = true,
			playerType = 3,
			offsetY = 21,
			color = 
			{
				b = 0,
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
					abilityIds = L"3746, 8551, 8617, 3748, 8560, 8619, 20458, 3747, 8556, 8618, 3038, 3773, 8567, 8620, 1591, 3670, 20476, 1588, 1600, 3570, 1608, 3650, 3671, 8269, 9248, 1910, 20415",
					durationMax = 5,
					hasDurationLimit = false,
					abilityIdsHash = 
					{
						[8560] = true,
						[1608] = true,
						[3670] = true,
						[3746] = true,
						[3748] = true,
						[3671] = true,
						[20458] = true,
						[8617] = true,
						[3570] = true,
						[1910] = true,
						[8269] = true,
						[8618] = true,
						[1588] = true,
						[20415] = true,
						[1600] = true,
						[1591] = true,
						[20476] = true,
						[3650] = true,
						[3747] = true,
						[8620] = true,
						[9248] = true,
						[3038] = true,
						[8551] = true,
						[3773] = true,
						[8567] = true,
						[8619] = true,
						[8556] = true,
					},
					nameMatch = 1,
					typeMatch = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Bw",
					abilityIds = L"3633,8164",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3633] = true,
						[8164] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					filterName = L"Sorc",
					abilityIds = L"9476",
					castedByMe = 2,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[9476] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 1.1,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = -5,
			customIcon = 8042,
			logic = L"Buff or Bw or Sorc",
			canDispell = 1,
			isCircleIcon = false,
			icon = "dot",
			id = "33868",
			archetypeMatch = 1,
			alpha = 1,
			exceptMe = false,
			isEnabled = true,
			anchorTo = 5,
			name = L"Buffs",
			color = 
			{
				b = 0,
				g = 0,
				r = 255,
			},
			playerType = 3,
			offsetY = 20,
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
			offsetX = 0,
			customIcon = 13325,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33869",
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
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 5308,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33870",
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
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 5196,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33871",
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
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 13445,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33872",
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
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 11047,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33873",
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
			offsetY = -16,
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
			offsetX = 0,
			customIcon = 8093,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33874",
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
			offsetY = -16,
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
			anchorTo = 8,
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			customIcon = 23172,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33875",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Demo",
			isEnabled = true,
			playerType = 1,
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
			color = 
			{
				b = 255,
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
				false,
			},
			labelScale = 1,
			anchorTo = 8,
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			customIcon = 4621,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33876",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Csmash",
			isEnabled = true,
			playerType = 3,
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
			color = 
			{
				b = 255,
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
				false,
			},
			labelScale = 1,
			anchorTo = 8,
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			customIcon = 5118,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33877",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 8,
			exceptMe = false,
			name = L"Talon",
			isEnabled = true,
			playerType = 1,
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
			color = 
			{
				b = 255,
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
			scale = 0.5,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 70,
			customIcon = 23173,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33878",
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
			anchorTo = 9,
			scale = 0.4,
			left = 0,
			isTimer = true,
			ticked = 0,
			customIcon = 23174,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33879",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 9,
			exceptMe = false,
			name = L"Champ",
			isEnabled = true,
			playerType = 1,
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
			color = 
			{
				b = 255,
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
				false,
			},
			labelScale = 1,
			anchorTo = 9,
			scale = 0.4,
			left = 0,
			isTimer = true,
			ticked = 0,
			customIcon = 7978,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33880",
			alpha = 1,
			archetypeMatch = 1,
			anchorFrom = 9,
			exceptMe = false,
			name = L"Excommunicate",
			isEnabled = true,
			playerType = 1,
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
			color = 
			{
				b = 255,
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
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 25,
			customIcon = 4672,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33881",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 6,
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
			offsetY = -13,
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
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 25,
			customIcon = 2644,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33882",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 6,
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
			offsetY = -13,
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
			isTimer = true,
			ticked = 0,
			offsetX = -15,
			customIcon = 8097,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33883",
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
			offsetY = -16,
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
			isTimer = true,
			ticked = 0,
			offsetX = -15,
			customIcon = 5260,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33884",
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
			offsetY = -16,
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
			isTimer = true,
			ticked = 0,
			offsetX = -15,
			customIcon = 4628,
			icon = "other",
			canDispell = 1,
			isCircleIcon = false,
			id = "33885",
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
			offsetY = -16,
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
			scale = 0.6,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = 45,
			icon = "FiskgjuseUiGuard",
			canDispell = 1,
			isCircleIcon = false,
			id = "33886",
			archetypeMatch = 2,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Other guard f",
			color = 
			{
				b = 255,
				g = 181,
				r = 127,
			},
			playerType = 3,
			offsetY = -16,
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
			labelScale = 0.9,
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
			scale = 0.4,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 85,
			customIcon = 5007,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33887",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
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
			offsetY = 13,
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
			labelScale = 0.9,
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
			scale = 0.4,
			left = 0,
			isTimer = true,
			ticked = 0,
			offsetX = 55,
			customIcon = 5006,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33888",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
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
			offsetY = 13,
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
			anchorTo = 5,
			scale = 0.7,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 8,
			logic = L"IB or WH or WL or BG or WE",
			canDispell = 1,
			archetypeMatch = 1,
			id = "33889",
			alpha = 1,
			icon = "heal",
			left = 0,
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
					abilityIds = L"3372, 9317",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[3372] = true,
						[9317] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
				
				{
					typeMatch = 1,
					castedByMe = 1,
					abilityIds = L"3598, 3811, 6016, 6054, 6055, 9407, 20263",
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
					filterName = L"WE",
					hasDurationLimit = false,
					type = "isDebuff",
				},
			},
			name = L"Outgoing HD 50%",
			isEnabled = true,
			playerType = 3,
			offsetY = 16,
			color = 
			{
				b = 56,
				g = 255,
				r = 181,
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
			anchorTo = 5,
			scale = 0.7,
			anchorFrom = 5,
			isTimer = false,
			ticked = 0,
			offsetX = 0,
			logic = L"RP or SL or WP or WH or AM or SW or Choppa or Shaman or SH or Mara or Zealot or DoK or WE",
			canDispell = 1,
			archetypeMatch = 1,
			id = "33890",
			alpha = 1,
			icon = "heal",
			left = 0,
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
					durationType = 1,
					castedByMe = 1,
					abilityIds = L"3915, 9247",
					descriptionMatch = 2,
					abilityIdsHash = 
					{
						[3915] = true,
						[9247] = true,
					},
					filterName = L"AM",
					hasDurationLimit = false,
					typeMatch = 1,
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
			name = L"Incomming HD 50%",
			isEnabled = true,
			playerType = 3,
			offsetY = 16,
			color = 
			{
				b = 0,
				g = 0,
				r = 255,
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
					typeMatch = 1,
					filterName = L"Charge",
					abilityIds = L"240,1440,1752,2997,2999,9184",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[240] = true,
						[1440] = true,
						[1752] = true,
						[9184] = true,
						[2999] = true,
						[2997] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -55,
			customIcon = 101,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33891",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Charge!",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = 13,
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
					filterName = L"SnareImmune",
					abilityIds = L"242,1377,1445,1740,1757,8019,8095,8258,8330,8408,9016,9173,9330,9395,9570",
					castedByMe = 1,
					descriptionMatch = 2,
					nameMatch = 1,
					abilityIdsHash = 
					{
						[242] = true,
						[9016] = true,
						[8330] = true,
						[1377] = true,
						[9395] = true,
						[1445] = true,
						[9570] = true,
						[9330] = true,
						[1757] = true,
						[8095] = true,
						[8408] = true,
						[9173] = true,
						[8258] = true,
						[8019] = true,
						[1740] = true,
					},
					hasDurationLimit = false,
					durationType = 1,
				},
			},
			scale = 0.4,
			left = 0,
			isTimer = false,
			ticked = 0,
			offsetX = -55,
			customIcon = 32,
			icon = "other",
			canDispell = 1,
			isCircleIcon = true,
			id = "33892",
			archetypeMatch = 1,
			alpha = 1,
			anchorFrom = 5,
			anchorTo = 5,
			isEnabled = true,
			name = L"Snare Immune",
			color = 
			{
				b = 255,
				g = 255,
				r = 255,
			},
			playerType = 3,
			offsetY = -13,
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
	unitFramesDirection2 = 3,
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
		id = 10,
		text = L"G",
		alpha = 1,
		layer = 3,
		color = 
		{
			65,
			150,
			255,
		},
		font = "font_default_text_giant",
		name = L"",
		targetOnClick = true,
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
	unitFramesGroupsCount1 = 6,
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
							abs = 0,
							min = 1038,
							count = 2,
							max = 1038,
							mit = 0,
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
							abs = 0,
							min = 112,
							count = 4,
							max = 112,
							mit = 0,
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
							abs = 0,
							min = 165,
							count = 3,
							max = 172,
							mit = 0,
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
							abs = 0,
							min = 439,
							count = 1,
							max = 439,
							mit = 0,
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
							abs = 0,
							min = 658,
							count = 1,
							max = 658,
							mit = 0,
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
							abs = 0,
							min = 112,
							count = 4,
							max = 112,
							mit = 0,
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
							abs = 0,
							min = 165,
							count = 3,
							max = 172,
							mit = 0,
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
							abs = 0,
							min = 439,
							count = 1,
							max = 439,
							mit = 0,
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
							abs = 0,
							min = 658,
							count = 1,
							max = 658,
							mit = 0,
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
							abs = 0,
							min = 1038,
							count = 2,
							max = 1038,
							mit = 0,
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
			eps = 
			{
				[4] = 
				{
					valueAoeMaxData = 
					{
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538887,
						},
						
						{
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 439,
							crit = false,
							time = 64926538888,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538889,
						},
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 172,
							crit = true,
							time = 64926538890,
						},
						
						{
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 658,
							crit = true,
							time = 64926538891,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538892,
						},
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538893,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538893,
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
						
						{
							overheal = 165,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538894,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (165 overhealed)",
						},
						
						{
							overheal = 112,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538895,
							crit = false,
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
						},
						
						{
							overheal = 170,
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							time = 64926538896,
							crit = true,
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (170 overhealed)",
						},
					},
					totalAoe = 2651,
					valueMaxData = 
					{
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538887,
						},
						
						{
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 439,
							crit = false,
							time = 64926538888,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538889,
						},
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 172,
							crit = true,
							time = 64926538890,
						},
						
						{
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
							type = 4,
							ability = L"Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 658,
							crit = true,
							time = 64926538891,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538892,
						},
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 4,
							ability = L"Divine Mend",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 1038,
							crit = false,
							time = 64926538893,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 4,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"you",
							value = 0,
							overheal = 112,
							crit = false,
							time = 64926538893,
						},
					},
					valueAoe = 379,
					valueMax = 614,
					value = 379,
					object = L"you",
					valueAoeMax = 614,
				},
				[3] = 
				{
					total = 2651,
					objectTime = 64926538896,
					data = 
					{
						
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
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (165 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 165,
							crit = true,
							time = 64926538894,
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
							time = 64926538895,
						},
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (170 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							object = L"Ybilla",
							value = 0,
							overheal = 170,
							crit = true,
							time = 64926538896,
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
							time = 64926538887,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 1038,
						},
						
						{
							str = L"Your Divine Aid heals you for 0 points. (439 overhealed)",
							type = 3,
							ability = L"Divine Aid",
							currentTarget = true,
							time = 64926538888,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 439,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538889,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 112,
						},
						
						{
							str = L"Your Lingering Divine Aid critically heals you for 0 points. (172 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538890,
							value = 0,
							object = L"Ybilla",
							crit = true,
							overheal = 172,
						},
						
						{
							str = L"Your Divine Aid critically heals you for 0 points. (658 overhealed)",
							type = 3,
							ability = L"Divine Aid",
							currentTarget = true,
							time = 64926538891,
							value = 0,
							object = L"Ybilla",
							crit = true,
							overheal = 658,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538892,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 112,
						},
						
						{
							str = L"Your Divine Mend heals you for 0 points. (1038 overhealed)",
							type = 3,
							ability = L"Divine Mend",
							currentTarget = true,
							time = 64926538893,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 1038,
						},
						
						{
							str = L"Your Lingering Divine Aid heals you for 0 points. (112 overhealed)",
							type = 3,
							ability = L"Lingering Divine Aid",
							currentTarget = true,
							time = 64926538893,
							value = 0,
							object = L"Ybilla",
							crit = false,
							overheal = 112,
						},
					},
					object = L"Ybilla",
					valueMax = 614,
					value = 379,
					valueAoe = 0,
				},
			},
			name = L"Default",
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
	unitFramesGroupsPadding2 = 0,
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
	playerKills = 11251,
	combatLogIDSMaxRows = L"5",
	groupIconsPetAlpha = 0.5,
	combatLogTargetDefenseTimeframe = 7.5,
	combatLogTargetDefenseEnabled = false,
	markNewTarget = true,
	unitFramesTooltipMode = "alt",
	unitFramesGroupsDirection1 = 3,
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
	unitFramesPadding2 = 0,
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
				[L"Edennae"] = false,
				[L"Brogn"] = false,
				[L"Papapapa"] = false,
				[L"Brogyn"] = false,
				[L"Khaled"] = false,
				[L"Mawntain"] = false,
				[L"Olethros"] = false,
				[L"Gitodabrodda"] = false,
				[L"Keraza"] = false,
				[L"Fullsovwb"] = false,
				[L"Xrealming"] = false,
				[L"Wamma"] = false,
				[L"Onlymelee"] = false,
				[L"Deprivation"] = false,
				[L"Huurl"] = false,
				[L"Burgon"] = false,
				[L"Garamar"] = false,
				[L"Chopling"] = false,
				[L"Ailune"] = false,
				[L"Openose"] = false,
				[L"Lutzgaroth"] = false,
				[L"Fastarhymes"] = false,
				[L"Puppychoppa"] = false,
				[L"Brogun"] = false,
				[L"Anetor"] = false,
				[L"Zorbaxmara"] = false,
				[L"Perdutoi"] = false,
				[L"Grufrip"] = false,
				[L"Brodda"] = false,
				[L"Brutality"] = false,
				[L"Zorbastank"] = false,
				[L"Edentacule"] = false,
				[L"Highelvesbest"] = false,
				[L"Kalervo"] = false,
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
			layer = 3,
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
				[L"Trippiaim"] = false,
				[L"Hellogigi"] = false,
				[L"Bitterbreaker"] = false,
				[L"Full"] = false,
				[L"Lutzenberg"] = false,
				[L"Cature"] = false,
				[L"Evilspinnray"] = false,
				[L"Krasnaya"] = false,
				[L"Trippie"] = false,
				[L"Rolgrom"] = false,
				[L"Obfuscate"] = false,
				[L"Atticus"] = false,
				[L"Lutzgarath"] = false,
				[L"Arwwhin"] = false,
				[L"Bombling"] = false,
				[L"Cluclu"] = false,
				[L"Ibal"] = false,
				[L"Erasure"] = false,
				[L"Grafferwl"] = false,
				[L"Pyrulen"] = false,
				[L"Luchs"] = false,
				[L"Knutbiter"] = false,
				[L"Edennaeonfire"] = false,
				[L"Iba"] = false,
				[L"Gitbaneism"] = false,
				[L"Tiji"] = false,
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
			layer = 3,
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
				[L"Minhvra"] = false,
				[L"Mesger"] = false,
				[L"Choppeur"] = false,
				[L"Wamba"] = false,
				[L"Madchata"] = false,
				[L"Ffs"] = false,
				[L"Cla"] = false,
				[L"Cybersport"] = false,
				[L"Nashdragonis"] = false,
				[L"Tormentor"] = false,
				[L"Jackdarippa"] = false,
				[L"Salao"] = false,
				[L"Egomelter"] = false,
				[L"Barakus"] = false,
				[L"Blackmattt"] = false,
				[L"Bomg"] = false,
				[L"Yvasishiir"] = false,
				[L"Grzegorz"] = false,
				[L"Wamrok"] = false,
				[L"Domantis"] = false,
				[L"Xergom"] = false,
				[L"Lllaraa"] = false,
				[L"Nervensaege"] = false,
				[L"Zunig"] = false,
				[L"Tosate"] = false,
				[L"Bshata"] = false,
				[L"Azeyune"] = false,
				[L"Katarinae"] = false,
				[L"Theoddone"] = false,
				[L"Qep"] = false,
				[L"Neurontin"] = false,
				[L"Zuglub"] = false,
				[L"Mieles"] = false,
				[L"Gilettz"] = false,
				[L"Puppychoppa"] = false,
				[L"Teefz"] = false,
				[L"Hyronen"] = false,
				[L"Xburnx"] = false,
				[L"Winona"] = false,
				[L"Okpoxa"] = false,
				[L"Llaraa"] = false,
				[L"Teinhala"] = false,
				[L"Coldlara"] = false,
				[L"Gitrate"] = false,
				[L"Gloom"] = false,
				[L"Dolphlundgren"] = false,
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
			layer = 3,
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
		84,
		52,
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
	unitFramesMyGroupFirst = false,
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
		maxTimer = 900,
		startingScenario = 0,
		destructionPoints = 84,
		id = 2000,
		queuedWithGroup = false,
		activeQueue = 0,
		timeLeft = 784.70748439059,
		orderPoints = 43,
		pointMax = 500,
		mode = 1,
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
	playerDeaths = 3224,
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
			id = "33822",
			data = 
			{
				offlineColor = 
				{
					150,
					150,
					150,
				},
				anchorTo = "left",
				color = 
				{
					0,
					0,
					0,
				},
				deadAlpha = 1,
				anchorFrom = "left",
				vertical = false,
				distHide = false,
				texture = "default",
				distColor = 
				{
					255,
					255,
					255,
				},
				distAlpha = 0.35,
				deadColor = 
				{
					25,
					25,
					25,
				},
				layer = 0,
				alpha = 0.5,
				deadHide = false,
				textureFullResize = true,
				wrap = false,
				scale = 1,
				offlineHide = true,
				size = 
				{
					84,
					52,
				},
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
			id = "33823",
			data = 
			{
				offlineColor = 
				{
					150,
					150,
					150,
				},
				offlineHide = true,
				anchorTo = "right",
				scale = 1,
				layer = 0,
				anchorFrom = "left",
				texture = "plain",
				alpha = 1,
				vertical = false,
				color = 
				{
					255,
					255,
					0,
				},
				deadHide = false,
				deadColor = 
				{
					255,
					255,
					0,
				},
				distHide = false,
				size = 
				{
					4.5,
					52,
				},
				pos = 
				{
					0,
					0,
				},
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
			id = "33824",
			data = 
			{
				anchorTo = "left",
				color = 
				{
					255,
					255,
					0,
				},
				anchorFrom = "right",
				vertical = false,
				distHide = false,
				size = 
				{
					4.5,
					52,
				},
				offlineHide = true,
				distAlpha = 0.5,
				deadColor = 
				{
					255,
					255,
					0,
				},
				layer = 0,
				alpha = 1,
				deadHide = false,
				textureFullResize = false,
				texture = "plain",
				scale = 1,
				wrap = false,
				pos = 
				{
					0,
					0,
				},
			},
			exceptMe = false,
			name = L"Selection2",
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
			id = "33825",
			data = 
			{
				color18 = 
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
				color = 
				{
					13,
					61,
					86,
				},
				anchorFrom = "left",
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
					84,
					52,
				},
				healColor = 
				{
					0,
					175,
					92,
				},
				color14 = 
				{
					255,
					255,
					255,
				},
				wrap = false,
				color2 = 
				{
					255,
					255,
					255,
				},
				deadHide = true,
				color9 = 
				{
					255,
					255,
					255,
				},
				pos = 
				{
					0,
					0,
				},
				anchorTo = "left",
				scale = 1,
				color20 = 
				{
					255,
					255,
					255,
				},
				color5 = 
				{
					255,
					255,
					255,
				},
				vertical = false,
				color4 = 
				{
					255,
					255,
					255,
				},
				color15 = 
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
				color23 = 
				{
					255,
					255,
					255,
				},
				texture = "default",
				color22 = 
				{
					255,
					255,
					255,
				},
				offlineHide = false,
				color19 = 
				{
					255,
					255,
					255,
				},
				distAlpha = 0.35,
				textureFullResize = false,
				layer = 1,
				alpha = 1,
				color1 = 
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
				color7 = 
				{
					255,
					255,
					255,
				},
				dpsColor = 
				{
					255,
					148,
					35,
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
					163,
				},
				color21 = 
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
				color10 = 
				{
					255,
					255,
					255,
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
			type = "hpacbar",
			playerTypeMatch = 1,
		},
		
		{
			archetypeMatch = 1,
			id = "33826",
			data = 
			{
				anchorTo = "bottomleft",
				scale = 1,
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
				wrap = false,
				alpha = 1,
				maxLength = 10,
				layer = 2,
				deadHide = true,
				font = "font_clear_small_bold",
				align = "bottomleft",
				distColor = 
				{
					190,
					225,
					255,
				},
				texture = "plain",
				color = 
				{
					255,
					220,
					100,
				},
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
			id = "33827",
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
					30,
					20,
				},
				offlineHide = false,
				distAlpha = 0.5,
				align = "center",
				layer = 2,
				alpha = 1,
				maxLength = 10,
				font = "font_clear_small_bold",
				wrap = false,
				distColor = 
				{
					190,
					225,
					255,
				},
				deadHide = false,
				scale = 0.8,
				texture = "aluminium",
				pos = 
				{
					12,
					5,
				},
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
			id = "33828",
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
				distHide = false,
				texture = "4dots",
				offlineHide = true,
				textureFullResize = false,
				font = "font_clear_small_bold",
				align = "center",
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
				scale = 1,
				level3 = 150,
				size = 
				{
					40,
					10,
				},
				level2 = 100,
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
			id = "33829",
			data = 
			{
				anchorTo = "right",
				scale = 0.7,
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
				color = 
				{
					255,
					255,
					255,
				},
				font = "font_clear_small_bold",
				align = "rightcenter",
				texture = "3dots",
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
		
		{
			archetypeMatch = 1,
			id = "33830",
			data = 
			{
				anchorTo = "bottomleft",
				color = 
				{
					255,
					255,
					255,
				},
				farValue = 151,
				anchorFrom = "bottomleft",
				farText = L"FAR",
				prefix = L"M ",
				suffix = L"",
				distHide = false,
				size = 
				{
					28,
					28,
				},
				offlineHide = false,
				vertical = false,
				distAlpha = 1,
				textureFullResize = true,
				wrap = false,
				alpha = 1,
				maxLength = 10,
				layer = 4,
				font = "font_clear_small_bold",
				scale = 1,
				texture = "aluminium",
				distColor = 
				{
					190,
					225,
					255,
				},
				align = "bottomleft",
				deadHide = false,
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
			id = "33831",
			data = 
			{
				anchorTo = "bottomleft",
				scale = 1.3,
				level1 = 65,
				anchorFrom = "bottomleft",
				farText = L"FAR",
				prefix = L"",
				suffix = L"",
				distHide = false,
				vertical = false,
				texture = "3dots",
				farValue = 151,
				offlineHide = true,
				color = 
				{
					255,
					255,
					0,
				},
				textureFullResize = false,
				align = "center",
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
				deadHide = true,
				color3 = 
				{
					255,
					50,
					50,
				},
				font = "font_clear_medium_bold",
				level3 = 150,
				size = 
				{
					30,
					30,
				},
				level2 = 100,
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
			id = "33832",
			data = 
			{
				level1 = 65,
				anchorTo = "bottomleft",
				scale = 1,
				farValue = 151,
				anchorFrom = "bottomleft",
				level2 = 100,
				vertical = false,
				farText = L"FAR",
				prefix = L"M ",
				suffix = L"",
				distColor = 
				{
					255,
					255,
					0,
				},
				distHide = false,
				layer = 4,
				texture = "star",
				color1 = 
				{
					255,
					150,
					50,
				},
				offlineHide = false,
				font = "font_clear_small_bold",
				distAlpha = 1,
				align = "bottomleft",
				wrap = false,
				alpha = 1,
				maxLength = 10,
				color2 = 
				{
					255,
					50,
					50,
				},
				deadHide = false,
				color3 = 
				{
					255,
					50,
					50,
				},
				textureFullResize = true,
				level3 = 150,
				size = 
				{
					10,
					10,
				},
				color = 
				{
					255,
					255,
					0,
				},
				pos = 
				{
					20,
					-10,
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
			id = "33833",
			data = 
			{
				vertical = false,
				anchorTo = "bottomleft",
				scale = 0.8,
				farValue = 151,
				anchorFrom = "bottomleft",
				farText = L"FAR",
				size = 
				{
					50,
					30,
				},
				level2 = 100,
				prefix = L"M ",
				suffix = L"",
				distColor = 
				{
					190,
					225,
					255,
				},
				distHide = false,
				textureFullResize = false,
				texture = "aluminium",
				color1 = 
				{
					255,
					150,
					50,
				},
				offlineHide = false,
				font = "font_clear_default",
				distAlpha = 0.5,
				align = "bottomleft",
				wrap = false,
				alpha = 1,
				maxLength = 4,
				color2 = 
				{
					255,
					50,
					50,
				},
				deadHide = false,
				color3 = 
				{
					255,
					50,
					50,
				},
				layer = 4,
				level3 = 150,
				level1 = 65,
				color = 
				{
					255,
					255,
					255,
				},
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
			id = "33834",
			data = 
			{
				anchorTo = "bottomleft",
				scale = 0.85,
				farValue = 151,
				anchorFrom = "bottomleft",
				vertical = false,
				prefix = L"",
				suffix = L"",
				distHide = true,
				texture = "aluminium",
				offlineHide = true,
				textureFullResize = false,
				layer = 4,
				alpha = 1,
				font = "font_clear_small_bold",
				color = 
				{
					255,
					255,
					250,
				},
				deadHide = true,
				align = "right",
				size = 
				{
					30,
					30,
				},
				farText = L"",
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
	unitFramesCount1 = 6,
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
			deaths = 0,
			renown = 969,
			healing = 0,
			soloKills = 3975,
			damage = 7534,
			kills = 3,
			name = L"Zotoz",
			exp = 4602,
			db = 1,
			level = 40,
			career = 5,
			realm = 2,
		},
		
		{
			deaths = 1,
			renown = 0,
			healing = 960,
			soloKills = 13026,
			damage = 5483,
			kills = 0,
			name = L"Amerasu",
			exp = 0,
			db = 0,
			level = 40,
			career = 17,
			realm = 1,
		},
		
		{
			deaths = 0,
			renown = 969,
			healing = 3332,
			soloKills = 405,
			damage = 13338,
			kills = 3,
			name = L"Hellbrun",
			exp = 4602,
			db = 1,
			level = 40,
			career = 22,
			realm = 2,
		},
		
		{
			deaths = 1,
			renown = 0,
			healing = 2748,
			soloKills = 1875,
			damage = 11030,
			kills = 0,
			name = L"Fiskg",
			exp = 0,
			db = 0,
			level = 40,
			career = 18,
			realm = 1,
		},
		
		{
			deaths = 0,
			renown = 969,
			healing = 72,
			soloKills = 7131,
			damage = 2884,
			kills = 3,
			name = L"Stourmer",
			exp = 4602,
			db = 1,
			level = 40,
			career = 21,
			realm = 2,
		},
		
		{
			deaths = 0,
			renown = 1206,
			healing = 15828,
			soloKills = 1430,
			damage = 2172,
			kills = 3,
			name = L"Biggyshroomz",
			exp = 4602,
			db = 0,
			level = 40,
			career = 7,
			realm = 2,
		},
		
		{
			deaths = 1,
			renown = 0,
			healing = 0,
			soloKills = 0,
			damage = 2563,
			kills = 0,
			name = L"Hozguilianth",
			exp = 0,
			db = 0,
			level = 40,
			career = 2,
			realm = 1,
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
	unitFramesGroupsPadding1 = 8,
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
		scale = 1,
		unique = false,
		firstLetters = 4,
		showCareerIcon = true,
		canClearOnClick = true,
		permanentTargets = 
		{
		},
		id = 1218,
		text = L"Stay Away",
		alpha = 1,
		layer = 3,
		color = 
		{
			20,
			250,
			250,
		},
		font = "font_clear_large_bold",
		name = L"Watchout",
		targetOnClick = true,
		display = 1,
		offsetY = 50,
		neverExpire = false,
		permanent = false,
	},
	combatLogIgnoreNpc = false,
	unitFramesGroupsDirection2 = 3,
	guardDistanceIndicatorMovable = true,
}



