CDownSettings = { ["ColorTable"] = {} }

local GeneralSettings = "CDown_Settings_GeneralSettings_ScrollChild_"
local NLayoutSettings = "CDown_Settings_NLayoutSettings_ScrollChild_N"
local SLayoutSettings = "CDown_Settings_SLayoutSettings_ScrollChild_S"
local ColorSettings = "CDown_Settings_ColorSettings_ScrollChild_"

local CDOWN_LAYOUT = { L"Classic", L"Bar" }
local CD_ORDER = { L"descending", L"ascending" }
local MIN_CD = { 0, 5, 8, 10, 20, 30 }
local MAX_CD = { 8, 10, 20, 30, 60, 18000 }
local N_CD_REFRESH_DELAY = { 0.25, 0.5, 0.75, 1.0 }
local S_CD_REFRESH_DELAY = { 0.05, 0.075, 0.1, 0.15 }

local CD_ROWS = {1, 2, 3, 4}
local CDS_PER_ROW = {5, 6, 7, 8, 9, 10}
local BAR_MAXCD = {5, 6, 7, 8, 9, 10}
local FONTTEXT = { "small", "medium", "large", "large bold"}
local FONTS	= { "font_clear_small_bold", "font_clear_medium", "font_clear_large", "font_clear_large_bold"}
local GROWLEFT = { "left to right", "right to left"}
local GROWUP = { "downwards", "upwards"}
local HORIZONTAL = { "vertical", "horizontal"}

local ipairs = ipairs
local LabelSetText = LabelSetText
local LabelSetTextColor = LabelSetTextColor
local ComboBoxClearMenuItems = ComboBoxClearMenuItems
local ComboBoxAddMenuItem = ComboBoxAddMenuItem
local ComboBoxGetSelectedMenuItem = ComboBoxGetSelectedMenuItem
local ButtonGetDisabledFlag = ButtonGetDisabledFlag
local ButtonGetPressedFlag = ButtonGetPressedFlag
local ButtonSetPressedFlag = ButtonSetPressedFlag

local GetAbilityName = GetAbilityName
local DynamicImageSetTexture = DynamicImageSetTexture
local LabelSetTextColor = LabelSetTextColor
local WindowGetId = WindowGetId
local ListBoxGetDataIndex = ListBoxGetDataIndex

-- POPULATE / SET BEGIN
local function GetACListDisplayOrder()
	local Liste = {}
	local i = 1

	for j,k in pairs(CDownSettings.ColorTable) do
		Liste[i] = j
		i = i + 1
	end

	return Liste
end

local activeItem = -1

local function SetTMBL()
	if (CDown.UpdateCD_bak) then
		ButtonSetText("CDown_SettingsToggleTestmode", L"Stop Testmode")
	else
		ButtonSetText("CDown_SettingsToggleTestmode", L"Start Testmode")
	end
end

local function SetLabels()
	LabelSetText("CDown_SettingsGeneralButton_Text", L"General Settings")

	LabelSetText(GeneralSettings .. "GeneralSettingsLabel", L"General Settings");
	LabelSetText(GeneralSettings .. "LayoutText", L"Change Layout")
	LabelSetText(GeneralSettings .. "RefreshText", L"Cooldown update delay")
	LabelSetText(GeneralSettings .. "SortOrderText", L"Cooldowns are sorted by duration")
	LabelSetText(GeneralSettings .. "MinCDText", L"Don't add cooldowns below")
	LabelSetText(GeneralSettings .. "MaxCDText", L"Only add cooldowns below")

	LabelSetText("CDown_SettingsLayoutButton_Text", L"Layout Settings")
	LabelSetText(NLayoutSettings .. "LayoutSettingsLabel", L"Classic-Layout Settings")
	LabelSetText(NLayoutSettings .. "RowText",L"Number of rows")
	LabelSetText(NLayoutSettings .. "CountText",L"Number of icons per row")
	LabelSetText(NLayoutSettings .. "FontText",L"Font of Texts")
	LabelSetText(NLayoutSettings .. "GrowLeftText",L"List should grow from")
	LabelSetText(NLayoutSettings .. "GrowUpText",L"List should grow")
	LabelSetText(NLayoutSettings .. "GrowHorizontalText", L"List should grow")
	LabelSetText(NLayoutSettings .. "TimerBelowText", L"Show timer below icons")
	LabelSetText(NLayoutSettings .. "FadingText", L"Enable fading")
	LabelSetText(NLayoutSettings .. "BorderText", L"Show border")
	LabelSetText(NLayoutSettings .. "GlassText", L"Use glass look")
	LabelSetText(NLayoutSettings .. "HPTEText", L"Use precise timer")

	LabelSetText(SLayoutSettings .. "LayoutSettingsLabel",L"Bar-Layout Settings")
	LabelSetText(SLayoutSettings .. "MaxCountText",L"Maximum number of cooldowns shown")
	LabelSetText(SLayoutSettings .. "FontText",L"Font of Timer")
	LabelSetText(SLayoutSettings .. "NameFontText",L"Font of Abilitynames")
	LabelSetText(SLayoutSettings .. "GrowLeftText",L"List should grow from")
	LabelSetText(SLayoutSettings .. "GrowUpText",L"List should grow")
	LabelSetText(SLayoutSettings .. "GrowHorizontalText", L"List should grow")
	LabelSetText(SLayoutSettings .. "ShowNameText", L"Show Abilityname")
	LabelSetText(SLayoutSettings .. "BorderText", L"Show border")
	LabelSetText(SLayoutSettings .. "BackText", L"Show Background")
	LabelSetText(SLayoutSettings .. "BEndText", L"Show Round End")
	LabelSetText(SLayoutSettings .. "GlassText", L"Use glass look")
	LabelSetText(SLayoutSettings .. "HPTEText", L"Use precise timer")
	LabelSetText(SLayoutSettings .. "CDBelowText", L"Show Timer in front of Icon")
	LabelSetText(SLayoutSettings .. "LengthText", L"Length of Bars: ")

	LabelSetText("CDown_SettingsColorButton_Text", L"Color Settings")
	LabelSetText(ColorSettings .. "ColorSettingsLabel",L"Color Settings")
	LabelSetText(ColorSettings .. "CSettingText",L"Color schema")
	LabelSetText(ColorSettings .. "AbilityColor_Red",L"Red")
	LabelSetText(ColorSettings .. "AbilityColor_Green",L"Green")
	LabelSetText(ColorSettings .. "AbilityColor_Blue",L"Blue")
	LabelSetText(ColorSettings .. "AbilityColor_Preview",L"Color Preview")
	LabelSetFont(ColorSettings .. "AbilityColor_Preview","font_clear_large_bold",10)
	LabelSetText(ColorSettings .. "SingleColor_Red",L"Red")
	LabelSetText(ColorSettings .. "SingleColor_Green",L"Green")
	LabelSetText(ColorSettings .. "SingleColor_Blue",L"Blue")
	LabelSetText(ColorSettings .. "SingleColor_Preview",L"Color Preview")
	LabelSetFont(ColorSettings .. "SingleColor_Preview","font_clear_large_bold",10)

	SetTMBL()
	ButtonSetText("CDown_SettingsRestartTracker", L"Restart CDown")

end

local function PopulateRefreshComboBoxText()
	if (CDownVar.optCDs.bar) then
		ComboBoxClearMenuItems(GeneralSettings .. "RefreshComboBox")
		for i,k in ipairs(S_CD_REFRESH_DELAY) do
			ComboBoxAddMenuItem(GeneralSettings .. "RefreshComboBox", k .. L"s")
		end
	else
		ComboBoxClearMenuItems(GeneralSettings .. "RefreshComboBox")
		for i,k in ipairs(N_CD_REFRESH_DELAY) do
			ComboBoxAddMenuItem(GeneralSettings .. "RefreshComboBox", k .. L"s")
		end
	end
end

local function PopulateComboBoxes()

	ComboBoxClearMenuItems(GeneralSettings .. "LayoutComboBox")
	for i,k in ipairs(CDOWN_LAYOUT) do
		ComboBoxAddMenuItem(GeneralSettings .. "LayoutComboBox", k)
	end

	PopulateRefreshComboBoxText()

	ComboBoxClearMenuItems(GeneralSettings .. "SortOrderComboBox")
	for i,k in ipairs(CD_ORDER) do
		ComboBoxAddMenuItem(GeneralSettings .. "SortOrderComboBox", k)
	end

	ComboBoxClearMenuItems(GeneralSettings .. "MinCDComboBox")
	for i,k in ipairs(MIN_CD) do
		ComboBoxAddMenuItem(GeneralSettings .. "MinCDComboBox", towstring(k) .. L"s")
	end

	ComboBoxClearMenuItems(GeneralSettings .. "MaxCDComboBox")
	for i,k in ipairs(MAX_CD) do
		ComboBoxAddMenuItem(GeneralSettings .. "MaxCDComboBox", towstring(k) .. L"s")
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "RowComboBox")
	for i,k in ipairs(CD_ROWS) do
		ComboBoxAddMenuItem(NLayoutSettings .. "RowComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "CountComboBox")
	for i,k in ipairs(CDS_PER_ROW) do
		ComboBoxAddMenuItem(NLayoutSettings .. "CountComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(SLayoutSettings .. "MaxCountComboBox")
	for i,k in ipairs(BAR_MAXCD) do
		ComboBoxAddMenuItem(SLayoutSettings .. "MaxCountComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "FontComboBox")
	ComboBoxClearMenuItems(SLayoutSettings .. "FontComboBox")
	ComboBoxClearMenuItems(SLayoutSettings .. "NameFontComboBox")
	for i,k in ipairs(FONTTEXT) do
		local e = towstring(k)
		ComboBoxAddMenuItem(NLayoutSettings .. "FontComboBox", e)
		ComboBoxAddMenuItem(SLayoutSettings .. "FontComboBox", e)
		ComboBoxAddMenuItem(SLayoutSettings .. "NameFontComboBox", e)
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "GrowLeftComboBox")
	ComboBoxClearMenuItems(SLayoutSettings .. "GrowLeftComboBox")
	for i,k in ipairs(GROWLEFT) do
		ComboBoxAddMenuItem(NLayoutSettings .. "GrowLeftComboBox", towstring(k))
		ComboBoxAddMenuItem(SLayoutSettings .. "GrowLeftComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "GrowUpComboBox")
	ComboBoxClearMenuItems(SLayoutSettings .. "GrowUpComboBox")
	for i,k in ipairs(GROWUP) do
		ComboBoxAddMenuItem(NLayoutSettings .. "GrowUpComboBox", towstring(k))
		ComboBoxAddMenuItem(SLayoutSettings .. "GrowUpComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(NLayoutSettings .. "GrowHorizontalComboBox")
	ComboBoxClearMenuItems(SLayoutSettings .. "GrowHorizontalComboBox")
	for i,k in ipairs(HORIZONTAL) do
		ComboBoxAddMenuItem(NLayoutSettings .. "GrowHorizontalComboBox", towstring(k))
		ComboBoxAddMenuItem(SLayoutSettings .. "GrowHorizontalComboBox", towstring(k))
	end

	ComboBoxClearMenuItems(ColorSettings .. "CSettingComboBox")
	ComboBoxAddMenuItem(ColorSettings .. "CSettingComboBox", towstring("Default WAR colors"))
	ComboBoxAddMenuItem(ColorSettings .. "CSettingComboBox", towstring("self defined colors"))
	ComboBoxAddMenuItem(ColorSettings .. "CSettingComboBox", towstring("One color for all abilities"))
end
-- POPULATE / SET END

local function UpdateMaxCDCount()
	if (CDownVar.optCDs.bar) then
		CDownVar.optCDs.maxCDCount = BAR_MAXCD[CDownVar.optCDs.bar_maxCDCount]
	else
		CDownVar.optCDs.maxCDCount = CD_ROWS[CDownVar.optCDs.rowcount] * CDS_PER_ROW[CDownVar.optCDs.CDRowStride]
	end
end
local function GetColorsWAR(abilityData)
	if (abilityData.isHex)					then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isCurse)		then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isCripple)		then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isAilment)		then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isBolster)		then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isAugmentation)then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isBlessing)	then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isEnchantment)	then return {abilityData.typeColorRed, abilityData.typeColorGreen, abilityData.typeColorBlue}
		elseif  (abilityData.isDamaging)	then return {DefaultColor.AbilityType.DAMAGING.r, DefaultColor.AbilityType.DAMAGING.g, DefaultColor.AbilityType.DAMAGING.b}
		elseif  (abilityData.isHealing)		then return {DefaultColor.AbilityType.HEALING.r, DefaultColor.AbilityType.HEALING.g, DefaultColor.AbilityType.HEALING.b}
		elseif  (abilityData.isDeCD)		then return {DefaultColor.AbilityType.DECD.r, DefaultColor.AbilityType.DECD.g, DefaultColor.AbilityType.DECD.b}
		elseif  (abilityData.isCD)			then return {DefaultColor.AbilityType.CD.r, DefaultColor.AbilityType.CD.g, DefaultColor.AbilityType.CD.b}
		elseif  (abilityData.isStatsCD)		then return {DefaultColor.AbilityType.CD.r, DefaultColor.AbilityType.CD.g, DefaultColor.AbilityType.CD.b}
		elseif  (abilityData.isOffensive)	then return {DefaultColor.AbilityType.OFFENSIVE.r, DefaultColor.AbilityType.OFFENSIVE.g, DefaultColor.AbilityType.OFFENSIVE.b}
		elseif  (abilityData.isDefensive)	then return {DefaultColor.AbilityType.OFFENSIVE.r, DefaultColor.AbilityType.OFFENSIVE.g, DefaultColor.AbilityType.OFFENSIVE.b}
	end
	return {255, 255, 255}
end
local function ShowABCSliders(show)
	WindowSetShowing(ColorSettings .. "AbilityColor_Red",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_RedText",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_RedSlider",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_Green",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_GreenText",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_GreenSlider",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_Blue",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_BlueText",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_BlueSlider",show)
	WindowSetShowing(ColorSettings .. "AbilityColor_Preview",show)
end
local function UpdateABCtable()
	local _tmp = CDown.GetAb()

	for i,k in pairs(_tmp) do
		if (CDownSettings.ColorTable[i] == nil) then
			local ad = GetAbilityData(i)
			CDownSettings.ColorTable[i] = GetColorsWAR(ad)
		end
	end
end
local function UpdateABCPreview()
	if (activeItem > 0 and CDownSettings.ColorTable[activeItem] ~= nil) then
		LabelSetTextColor(ColorSettings .. "AbilityColor_Preview", unpack(CDownSettings.ColorTable[activeItem]))

		LabelSetText(ColorSettings .. "AbilityColor_RedText", towstring(CDownSettings.ColorTable[activeItem][1]))
		LabelSetText(ColorSettings .. "AbilityColor_GreenText", towstring(CDownSettings.ColorTable[activeItem][2]))
		LabelSetText(ColorSettings .. "AbilityColor_BlueText", towstring(CDownSettings.ColorTable[activeItem][3]))
	end
end
local function UpdateABCColor()
	if (activeItem > 0 and CDownSettings.ColorTable[activeItem] ~= nil) then
		local c = CDownSettings.ColorTable[activeItem]
		SliderBarSetCurrentPosition(ColorSettings .. "AbilityColor_RedSlider", c[1] / 255)
		SliderBarSetCurrentPosition(ColorSettings .. "AbilityColor_GreenSlider", c[2] / 255)
		SliderBarSetCurrentPosition(ColorSettings .. "AbilityColor_BlueSlider", c[3] / 255)
		LabelSetText(ColorSettings .. "AbilityColor_RedText", towstring(c[1]))
		LabelSetText(ColorSettings .. "AbilityColor_GreenText", towstring(c[2]))
		LabelSetText(ColorSettings .. "AbilityColor_BlueText", towstring(c[3]))
		LabelSetTextColor(ColorSettings .. "AbilityColor_Preview", unpack(c))
		ShowABCSliders(true)
	else
		ShowABCSliders(false)
	end
end
local function UpdateSCPreview()
	local c = CDownVar.CP
	LabelSetTextColor(ColorSettings .. "SingleColor_Preview", unpack(c))

	LabelSetText(ColorSettings .. "SingleColor_RedText", towstring(c[1]))
	LabelSetText(ColorSettings .. "SingleColor_GreenText", towstring(c[2]))
	LabelSetText(ColorSettings .. "SingleColor_BlueText", towstring(c[3]))
end
local function UpdateSCColor()
	local c = CDownVar.CP
	SliderBarSetCurrentPosition(ColorSettings .. "SingleColor_RedSlider", c[1] / 255)
	SliderBarSetCurrentPosition(ColorSettings .. "SingleColor_GreenSlider", c[2] / 255)
	SliderBarSetCurrentPosition(ColorSettings .. "SingleColor_BlueSlider", c[3] / 255)
	LabelSetText(ColorSettings .. "SingleColor_RedText", towstring(c[1]))
	LabelSetText(ColorSettings .. "SingleColor_GreenText", towstring(c[2]))
	LabelSetText(ColorSettings .. "SingleColor_BlueText", towstring(c[3]))
	LabelSetTextColor(ColorSettings .. "SingleColor_Preview", unpack(c))
end

-- SHOW TABS BEGIN
local function ShowTab(i)
	local j = nil
	SetTMBL()
	if (i == 1) then
		WindowSetShowing("CDown_Settings_GeneralSettings", true)
		WindowSetShowing("CDown_Settings_NLayoutSettings", false)
		WindowSetShowing("CDown_Settings_SLayoutSettings", false)
		WindowSetShowing("CDown_Settings_ColorSettings", false)

		LabelSetTextColor("CDown_SettingsGeneralButton_Text", 255, 204, 102)
		LabelSetTextColor("CDown_SettingsLayoutButton_Text", 255, 255, 255)
		LabelSetTextColor("CDown_SettingsColorButton_Text", 255, 255, 255)

		if (CDownVar.optCDs.bar) then
			ComboBoxSetSelectedMenuItem(GeneralSettings .. "LayoutComboBox", 2)
		else
			ComboBoxSetSelectedMenuItem(GeneralSettings .. "LayoutComboBox", 1)
		end

		j = CDownVar.refresh
		ComboBoxSetSelectedMenuItem(GeneralSettings .. "RefreshComboBox", j)

		j = CDownVar.optCDs.CDorder
		ComboBoxSetSelectedMenuItem(GeneralSettings .. "SortOrderComboBox", j)

		j = CDownVar.minCD
		ComboBoxSetSelectedMenuItem(GeneralSettings .. "MinCDComboBox", j)

		j = CDownVar.maxCD
		ComboBoxSetSelectedMenuItem(GeneralSettings .. "MaxCDComboBox", j)

	elseif (i == 2) then
		LabelSetTextColor("CDown_SettingsGeneralButton_Text", 255, 255, 255)
		LabelSetTextColor("CDown_SettingsLayoutButton_Text", 255, 204, 102)
		LabelSetTextColor("CDown_SettingsColorButton_Text", 255, 255, 255)

		WindowSetShowing("CDown_Settings_GeneralSettings", false)
		WindowSetShowing("CDown_Settings_NLayoutSettings", not CDownVar.optCDs.bar)
		WindowSetShowing("CDown_Settings_SLayoutSettings", CDownVar.optCDs.bar)
		WindowSetShowing("CDown_Settings_ColorSettings", false)

		if (CDownVar.optCDs.bar) then
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "MaxCountComboBox",CDownVar.optCDs.bar_maxCDCount)
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "FontComboBox", CDownVar.optCDs.tfont)
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "NameFontComboBox", CDownVar.optCDs.nfont)
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "GrowLeftComboBox", CDownVar.optCDs.growleft)
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "GrowUpComboBox", CDownVar.optCDs.growup)
			ComboBoxSetSelectedMenuItem(SLayoutSettings .. "GrowHorizontalComboBox", CDownVar.optCDs.horizontal)
			ButtonSetPressedFlag(SLayoutSettings .. "BorderCheckBoxButton", CDownVar.optCDs.showborder)
			ButtonSetPressedFlag(SLayoutSettings .. "GlassCheckBoxButton", CDownVar.optCDs.glass)

			if (CDownVar.optCDs.horizontal == 2) then
				ButtonSetDisabledFlag(SLayoutSettings .. "ShowNameCheckBoxButton", true)
				CDownVar.optCDs.name = false
			end
			ButtonSetPressedFlag(SLayoutSettings .. "ShowNameCheckBoxButton", CDownVar.optCDs.name)

			ButtonSetPressedFlag(SLayoutSettings .. "HPTECheckBoxButton", CDownVar.optCDs.hpte)
			ButtonSetPressedFlag(SLayoutSettings .. "CDBelowCheckBoxButton", (CDownVar.optCDs.CDsbelow == 1))
			ButtonSetPressedFlag(SLayoutSettings .. "BEndCheckBoxButton", CDownVar.optCDs.bend)
			ButtonSetPressedFlag(SLayoutSettings .. "BackCheckBoxButton", CDownVar.optCDs.back)
			LabelSetText(SLayoutSettings .. "LengthNumText", towstring(CDownVar.optCDs.width))
			SliderBarSetCurrentPosition(SLayoutSettings .. "LengthSlider", (CDownVar.optCDs.width - 50) / 200)
		else
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "RowComboBox", CDownVar.optCDs.rowcount)
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "CountComboBox", CDownVar.optCDs.CDRowStride)
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "FontComboBox", CDownVar.optCDs.tfont)
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "GrowLeftComboBox", CDownVar.optCDs.growleft)
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "GrowUpComboBox", CDownVar.optCDs.growup)
			ComboBoxSetSelectedMenuItem(NLayoutSettings .. "GrowHorizontalComboBox", CDownVar.optCDs.horizontal)
			ButtonSetPressedFlag(NLayoutSettings .. "TimerBelowCheckBoxButton", (CDownVar.optCDs.CDsbelow == 1))
			ButtonSetPressedFlag(NLayoutSettings .. "FadingCheckBoxButton", (CDownVar.optCDs.fade_start > 0))
			ButtonSetPressedFlag(NLayoutSettings .. "BorderCheckBoxButton", CDownVar.optCDs.showborder)
			ButtonSetPressedFlag(NLayoutSettings .. "GlassCheckBoxButton", CDownVar.optCDs.glass)
			ButtonSetPressedFlag(NLayoutSettings .. "HPTECheckBoxButton", CDownVar.optCDs.hpte)
		end
	elseif (i == 3) then
		WindowSetShowing("CDown_Settings_GeneralSettings", false)
		WindowSetShowing("CDown_Settings_NLayoutSettings", false)
		WindowSetShowing("CDown_Settings_SLayoutSettings", false)
		WindowSetShowing("CDown_Settings_ColorSettings", true)

		LabelSetTextColor("CDown_SettingsGeneralButton_Text", 255, 255, 255)
		LabelSetTextColor("CDown_SettingsLayoutButton_Text", 255, 255, 255)
		LabelSetTextColor("CDown_SettingsColorButton_Text", 255, 204, 102)

		activeItem = -1

		ComboBoxSetSelectedMenuItem(ColorSettings .. "CSettingComboBox", CDownVar.color)

		if (CDownVar.color == 1) then
			WindowSetShowing(ColorSettings .. "SingleColor", false)
			WindowSetShowing(ColorSettings .. "AbilityColor", false)
		elseif (CDownVar.color == 2) then
			CDownSettings.ColorTable = CDownVar.CPA[tostring(GameData.Account.ServerName)..tostring(GameData.Player.name)]
			UpdateABCtable()
			UpdateABCColor()
			WindowSetShowing(ColorSettings .. "SingleColor", false)
			WindowSetShowing(ColorSettings .. "AbilityColor", true)
		elseif (CDownVar.color == 3) then
			WindowSetShowing(ColorSettings .. "SingleColor", true)
			WindowSetShowing(ColorSettings .. "AbilityColor", false)
			UpdateSCColor()
		else
			CDownVar.color = 1
			WindowSetShowing(ColorSettings .. "SingleColor", false)
			WindowSetShowing(ColorSettings .. "AbilityColor", false)
		end

		ListBoxSetDisplayOrder( "CDown_Settings_ColorSettings_ScrollChild_AbilityColor_ColorList", GetACListDisplayOrder() )
	end
end
-- SHOWTABS END


-- INIT BEGIN
function CDownSettings.Create()
	CreateWindow("CDown_Settings", false)

	SetLabels()
	PopulateComboBoxes()

	local color = GameDefs.RowColors[0]
	WindowSetTintColor("CDown_SettingsGeneralButton", color.r, color.g, color.b);
	WindowSetAlpha("CDown_SettingsGeneralButton_Background", color.a);
	WindowSetTintColor("CDown_SettingsLayoutButton", color.r, color.g, color.b);
	WindowSetAlpha("CDown_SettingsLayoutButton_Background", color.a);
	WindowSetTintColor("CDown_SettingsColorButton", color.r, color.g, color.b);
	WindowSetAlpha("CDown_SettingsColorButton_Background", color.a);

	DataUtils.SetListRowAlternatingTints( "CDown_Settings_ColorSettings_ScrollChild_AbilityColor_ColorList", 8 )
	ListBoxSetDisplayOrder( "CDown_Settings_ColorSettings_ScrollChild_AbilityColor_ColorList", GetACListDisplayOrder() )

end
-- INIT END

function CDownSettings.ShowGeneralOptions()
	ShowTab(1)
end
function CDownSettings.ShowLayoutOptions()
	ShowTab(2)
end
function CDownSettings.ShowColorOptions()
	ShowTab(3)
end


function CDownSettings.ToggleTestmode()
	if (CDown.UpdateCD_bak) then
		CDown.StopTestmode()
	else
		CDown.StartTestmode()
	end
	SetTMBL()
end


-- ComboBoxes BEGIN
function CDownSettings.LayoutChanged()
	CDownVar.optCDs.bar = (ComboBoxGetSelectedMenuItem(GeneralSettings .. "LayoutComboBox") == 2)
	UpdateMaxCDCount()
	PopulateRefreshComboBoxText()
	ComboBoxSetSelectedMenuItem(GeneralSettings .. "RefreshComboBox", 2)
	CDownSettings.RefreshChanged()
end
function CDownSettings.RefreshChanged()
	local index = ComboBoxGetSelectedMenuItem(GeneralSettings .. "RefreshComboBox")
	CDownVar.refresh = index
end
function CDownSettings.OrderChanged()
	CDownVar.optCDs.CDorder = ComboBoxGetSelectedMenuItem(GeneralSettings .. "SortOrderComboBox")
end
function CDownSettings.MinCDChanged()
	local index = ComboBoxGetSelectedMenuItem(GeneralSettings .. "MinCDComboBox")
	CDownVar.minCD = index
end
function CDownSettings.MaxCDChanged()
	local index = ComboBoxGetSelectedMenuItem(GeneralSettings .. "MaxCDComboBox")
	CDownVar.maxCD = index
end
function CDownSettings.RowChanged()
	local index = 1
	index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "RowComboBox")

	CDownVar.optCDs.rowcount = index
	UpdateMaxCDCount()
end
function CDownSettings.CountChanged()
	local index = 1
	index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "CountComboBox")

	CDownVar.optCDs.CDRowStride = index
	UpdateMaxCDCount()
end
function CDownSettings.SMaxCountChanged()
	local index = 1
	index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "MaxCountComboBox")

	CDownVar.optCDs.bar_maxCDCount = index
	UpdateMaxCDCount()
end
function CDownSettings.TimerFontChanged()
	local index = 1
	if (CDownVar.optCDs.bar) then
		index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "FontComboBox")
	else
		index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "FontComboBox")
	end
	CDownVar.optCDs.tfont = index
end
function CDownSettings.ABNameFontChanged()
	index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "NameFontComboBox")
	CDownVar.optCDs.nfont = index
end
function CDownSettings.GrowLeftChanged()
	local index = 1
	if (CDownVar.optCDs.bar) then
		index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "GrowLeftComboBox")
	else
		index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "GrowLeftComboBox")
	end
	CDownVar.optCDs.growleft = index
end
function CDownSettings.GrowUpChanged()
	local index = 1
	if (CDownVar.optCDs.bar) then
		index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "GrowUpComboBox")
	else
		index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "GrowUpComboBox")
	end
	CDownVar.optCDs.growup = index
end
function CDownSettings.GrowHorizontalChanged()
	local index = 1
	if (CDownVar.optCDs.bar) then
		index = ComboBoxGetSelectedMenuItem(SLayoutSettings .. "GrowHorizontalComboBox")
		if (index == 2) then
			ButtonSetDisabledFlag(SLayoutSettings .. "ShowNameCheckBoxButton", true)
			CDownVar.optCDs.name = false
			ButtonSetPressedFlag( SLayoutSettings .. "ShowNameCheckBoxButton", false )
		else
			ButtonSetDisabledFlag(SLayoutSettings .. "ShowNameCheckBoxButton", false)
		end
	else
		index = ComboBoxGetSelectedMenuItem(NLayoutSettings .. "GrowHorizontalComboBox")
	end
	CDownVar.optCDs.horizontal = index
end
function CDownSettings.CSettingChanged()
	CDownVar.color = ComboBoxGetSelectedMenuItem(ColorSettings .. "CSettingComboBox")
	CDownSettings.ShowColorOptions()
end
-- ComboBoxes END

--Slider

function CDownSettings.OnSlideLength(pos)
	local addedlength = 200 * pos

	CDownVar.optCDs.width = math.floor(50 + addedlength + 0.5)
	LabelSetText(SLayoutSettings .. "LengthNumText", towstring(CDownVar.optCDs.width))
end

--Slider END

--CheckBox
local function NTimerBelowChanged(pressed)
	if (pressed) then
		CDownVar.optCDs.CDsbelow = 1
	else
		CDownVar.optCDs.CDsbelow = 0
	end
end
local function NFadingChanged(pressed)
	if (pressed) then
		CDownVar.optCDs.fade_start = 5
	else
		CDownVar.optCDs.fade_start = 0
	end
end
local function NBorderChanged(pressed)
	CDownVar.optCDs.showborder = pressed
end
local function NGlassChanged(pressed)
	CDownVar.optCDs.glass = pressed
end
local function ShowNameChanged(pressed)
	CDownVar.optCDs.name = pressed
end
local function HPTEChanged(pressed)
	CDownVar.optCDs.hpte = pressed
end
local function BEndChanged(pressed)
	CDownVar.optCDs.bend = pressed
end
local function BackChanged(pressed)
	CDownVar.optCDs.back = pressed
end
--CheckBox END

function CDownSettings.CheckBox()
	local actwnd		= SystemData.ActiveWindow.name
	local buttonName	= actwnd.."Button"

	if( ButtonGetDisabledFlag( buttonName ) ) then
		return
	end

	local pressed = ButtonGetPressedFlag( buttonName )
	ButtonSetPressedFlag( buttonName, not pressed )

	if (actwnd == NLayoutSettings .. "TimerBelowCheckBox") then
		NTimerBelowChanged(not pressed)
	elseif (actwnd == NLayoutSettings .. "FadingCheckBox") then
		NFadingChanged(not pressed)
	elseif (actwnd == NLayoutSettings .. "BorderCheckBox") then
		NBorderChanged(not pressed)
	elseif (actwnd == NLayoutSettings .. "GlassCheckBox") then
		NGlassChanged(not pressed)
	elseif (actwnd == NLayoutSettings .. "HPTECheckBox") then
		HPTEChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "BorderCheckBox") then
		NBorderChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "GlassCheckBox") then
		NGlassChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "ShowNameCheckBox") then
		ShowNameChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "HPTECheckBox") then
		HPTEChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "CDBelowCheckBox") then
		NTimerBelowChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "BEndCheckBox") then
		BEndChanged(not pressed)
	elseif (actwnd == SLayoutSettings .. "BackCheckBox") then
		BackChanged(not pressed)
	end
end

function CDownSettings.OnSlideABCRed(pos)
	if (activeItem > 0 and CDownSettings.ColorTable[activeItem] ~= nil) then
		CDownSettings.ColorTable[activeItem][1] = math.floor(pos * 255)
	end
	UpdateABCPreview()
end

function CDownSettings.OnSlideABCGreen(pos)
	if (activeItem > 0 and CDownSettings.ColorTable[activeItem] ~= nil) then
		CDownSettings.ColorTable[activeItem][2] = math.floor(pos * 255)
	end
	UpdateABCPreview()
end

function CDownSettings.OnSlideABCBlue(pos)
	if (activeItem > 0 and CDownSettings.ColorTable[activeItem] ~= nil) then
		CDownSettings.ColorTable[activeItem][3] = math.floor(pos * 255)
	end
	UpdateABCPreview()
end

function CDownSettings.OnSlideSCRed(pos)
	CDownVar.CP[1] = math.floor(pos * 255)
	UpdateSCPreview()
end

function CDownSettings.OnSlideSCGreen(pos)
	CDownVar.CP[2] = math.floor(pos * 255)
	UpdateSCPreview()
end

function CDownSettings.OnSlideSCBlue(pos)
	CDownVar.CP[3] = math.floor(pos * 255)
	UpdateSCPreview()
end

function CDownSettings.ColorListOnLButtonUp()
	local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
	activeItem = ListBoxGetDataIndex(ColorSettings .. "AbilityColor_ColorList", selectedRow)
	CDownSettings.PopulateColorList()
	UpdateABCColor()
end

function CDownSettings.PopulateColorList()
	if (CDown_Settings_ColorSettings_ScrollChild_AbilityColor_ColorList.PopulatorIndices ~= nil) then
		for row, effectdata in ipairs(CDown_Settings_ColorSettings_ScrollChild_AbilityColor_ColorList.PopulatorIndices) do
			local rowWindow = ColorSettings .. "AbilityColor_ColorListRow" .. row

			LabelSetText(rowWindow .. "Name", GetAbilityName(effectdata))

			local text, x, y = GetIconData(GetAbilityData(effectdata)["iconNum"])
			DynamicImageSetTexture(rowWindow .. "Icon", text, x, y)

			if (effectdata == activeItem) then
				LabelSetTextColor(rowWindow.."Name", 255, 204, 102)
			else
				LabelSetTextColor(rowWindow.."Name", 255, 255, 255)
			end
		end
	end
end

-- OPEN / CLOSE FUNCTIONS BEGIN
function CDownSettings.Show()
	WindowSetShowing("CDown_Settings",true)
	CDownSettings.ShowGeneralOptions()
end

function CDownSettings.CloseOptionswindow()
	CDown.RestartTracker()
	WindowSetShowing("CDown_Settings",false)
end
-- OPEN / CLOSE FUNCTIONS END
