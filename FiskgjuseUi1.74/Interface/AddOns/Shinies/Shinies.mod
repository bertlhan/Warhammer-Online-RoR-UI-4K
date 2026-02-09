<? version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<UiMod name="Shinies" version="0.9.7" date="10/31/2024">
		<Author name="Wikki" email="wikkifizzle@gmail.com" />
		<Description text="Shinies - Making gold has never been easier!" />
		<VersionSettings gameVersion="1.4.8" windowsVersion="2.0" savedVariablesVersion="2.0" />
		<Dependencies>
			<Dependency name="EASystem_Strings" />
			<Dependency name="EASystem_Utils" />
			<Dependency name="EASystem_ResourceFrames" />
			<Dependency name="EASystem_WindowUtils" />
            <Dependency name="EASystem_Tooltips" />
            <Dependency name="EATemplate_DefaultWindowSkin" />
            <Dependency name="EA_LoadingScreen" />
        	<Dependency name="EA_AuctionHouseWindow" />
        	<Dependency name="EA_BackpackWindow" />
        </Dependencies>
        
        <SavedVariables>
			<SavedVariable name="ShiniesDB" 	global="true" />
		</SavedVariables>
		
		<Files>
			<File name="Libraries/LibStub.lua" />
			<File name="Libraries/AceAddon-3.0.lua" />
			<File name="Libraries/AceDB-3.0.lua" />
			<File name="Libraries/AceDBOptions-3.0.lua" />
			<File name="Libraries/AceLocale-3.0.lua" />
			<File name="Libraries/AceTimer-3.0.lua" />
			<File name="Libraries/CallbackHandler-1.0.lua" />
			<File name="Libraries/LibGUI.lua" />
			<!-- <File name="Libraries/LibDate.lua" /> -->
			
			<!-- START LOCALIZATION FILES -->
			<File name="Localization/deDE.lua" />
			<File name="Localization/enUS.lua" />
			<File name="Localization/esES.lua" />
			<File name="Localization/frFR.lua" />
			<File name="Localization/itIT.lua" />
			<File name="Localization/jaJP.lua" />
			<File name="Localization/koKR.lua" />
			<File name="Localization/ruRU.lua" />
			<File name="Localization/zhCN.lua" />
			<File name="Localization/zhTW.lua" />
			<!-- END LOCALIZATION FILES -->
			
			<!-- START ASSETS/UI TEMPLATES-->
			<File name="Assets/Assets.xml" />
			<File name="Source/ShiniesUITemplates.xml" />
			<!-- END ASSETS/UI TEMPLATES-->
			
			<!-- START CONSTANTS & GENERAL OBJECTS -->
			<File name="Source/ShiniesConstants.lua" />
			<File name="Source/ShiniesQueue.lua" />
			<!-- END CONSTANTS & GENERAL OBJECTS -->
			
			<!-- START SHINIES FILES -->
			<File name="Source/Shinies.lua" />
			<File name="Source/Shinies.xml" />
			<!-- START SHINIES FILES -->
			
			<!-- START SHINIES MODULE DEFINITIONS -->
			<File name="Modules/Module.lua" />
			<File name="Modules/Base/Aggregator.lua" />
			<File name="Modules/Base/API.lua" />
			<File name="Modules/Base/Config.lua" />
			<File name="Modules/Base/Data.lua" />
			<File name="Modules/Base/Price.lua" />
			<File name="Modules/Base/Stat.lua" />
			<File name="Modules/Base/Tooltip.lua" />
			<File name="Modules/Base/UI.lua" />
			<!-- END SHINIES MODULE DEFINITIONS -->
			
			<!-- START AGGREGATOR MODULES -->
			<File name="Modules/Aggregator/Shinies-Aggregator-Price.lua" />
			<File name="Modules/Aggregator/Shinies-Aggregator-Tooltip.lua" />
			<!-- END AGGREGATOR MODULES -->
			
			<!-- START API MODULES -->
			<File name="Modules/API/Shinies-API.lua" />
			<File name="Modules/API/Shinies-API-Auction.lua" />
			<File name="Modules/API/Shinies-API-DateTime.lua" />
			<File name="Modules/API/Shinies-API-Display.lua" />
			<File name="Modules/API/Shinies-API-Inventory.lua" />
			<File name="Modules/API/Shinies-API-Item.lua" />
			<File name="Modules/API/Shinies-API-Query.lua" />
			<!-- END API MODULES -->
			
			<!-- START CONFIG MODULES -->
			<File name="Modules/Config/Shinies-Config-General.lua" />
			<File name="Modules/Config/Shinies-Config-General.xml" />
			<File name="Modules/Config/Shinies-Config-Price.lua" />
			<File name="Modules/Config/Shinies-Config-Price.xml" />
			<!-- END AGGREGATOR MODULES -->
			
			<!-- START DATA MODULES -->
			<!-- <File name="Modules/Data/Shinies-Data-Auction.lua" /> -->
			<File name="Modules/Data/Shinies-Data-Inventory.lua" />
			<!-- END DATA MODULES -->
			
			<!-- START PRICE MODULES -->
			<File name="Modules/Price/Shinies-Price-Fixed.lua" />
			<File name="Modules/Price/Shinies-Price-Flat.lua" />
			<File name="Modules/Price/Shinies-Price-Match.lua" />
			<File name="Modules/Price/Shinies-Price-Multiplier.lua" />
			<File name="Modules/Price/Shinies-Price-Percent.lua" />
			<!-- END PRICE MODULES --> 
			
			<!-- START STAT MODULES -->
			<File name="Modules/Stat/Shinies-Stat-Basic.lua" />
			<!-- END DATA MODULES -->
			
			<!-- START TOOLTIP MODULES -->
			<!-- <File name="Modules/Tooltip/Shinies-Tooltip-Crafting.lua" /> -->
			<!--@alpha@
			<File name="Modules/Tooltip/Shinies-Tooltip-Debug.lua" />
			@end-alpha@-->
			<File name="Modules/Tooltip/Shinies-Tooltip-Inventory.lua" />
			<File name="Modules/Tooltip/Shinies-Tooltip-Stats.lua" />
			<!-- END DATA MODULES -->
			
			<!-- START UI MODULES -->
			<File name="Modules/UI/Shinies-UI-Auctions.lua" />
			<File name="Modules/UI/Shinies-UI-Auctions.xml" />
			<File name="Modules/UI/Shinies-UI-Auto.lua" />
			<File name="Modules/UI/Shinies-UI-Auto.xml" />
			<File name="Modules/UI/Shinies-UI-Browse.lua" />
			<File name="Modules/UI/Shinies-UI-Browse.xml" />
			<File name="Modules/UI/Shinies-UI-Config.lua" />
			<File name="Modules/UI/Shinies-UI-Config.xml" />
			<File name="Modules/UI/Shinies-UI-Post.lua" />
			<File name="Modules/UI/Shinies-UI-Post.xml" />
			<!-- END UI MODULES -->
		</Files>

		<OnUpdate/>
		<OnInitialize/>
		<OnShutdown>
			<CallFunction name="AceDBLogoutHandler" />
        </OnShutdown>
	</UiMod>
</ModuleFile>