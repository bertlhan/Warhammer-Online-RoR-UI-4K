<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="CDown" version="0.94.2" date="08/20/2009" >

		<VersionSettings gameVersion="1.3.1" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Author name="Crestor" email="" />
		<Description text="Alternative Window for currently active Cooldowns" />

		<Dependencies>
			<Dependency name="LibSlash" />
		</Dependencies>

		<SavedVariables>
			<SavedVariable name="CDownVar" />
		</SavedVariables>

		<Files>
			<File name="textures/Textures.xml" />
			<File name="CDown.xml" />
			<File name="CDownSettingsTabs.xml" />
			<File name="CDownSettings.xml" />

			<File name="CDown.lua" />
			<File name="CDownFrames.lua" />
			<File name="CDownSettings.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="CDown.Initialize" />
			<CallFunction name="CDownSettings.Create" />
		</OnInitialize>
		<OnUpdate>
            	<CallFunction name="CDown.UpdateWindow" />
        	</OnUpdate>
		<OnShutdown>
            	<CallFunction name="CDown.Shutdown" />
		</OnShutdown>

		<WARInfo>
			<Categories>
				<Category name="ACTION_BARS" />
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
