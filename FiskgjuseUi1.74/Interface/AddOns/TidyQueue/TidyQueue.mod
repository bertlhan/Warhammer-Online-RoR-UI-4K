<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
  <UiMod name="TidyQueue" version="1.5" date="2010/09/03" >
    <Author name="Raidez" email="raidez@mail.ru" />
    <Description text="Allows you to quickly join the appropriate scenarios."/>
    
    <VersionSettings gameVersion="1.3.6" windowsVersion="1.0" savedVariablesVersion="1.0" />
    
    <Dependencies>
      <Dependency name="EA_ScenarioLobbyWindow" />
    </Dependencies>

    <Files>
      <File name="TidyQueue.xml" />
      <File name="TidyQueue.lua" />
    </Files>
    
    <OnInitialize>
      <CallFunction name="TidyQueue.Initialize" />
    </OnInitialize>
    
    <SavedVariables>
      <SavedVariable name="TidyQueue.Settings" />
    </SavedVariables>
    
    <WARInfo>
      <Categories>
        <Category name="OTHER" />
      </Categories>
      <Careers>
        <Career name="BLACKGUARD" />
        <Career name="WITCH_ELF" />
        <Career name="DISCIPLE" />
        <Career name="SORCERER" />
        <Career name="IRON_BREAKER" />
        <Career name="SLAYER" />
        <Career name="RUNE_PRIEST" />
        <Career name="ENGINEER" />
        <Career name="BLACK_ORC" />
        <Career name="CHOPPA" />
        <Career name="SHAMAN" />
        <Career name="SQUIG_HERDER" />
        <Career name="WITCH_HUNTER" />
        <Career name="KNIGHT" />
        <Career name="BRIGHT_WIZARD" />
        <Career name="WARRIOR_PRIEST" />
        <Career name="CHOSEN" />
        <Career name="MARAUDER" />
        <Career name="ZEALOT" />
        <Career name="MAGUS" />
        <Career name="SWORDMASTER" />
        <Career name="SHADOW_WARRIOR" />
        <Career name="WHITE_LION" />
        <Career name="ARCHMAGE" />
      </Careers>
    </WARInfo>

  </UiMod>
</ModuleFile>