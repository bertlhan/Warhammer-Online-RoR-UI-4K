<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="PetPassive" version="1.0.0" date="30/11/2023" >
    <VersionSettings gameVersion="1.4.8" windowsVersion="1.0" savedVariablesVersion="1.0"/>
        <Author name="Octonetwork"/>
        <Description text="Put pet and abilities on passive on summon. Use /petpassive to setup" />
        <Files>
          <File name="PetPassive.lua" />
		  <File name="PetPassiveConstants.lua" />
		  <File name="ui/Config.lua" />
		  <File name="ui/Config.xml" />
        </Files>
		<SavedVariables>
			<SavedVariable name="PetPassiveShowDebug"/>
			<SavedVariable name="PetPassiveAutoPassiveStance"/>
            <SavedVariable name="PetPassiveAutoAbilityDisabled"/>
		</SavedVariables>
        <Dependencies>
            <Dependency name="EA_ChatWindow" />
            <Dependency name="EA_ActionBars" />
            <Dependency name="EA_CareerResourcesWindow" />
			<Dependency name="LibSlash"/>
         </Dependencies>
        <OnInitialize>
            <CallFunction name="PetPassive.Initialize" />
		</OnInitialize>
        <WARInfo>
            <Categories>
                <Category name="PET" />
            </Categories>
            <Careers>
                <Career name="ENGINEER" />
                <Career name="SQUIG_HERDER" />
                <Career name="MAGUS" />
                <Career name="WHITE_LION" />
            </Careers>
        </WARInfo>

    </UiMod>
</ModuleFile>