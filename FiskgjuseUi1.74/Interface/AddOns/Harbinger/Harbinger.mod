<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="Harbinger" version="1.7" date="16/12/2023">
	<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" /> 
     <Author name="Sullemunk" />
			<WARInfo>
			<Careers>
				<Career name="ZEALOT" />
				<Career name="RUNE_PRIEST" />
			</Careers>
		</WARInfo>
        <Description text="Shows your Harbinger of Doom or Harbinger of Change stance. made by Sullemunk for RoR" />
        <Dependencies>
		    <Dependency name="EATemplate_DefaultWindowSkin" />
            <Dependency name="EASystem_Utils" />
            <Dependency name="EASystem_WindowUtils" />
            <Dependency name="EASystem_TargetInfo" />
            <Dependency name="EA_ActionBars" />					
		</Dependencies>
        <Files>
            <File name="Harbinger.lua" />
			<File name="Harbinger.xml" />
        </Files>
			<SavedVariables>
			</SavedVariables>
        <OnInitialize>
            <CallFunction name="Harbinger.Initialize" />
        </OnInitialize>
        <OnUpdate>
    	  	<CallFunction name="Harbinger.OnUpdate" />	
		  </OnUpdate>	  
        <OnShutdown>
			<CallFunction name="Harbinger.OnShutdown" />
		</OnShutdown>
    </UiMod>
</ModuleFile>