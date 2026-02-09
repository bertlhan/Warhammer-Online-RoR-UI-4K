<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <UiMod name="Refer" version="1.2" date="05/04/2025">
        <Author name="Brizio" email="" />
        <Description text="Adds a Refer option to the player menu to suggest inviting a player to party/warband. Now includes UI to track and manage refer requests." />
        <Dependencies>
            <Dependency name="EASystem_WindowUtils" />			
            <Dependency name="EA_ChatWindow" />			
            <Dependency name="EASystem_Utils" />
            <Dependency name="EA_LegacyTemplates" />
            <Dependency name="EASystem_Tooltips" />            
            <Dependency name="EA_PlayerMenu" />
            <Dependency name="EA_ContextMenu" />
        </Dependencies>
        <Files>
            <File name="Refer.lua" />
            <File name="ReferList.xml" />
            <File name="Refer.tga" />
        </Files>
        <SavedVariables>
            <SavedVariable name="ReferWindow.SavedSettings" global="false"/>
        </SavedVariables>
        <OnInitialize>
            <CallFunction name="ReferWindow.Initialize" />
        </OnInitialize>
        <OnShutdown>
            <CallFunction name="ReferWindow.Shutdown" />
        </OnShutdown>
        <OnUpdate>
            <CallFunction name="ReferWindow.OnUpdate" />
        </OnUpdate>
    </UiMod>

</ModuleFile>