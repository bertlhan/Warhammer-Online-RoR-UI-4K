PetPassive = PetPassive or {};

local towstring = towstring;

local windowName = "PetPassiveConfigWindow";
local OFFSET_MINIMUM = 0;
local OFFSET_MAXIMUM = 200;

function PetPassive.createConfigWindow()

    if (DoesWindowExist(windowName) == true) then return end

    CreateWindow(windowName, false)
	WindowSetTintColor(windowName .. "Background", 0, 0, 0);
	WindowSetAlpha(windowName .. "Background", 0.8);
    LabelSetText(windowName .. "Title", L"Pet Passive Config");
    
    -- fill in static description labels
    LabelSetText(windowName .. "ShowDebugCheckBoxLabel", L"Show debug logs");
    LabelSetText(windowName .. "PassiveStanceCheckBoxLabel", L"Auto passive stance");
    LabelSetText(windowName .. "AutoAbilityDisabledCheckBoxLabel", L"Disable auto ability usage");
end

-- /script PetPassive.showConfig()
function PetPassive.showConfig()
	WindowSetShowing(windowName, true);
end

-- /script PetPassive.hideConfigWindow();
function PetPassive.hideConfigWindow()
	WindowSetShowing(windowName, false);
end

function PetPassive.setUpCheckboxes()
    ButtonSetPressedFlag( windowName .. "ShowDebugCheckBox", PetPassiveShowDebug);
	ButtonSetPressedFlag( windowName .. "PassiveStanceCheckBox", PetPassiveAutoPassiveStance);
	ButtonSetPressedFlag( windowName .. "AutoAbilityDisabledCheckBox", PetPassiveAutoAbilityDisabled);
end

function PetPassive.ToggleShowDebug()
    PetPassiveShowDebug = not PetPassiveShowDebug;
    ButtonSetPressedFlag(windowName .. "ShowDebugCheckBox", PetPassiveShowDebug);
end

function PetPassive.TogglePassiveStance()
    PetPassiveAutoPassiveStance = not PetPassiveAutoPassiveStance;
    ButtonSetPressedFlag(windowName .. "PassiveStanceCheckBox", PetPassiveAutoPassiveStance);
	PetPassive.OnPetUpdate()
end

function PetPassive.ToggleAutoAbilityDisabled()
    PetPassiveAutoAbilityDisabled = not PetPassiveAutoAbilityDisabled;
    ButtonSetPressedFlag(windowName .. "AutoAbilityDisabledCheckBox", PetPassiveAutoAbilityDisabled);
	PetPassive.OnPetUpdate()
end



