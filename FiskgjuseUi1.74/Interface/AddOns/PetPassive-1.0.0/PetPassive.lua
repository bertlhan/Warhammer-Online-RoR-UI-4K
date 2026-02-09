-- Inspire by LoyalPet code thanks you good sir
PetPassive = {}
PetPassive.enabled = true
local pairs = pairs
local Print = EA_ChatWindow.Print
local function Print(str)
	EA_ChatWindow.Print(L"[PetPassive]" .. towstring(str));
end

local function PrintDebug(str)
	if PetPassiveShowDebug then
		Print(L"[Debug]" .. towstring(str))
	end
end

local function toRgbWstring(color, str)
	return towstring(CreateHyperLink(L"", towstring(str), {color.R, color.G, color.B}, {}));
end

local function CarrerUsePet() 
	if GameData.Player.career.id == PPET_CONSTANTS.SQUIG_HERDER or GameData.Player.career.id == PPET_CONSTANTS.WHITE_LION or GameData.Player.career.id == PPET_CONSTANTS.MAGUS or GameData.Player.career.id == PPET_CONSTANTS.ENGINEER then
		return true
	else
		return false
	end
end

function PetPassive.slashCmd(arg)
	PetPassive.showConfig()
end

-- load or initialize settings
function PetPassive.loadSettings()
	if PetPassiveShowDebug == nil then
		PetPassiveShowDebug = false
	end
	if PetPassiveAutoPassiveStance == nil then
		PetPassiveAutoPassiveStance = true
	end
	if PetPassiveAutoAbilityDisabled == nil then
		PetPassiveAutoAbilityDisabled = true
	end
end

function PetPassive.Initialize()
	if not CarrerUsePet() then
		Print(L"Not loaded, carrer do not use pets")
		return
	end
	PetPassive.loadSettings()
	PetPassive.createConfigWindow()
	PetPassive.setUpCheckboxes()
	LibSlash.RegisterSlashCmd("petpassive", PetPassive.slashCmd)
			
	RegisterEventHandler(SystemData.Events.PLAYER_PET_STATE_UPDATED, "PetPassive.OnPetUpdate")
	RegisterEventHandler(SystemData.Events.PLAYER_CAREER_RESOURCE_UPDATED, "PetPassive.OnPetUpdate")
	RegisterEventHandler(SystemData.Events.PLAYER_PET_UPDATED, "PetPassive.OnPetUpdate")
	
	Print(L"Initialized. Use /petpassive to setup")
end

function PetPassive.OnPetUpdate()
	if not PetPassive.HasPet() then
		PrintDebug("No pet found")
		return
	else
		PrintDebug("Pet found")
	end
		
	if PetPassiveAutoPassiveStance == true then 
		PrintDebug("Putting pet to passive stance")
		CommandPet(GameData.PetCommand.PASSIVE)
	else
		PrintDebug("AutoPassiveStance is off")
	end	
		
	abilityTable = GetAbilityTable(GameData.AbilityType.PET)
	for abilityId, abilityData in pairs (abilityTable) do 
		--[[local abilityOnAutoUse = ActionBars:IsActionActive(abilityId)
		if abilityOnAutoUse and PetPassiveAutoAbilityDisabled then
			PrintDebug("Disabling auto use for " .. abilityId .. " " .. tostring(abilityData.name))
			CommandPetToggleAbility(abilityId)
		elseif not abilityOnAutoUse and not PetPassiveAutoAbilityDisabled then
			PrintDebug("Enable auto use for  " .. abilityId .. " " .. tostring(abilityData.name))
			CommandPetToggleAbility(abilityId)
		end]]
		CommandPetToggleAbility(abilityId)
	end

end

function PetPassive.HasPet()
  if GameData.Player.Pet.name == L"" or GameData.Player.Pet.name == nil then
    return false
  end
  return true
end

function PetPassive.Shutdown()
  	UnregisterEventHandler(SystemData.Events.PLAYER_PET_STATE_UPDATED, "PetPassive.OnPetUpdate")
	UnregisterEventHandler(SystemData.Events.PLAYER_CAREER_RESOURCE_UPDATED, "PetPassive.OnPetUpdate")
	UnregisterEventHandler(SystemData.Events.PLAYER_PET_UPDATED, "PetPassive.OnPetUpdate")
end