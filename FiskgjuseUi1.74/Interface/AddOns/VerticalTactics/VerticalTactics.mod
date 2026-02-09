<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="VerticalTactics" version="1.2.1" date="2/24/2010" >

		<Author name="Reivan" email="" />
		<Description text="Changes the layout of EA_TacticsEditor to vertical." />

		<VersionSettings gameVersion="1.3.4" windowsVersion="1.0" savedVariablesVersion="1.0" />
		
        <Dependencies>
        	<Dependency name="EA_TacticsWindow" />
        	<Dependency name="LibSlash" />
        </Dependencies>
        <SavedVariables>
        	<SavedVariable name="VerticalTactics.reverse" />
        </SavedVariables>
       	<Files>
			<File name="VerticalTactics.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="VerticalTactics.Initialize" />
		</OnInitialize>
		<OnShutdown>
			<CallFunction name="VerticalTactics.Shutdown" />
		</OnShutdown>
	</UiMod>
</ModuleFile>
