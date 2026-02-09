<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="GuardList" version="1.7" date="13/01/2024" >

		<Author name="Sullemunk"/>
		<Description text="MultiGuard List/Range (formely Guardrange) \n use /guardlist for options"/>
		
        <Dependencies>
			<Dependency name="LibGuard" />
			<Dependency name="LibSlash" />			
        </Dependencies>
        
		<SavedVariables>
        	<SavedVariable name="GuardList.Settings" />
        </SavedVariables> 
        
		<Files>
			<File name="GuardList.xml" />
		</Files>
		
		<OnInitialize>
            <CallFunction name="GuardList.Initialize" />
		</OnInitialize>
		<OnUpdate>
        </OnUpdate>
		<OnShutdown/>
		<Replaces name="GuardRange" />
	</UiMod>
</ModuleFile>
