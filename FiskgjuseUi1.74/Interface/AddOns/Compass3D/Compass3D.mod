<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile>
  <UiMod name="Compass3D" version="0.1" date="">

    <Author name="Zomega (Omegus)" />

    <Files>
      <!-- The order is important -->
      <File name="Source\ZoneData.lua" />
      <File name="Source\Camera.lua" />

      <File name="Source\Compass3D.xml" />
      <File name="Source\Compass3D.lua" />
    </Files>

    <OnInitialize>
      <CallFunction name="Compass3D.OnInitialize" />
    </OnInitialize>

    <OnShutdown>
      <CallFunction name="Compass3D.OnShutdown" />
    </OnShutdown>

    <OnUpdate>
      <CallFunction name="Compass3D.OnUpdate" />
    </OnUpdate>

    <VersionSettings gameVersion="1.4.8" windowsVersion="1.0" />

  </UiMod>
</ModuleFile>
