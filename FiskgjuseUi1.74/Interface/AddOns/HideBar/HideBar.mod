<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="HideBar" version="1.3" date="21/8/2018">
        <Author name="Sullemunk, Caffeine" />
        <Description text="Makes an Action Bar invisible untill hovered over." />
		<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Dependencies>
			<Dependency name="EA_ActionBars" />
            <Dependency name="EASystem_ActionBarClusterManager" />
            <Dependency name="EA_SettingsWindow" />
	    	<Dependency name="LibSlash" />
        </Dependencies>
        <Files>
            <File name="HideBar.lua" />
        </Files>
        <OnInitialize>
            <CallFunction name="HideBar.Initialize" />
        </OnInitialize>
		<OnUpdate>
			<CallFunction name="HideBar.OnUpdate" />
		</OnUpdate>
        <OnShutdown>
			<CallFunction name="HideBar.OnShutdown" />
        </OnShutdown>
		<SavedVariables>
			<SavedVariable name="HideBar.SavedSettings" global="false"/>
		</SavedVariables>		
    </UiMod>
</ModuleFile>