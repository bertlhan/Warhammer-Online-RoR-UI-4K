<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ChannelAlert" version="15" date="11/01/2021" >
		<VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0" />
		<Author name="ChannelAlert"/>
		<Description text="Alerts you when you get hit by specific channelled abilities." />
		<Files>
			<File name="ChannelAlert.xml" />
		</Files>
		<OnInitialize>
			<CallFunction name="ChannelAlert.OnInitialize" />
		</OnInitialize>
		<OnUpdate>
            <CallFunction name="ChannelAlert.OnUpdate" />
    	</OnUpdate>
        <OnShutdown>
        </OnShutdown>
	</UiMod>
</ModuleFile>