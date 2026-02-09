<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ScenarioAlert" version="1.1" date="20/03/2017" >
		<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Author name="Caffeine"/>
		<Description text="Keeps a log of scenario pops." />
		<Files>
			<File name="ScenarioAlert.lua" />
		</Files>
		<OnInitialize>
			<CallFunction name="ScenarioAlert.OnInitialize" /> 
		</OnInitialize>
		<OnUpdate>
    	</OnUpdate>
        <OnShutdown>
			<CallFunction name="ScenarioAlert.clearLogFile" /> 
        </OnShutdown>		
	</UiMod>
</ModuleFile>