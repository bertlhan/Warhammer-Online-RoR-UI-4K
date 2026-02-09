<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="DAoCBuff" version="1.0191" date="06/04/2010" >

		<VersionSettings gameVersion="1.3.5" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Author name="Olmi and Crestor" email="" />
		<Description text="DAoCBuff is an alternate Bufftracker with alot more Options" />

		<Dependencies>
			<Dependency name="EASystem_Utils" />
			<Dependency name="EASystem_WindowUtils" />
			<Dependency name="EASystem_Tooltips" />
			<Dependency name="EATemplate_DefaultWindowSkin" />
			<Dependency name="EA_SettingsWindow" />
			<Dependency name="LibSlash" />
		</Dependencies>

		<SavedVariables>
			<SavedVariable name="DAoCBuffVar" />
		</SavedVariables>

		<Files>
			<File name="textures/Textures.xml" />
			<File name="Source/DAoCBuff.xml" />
			<File name="Source/DAoCBuffSettingsTabs.xml" />
			<File name="Source/DAoCBuffMsgWindow.xml" />
			<File name="Source/DAoCTooltips.xml" />
			<File name="Source/DAoCBuffSettings.xml" />
			<File name="Source/DAoCBuff.lua" />
			<File name="Source/DAoCBuffService.lua" />
			<File name="Source/DAoCBuffFilters.lua" />
			<File name="Source/DAoCBuffFrames.lua" />
			<File name="Source/DAoCBuffHeadFrames.lua" />
			<File name="Source/DAoCTooltips.lua" />
			<File name="Source/DAoCBuffSettings.lua" />
			<File name="Source/DAoCBuffSettings2ndTier.lua" />
			<File name="Source/Transcode.lua" />
			<File name="textures/Textures.lua" />
		</Files>

		<OnInitialize>
				<CallFunction name="DAoCBuff.Initialize" />
				<CallFunction name="DAoCTooltips.Init" />
				<CallFunction name="DAoCBuffSettings.CreateOptionswindow" />
		</OnInitialize>

		<OnUpdate>
				<CallFunction name="DAoCBuff.UpdateWindow" />
		</OnUpdate>

		<OnShutdown>
            	<CallFunction name="DAoCBuff.Shutdown" />
		</OnShutdown>

		<WARInfo>
			<Categories>
				<Category name="BUFFS_DEBUFFS" />
				<Category name="RVR" />
				<Category name="COMBAT" />
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
				<Career name= "MARAUDER" />
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
