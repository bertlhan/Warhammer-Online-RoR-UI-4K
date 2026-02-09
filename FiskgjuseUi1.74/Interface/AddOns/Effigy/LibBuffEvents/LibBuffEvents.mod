<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<UiMod name="LibBuffEvents" version="1" date="03/15/2010" >
	<VersionSettings gameVersion="1.3.5" windowsVersion="1.0" savedVariablesVersion="1.0" />
	<Author name="Philosound" email="" />
	<Description text="Global Rule Preset Storage" />

	<Dependencies>
		<Dependency name="EASystem_Utils" optional="false" forceEnable="true" />
		<Dependency name="Busted" optional="true" forceEnable="true" />
	</Dependencies>

	<Files>
		<File name="LibStub.lua" />
		<File name="LibBuffEvents.lua" />
	</Files>
	
	<OnInitialize>
		<CallFunction name="LibBuffEvents.Initialize" />
	</OnInitialize>

	<OnUpdate>
		<CallFunction name="LibBuffEvents.OnUpdate" />
	</OnUpdate>

	<OnShutdown>
		<CallFunction name="LibBuffEvents.Shutdown" />
	</OnShutdown>
	
	<SavedVariables />
	
	<WARInfo>
		<Categories>
			<Category name="BUFFS_DEBUFFS" />
			<Category name="SYSTEM" />
			<Category name="DEVELOPMENT" />
			<Category name="OTHER" />
		</Categories>
		<Careers>
			<Career name="BLACKGUARD" />
			<Career name="WITCH_ELF" />
			<Career name="DISCIPLE" />
			<Career name="SORCERER" />
			<Career name="IRON_BREAKER" />
			<Career name="SLAYER" />
			<Career name="RUNE_PRIEST" />
			<Career name="ENGINEER" />
			<Career name="BLACK_ORC" />
			<Career name="CHOPPA" />
			<Career name="SHAMAN" />
			<Career name="SQUIG_HERDER" />
			<Career name="WITCH_HUNTER" />
			<Career name="KNIGHT" />
			<Career name="BRIGHT_WIZARD" />
			<Career name="WARRIOR_PRIEST" />
			<Career name="CHOSEN" />
			<Career name="MARAUDER" />
			<Career name="ZEALOT" />
			<Career name="MAGUS" />
			<Career name="SWORDMASTER" />
			<Career name="SHADOW_WARRIOR" />
			<Career name="WHITE_LION" />
			<Career name="ARCHMAGE" />
		</Careers>
	</WARInfo>
</UiMod>
</ModuleFile>
