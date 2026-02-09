<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Swinger" version="0.2" date="09/09/2017" >
		<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Author name="Sullemunk"/>
		<Description text="An Melee autoattack timer" />
		<Files>
		<File name="Swinger.lua" />
	    <File name="Swinger.xml" />		
		</Files>
		<OnInitialize>
		<CallFunction name="Swinger.OnInitialize" /> 
		</OnInitialize>
		<OnUpdate>
		<CallFunction name="Swinger.Update" />
    	</OnUpdate>
        <OnShutdown>
        </OnShutdown>
		
		
	</UiMod>
</ModuleFile>