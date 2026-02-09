AuraAddon.Configuration = 
{
	Characters = 
	{
		["FiskgjuseUi"] = 
		{
			Enabled = true,
			Version = 
			{
				MINOR = 7,
				MAJOR = 2,
				REV = 2,
			},
			Debug = false,
			Settings = 
			{
				["general-effect-timers"] = 0.4,
			},
			Auras = 
			{
				
				{
					Data = 
					{
						["effect-name"] = L"Defense Buff",
						["texture-offsety"] = -400,
						["effect-self"] = false,
						["texture-id"] = 8059,
						["effect-type"] = 4,
						["trigger-onlyingroup"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 1.0000000187755,
						["timer-offsety"] = -400,
						["timer-enabled"] = true,
						["effect-enemy"] = true,
						["texture-circledimage"] = true,
						["general-name"] = L"aAll - Defense Buff",
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Immovable",
						["timer-offsetx"] = 200,
						["texture-id"] = 5007,
						["effect-type"] = 5,
						["general-name"] = L"aAll - Immovable",
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.55999921888113,
						["timer-offsety"] = -340,
						["timer-enabled"] = true,
						["activation-animation"] = 6,
						["texture-offsety"] = -300,
						["texture-offsetx"] = 200,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Unstoppable",
						["timer-offsetx"] = 150,
						["texture-id"] = 5006,
						["effect-type"] = 5,
						["general-name"] = L"aAll - Unstoppable",
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.55999921888113,
						["timer-offsety"] = -340,
						["timer-enabled"] = true,
						["activation-animation"] = 6,
						["texture-offsety"] = -300,
						["texture-offsetx"] = 150,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"Bellow",
						["general-name"] = L"aDamage - Distracting Bellow",
						["texture-id"] = 23173,
						["timer-scale"] = 1.0000000238419,
						["activation-animation"] = 6,
						["effect-name"] = L"Distracting Bellow",
						["texture-offsety"] = -400,
						["effect-type"] = 4,
						["ability-abilityid"] = 9550,
						["texture-scale"] = 1.0000000187755,
						["timer-offsety"] = -400,
						["trigger-onlyincombat"] = true,
						["activation-alerttexttype"] = 23,
						["texture-circledimage"] = true,
						["timer-enabled"] = true,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"Blinding Light",
						["general-name"] = L"aDestro - Blinding Light",
						["texture-id"] = 13367,
						["timer-scale"] = 1.0000000238419,
						["timer-enabled"] = true,
						["effect-name"] = L"Blinding Light",
						["timer-offsetx"] = 70,
						["texture-offsety"] = -400,
						["effect-type"] = 3,
						["activation-animation"] = 6,
						["texture-offsetx"] = 70,
						["texture-scale"] = 0.90999985516071,
						["timer-offsety"] = -400,
						["activation-alerttexttype"] = 23,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"WH M4",
						["general-name"] = L"aDestro - Excommunicate ",
						["texture-id"] = 7978,
						["activation-sound"] = 6,
						["timer-scale"] = 1.6030143260956,
						["timer-enabled"] = true,
						["effect-name"] = L"Excommunicate",
						["texture-offsety"] = -260,
						["effect-type"] = 7,
						["texture-scale"] = 1.009441178143,
						["timer-offsety"] = -260,
						["trigger-onlyincombat"] = true,
						["activation-screenflash"] = 6,
						["texture-circledimage"] = true,
						["activation-alerttexttype"] = 23,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"For The Witch King!",
						["general-name"] = L"aDestro - For The Witch King!",
						["texture-id"] = 11046,
						["effect-type"] = 15,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 1.0000000187755,
						["texture-offsety"] = -260,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
						["texture-offsetx"] = -70,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Numbing Strike",
						["texture-id"] = 4672,
						["effect-type"] = 12,
						["general-name"] = L"aDestro - Numbing Strike",
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.80999967336655,
						["timer-offsety"] = -330,
						["timer-enabled"] = true,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
						["texture-offsety"] = -330,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Shatter Limbs",
						["general-name"] = L"aDestro - Shatter Limbs",
						["texture-id"] = 4686,
						["effect-type"] = 12,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70999949157238,
						["texture-offsety"] = -330,
						["texture-offsetx"] = -70,
						["texture-circledimage"] = true,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"Slayer M4",
						["texture-id"] = 4691,
						["activation-sound"] = 6,
						["activation-screenflash"] = 6,
						["timer-enabled"] = true,
						["effect-name"] = L"Unleashed Power",
						["effect-self"] = false,
						["texture-offsety"] = -260,
						["effect-type"] = 4,
						["timer-scale"] = 1.6030143260956,
						["activation-alerttexttype"] = 23,
						["texture-scale"] = 1.0000000187755,
						["timer-offsety"] = -260,
						["trigger-onlyincombat"] = true,
						["effect-enemy"] = true,
						["texture-circledimage"] = true,
						["general-name"] = L"aDestro - Unleashed Power ",
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"We'z Bigger",
						["timer-offsetx"] = 70,
						["general-name"] = L"aDestro - We'z Bigger",
						["texture-id"] = 2568,
						["effect-type"] = 15,
						["trigger-onlyingroup"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 1.0000000187755,
						["timer-offsety"] = -260,
						["texture-offsetx"] = 70,
						["texture-offsety"] = -260,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Bad Gas!",
						["general-name"] = L"aOrder - Bad Gas!",
						["texture-id"] = 2608,
						["effect-type"] = 12,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70999949157238,
						["texture-offsety"] = -330,
						["texture-offsetx"] = -70,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"WE M3",
						["texture-id"] = 10963,
						["timer-scale"] = 1.0000000238419,
						["timer-enabled"] = true,
						["effect-name"] = L"Death Reaper",
						["timer-offsetx"] = 70,
						["effect-self"] = false,
						["texture-offsety"] = -330,
						["effect-type"] = 4,
						["general-name"] = L"aOrder - Death Reaper",
						["activation-alerttexttype"] = 23,
						["texture-scale"] = 0.80999967336655,
						["timer-offsety"] = -330,
						["texture-offsetx"] = 70,
						["effect-enemy"] = true,
						["texture-circledimage"] = true,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Dropp Da Basha",
						["texture-id"] = 2644,
						["effect-type"] = 10,
						["general-name"] = L"aOrder - Dropp Da Basha",
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.80999967336655,
						["timer-offsety"] = -330,
						["timer-enabled"] = true,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
						["texture-offsety"] = -330,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Not In da face!",
						["general-name"] = L"aOrder - Not In da face!",
						["texture-id"] = 2566,
						["effect-type"] = 12,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70999949157238,
						["texture-offsety"] = -330,
						["texture-offsetx"] = -70,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["activation-alerttext"] = L"Choppa M4",
						["texture-id"] = 2663,
						["activation-sound"] = 6,
						["activation-screenflash"] = 6,
						["timer-enabled"] = true,
						["effect-name"] = L"We'z Fightin' Betta",
						["effect-self"] = false,
						["texture-offsety"] = -260,
						["effect-type"] = 4,
						["general-name"] = L"aOrder - We'z Fightin' Betta",
						["activation-alerttexttype"] = 23,
						["texture-scale"] = 1.0004860797524,
						["timer-offsety"] = -260,
						["trigger-onlyincombat"] = true,
						["effect-enemy"] = true,
						["texture-circledimage"] = true,
						["timer-scale"] = 1.6093846797943,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Whispering Wind",
						["general-name"] = L"aOrder - Whispering Wind",
						["texture-id"] = 13380,
						["effect-type"] = 16,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 1.0000000187755,
						["texture-offsety"] = -260,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -70,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 2,
						["texture-offsety"] = 23,
						["general-name"] = L"Hp 20%",
						["activation-animation"] = 6,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60054308623075,
						["hitpoints-operator"] = 2,
						["texture-offsetx"] = -115,
						["trigger-onlyincombat"] = true,
						["hitpoints-value"] = 20,
						["texture-id"] = 22753,
					},
				},
				
				{
					Data = 
					{
						["hitpoints-secondaryvalue"] = 20,
						["general-triggertype"] = 2,
						["general-name"] = L"Hp 50%",
						["activation-animation"] = 6,
						["texture-offsety"] = 23,
						["hitpoints-enablesecondary"] = true,
						["texture-offsetx"] = -115,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881974369287,
						["hitpoints-operator"] = 2,
						["trigger-onlyincombat"] = true,
						["hitpoints-secondaryoperator"] = 3,
						["hitpoints-value"] = 50,
						["texture-id"] = 22755,
					},
				},
				
				{
					Data = 
					{
						["general-name"] = L"Hp 80%",
						["hitpoints-secondaryoperator"] = 3,
						["hitpoints-secondaryvalue"] = 50,
						["hitpoints-enablesecondary"] = true,
						["texture-offsety"] = 23,
						["activation-animation"] = 5,
						["trigger-onlyincombat"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.40088162958622,
						["hitpoints-operator"] = 2,
						["texture-offsetx"] = -115,
						["general-triggertype"] = 2,
						["hitpoints-value"] = 80,
						["texture-id"] = 22754,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 2,
						["texture-offsety"] = 23,
						["general-name"] = L"Hp2 20%",
						["activation-animation"] = 7,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70054326802492,
						["hitpoints-operator"] = 2,
						["texture-offsetx"] = -115,
						["trigger-onlyincombat"] = true,
						["hitpoints-value"] = 20,
						["texture-id"] = 22753,
					},
				},
				
				{
					Data = 
					{
						["general-name"] = L"Hp2 50%",
						["hitpoints-secondaryoperator"] = 3,
						["hitpoints-secondaryvalue"] = 20,
						["activation-animation"] = 7,
						["texture-offsety"] = 23,
						["hitpoints-enablesecondary"] = true,
						["trigger-onlyincombat"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60881992548704,
						["hitpoints-operator"] = 2,
						["texture-offsetx"] = -115,
						["general-triggertype"] = 2,
						["hitpoints-value"] = 50,
						["texture-id"] = 22755,
					},
				},
				
				{
					Data = 
					{
						["hitpoints-secondaryvalue"] = 50,
						["hitpoints-secondaryoperator"] = 3,
						["general-name"] = L"Hp2 80%",
						["activation-animation"] = 6,
						["texture-offsety"] = 23,
						["hitpoints-enablesecondary"] = true,
						["texture-offsetx"] = -115,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50088181138039,
						["hitpoints-operator"] = 2,
						["trigger-onlyincombat"] = true,
						["general-triggertype"] = 2,
						["hitpoints-value"] = 80,
						["texture-id"] = 22754,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Increasing Impetus",
						["general-name"] = L"aProc - Increasing Impetus",
						["texture-id"] = 4532,
						["effect-type"] = 4,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.80999967336655,
						["texture-circledimage"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 7,
						["general-name"] = L"xaPet - Use with Timer",
						["texture-id"] = 2447,
						["activation-sound"] = 7,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 1.180000346005,
						["activation-animation"] = 7,
						["texture-offsety"] = 200,
						["timer-enabled"] = true,
						["texture-offsetx"] = -481,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xBG - Shatter Enchatment",
						["texture-id"] = 11030,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50848091095686,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -130,
						["trigger-onlyincombat"] = true,
						["ability-abilityid"] = 9337,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xBG - Spiteful Slam",
						["texture-id"] = 11014,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60777456045151,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 9321,
						["texture-offsety"] = -150,
						["texture-offsetx"] = -170,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xBO - Shatter Enchatment",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.5053734600544,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -130,
						["ability-abilityid"] = 1733,
						["texture-id"] = 2497,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xBO - Ya Missed Me",
						["texture-id"] = 2565,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60743565350771,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["ability-abilityid"] = 1690,
						["texture-offsetx"] = -170,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Flashfire",
						["general-name"] = L"xBW - Flashfire",
						["texture-id"] = 22694,
						["effect-type"] = 5,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70811498492956,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xChoppa - Behind ",
						["texture-offsety"] = 115,
						["texture-offsetx"] = 278,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70999949157238,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 1749,
						["trigger-onlyincombat"] = true,
						["texture-circledimage"] = true,
						["texture-id"] = 2512,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Dropp Da Basha",
						["general-triggertype"] = 5,
						["general-name"] = L"xChoppa - Dropp Da Basha",
						["texture-id"] = 2644,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60999930977821,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["ability-abilityid"] = 1756,
						["texture-offsety"] = -150,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xChosen - Sever Blessing",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881978079677,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 8339,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -130,
						["texture-id"] = 2497,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xDoK - Consume Enchantment",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50709663897753,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 9569,
						["texture-offsetx"] = -130,
						["trigger-onlyincombat"] = true,
						["texture-id"] = 5188,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xDoK - Wracking Agony",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60639021426439,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 9576,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["texture-id"] = 10959,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xIB - Sever Blessing",
						["texture-id"] = 2497,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50398918807507,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 1374,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -130,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xIB - Shield of Reprisal",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.6026050978899,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["ability-abilityid"] = 1369,
						["trigger-onlyincombat"] = true,
						["texture-id"] = 4587,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xKotBS - Shatter Confidence",
						["texture-id"] = 8010,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50365035533905,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 8023,
						["texture-offsetx"] = -130,
						["texture-offsety"] = -150,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["texture-id"] = 5200,
						["trigger-onlyincombat"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881978079677,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 8405,
						["texture-offsety"] = -150,
						["texture-offsetx"] = -210,
						["general-name"] = L"xMara - Death Grip",
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["texture-offsety"] = -150,
						["texture-id"] = 5223,
						["hitpoints-type"] = 2,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60811339318752,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["ability-abilityid"] = 8420,
						["trigger-onlyincombat"] = true,
						["general-name"] = L"xMara - Guillotine",
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["texture-id"] = 5219,
						["trigger-onlyincombat"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881978079677,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["texture-offsety"] = -190,
						["ability-abilityid"] = 8414,
						["general-name"] = L"xMara - Gut Ripper",
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["texture-id"] = 5220,
						["trigger-onlyincombat"] = true,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60881992548704,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -125,
						["texture-offsety"] = -150,
						["ability-abilityid"] = 8412,
						["general-name"] = L"xMara - Mutated Energy",
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["texture-id"] = 4635,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.5053734600544,
						["texture-offsety"] = -150,
						["ability-abilityid"] = 1601,
						["general-name"] = L"xRP - Rune of Serenity",
						["texture-offsetx"] = -130,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["timer-offsetx"] = -481,
						["ability-showwhennotactive"] = true,
						["general-name"] = L"xSH - Gas Timer",
						["texture-id"] = 2507,
						["texture-offsetx"] = -481,
						["timer-scale"] = 0.80495700836182,
						["texture-scale"] = 0.50054438859224,
						["timer-offsety"] = 170,
						["timer-enabled"] = true,
						["ability-abilityid"] = 1843,
						["texture-circledimage"] = true,
						["texture-offsety"] = 155,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["timer-offsetx"] = -441,
						["ability-showwhennotactive"] = true,
						["general-name"] = L"xSH - Horned Timer",
						["texture-id"] = 2488,
						["texture-offsetx"] = -441,
						["timer-scale"] = 0.80343523025513,
						["texture-scale"] = 0.50999912798405,
						["timer-offsety"] = 170,
						["timer-enabled"] = true,
						["ability-abilityid"] = 1842,
						["texture-circledimage"] = true,
						["texture-offsety"] = 155,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["timer-offsetx"] = -521,
						["ability-showwhennotactive"] = true,
						["general-name"] = L"xSH - Spiked Timer",
						["texture-id"] = 2483,
						["texture-offsetx"] = -521,
						["timer-scale"] = 0.80191352367401,
						["texture-scale"] = 0.50226749330759,
						["timer-offsety"] = 170,
						["timer-enabled"] = true,
						["ability-abilityid"] = 1844,
						["texture-circledimage"] = true,
						["texture-offsety"] = 155,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xSlayer - Behind",
						["texture-offsety"] = 115,
						["ability-abilityid"] = 1437,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70466729134321,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = 278,
						["texture-circledimage"] = true,
						["texture-id"] = 2512,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xSlayer - Numbing Strike",
						["texture-id"] = 4672,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60999930977821,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 1444,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xSM - Redirect Force",
						["texture-id"] = 13394,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.6026050978899,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["ability-abilityid"] = 9032,
						["trigger-onlyincombat"] = true,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xSM - Shatter Enchantment",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881978079677,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 9034,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -130,
						["texture-id"] = 2497,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWE - Sever Blessing",
						["texture-id"] = 2497,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.5053734600544,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -130,
						["trigger-onlyincombat"] = true,
						["texture-offsety"] = -150,
						["ability-abilityid"] = 9413,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWE - We Sever Limb",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60999930977821,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 9400,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["texture-id"] = 10972,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWH - Confess!",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60999930977821,
						["ability-requireexplicitactivecheck"] = true,
						["texture-offsetx"] = -170,
						["trigger-onlyincombat"] = true,
						["ability-abilityid"] = 8086,
						["texture-id"] = 7976,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWH - Sever Blessing",
						["texture-offsety"] = -150,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50398918807507,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -130,
						["ability-abilityid"] = 8101,
						["texture-id"] = 2497,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWL - Behind",
						["texture-offsety"] = 115,
						["texture-offsetx"] = 278,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.70999949157238,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["ability-abilityid"] = 9161,
						["texture-circledimage"] = true,
						["texture-id"] = 2512,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWL - Cull The Weak",
						["texture-id"] = 13443,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60999930977821,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["ability-abilityid"] = 9190,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["timer-offsetx"] = -481,
						["ability-showwhennotactive"] = true,
						["general-name"] = L"xWL - Pet Timer",
						["texture-offsety"] = 200,
						["timer-scale"] = 2.0011753082275,
						["texture-scale"] = 1.0000000187755,
						["texture-hideimage"] = true,
						["texture-offsetx"] = -481,
						["ability-abilityid"] = 9159,
						["timer-offsety"] = 200,
						["timer-enabled"] = true,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWP - Hammer of Sigmar",
						["texture-id"] = 7962,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60811339318752,
						["ability-requireexplicitactivecheck"] = true,
						["ability-abilityid"] = 8272,
						["trigger-onlyincombat"] = true,
						["texture-offsetx"] = -170,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xWP - Purge",
						["texture-id"] = 8041,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.50881978079677,
						["ability-requireexplicitactivecheck"] = true,
						["trigger-onlyincombat"] = true,
						["ability-abilityid"] = 8251,
						["texture-offsetx"] = -130,
						["texture-offsety"] = -150,
					},
				},
				
				{
					Data = 
					{
						["general-triggertype"] = 5,
						["general-name"] = L"xZealot - Leaping Alteration",
						["texture-id"] = 5250,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.5053734600544,
						["texture-offsetx"] = -130,
						["texture-offsety"] = -150,
						["ability-abilityid"] = 8557,
						["trigger-onlyincombat"] = true,
					},
				},
				
				{
					Data = 
					{
						["effect-name"] = L"Scourged Warping",
						["general-name"] = L"xZealot - Scourged Warping",
						["texture-offsety"] = -150,
						["effect-type"] = 5,
						["timer-scale"] = 1.0000000238419,
						["texture-scale"] = 0.60983798205853,
						["trigger-onlyincombat"] = true,
						["texture-id"] = 5144,
						["texture-offsetx"] = -170,
					},
				},
			},
		},
	},
	Classes = 
	{
	},
	Default = 
	{
	},
	Servers = 
	{
	},
}



