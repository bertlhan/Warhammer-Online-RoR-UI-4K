<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <UiMod name="MoraleCircle" version="1.2.9" date="24/5/2020">
    	<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" /> 
     <Author name="Sullemunk" />
        <Description text="Movable MoraleButtons" />
        <Dependencies>
            <Dependency name="EASystem_Utils" />
            <Dependency name="EASystem_WindowUtils" />
            <Dependency name="EA_LegacyTemplates" />
            <Dependency name="EASystem_Tooltips" />
            <Dependency name="EASystem_LayoutEditor" />
            <Dependency name="EA_Cursor" />
            <Dependency name="EA_ActionBars" />
            <Dependency name="EASystem_AdvancedWindowManager" />
            <Dependency name="EA_MoraleWindow" />

        </Dependencies>

        <SavedVariables>
            <SavedVariable name="MoraleCircle.Colors" />
          </SavedVariables>

        <Files>
            <File name="MoraleCircle.lua" />
            <File name="MoraleCircle.xml" />
        </Files>
        <OnInitialize>
            <CallFunction name="MoraleCircle.init" />
        </OnInitialize>
        <OnUpdate>
		<CallFunction name="MoraleCircle.update" />
    	  </OnUpdate>
    </UiMod>
</ModuleFile>
