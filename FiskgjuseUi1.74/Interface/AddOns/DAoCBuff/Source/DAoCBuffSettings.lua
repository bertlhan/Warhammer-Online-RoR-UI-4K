--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################


DAoCBuffSettings = {}

local pairs = pairs
local ipairs = ipairs
local ComboBoxClearMenuItems = ComboBoxClearMenuItems
local ComboBoxGetSelectedMenuItem = ComboBoxGetSelectedMenuItem
local ComboBoxAddMenuItem = ComboBoxAddMenuItem
local ListBoxSetDisplayOrder = ListBoxSetDisplayOrder
local DynamicImageSetTexture = DynamicImageSetTexture
local LabelSetText = LabelSetText
local ButtonSetText = ButtonSetText
local towstring = towstring
local tostring = tostring

local FrameTab = "DAoCBuff_Settings_FrameSettings_ScrollChild_"
local ListManagerTab = "DAoCBuff_Settings_ListManagerSettings_ScrollChild_"
local GeneralTab = "DAoCBuff_Settings_GeneralSettings_ScrollChild_"
local FilterWindow = "DAoCBuff_Settings_FilterFrame_ScrollChild_"

local activewindow = {name=L"", index=0}
local activefilter  = {name=L"", index=0}
local activeconditionindex
local activeleftitem = 0
local activerightitem = 0
local buggylists={"DAoCBuff_SettingsList",ListManagerTab.."LeftList",ListManagerTab.."RightList",FrameTab.."FilterList"}

local BUFFS_PER_ROW 	= { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
local BUFF_ROWS 		= { 1, 2, 3, 4 }
local GROWLEFT 			= { "left to right", "right to left" }
local GROWUP 			= { "downwards", "upwards" }
local HORIZONTAL 		= { "vertical", "horizontal" }
local FONTTEXT 			= { "small", "medium", "large", "large bold" }
local PERMABUFFS 		= { "beginning", "ending" }
local BUFFORDER 		= { "descending", "ascending" }

local BUFF_REFRESH_DELAY= { 0.25, 0.5, 0.75, 1.0 }
local FRAME_TARGET		= { "Self", "Friendly", "Hostile", "Group" }
local FRAME_TARGET_HEAD	= { "Friendly", "Hostile" }
local FRAME_DIVIDE		= { "All Effects", "Buffs", "Debuffs" }
local FRAME_TYPE		= { "DAoCBuff (Classic)", "Headframes" }

local ACTIVE_CONDITION = {}
local STICKY_FRAMES = {}

DAoCBuffSettings.TmpFilter = {}
DAoCBuffSettings.LeftTable = {}
DAoCBuffSettings.RelocateLeftTable={}
DAoCBuffSettings.RightTable = {}
DAoCBuffSettings.RelocateRightTable={}

local function UpdateLeftList()
	ListBoxSetDisplayOrder( "DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList", DAoCBuffSettings.CreateLeftListDisplayOrder() )
end

local function UpdateRightList()
	ListBoxSetDisplayOrder( "DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList", DAoCBuffSettings.CreateRightListDisplayOrder() )
end

function DAoCBuffSettings.CreateOptionswindow()

	CreateWindow("DAoCBuff_Settings", false)
	WindowSetShowing("DAoCBuff_Settings", false)

	local color = GameDefs.RowColors[0]
	WindowSetTintColor("DAoCBuff_SettingsGeneralButton", color.r, color.g, color.b)
	WindowSetAlpha("DAoCBuff_SettingsGeneralButtonBackground", color.a)

	WindowSetTintColor("DAoCBuff_SettingsListMngrButton", color.r, color.g, color.b)
	WindowSetAlpha("DAoCBuff_SettingsListMngrButtonBackground", color.a)

	DataUtils.SetListRowAlternatingTints( "DAoCBuff_SettingsList", 12 )
	DataUtils.SetListRowAlternatingTints( FrameTab .. "FilterList", 5 )
	DataUtils.SetListRowAlternatingTints( ListManagerTab .. "LeftList", 8 )
	DataUtils.SetListRowAlternatingTints( ListManagerTab .. "RightList", 8 )

	ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )

	DAoCBuffSettings.SetLabels()

	WindowSetHandleInput("DAoCBuff_Settings", false)
	DAoCBuffSettings.FilterSettings.Create()
	DAoCBuffSettings.ImExport.Create()
end

function DAoCBuffSettings.OpenOptionswindow()
	activewindow.name = "General Settings"
	activewindow.index= -1
	DAoCBuffSettings.PopulateList()
	DAoCBuffSettings.Change_Setting()

	WindowSetShowing("DAoCBuff_Settings", true)
	for i,k in ipairs(buggylists)
	do
		WindowSetShowing(k,true)
	end
	if (not WindowGetHandleInput("DAoCBuff_Settings")) then
		WindowSetHandleInput("DAoCBuff_Settings", true)
		WindowStartAlphaAnimation ("DAoCBuff_Settings", Window.AnimationType.SINGLE_NO_RESET, 0, 1, 0.75, false, 0, 0)
	end

	DAoCBuffSettings.LeftTable = DAoCBuffVar.Tables[GameData.BuffTargetType.SELF]
	DAoCBuffSettings.RightTable = DAoCBuffVar.Tables[GameData.BuffTargetType.TARGET_FRIENDLY]
end

local ti
function DAoCBuffSettings.UC()
	local alpha=WindowGetAlpha("DAoCBuff_Settings")
	if(alpha==1)
	then
		ti = ti+1
		if(ti==2)
		then
			ti=0
			if (WindowGetHandleInput("DAoCBuff_Settings")) then
				WindowSetHandleInput("DAoCBuff_Settings", false)
				WindowStartAlphaAnimation ("DAoCBuff_Settings", Window.AnimationType.EASE_OUT, 1, 0, 0.5, true, 0, 0)
				for i,k in ipairs(buggylists)
				do
					WindowSetShowing(k,false)
				end
			end
		end
	elseif(alpha==0)
	then
		WindowSetShowing("DAoCBuff_Settings",false)
		UnregisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.UC")
	end
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.CloseOptionswindow()
--# Surprise, surprise ... this is used to close the Settingswindow ,)
--#
--# Parameters:
--#
--# Returns:
--#
--# Notes:
--# 	Do not use an other way to close the Settingswindow, we have to restart the Trackers
--# 	or changed settings will not apply !!!
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.CloseOptionswindow()

	activewindow.name = "General Settings"
	activewindow.index= -1

	WindowSetShowing("DAoCBuff_Settings", true)
	ButtonSetPressedFlag(GeneralTab .. "ToggleTestModeCheckBoxButton", false)

	ti=0
	DAoCBuffSettings.RestartTracker()
	RegisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.UC")
end

function DAoCBuffSettings.Disable()
	if(WindowGetHandleInput("DAoCBuff_Settings")==true)
	then
		WindowSetHandleInput("DAoCBuff_Settings",false)
		WindowStartAlphaAnimation("DAoCBuff_Settings",Window.AnimationType.SINGLE_NO_RESET,1,0.7,0.4,true,0,0)
	end
end

function DAoCBuffSettings.Reactivate()
	if(WindowGetHandleInput("DAoCBuff_Settings")==false)
	then
		WindowSetHandleInput("DAoCBuff_Settings",true)
		WindowStartAlphaAnimation("DAoCBuff_Settings",Window.AnimationType.SINGLE_NO_RESET,0.7,1,0.4,true,0,0)
	end
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.ShowGeneralOptions()
--# Called when you click on General Settings Button
--#
--# Parameters:
--#
--# Returns:
--#
--# Notes:
--# 	Used to show the General Settings
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.ShowGeneralOptions()
	activewindow.name = "General Settings"
	activewindow.index= -1
	DAoCBuffSettings.PopulateList()
	DAoCBuffSettings.Change_Setting()
end

function DAoCBuffSettings.ShowListManager()
	activewindow.name = "Manage Lists"
	activewindow.index= -2
	DAoCBuffSettings.PopulateList()
	DAoCBuffSettings.Change_Setting()
end

function DAoCBuffSettings.FrameSettingsRowItemOnLButtonUp()
	local Row = SystemData.ActiveWindow.name
	for i,k in ipairs(DAoCBuffVar.Frames) do
		if (k.name == LabelGetText(Row.."Name")) then
			activewindow.name = k.name 
			activewindow.index= i
		end
	end

	DAoCBuffSettings.Change_Setting()
	DAoCBuffSettings.PopulateList()
end

function DAoCBuffSettings.FilterRowOnLButtonUp()
	local name = LabelGetText(SystemData.ActiveWindow.name.."Name")

	for i,k in ipairs(DAoCBuffSettings.TmpFilter) do
		if (k.name == name) then
			activefilter.name = k.name 
			activefilter.index= i
			break
		end
	end
	DAoCBuffSettings.PopulateFilter()
end

function DAoCBuffSettings.EditFilterOnLButtonUp()
	if(DAoCBuffSettings.TmpFilter~=nil and activefilter.index>0)
	then
		local filter=DAoCBuffSettings.TmpFilter[activefilter.index]
		if(filter~=nil)
		then
			DAoCBuffSettings.FilterSettings.Open(filter,DAoCBuffVar.Frames[activewindow.index].type)
		end
	end
end

function DAoCBuffSettings.LeftListOnLButtonUp()
	local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
	activeleftitem = DAoCBuffSettings.RelocateLeftTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList", selectedRow)]
	DAoCBuffSettings.PopulateLeftListManager()
	DAoCBuffSettings.PopulateEffect()
end

function DAoCBuffSettings.RightListOnLButtonUp()
	local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
	activerightitem = DAoCBuffSettings.RelocateRightTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList", selectedRow)]
	DAoCBuffSettings.PopulateRightListManager()
end

function DAoCBuffSettings.LeftListOnRButtonUp()
	if (ButtonGetPressedFlag(ListManagerTab .. "RightClickCopyCheckBoxButton") and (ComboBoxGetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox")~=2)) then
		local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
		activeleftitem = DAoCBuffSettings.RelocateLeftTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList", selectedRow)]
		DAoCBuffSettings.PopulateLeftListManager()
		DAoCBuffSettings.CopyLeftToRight()
	end
end

function DAoCBuffSettings.RightListOnRButtonUp()
	if (ButtonGetPressedFlag(ListManagerTab .. "RightClickCopyCheckBoxButton")) then
		local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
		activerightitem = DAoCBuffSettings.RelocateRightTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList", selectedRow)]
		DAoCBuffSettings.PopulateRightListManager()
		DAoCBuffSettings.CopyRightToLeft()
	end
end

function DAoCBuffSettings.RightListOnMouseOver()
	local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
	local index = DAoCBuffSettings.RelocateRightTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList", selectedRow)]

	local name = DAoCBuffSettings.RightTable[index].name .. L" (".. index .. L")"
	local effecttext = DAoCBuffSettings.RightTable[index].effectText

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, nil)
	Tooltips.SetTooltipColorDef(1, 1, Tooltips.COLOR_HEADING)
	Tooltips.SetTooltipColorDef(3, 1, Tooltips.COLOR_BODY)

	local tooltip_anchor = { Point = "center",	RelativeTo = SystemData.ActiveWindow.name, RelativePoint = "topleft",	XOffset = 0, YOffset = 8 }
	Tooltips.AnchorTooltip(tooltip_anchor)
	Tooltips.SetTooltipText(1, 1, name)
	if(effecttext~=nil)then Tooltips.SetTooltipText(3, 1, effecttext) end
	Tooltips.Finalize()
end

function DAoCBuffSettings.LeftListOnMouseOver()
	local selectedRow = WindowGetId(SystemData.ActiveWindow.name)
	local index = DAoCBuffSettings.RelocateLeftTable[ListBoxGetDataIndex("DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList", selectedRow)]

	local name = DAoCBuffSettings.LeftTable[index].name .. L" (".. index .. L")"
	local effecttext = DAoCBuffSettings.LeftTable[index].effectText

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, nil)
	Tooltips.SetTooltipColorDef(1, 1, Tooltips.COLOR_HEADING)
	Tooltips.SetTooltipColorDef(3, 1, Tooltips.COLOR_BODY)

	local tooltip_anchor = { Point = "center",	RelativeTo = SystemData.ActiveWindow.name, RelativePoint = "topleft",	XOffset = 0, YOffset = 8 }
	Tooltips.AnchorTooltip(tooltip_anchor)
	Tooltips.SetTooltipText(1, 1, name)
	if(effecttext~=nil)then Tooltips.SetTooltipText(3, 1, effecttext) end
	Tooltips.Finalize()
end
function DAoCBuffSettings.Change_Setting()
	if (activewindow.index == -1) then
		LabelSetTextColor("DAoCBuff_SettingsGeneralButtonName", 255, 204, 102)
		LabelSetTextColor("DAoCBuff_SettingsListMngrButtonName", 255, 255, 255)
	elseif (activewindow.index == -2) then
		LabelSetTextColor("DAoCBuff_SettingsGeneralButtonName", 255, 255, 255)
		LabelSetTextColor("DAoCBuff_SettingsListMngrButtonName", 255, 204, 102)
	else
		LabelSetTextColor("DAoCBuff_SettingsGeneralButtonName", 255, 255, 255)
		LabelSetTextColor("DAoCBuff_SettingsListMngrButtonName", 255, 255, 255)
	end

	DAoCBuffSettings.PopulateSettings()
end

function DAoCBuffSettings.PopulateSettings()
	if (activewindow.index == -1) then
		ButtonSetPressedFlag(GeneralTab .. "KillBuffsCheckBoxButton", DAoCBuffVar.killbuffs)

		DAoCBuffSettings.PopulateGlobalChangeComboBoxes()

		WindowSetShowing("DAoCBuff_Settings_GeneralSettings_ScrollChild", true)
		WindowSetShowing("DAoCBuff_Settings_ListManagerSettings", false)
		WindowSetShowing("DAoCBuff_Settings_FrameSettings", false)
	elseif (activewindow.index == -2) then
		LabelSetText(ListManagerTab .. "AddListEditErrorText", L"")
		TextEditBoxSetText(ListManagerTab .. "AddListEditBox", L"")

		DAoCBuffSettings.PopulateRemoveLists()
		DAoCBuffSettings.PopulateListComboBoxes()
		UpdateRightList()
		UpdateLeftList()

		WindowSetShowing("DAoCBuff_Settings_GeneralSettings_ScrollChild", false)
		WindowSetShowing("DAoCBuff_Settings_ListManagerSettings", true)
		WindowSetShowing("DAoCBuff_Settings_FrameSettings", false)
	else

		WindowSetShowing("DAoCBuff_Settings_GeneralSettings_ScrollChild", false)
		WindowSetShowing("DAoCBuff_Settings_ListManagerSettings", false)

		activefilter.name = L""
		activefilter.index= 0

		ComboBoxSetSelectedMenuItem(FrameTab .. "CountComboBox", DAoCBuffVar.Frames[activewindow.index].buffRowStride)
		ComboBoxSetSelectedMenuItem(FrameTab .. "RowComboBox", DAoCBuffVar.Frames[activewindow.index].rowcount)
		ComboBoxSetSelectedMenuItem(FrameTab .. "GrowLeftComboBox", DAoCBuffVar.Frames[activewindow.index].growleft)
		ComboBoxSetSelectedMenuItem(FrameTab .. "GrowUpComboBox", DAoCBuffVar.Frames[activewindow.index].growup)
		ComboBoxSetSelectedMenuItem(FrameTab .. "GrowHorizontalComboBox", DAoCBuffVar.Frames[activewindow.index].horizontal)
		ComboBoxSetSelectedMenuItem(FrameTab .. "FontComboBox", DAoCBuffVar.Frames[activewindow.index].font)

		if (DAoCBuffVar.Frames[activewindow.index].buffsbelow == 1) then
			ButtonSetPressedFlag(FrameTab .. "BuffsBelowCheckBoxButton", true)
		else
			ButtonSetPressedFlag(FrameTab .. "BuffsBelowCheckBoxButton", false)
		end

		ButtonSetPressedFlag(FrameTab .. "HideLongtimeCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].longtimehide)
		ButtonSetPressedFlag(FrameTab .. "LongtoPermaCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].longtoperma)
		ButtonSetPressedFlag(FrameTab .. "ShowBorderCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].showborder)
		ButtonSetPressedFlag(FrameTab .. "GlassCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].glass)
		ButtonSetPressedFlag(FrameTab .. "HPTECheckBoxButton", DAoCBuffVar.Frames[activewindow.index].hpte)

		ComboBoxSetSelectedMenuItem(FrameTab .. "PermabuffsComboBox", DAoCBuffVar.Frames[activewindow.index].permabuffs)
		ComboBoxSetSelectedMenuItem(FrameTab .. "BufforderComboBox", DAoCBuffVar.Frames[activewindow.index].bufforder)

		TextEditBoxSetText(FrameTab .. "FrameNameEditBox", DAoCBuffVar.Frames[activewindow.index].name)
		LabelSetText(FrameTab .. "FrameNameEditErrorText", L"")

		ButtonSetPressedFlag(FrameTab .. "ActiveCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].active)

		ComboBoxSetSelectedMenuItem(FrameTab .. "TypeComboBox",DAoCBuffVar.Frames[activewindow.index].type)
		DAoCBuffSettings.ActivateType()
		DAoCBuffSettings.PopulateTarget()

		ComboBoxSetSelectedMenuItem(FrameTab .. "DivideComboBox", (DAoCBuffVar.Frames[activewindow.index].divide + 1))

		if (DAoCBuffVar.Frames[activewindow.index].ismine == 1) then
			ButtonSetPressedFlag(FrameTab .. "SelfEffectsCheckBoxButton", true)
		else
			ButtonSetPressedFlag(FrameTab .. "SelfEffectsCheckBoxButton", false)
		end

		local found = false
		for i,k in ipairs(BUFF_REFRESH_DELAY) do
			if (k == DAoCBuffVar.Frames[activewindow.index].update) then
				ComboBoxSetSelectedMenuItem(FrameTab .. "RefreshComboBox", i)
				found = true
				break
			end
		end
		if (not found) then
			DAoCBuffVar.Frames[activewindow.index].update = 0.5
			ComboBoxSetSelectedMenuItem(FrameTab .. "RefreshComboBox", 2)
		end

		ComboBoxClearMenuItems(FrameTab .. "StickComboBox")
		ComboBoxAddMenuItem(FrameTab .. "StickComboBox", L"---" )
		STICKY_FRAMES={{}}
		local stickindex = 1
		local o=1
		local stickname=DAoCBuffVar.Frames[activewindow.index].Stickname
		for i,k in ipairs(DAoCBuffVar.Frames) do
			if (i ~= activewindow.index and k.type==1 and k.buffTargetType<100) then
				ComboBoxAddMenuItem(FrameTab .. "StickComboBox", k.name )
				table.insert(STICKY_FRAMES,k)
				if(k.name==stickname)
				then
					stickindex=i+o
				end
			else
				o=o-1
			end
		end
		ComboBoxSetSelectedMenuItem(FrameTab .. "StickComboBox", stickindex)

		DAoCBuffSettings.StickChanged()

		activefilter.name = L""
		activefilter.index = 0

		ButtonSetPressedFlag(FrameTab .. "AdvancedFiltersCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].FA)
		ButtonSetPressedFlag(FrameTab .. "StaticCondenseCheckBoxButton", DAoCBuffVar.Frames[activewindow.index].staticcondense)

		DAoCBuffSettings.TmpFilter = DAoCBuffVar.Frames[activewindow.index].filters
		ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )

		WindowSetShowing("DAoCBuff_Settings_FrameSettings", true)
	end
end

function DAoCBuffSettings.PopulateGlobalChangeComboBoxes()
	ComboBoxClearMenuItems(GeneralTab .. "ChangeGlobalSizeComboBox")
	for i,k in ipairs(DAoCBuffVar.Frames) do
		ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalSizeComboBox",k.name)
	end
	ComboBoxSetSelectedMenuItem(GeneralTab .. "ChangeGlobalSizeComboBox", 0)

	ComboBoxClearMenuItems(GeneralTab .. "ChangeGlobalRefreshComboBox")
	for i,k in ipairs(BUFF_REFRESH_DELAY) do
		ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalRefreshComboBox", towstring(k) .. L"s" )
	end
	ComboBoxSetSelectedMenuItem(GeneralTab .. "ChangeGlobalRefreshComboBox", 0)

	ComboBoxClearMenuItems(GeneralTab .. "ChangeGlobalFontComboBox")
	for i,k in ipairs(FONTTEXT) do
		ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalFontComboBox", towstring(k) )
	end
	ComboBoxSetSelectedMenuItem(GeneralTab .. "ChangeGlobalFontComboBox", 0)

	ComboBoxClearMenuItems(GeneralTab .. "ChangeGlobalBorderComboBox")
	ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalBorderComboBox", L"enable border" )
	ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalBorderComboBox", L"disable border" )
	ComboBoxSetSelectedMenuItem(GeneralTab .. "ChangeGlobalBorderComboBox", 0)

	ComboBoxClearMenuItems(GeneralTab .. "ChangeGlobalGlassComboBox")
	ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalGlassComboBox", L"enable glass look" )
	ComboBoxAddMenuItem(GeneralTab .. "ChangeGlobalGlassComboBox", L"disable glass look" )
	ComboBoxSetSelectedMenuItem(GeneralTab .. "ChangeGlobalGlassComboBox", 0)
end

function DAoCBuffSettings.PopulateEffect()
	LabelSetText(ListManagerTab.."ApplyErrorText",L"")
	if((ComboBoxGetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox")==2) and ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.LeftTable[activeleftitem]~=nil)
	then
		local effect=DAoCBuffSettings.LeftTable[activeleftitem]
		if(effect.name~=nil)then TextEditBoxSetText(ListManagerTab.."NameEditBox",towstring(effect.name))
		else TextEditBoxSetText(ListManagerTab.."NameEditBox",L"") end
		if(effect.abilityId~=nil)then TextEditBoxSetText(ListManagerTab.."IDEditBox",towstring(effect.abilityId))
		else TextEditBoxSetText(ListManagerTab.."IDEditBox",L"") end
		if(effect.effectText~=nil)then TextEditBoxSetText(ListManagerTab.."DescEditBox",towstring(effect.effectText))
		else TextEditBoxSetText(ListManagerTab.."DescEditBox",L"") end
		if(type(activeleftitem)=="number")
		then
			LabelSetText(ListManagerTab.."ErrorText",L"")
		else
			LabelSetText(ListManagerTab.."ErrorText",L"This Effect has no ID,\nthis slows the Filter down.")
		end
	else
		TextEditBoxSetText(ListManagerTab.."NameEditBox",L"")
		TextEditBoxSetText(ListManagerTab.."IDEditBox",L"")
		TextEditBoxSetText(ListManagerTab.."DescEditBox",L"")
		LabelSetText(ListManagerTab.."ErrorText",L"")
	end
end

function DAoCBuffSettings.PopulateTarget()
	if(DAoCBuffVar.Frames[activewindow.index].type==1)
	then
		if (DAoCBuffVar.Frames[activewindow.index].buffTargetType == GameData.BuffTargetType.SELF) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 1)
		elseif (DAoCBuffVar.Frames[activewindow.index].buffTargetType == GameData.BuffTargetType.TARGET_FRIENDLY) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 2)
		elseif (DAoCBuffVar.Frames[activewindow.index].buffTargetType == GameData.BuffTargetType.TARGET_HOSTILE) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 3)
		elseif (DAoCBuffVar.Frames[activewindow.index].buffTargetType == 100) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 4)
			ComboBoxSetDisabledFlag(FrameTab .. "StickComboBox", true)
		end
	else
		if (DAoCBuffVar.Frames[activewindow.index].buffTargetType == GameData.BuffTargetType.TARGET_FRIENDLY) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 1)
		elseif (DAoCBuffVar.Frames[activewindow.index].buffTargetType == GameData.BuffTargetType.TARGET_HOSTILE) then
			ComboBoxSetSelectedMenuItem(FrameTab .. "TargetComboBox", 2)
		end
	end
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.SetLabels()
--# This is used to create the Labels in the optionswindow
--#
--# Parameters:
--#
--# Returns:
--#
--# Notes:
--# 	needed: Language support
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.SetLabels()

	LabelSetText("DAoCBuff_SettingsGeneralButtonName", L"General Settings")
	LabelSetText("DAoCBuff_SettingsListMngrButtonName", L"Manage Lists")
	ButtonSetText("DAoCBuff_SettingsReloadTrackers", L"Reload Frames")
	ButtonSetText("DAoCBuff_SettingsAddFrameButton", L"Add Frame")
	ButtonSetText("DAoCBuff_SettingsReloadTrackers", L"Reload Frames");
	ButtonSetText("DAoCBuff_SettingsAddFrameButton", L"Add Frame");

	LabelSetText(GeneralTab .. "GeneralSettingsLabel", L"General Settings")
	LabelSetText(GeneralTab .. "KillBuffsCheckBoxText", L"Kill all standard buffs")
	LabelSetText(GeneralTab .. "ToggleTestModeCheckBoxText", L"Testmode")
	ButtonSetText(GeneralTab .. "ImExportButton", L"Import/Export Settings")

	LabelSetText(GeneralTab .. "GlobalFrameSettingsLabel", L"Change Settings of all Frames")

	LabelSetText(GeneralTab .. "ChangeGlobalSizeText", L"Set size of all AKTIVE Frames to size of selected Frame")
	ButtonSetText(GeneralTab .. "ChangeGlobalSizeButton", L"Change Size")

	LabelSetText(GeneralTab .. "ChangeGlobalRefreshText", L"Change refresh delay of all Frames")
	ButtonSetText(GeneralTab .. "ChangeGlobalRefreshButton", L"Change Refresh Delay")

	LabelSetText(GeneralTab .. "ChangeGlobalFontText", L"Change font of all Frames")
	ButtonSetText(GeneralTab .. "ChangeGlobalFontButton", L"Change Font")

	LabelSetText(GeneralTab .. "ChangeGlobalBorderText", L"Change border of all Frames")
	ButtonSetText(GeneralTab .. "ChangeGlobalBorderButton", L"Change Border")

	LabelSetText(GeneralTab .. "ChangeGlobalGlassText", L"Change Glass look of all Frames")
	ButtonSetText(GeneralTab .. "ChangeGlobalGlassButton", L"Change Glass look")

	LabelSetText(ListManagerTab .. "ListSettingsLabel", L"Manage Lists for abilityId condition")

	ButtonSetText(ListManagerTab .. "CopyLeftToRight", L"Copy >>")
	ButtonSetText(ListManagerTab .. "CopyRightToLeft", L"<< Copy")

	ButtonSetText(ListManagerTab .. "MoveLeftToRight", L"Move >>")
	ButtonSetText(ListManagerTab .. "MoveRightToLeft", L"<< Move")

	ButtonSetText(ListManagerTab .. "RemoveLeft", L"Remove")
	ButtonSetText(ListManagerTab .. "RemoveRight", L"Remove")

	ButtonSetText(ListManagerTab .. "ClearLeft", L"Clear List")
	ButtonSetText(ListManagerTab .. "ClearRight", L"Clear List")

	LabelSetText(ListManagerTab .. "AddListEditBoxText", L"Add a new list")
	LabelSetText(ListManagerTab .. "AddListEditErrorText", L"")
	ButtonSetText(ListManagerTab .. "AddListEditBoxButton", L"Add")

	LabelSetText(ListManagerTab .. "RemoveListEditBoxText", L"Delete selected list")
	ButtonSetText(ListManagerTab .. "RemoveListEditBoxButton", L"Delete")

	LabelSetText(ListManagerTab .. "RightClickCopyCheckBoxText", L"Use right click to copy list items")

	ButtonSetText(ListManagerTab.."Add",L"Add New")
	LabelSetText(ListManagerTab.."ManagerModeComboText",L"List Manager Mode")
	ComboBoxAddMenuItem(ListManagerTab.."ManagerModeComboBox",L"Move Mode")
	ComboBoxAddMenuItem(ListManagerTab.."ManagerModeComboBox",L"Edit Mode")
	ComboBoxSetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox",1)
	DAoCBuffSettings.ManagerModeChanged()
	LabelSetText(ListManagerTab.."NameEditBoxText",L"Name:")
	LabelSetText(ListManagerTab.."IDEditBoxText",L"ID:")
	LabelSetText(ListManagerTab.."DescEditBoxText",L"Description:")
	ButtonSetText(ListManagerTab.."Apply",L"Apply")

--# Frame settings
	ButtonSetText(FrameTab .. "RemoveFrame", L"Delete Frame")

	LabelSetText(FrameTab .. "FrameSettingsLabel", L"Frame Settings")
	LabelSetText(FrameTab .. "FrameNameEditBoxText", L"Name of this Frame")
	LabelSetText(FrameTab .. "FrameNameEditErrorText", L"")
	ButtonSetText(FrameTab .. "FrameNameEditBoxButton", L"Change Name")
	LabelSetText(FrameTab .. "ActiveCheckBoxText", L"Active")

	LabelSetText(FrameTab .. "TypeComboText", L"Type")
	for i,k in ipairs(FRAME_TYPE) do
		ComboBoxAddMenuItem(FrameTab .. "TypeComboBox", towstring(k))
	end
	LabelSetText(FrameTab .. "TargetComboText", L"Target")
	for i,k in ipairs(FRAME_TARGET) do
		ComboBoxAddMenuItem(FrameTab .. "TargetComboBox", towstring(k))
	end
	LabelSetText(FrameTab .. "DivideComboText", L"Effects")
	for i,k in ipairs(FRAME_DIVIDE) do
		ComboBoxAddMenuItem(FrameTab .. "DivideComboBox", towstring(k))
	end
	LabelSetText(FrameTab .. "SelfEffectsCheckBoxText", L"Show only your effects")

	LabelSetText(FrameTab .. "RefreshComboText", L"Refresh delay")
	for i,k in ipairs(BUFF_REFRESH_DELAY) do
		ComboBoxAddMenuItem(FrameTab .. "RefreshComboBox", towstring(k) .. L"s" )
	end
	LabelSetText(FrameTab .. "StickComboText", L"Stick frame to")

	LabelSetText(FrameTab .. "LayoutLabel", L"Layout Options")
	LabelSetText(FrameTab .. "CountComboText", L"Number of Buffs per row")
	for i,k in ipairs(BUFFS_PER_ROW) do
		ComboBoxAddMenuItem(FrameTab .. "CountComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "RowComboText", L"Number of rows")
	for i,k in ipairs(BUFF_ROWS) do
		ComboBoxAddMenuItem(FrameTab .. "RowComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "GrowLeftComboText", L"Bufflist show grow from")
	for i,k in ipairs(GROWLEFT) do
		ComboBoxAddMenuItem(FrameTab .. "GrowLeftComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "GrowUpComboText", L"Bufflist show grow")
	for i,k in ipairs(GROWUP) do
		ComboBoxAddMenuItem(FrameTab .. "GrowUpComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "GrowHorizontalComboText", L"Bufflist show grow")
	for i,k in ipairs(HORIZONTAL) do
		ComboBoxAddMenuItem(FrameTab .. "GrowHorizontalComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "FontComboText", L"Font of timers")
	for i,k in ipairs(FONTTEXT) do
		ComboBoxAddMenuItem(FrameTab .. "FontComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "BuffsBelowCheckBoxText", L"Show timers below icons")
	LabelSetText(FrameTab .. "HideLongtimeCheckBoxText", L"Hide longtime effects in combat")
	LabelSetText(FrameTab .. "LongtoPermaCheckBoxText", L"Display longtime effects as permanent effects")
	LabelSetText(FrameTab .. "ShowBorderCheckBoxText", L"Show buffborder")
	LabelSetText(FrameTab .. "GlassCheckBoxText", L"Use glass look")
	LabelSetText(FrameTab .. "HPTECheckBoxText", L"High Precision at the end of a Timer")

	LabelSetText(FrameTab .. "SortLabel", L"Sorting Options")
	LabelSetText(FrameTab .. "PermabuffsComboText", L"Permanent Buff position")
	for i,k in ipairs(PERMABUFFS) do
		ComboBoxAddMenuItem(FrameTab .. "PermabuffsComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "BufforderComboText", L"Buffs are sorted by duration")
	for i,k in ipairs(BUFFORDER) do
		ComboBoxAddMenuItem(FrameTab .. "BufforderComboBox", towstring(k) )
	end
	LabelSetText(FrameTab .. "FilterLabel", L"Filter Settings")
	LabelSetText(FrameTab .. "AdvancedFiltersCheckBoxText", L"Enable advanced filters")
	LabelSetText(FrameTab .. "StaticCondenseCheckBoxText", L"Always show condensed icon")

	LabelSetText(FrameTab .. "FilterNameEditBoxText", L"Name of this Filter")
	LabelSetText(FrameTab .. "FilterNameEditErrorText", L"")
	ButtonSetText(FrameTab .. "FilterNameEditBoxButton", L"Change Name")

	ButtonSetText(FrameTab .. "AddFilterButton", L"Add Filter")
	ButtonSetText(FrameTab .. "RemoveFilterButton", L"Delete Filter")
	ButtonSetText(FrameTab .. "FilterEditButton", L"Edit Filter")

	LabelSetText(FrameTab .. "FilterUpButtonText", L"Move Filter Up")
	LabelSetText(FrameTab .. "FilterDownButtonText", L"Move Filter Down")
end

function DAoCBuffSettings.RestartTracker()
	DAoCBuff.U()
end

function DAoCBuffSettings.RestartTracker()
	DAoCBuff.U()
end

function DAoCBuffSettings.AddFrame()

	local newFrame =
	{
		active			=false,
		buffTargetType	=GameData.BuffTargetType.SELF,
		type			=1,
		maxBuffCount	=30,
		buffRowStride	=6,
		rowcount		=3,
		permabuffs		=1,
		bufforder		=1,
		buffsbelow		=0,
		growleft		=1,
		growup			=1,
		divide			=0,
		ismine			=0,
		horizontal		=2,
		update			=0.5,
		font			=3,
		longtimehide	=false,
		longtoperma		=false,
		showborder		=true,
		glass			=true,
		FA				=false,
		filters			={},
		staticcondense	=false,
		hpte			=false,
	}

	local i = 1
	local tmp_name
	repeat
		tmp_name = L"new_Frame" .. i
		i = i + 1
	until (not DAoCBuffSettings.CheckDuplicate(DAoCBuffVar.Frames, "name", tmp_name))

	newFrame.name = tmp_name


	table.insert(DAoCBuffVar.Frames, newFrame)

	ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )

	DAoCBuffSettings.PopulateGlobalChangeComboBoxes()
end

function DAoCBuffSettings.RemoveFrame()
	table.remove(DAoCBuffVar.Frames, activewindow.index)

	activewindow.index = -1
	activewindow.name  = L""

	DAoCBuffSettings.Change_Setting()

	ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )

	DAoCBuffSettings.PopulateGlobalChangeComboBoxes()
end

function DAoCBuffSettings.ChangeFrameName()
	local new = TextEditBoxGetText(FrameTab .. "FrameNameEditBox")
	local old = DAoCBuffVar.Frames[activewindow.index].name

	DAoCBuffSettings.ChangeName(old, new)
end

function DAoCBuffSettings.ManagerModeChanged()
	local move=(ComboBoxGetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox")~=2)
	local edit=not move

	WindowSetShowing(ListManagerTab.."RightClickCopyCheckBoxText",move)
	WindowSetShowing(ListManagerTab.."RightClickCopyCheckBox",move)
	WindowSetShowing(ListManagerTab.."RightListComboBox",move)
	WindowSetShowing(ListManagerTab.."RightList",move)
	WindowSetShowing(ListManagerTab.."CopyRightToLeft",move)
	WindowSetShowing(ListManagerTab.."MoveRightToLeft",move)
	WindowSetShowing(ListManagerTab.."CopyLeftToRight",move)
	WindowSetShowing(ListManagerTab.."MoveLeftToRight",move)
	WindowSetShowing(ListManagerTab.."RemoveRight",move)
	WindowSetShowing(ListManagerTab.."ClearRight",move)

	WindowSetShowing(ListManagerTab.."Add",edit)
	WindowSetShowing(ListManagerTab.."ErrorText",edit)
	WindowSetShowing(ListManagerTab.."NameEditBoxText",edit)
	WindowSetShowing(ListManagerTab.."NameEditBox",edit)
	WindowSetShowing(ListManagerTab.."IDEditBoxText",edit)
	WindowSetShowing(ListManagerTab.."IDEditBox",edit)
	WindowSetShowing(ListManagerTab.."DescEditBoxText",edit)
	WindowSetShowing(ListManagerTab.."DescEditBox",edit)
	WindowSetShowing(ListManagerTab.."Apply",edit)
	WindowSetShowing(ListManagerTab.."ApplyErrorText",edit)
	DAoCBuffSettings.PopulateEffect()
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.ActiveChanged()
--# Used when index of FrameTab .. "ActiveCheckBox" is pressed
--# 
--# Parameters:
--# 	checked				- (bool)		is the checkbox checked ?
--#
--# Returns:
--#
--# Notes:
--# 	Called in DAoCBuffSettings.ToggleCheckBox
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.ActiveChanged(checked)
	if (checked) then
		DAoCBuffVar.Frames[activewindow.index].active = true
	else
		DAoCBuffVar.Frames[activewindow.index].active = false
	end
	ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )
end

function DAoCBuffSettings.TypeChanged()
	DAoCBuffVar.Frames[activewindow.index].type=ComboBoxGetSelectedMenuItem(FrameTab .. "TypeComboBox")
	DAoCBuffSettings.ActivateType()
end

function DAoCBuffSettings.ActivateType()
	local disable=(DAoCBuffVar.Frames[activewindow.index].type~=1)
	ComboBoxSetDisabledFlag(FrameTab.."StickComboBox", disable)
	ComboBoxSetDisabledFlag(FrameTab.."RowComboBox", disable)
	ComboBoxSetDisabledFlag(FrameTab.."GrowLeftComboBox", disable)
	ComboBoxSetDisabledFlag(FrameTab.."GrowUpComboBox", disable)
	ComboBoxSetDisabledFlag(FrameTab.."GrowHorizontalComboBox", disable)

	ComboBoxClearMenuItems(FrameTab .. "TargetComboBox")
	if(disable)
	then
		for i,k in ipairs(FRAME_TARGET_HEAD) do
			ComboBoxAddMenuItem(FrameTab .. "TargetComboBox", towstring(k))
		end
		if(DAoCBuffVar.Frames[activewindow.index].buffTargetType~=GameData.BuffTargetType.TARGET_HOSTILE and DAoCBuffVar.Frames[activewindow.index].buffTargetType~=GameData.BuffTargetType.TARGET_FRIENDLY)
		then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType=GameData.BuffTargetType.TARGET_FRIENDLY
		end
	else
		for i,k in ipairs(FRAME_TARGET) do
			ComboBoxAddMenuItem(FrameTab .. "TargetComboBox", towstring(k))
		end
	end
	DAoCBuffSettings.PopulateTarget()
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.TargetChanged()
--# Called when index of FrameTab .. "TargetComboBox" is changed
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.TargetChanged()
	if(DAoCBuffVar.Frames[activewindow.index].type==1)
	then
		ComboBoxSetDisabledFlag(FrameTab .. "StickComboBox", false)
		if (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 1) then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = GameData.BuffTargetType.SELF
		elseif (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 2) then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = GameData.BuffTargetType.TARGET_FRIENDLY
		elseif (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 3) then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = GameData.BuffTargetType.TARGET_HOSTILE
		elseif (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 4) then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = 100
			ComboBoxSetDisabledFlag(FrameTab .. "StickComboBox", true)
		end
	else
		if (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 1)
		then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = GameData.BuffTargetType.TARGET_FRIENDLY
		elseif (ComboBoxGetSelectedMenuItem(FrameTab .. "TargetComboBox") == 2)
		then
			DAoCBuffVar.Frames[activewindow.index].buffTargetType = GameData.BuffTargetType.TARGET_HOSTILE
		end
	end
end

function DAoCBuffSettings.DivideChanged()
	DAoCBuffVar.Frames[activewindow.index].divide = (ComboBoxGetSelectedMenuItem(FrameTab .. "DivideComboBox") - 1)
end

function DAoCBuffSettings.SelfEffectsChanged(checked)
	if (checked) then
		DAoCBuffVar.Frames[activewindow.index].ismine = 1
	else
		DAoCBuffVar.Frames[activewindow.index].ismine = 2
	end
end

function DAoCBuffSettings.RefreshChanged()
	DAoCBuffVar.Frames[activewindow.index].update = BUFF_REFRESH_DELAY[ComboBoxGetSelectedMenuItem(FrameTab .. "RefreshComboBox")]
end

function DAoCBuffSettings.StickChanged()
	local sticktarget = STICKY_FRAMES[ComboBoxGetSelectedMenuItem(FrameTab .. "StickComboBox")]
	if(sticktarget~=nil)
	then
		local stickframe  = DAoCBuffVar.Frames[activewindow.index]
		stickframe.Stickname = sticktarget.name

		if (sticktarget.name ~= nil) then
			stickframe.growleft 	= sticktarget.growleft
			stickframe.growup		= sticktarget.growup
			stickframe.horizontal	= sticktarget.horizontal

			ComboBoxSetSelectedMenuItem(FrameTab .. "GrowLeftComboBox", stickframe.growleft)
			ComboBoxSetSelectedMenuItem(FrameTab .. "GrowUpComboBox", stickframe.growup)
			ComboBoxSetSelectedMenuItem(FrameTab .. "GrowHorizontalComboBox", stickframe.horizontal)

			DAoCBuffSettings.ActivateStickCombos(true)
		else
			DAoCBuffSettings.ActivateStickCombos(false)
		end
	end
end

function DAoCBuffSettings.ActivateStickCombos(active)
	if(DAoCBuffVar.Frames[activewindow.index].type==1)
	then
		ComboBoxSetDisabledFlag(FrameTab .. "GrowLeftComboBox", active)
		ComboBoxSetDisabledFlag(FrameTab .. "GrowUpComboBox", active)
		ComboBoxSetDisabledFlag(FrameTab .. "GrowHorizontalComboBox", active)
	end
end

function DAoCBuffSettings.CountChanged()
	DAoCBuffVar.Frames[activewindow.index].buffRowStride = ComboBoxGetSelectedMenuItem(FrameTab .. "CountComboBox")
	DAoCBuffSettings.ChangeBuffCount()
end

function DAoCBuffSettings.RowChanged()
	DAoCBuffVar.Frames[activewindow.index].rowcount = ComboBoxGetSelectedMenuItem(FrameTab .. "RowComboBox")
	DAoCBuffSettings.ChangeBuffCount()
end

function DAoCBuffSettings.GrowLeftChanged()
	DAoCBuffVar.Frames[activewindow.index].growleft = ComboBoxGetSelectedMenuItem(FrameTab .. "GrowLeftComboBox")
end

function DAoCBuffSettings.GrowUpChanged()
	DAoCBuffVar.Frames[activewindow.index].growup = ComboBoxGetSelectedMenuItem(FrameTab .. "GrowUpComboBox")
end

function DAoCBuffSettings.GrowHorizontalChanged()
	DAoCBuffVar.Frames[activewindow.index].horizontal = ComboBoxGetSelectedMenuItem(FrameTab .. "GrowHorizontalComboBox")
end

function DAoCBuffSettings.FontChanged()
	DAoCBuffVar.Frames[activewindow.index].font = ComboBoxGetSelectedMenuItem(FrameTab .. "FontComboBox")
end

function DAoCBuffSettings.BuffsBelowChanged(checked)
	if (checked) then
		DAoCBuffVar.Frames[activewindow.index].buffsbelow = 1
	else
		DAoCBuffVar.Frames[activewindow.index].buffsbelow = 2
	end
end

function DAoCBuffSettings.HideLongtimeChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].longtimehide = checked
end

function DAoCBuffSettings.LongtoPermaChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].longtoperma = checked
end

function DAoCBuffSettings.ShowBorderChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].showborder = checked
end

function DAoCBuffSettings.GlassChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].glass = checked
end

function DAoCBuffSettings.HPTEChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].hpte = checked
end

function DAoCBuffSettings.PermabuffsChanged()
	DAoCBuffVar.Frames[activewindow.index].permabuffs = ComboBoxGetSelectedMenuItem(FrameTab .. "PermabuffsComboBox")
end

function DAoCBuffSettings.BufforderChanged()
	DAoCBuffVar.Frames[activewindow.index].bufforder = ComboBoxGetSelectedMenuItem(FrameTab .. "BufforderComboBox")
end

function DAoCBuffSettings.AdvancedFiltersChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].FA = checked
end

function DAoCBuffSettings.StaticCondenseChanged(checked)
	DAoCBuffVar.Frames[activewindow.index].staticcondense = checked
end

function DAoCBuffSettings.KillBuffsChanged(checked)
	DAoCBuffVar.killbuffs = checked
end

function DAoCBuffSettings.ToggleTestModeChanged(checked)
	DAoCBuff.Testmode(checked)
end

function DAoCBuffSettings.AddFilter()
	local filter={}
	filter.active=true
	filter.combathide=false
	filter.icon="DAoC_new_qm"
	filter.condense=true
	filter.delete=false
	filter.enda=false
	filter.addPrefs={ ["isBuff"] = true }
	filter.useand=true
	filter.notresult=false
	filter.conditions={}

	local i = 1
	local tmp_name
	repeat
		tmp_name = L"new_Filter" .. i
		i = i + 1
	until (not DAoCBuffSettings.CheckDuplicate(DAoCBuffVar.Frames[activewindow.index].filters, "name", tmp_name))

	filter.name = tmp_name

	table.insert(DAoCBuffVar.Frames[activewindow.index].filters, filter)

	activefilter.name  = tmp_name
	activefilter.index = #DAoCBuffVar.Frames[activewindow.index].filters

	ACTIVE_CONDITION = {[1] = DAoCBuffSettings.TmpFilter[activefilter.index].conditions}

	ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )

	DAoCBuffSettings.PopulateFilter()
end

function DAoCBuffSettings.RemoveFilter()
	if (activefilter.index == 0) then
		return
	end

	table.remove(DAoCBuffVar.Frames[activewindow.index].filters, activefilter.index)

	activefilter.name  = L""
	activefilter.index = 0
	ACTIVE_CONDITION={}

	ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )

	DAoCBuffSettings.PopulateFilterList()
end

function DAoCBuffSettings.MoveFilterUp()
	if (activefilter.index > 1) then
		local filters = DAoCBuffVar.Frames[activewindow.index].filters
		local tmp = filters[activefilter.index]

		filters[activefilter.index] = filters[activefilter.index-1]
		filters[activefilter.index-1] = tmp

		activefilter.name  = activefilter.name
		activefilter.index = activefilter.index - 1

		ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )

		DAoCBuffSettings.PopulateFilterList()
	end
end

function DAoCBuffSettings.MoveFilterDown()
	local filters = DAoCBuffVar.Frames[activewindow.index].filters

	if (activefilter.index > 0 and activefilter.index < #filters) then
		local tmp = filters[activefilter.index]

		filters[activefilter.index] = filters[activefilter.index+1]
		filters[activefilter.index+1] = tmp

		activefilter.name  = activefilter.name
		activefilter.index = activefilter.index + 1

		ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )

		DAoCBuffSettings.PopulateFilterList()
	end
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.ChangeBuffCount()
--# Used to change Buffcount
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.ChangeBuffCount()
	DAoCBuffVar.Frames[activewindow.index].maxBuffCount = BUFFS_PER_ROW[DAoCBuffVar.Frames[activewindow.index].buffRowStride] * BUFF_ROWS[DAoCBuffVar.Frames[activewindow.index].rowcount]
end

function DAoCBuffSettings.AddList()
	local newentry = tostring(TextEditBoxGetText(ListManagerTab .. "AddListEditBox"))
	if (newentry:len() <= 3) then
		LabelSetText(ListManagerTab .. "AddListEditErrorText", L"Name is too short")
		return
	end
	if (DAoCBuffVar.Tables[newentry] ~= nil) then
		LabelSetText(ListManagerTab .. "AddListEditErrorText", L"A list with this name already exists")
		return
	end
	LabelSetText(ListManagerTab .. "AddListEditErrorText", L"")

	DAoCBuffVar.Tables[newentry] = {}

	DAoCBuffSettings.PopulateListComboBoxes()
	UpdateLeftList()
	UpdateRightList()

	DAoCBuffSettings.PopulateRemoveLists()

	TextEditBoxSetText(ListManagerTab .. "AddListEditBox", L"")
end

function DAoCBuffSettings.RemoveListChanged()
end

function DAoCBuffSettings.RemoveList()
	local index = ComboBoxGetSelectedMenuItem(ListManagerTab .. "RemoveListComboBox")

	for i,k in pairs(DAoCBuffVar.Tables) do
		if (type(i) ~= "number") then
			if (index == 1) then
				DAoCBuffVar.Tables[i] = nil
				break
			else
				index = index - 1
			end
		end
	end

	DAoCBuffSettings.PopulateListComboBoxes()
	UpdateLeftList()
	UpdateRightList()

	DAoCBuffSettings.PopulateRemoveLists()
end

function DAoCBuffSettings.PopulateRemoveLists()
	ComboBoxClearMenuItems(ListManagerTab .. "RemoveListComboBox")

	for i,k in pairs(DAoCBuffVar.Tables) do
		if (type(i) ~= "number") then
			ComboBoxAddMenuItem(ListManagerTab .. "RemoveListComboBox", towstring(i))
		end
	end

	ComboBoxSetSelectedMenuItem(ListManagerTab .. "RemoveListComboBox", 0)
end

function DAoCBuffSettings.MoveLeftToRight()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0 ) then
		if(DAoCBuffSettings.RightTable~=nil and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.LeftTable[activeleftitem]~=nil) then
			if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") ~= ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
				if (DAoCBuffSettings.RightTable[activeleftitem] ~= nil) then
					DAoCBuff.MergeTables(DAoCBuffSettings.RightTable[activeleftitem], DAoCBuffSettings.LeftTable[activeleftitem], true)
				else
					DAoCBuffSettings.RightTable[activeleftitem] = DAoCBuffSettings.LeftTable[activeleftitem]
				end
				DAoCBuffSettings.LeftTable[activeleftitem] = nil
				UpdateLeftList()
				UpdateRightList()
			end
		end
	end
end

function DAoCBuffSettings.MoveRightToLeft()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0 ) then
		if(DAoCBuffSettings.RightTable~=nil and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.RightTable[activerightitem]~=nil) then
			if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") ~= ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
				if (DAoCBuffSettings.LeftTable[activerightitem] ~= nil) then
					DAoCBuff.MergeTables(DAoCBuffSettings.LeftTable[activerightitem], DAoCBuffSettings.RightTable[activerightitem], true)
				else
					DAoCBuffSettings.LeftTable[activerightitem] = DAoCBuffSettings.RightTable[activerightitem]
				end
				DAoCBuffSettings.RightTable[activerightitem] = nil
				UpdateLeftList()
				UpdateRightList()
			end
		end
	end
end

function DAoCBuffSettings.RemoveLeft()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0) then
		if(DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.LeftTable[activeleftitem]~=nil)
		then
			DAoCBuffSettings.LeftTable[activeleftitem]=nil
			UpdateLeftList()

			if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") == ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
				UpdateRightList()
			end
		end
	end
end

function DAoCBuffSettings.RemoveRight()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0) then
		if(DAoCBuffSettings.RightTable~=nil and DAoCBuffSettings.RightTable[activerightitem]~=nil)
		then
			DAoCBuffSettings.RightTable[activerightitem]=nil
			UpdateRightList()

			if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") == ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
				UpdateLeftList()
			end
		end
	end
end

function DAoCBuffSettings.ClearLeft()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0) then
		if(DAoCBuffSettings.LeftTable~=nil)
		then
			for i,k in pairs(DAoCBuffSettings.LeftTable) do
				DAoCBuffSettings.LeftTable[i] = nil
			end
		end
	end

	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") == ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
		UpdateRightList()
	end
	UpdateLeftList()
end

function DAoCBuffSettings.ClearRight()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0) then
		if(DAoCBuffSettings.RightTable~=nil)
		then
			for i,k in pairs(DAoCBuffSettings.RightTable) do
				DAoCBuffSettings.RightTable[i] = nil
			end
		end
	end

	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") == ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")) then
		UpdateLeftList()
	end
	UpdateRightList()
end

function DAoCBuffSettings.CopyLeftToRight()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0 ) then
		if(DAoCBuffSettings.RightTable~=nil and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.LeftTable[activeleftitem]~=nil)
		then
			DAoCBuffSettings.RightTable[activeleftitem]=DAoCBuff.CopyTable(DAoCBuffSettings.LeftTable[activeleftitem])
			UpdateRightList()
		end
	end
end

function DAoCBuffSettings.CopyRightToLeft()
	if (ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox") > 0 ) then
		if(DAoCBuffSettings.RightTable~=nil and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.RightTable[activerightitem]~=nil)
		then
			DAoCBuffSettings.LeftTable[activerightitem]=DAoCBuff.CopyTable(DAoCBuffSettings.RightTable[activerightitem])
			UpdateLeftList()
		end
	end
end

function DAoCBuffSettings.LeftListChanged()
	local index=ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox")
	activeleftitem = 0
	if(index<4)
	then
		if(index>0)
		then
			if(index==1)then DAoCBuffSettings.LeftTable=DAoCBuffVar.Tables[GameData.BuffTargetType.SELF]
			elseif(index==2)then DAoCBuffSettings.LeftTable=DAoCBuffVar.Tables[GameData.BuffTargetType.TARGET_FRIENDLY]
			elseif(index==3)then DAoCBuffSettings.LeftTable=DAoCBuffVar.Tables[GameData.BuffTargetType.TARGET_HOSTILE]
			end
		end
	else
		index=index-3
		for i,k in pairs(DAoCBuffVar.Tables)
		do
			if(type(i)~="number")
			then
				if(index==1)
				then
					DAoCBuffSettings.LeftTable=k
					break
				else
					index=index-1
				end
			end
		end
	end

	UpdateLeftList()
end

function DAoCBuffSettings.RightListChanged()
	local index=ComboBoxGetSelectedMenuItem(ListManagerTab .. "RightListComboBox")
	activerightitem = 0
	if(index<4)
	then
		if(index>0)
		then
			if(index==1)then DAoCBuffSettings.RightTable=DAoCBuffVar.Tables[GameData.BuffTargetType.SELF]
			elseif(index==2)then DAoCBuffSettings.RightTable=DAoCBuffVar.Tables[GameData.BuffTargetType.TARGET_FRIENDLY]
			elseif(index==3)then DAoCBuffSettings.RightTable=DAoCBuffVar.Tables[GameData.BuffTargetType.TARGET_HOSTILE]
			end
		end
	else
		index=index-3
		for i,k in pairs(DAoCBuffVar.Tables)
		do
			if(type(i)~="number")
			then
				if(index==1)
				then
					DAoCBuffSettings.RightTable=k
					break
				else
					index=index-1
				end
			end
		end
	end

	UpdateRightList()
end

function DAoCBuffSettings.PopulateListComboBoxes()
	activeleftitem = 0
	activerightitem = 0

	ComboBoxClearMenuItems(ListManagerTab .. "LeftListComboBox")
	ComboBoxAddMenuItem(ListManagerTab .. "LeftListComboBox", L"Self Target List")
	ComboBoxAddMenuItem(ListManagerTab .. "LeftListComboBox", L"Friendly Target List")
	ComboBoxAddMenuItem(ListManagerTab .. "LeftListComboBox", L"Hostile Target List")
	for i,k in pairs(DAoCBuffVar.Tables)
	do
		if(type(i)~="number")
		then
			ComboBoxAddMenuItem(ListManagerTab .. "LeftListComboBox", towstring(i))
		end
	end
	ComboBoxSetSelectedMenuItem(ListManagerTab .. "LeftListComboBox",0)
	DAoCBuffSettings.LeftTable = {}

	ComboBoxClearMenuItems(ListManagerTab .. "RightListComboBox")
	ComboBoxAddMenuItem(ListManagerTab .. "RightListComboBox", L"Self Target List")
	ComboBoxAddMenuItem(ListManagerTab .. "RightListComboBox", L"Friendly Target List")
	ComboBoxAddMenuItem(ListManagerTab .. "RightListComboBox", L"Hostile Target List")
	for i,k in pairs(DAoCBuffVar.Tables)
	do
		if(type(i)~="number")
		then
			ComboBoxAddMenuItem(ListManagerTab .. "RightListComboBox", towstring(i))
		end
	end
	ComboBoxSetSelectedMenuItem(ListManagerTab .. "RightListComboBox",0)
	DAoCBuffSettings.RightTable = {}

	DAoCBuffSettings.PopulateEffect()
end

function DAoCBuffSettings.FilterNameChanged()

	if( ButtonGetDisabledFlag( FrameTab .. "FilterNameEditBoxButton" ) ) then
		return
	end

	local new = TextEditBoxGetText(FrameTab .. "FilterNameEditBox")

	if (new:len() < 3) then
		LabelSetText(FrameTab .. "FilterNameEditErrorText", L"name is too short")
		return
	end

	if (DAoCBuffSettings.CheckDuplicate(DAoCBuffSettings.TmpFilter, "name", new)) then
		LabelSetText(FrameTab .. "FilterNameEditErrorText", L"name is already in use")
		return
	end

	LabelSetText(FrameTab .. "FilterNameEditErrorText", L"")

	DAoCBuffSettings.TmpFilter[activefilter.index].name = new

	activefilter.name = new
	ListBoxSetDisplayOrder(FrameTab .. "FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )
end

----------------------------------------------------------------------------------------------------
--# DAoCBuffSettings.ChangeName(oldName, newName)
--# Used to change the name of a Frame and to tell all Stickname windows the new name
--# 
--# Parameters:
--# 	oldName				- (wstring)		old name of the Frame that has to be changed
--# 	newName				- (wstring)		new name this frame will use
--#
--# Returns:
--#
--# Notes:
--#
----------------------------------------------------------------------------------------------------
function DAoCBuffSettings.ChangeName(oldName, newName)
	if (newName == nil) then
		LabelSetText(FrameTab .. "FrameNameEditErrorText", L"invalid input - an error occurred")
		return
	end

	if (newName:len() <= 3) then
		LabelSetText(FrameTab .. "FrameNameEditErrorText", L"name is too short")
		return
	end

	if (DAoCBuffSettings.CheckDuplicate(DAoCBuffVar.Frames, "name", newName)) then
		LabelSetText(FrameTab .. "FrameNameEditErrorText", L"name is already in use")
		return
	end

	LabelSetText(FrameTab .. "FrameNameEditErrorText", L"")

	DAoCBuffVar.Frames[activewindow.index].name = newName

	for i,k in ipairs(DAoCBuffVar.Frames) do
		if (k.Stickname ~= nil and k.Stickname == oldName) then
			if (k.name == newName) then
				k.Stickname = nil
			else
				k.Stickname = newName
			end
		end
	end

	DAoCBuff.U()

	activewindow.name = newName
	ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )
end

function DAoCBuffSettings.CheckDuplicate(tab,place,value)
	for i,k in pairs(tab)
	do
		if(k[place]==value)
		then
			return true
		end
	end
	return false
end

function DAoCBuffSettings.ChangeGlobalSize()
	local index = ComboBoxGetSelectedMenuItem(GeneralTab .. "ChangeGlobalSizeComboBox")

	if (index > 0) then
		local name="DAoCBuff_"..tostring(DAoCBuffVar.Frames[index].name)
		if(DoesWindowExist(name))
		then
			local scale = WindowGetScale(name)
			for i, k in ipairs(DAoCBuffVar.Frames) do
				if (k.active)
				then
					if(k.buffTargetType==100)
					then
						for i=GameData.BuffTargetType.GROUP_MEMBER_START,GameData.BuffTargetType.GROUP_MEMBER_END-1
						do
							WindowSetScale("DAoCBuff_"..tostring(k.name)..i,scale)
						end
					else
						WindowSetScale("DAoCBuff_"..tostring(k.name),scale)
					end
					if(DAoCBuff.LES == false)
					then
						DAoCBuff.LEH(LayoutEditor.EDITING_END)
					end
				end
			end
		end
	end
end

function DAoCBuffSettings.ChangeGlobalRefresh()
	local index = ComboBoxGetSelectedMenuItem(GeneralTab .. "ChangeGlobalRefreshComboBox")

	if (index > 0) then
		for i, k in ipairs(DAoCBuffVar.Frames) do
			k.update = BUFF_REFRESH_DELAY[index]
		end
	end
end

function DAoCBuffSettings.ChangeGlobalFont()
	local index = ComboBoxGetSelectedMenuItem(GeneralTab .. "ChangeGlobalFontComboBox")

	if (index > 0) then
		for i, k in ipairs(DAoCBuffVar.Frames) do
			k.font = index
		end
	end
end


function DAoCBuffSettings.ChangeGlobalBorder()
	local index = ComboBoxGetSelectedMenuItem(GeneralTab .. "ChangeGlobalBorderComboBox")

	if (index > 0) then
		for i, k in ipairs(DAoCBuffVar.Frames) do
			k.showborder = (index == 1)
		end
	end
end

function DAoCBuffSettings.ChangeGlobalGlass()
	local index = ComboBoxGetSelectedMenuItem(GeneralTab .. "ChangeGlobalGlassComboBox")

	if (index > 0) then
		for i, k in ipairs(DAoCBuffVar.Frames) do
			k.glass = (index == 1)
		end
	end
end

function DAoCBuffSettings.ShowTooltip()
	local id 		= WindowGetId(SystemData.MouseOverWindow.name)
	local Title		= L""
	local Text		= L""

	if (id == 101) then
		Title	= L"Kill standard buffs"
		Text	= L"We recommend this feature to kill the standard buffs instead of hiding them with phantom (performance increase)\nYou will need to relog to reactivate them."
	elseif (id == 102) then
		Title	= L"Manage Lists"
		Text	= L"Lists for abilityid in advanced filters\nYou can leftclick on an Effect in a DAoCBuff frame to add it to the internal List."
	elseif (id == 103) then
		Title	= L"Advanced Filters"
		Text	= L"Enables the new feature of DAoCBuff,\nrecommended only for advanced user."
	elseif (id == 104) then
		Title	= L"List of Filters"
		Text	= L"The order of the filters are very important,\ni.e. when you delete a buff in a filter the other filters below will not see this buff."
	elseif (id == 105) then
		Title	= L"Delete effects afterwards"
		Text	= L"A buff matching this filter will never show in the normal frame and preceeding filters will never see it."
	elseif (id == 106) then
		Title	= L"End filtering afterwards"
		Text	= L"A buff matching this filter will show it in the normal Frame, but preceeding filters will never see this buff."
	elseif (id == 107) then
		Title	= L"Invert result"
		Text	= L"Inverts the result of all conditions."
	elseif (id == 108) then
		Title	= L"Condense effects of this filter"
		Text	= L"Show all matching buffs of this filter in a condensed buffframe with a custom image."
	elseif (id == 109) then
		Title	= L"Stack Browser"
		Text	= L"Here you can browse through upper layers."
	elseif (id == 110) then
		Title	= L"List filtering"
		Text	= L"Use the Listmanager, to create and edit lists"
	elseif (id == 111) then
		Title	= L"Layers"
		Text	= L"Contains another set of conditions that can be linked in another way."
	end

	if (Title:len() > 0 and Text:len() > 0) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, nil)
		Tooltips.SetTooltipColorDef(1, 1, Tooltips.COLOR_HEADING)
		Tooltips.SetTooltipColorDef(1, 2, Tooltips.COLOR_HEADING)

		Tooltips.SetTooltipText(1, 1, Title)
		Tooltips.SetTooltipText(2, 1, Text)

		Tooltips.Finalize()

		local tooltip_anchor = { Point = "bottomright",  RelativeTo = SystemData.ActiveWindow.name, RelativePoint = "topleft",   XOffset = 5, YOffset = 15 }

		Tooltips.AnchorTooltip(tooltip_anchor)
	end
end

function DAoCBuffSettings.ToggleCheckBox()
	local actwnd		= SystemData.ActiveWindow.name
	local buttonName	= actwnd.."Button"

	if( ButtonGetDisabledFlag( buttonName ) ) then
		return
	end

	local pressed = ButtonGetPressedFlag( buttonName )
	ButtonSetPressedFlag( buttonName, not pressed )

	if (actwnd == FrameTab.."BuffsBelowCheckBox") then
		DAoCBuffSettings.BuffsBelowChanged(not pressed)
	elseif (actwnd == FrameTab.."SelfEffectsCheckBox") then
		DAoCBuffSettings.SelfEffectsChanged(not pressed)
	elseif (actwnd == FrameTab.."ActiveCheckBox") then
		DAoCBuffSettings.ActiveChanged(not pressed)
	elseif (actwnd == FrameTab.."AdvancedFiltersCheckBox") then
		DAoCBuffSettings.AdvancedFiltersChanged(not pressed)
	elseif (actwnd == FrameTab.."StaticCondenseCheckBox") then
		DAoCBuffSettings.StaticCondenseChanged(not pressed)
	elseif (actwnd == FilterWindow.."G4FilterWindow_G4NotResultCheckBox") then
		DAoCBuffSettings.FilterSettings.G4NotResultChanged(not pressed)
	elseif (actwnd == FilterWindow.."EnableFilterCheckBox") then
		DAoCBuffSettings.FilterSettings.EnableFilterChanged(not pressed)
	elseif (actwnd == FilterWindow.."CombatHideCheckBox") then
		DAoCBuffSettings.FilterSettings.CombatHideChanged(not pressed)
	elseif (actwnd == FilterWindow.."CondenseCheckBox") then
		DAoCBuffSettings.FilterSettings.CondenseChanged(not pressed)
	elseif (actwnd == FilterWindow.."DeleteCheckBox") then
		DAoCBuffSettings.FilterSettings.DeleteChanged(not pressed)
	elseif (actwnd == FilterWindow.."EndaCheckBox") then
		DAoCBuffSettings.FilterSettings.EndaChanged(not pressed)
	elseif (actwnd == FilterWindow.."ColorCCheckBox") then
		DAoCBuffSettings.FilterSettings.ColorCChanged(not pressed)
	elseif (actwnd == FilterWindow.."ColorBCheckBox") then
		DAoCBuffSettings.FilterSettings.ColorBChanged(not pressed)
	elseif (actwnd == FrameTab.."HideLongtimeCheckBox") then
		DAoCBuffSettings.HideLongtimeChanged(not pressed)
	elseif (actwnd == FrameTab.."LongtoPermaCheckBox") then
		DAoCBuffSettings.LongtoPermaChanged(not pressed)
	elseif (actwnd == FrameTab.."ShowBorderCheckBox") then
		DAoCBuffSettings.ShowBorderChanged(not pressed)
	elseif (actwnd == FrameTab.."GlassCheckBox") then
		DAoCBuffSettings.GlassChanged(not pressed)
	elseif (actwnd == FrameTab.."HPTECheckBox") then
		DAoCBuffSettings.HPTEChanged(not pressed)
	elseif (actwnd == FilterWindow.."InvertResultCheckBox") then
		DAoCBuffSettings.FilterSettings.InvertResultChanged(not pressed)
	elseif (actwnd == FilterWindow.."EnableClasstableCheckBox") then
		DAoCBuffSettings.FilterSettings.EnableClasstableChanged(not pressed)
	elseif (actwnd == GeneralTab .. "KillBuffsCheckBox") then
		DAoCBuffSettings.KillBuffsChanged(not pressed)
	elseif (actwnd == GeneralTab .. "ToggleTestModeCheckBox") then
		DAoCBuffSettings.ToggleTestModeChanged(not pressed)
	end
end

function DAoCBuffSettings.CreateDisplayOrder()
	local Liste = {}

	for j,k in ipairs(DAoCBuffVar.Frames) do
		Liste[j] = j
	end

	return Liste
end

function DAoCBuffSettings.CreateFilterDisplayOrder()
	local Liste = {}

	for j,k in ipairs(DAoCBuffSettings.TmpFilter) do
		Liste[j] = j
	end

	return Liste
end


function DAoCBuffSettings.CreateLeftListDisplayOrder()
	local Liste = {}
	DAoCBuffSettings.RelocateLeftTable={}

	local i = 1
	for j,k in pairs(DAoCBuffSettings.LeftTable) do
		DAoCBuffSettings.RelocateLeftTable[i]=j
		Liste[i] = i
		i = i + 1
	end

	return Liste
end

function DAoCBuffSettings.CreateRightListDisplayOrder()
	local Liste = {}
	DAoCBuffSettings.RelocateRightTable={}

	local i = 1
	for j,k in pairs(DAoCBuffSettings.RightTable) do
		DAoCBuffSettings.RelocateRightTable[i]=j
		Liste[i] = i
		i = i + 1
	end

	return Liste
end

function DAoCBuffSettings.PopulateList()
	if (DAoCBuff_SettingsList.PopulatorIndices ~= nil) then
		for row, data in ipairs(DAoCBuff_SettingsList.PopulatorIndices) do

			local rowWindow = "DAoCBuff_SettingsListRow"..row

			if (DAoCBuffVar.Frames[data].active) then
				if (LabelGetText(rowWindow.."Name") == activewindow.name) then
					LabelSetTextColor(rowWindow.."Name", 255, 204, 102)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 255, 255)
				end
			else
				if (LabelGetText(rowWindow.."Name") == activewindow.name) then
					LabelSetTextColor(rowWindow.."Name", 120, 96, 48)
				else
					LabelSetTextColor(rowWindow.."Name", 120, 120, 120)
				end
			end
		end
	end
end

function DAoCBuffSettings.PopulateFilterList()
	if (DAoCBuff_Settings_FrameSettings_ScrollChild_FilterList.PopulatorIndices ~= nil) then
		for row, data in ipairs(DAoCBuff_Settings_FrameSettings_ScrollChild_FilterList.PopulatorIndices) do

			local rowWindow = FrameTab .. "FilterListRow"..row

			if (DAoCBuffSettings.TmpFilter[data].active) then
				if (LabelGetText(rowWindow.."Name") == activefilter.name) then
					LabelSetTextColor(rowWindow.."Name", 255, 204, 102)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 255, 255)
				end
			else
				if (LabelGetText(rowWindow.."Name") == activefilter.name) then
					LabelSetTextColor(rowWindow.."Name", 120, 96, 48)
				else
					LabelSetTextColor(rowWindow.."Name", 120, 120, 120)
				end
			end

		end
	end
end

function DAoCBuffSettings.PopulateFilter()
	DAoCBuffSettings.PopulateFilterList()
	TextEditBoxSetText(FrameTab .. "FilterNameEditBox", DAoCBuffSettings.TmpFilter[activefilter.index].name)
end

function DAoCBuffSettings.PopulateLeftListManager()
	if (DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList.PopulatorIndices ~= nil) then
		for row, effectdata in ipairs(DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftList.PopulatorIndices) do
			effectdata=DAoCBuffSettings.RelocateLeftTable[effectdata]
			local rowWindow = "DAoCBuff_Settings_ListManagerSettings_ScrollChild_LeftListRow" .. row

			local desc = L"("
			if(type(effectdata)~="number")
			then
				desc=desc..effectdata:sub(1,5)..L")"..DAoCBuffSettings.LeftTable[effectdata].name
				if (effectdata == activeleftitem) then
					LabelSetTextColor(rowWindow.."Name", 200, 20, 20)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 50, 50)
				end
			else
				desc=desc..effectdata..L")"..DAoCBuffSettings.LeftTable[effectdata].name
				if (effectdata == activeleftitem) then
					LabelSetTextColor(rowWindow.."Name", 255, 204, 102)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 255, 255)
				end
			end
			LabelSetText(rowWindow .. "Name", desc)

			if(DAoCBuffSettings.LeftTable[effectdata].iconNum~=nil)
			then
				local text, x, y = GetIconData(DAoCBuffSettings.LeftTable[effectdata].iconNum)
				DynamicImageSetTexture(rowWindow .. "Icon", text, x, y)
			else
				DynamicImageSetTexture(rowWindow.."Icon","DAoC_new_qm",0,0)
			end
		end
	end
end

function DAoCBuffSettings.PopulateRightListManager()
	if (DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList.PopulatorIndices ~= nil) then
		for row, effectdata in ipairs(DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightList.PopulatorIndices) do
			effectdata=DAoCBuffSettings.RelocateRightTable[effectdata]
			local rowWindow = "DAoCBuff_Settings_ListManagerSettings_ScrollChild_RightListRow" .. row

			local desc = L"("
			if(type(effectdata)~="number")
			then
				desc=desc..effectdata:sub(1,5)..L")"..DAoCBuffSettings.RightTable[effectdata].name
				if (effectdata == activerightitem) then
					LabelSetTextColor(rowWindow.."Name", 200, 20, 20)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 50, 50)
				end
			else
				desc=desc..effectdata..L")"..DAoCBuffSettings.RightTable[effectdata].name
				if (effectdata == activerightitem) then
					LabelSetTextColor(rowWindow.."Name", 255, 204, 102)
				else
					LabelSetTextColor(rowWindow.."Name", 255, 255, 255)
				end
			end
			LabelSetText(rowWindow .. "Name", desc)

			if(DAoCBuffSettings.RightTable[effectdata].iconNum~=nil)
			then
				local text, x, y = GetIconData(DAoCBuffSettings.RightTable[effectdata].iconNum)
				DynamicImageSetTexture(rowWindow .. "Icon", text, x, y)
			else
				DynamicImageSetTexture(rowWindow.."Icon","DAoC_new_qm",0,0)
			end
		end
	end
end

function DAoCBuffSettings.ApplyEffectEdit()
	if((ComboBoxGetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox")==2) and ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and DAoCBuffSettings.LeftTable~=nil and DAoCBuffSettings.LeftTable[activeleftitem]~=nil)
	then
		local effect=DAoCBuffSettings.LeftTable[activeleftitem]
		local name=TextEditBoxGetText(ListManagerTab.."NameEditBox")
		local abilityId=tonumber(TextEditBoxGetText(ListManagerTab.."IDEditBox"))
		if(not (abilityId>0))then abilityId=nil end
		DAoCBuffSettings.LeftTable[activeleftitem]=nil
		if(abilityId~=nil)
		then
			if(DAoCBuffSettings.LeftTable[abilityId]==nil)
			then
				DAoCBuffSettings.LeftTable[abilityId]=effect
				activeleftitem=abilityId
				LabelSetText(ListManagerTab.."ApplyErrorText",L"")
				LabelSetText(ListManagerTab.."ErrorText",L"")
			else
				DAoCBuffSettings.LeftTable[activeleftitem]=effect
				DAoCBuffSettings.PopulateEffect()
				LabelSetText(ListManagerTab.."ApplyErrorText",L"An entry with that ID already exists, changes resetted.")
				return
			end
		else
			local index=L""
			if(name~=L"")then index=name:gsub(L"[%^]%w%w?",L""):gsub(L"[%s|%p]",L""):lower() end
			if(DAoCBuffSettings.LeftTable[index]==nil)
			then
				DAoCBuffSettings.LeftTable[index]=effect
				activeleftitem=index
				LabelSetText(ListManagerTab.."ApplyErrorText",L"")
				LabelSetText(ListManagerTab.."ErrorText",L"This Effect has no ID,\nthis slows the Filter down.")
			else
				DAoCBuffSettings.LeftTable[activeleftitem]=effect
				DAoCBuffSettings.PopulateEffect()
				LabelSetText(ListManagerTab.."ApplyErrorText",L"An entry with that Name already exists, changes resetted.")
				return
			end
		end
		effect.name=name
		effect.abilityId=abilityId
		effect.effectText=TextEditBoxGetText(ListManagerTab.."DescEditBox")
		UpdateLeftList()
	end
end

function DAoCBuffSettings.AddEntry()
	if((ComboBoxGetSelectedMenuItem(ListManagerTab.."ManagerModeComboBox")==2) and ComboBoxGetSelectedMenuItem(ListManagerTab .. "LeftListComboBox") > 0 and DAoCBuffSettings.LeftTable~=nil)
	then
		local effect={["name"]=L"newEntry"}
		local index=effect.name:gsub(L"[%^]%w%w?",L""):gsub(L"[%s|%p]",L""):lower()
		if(DAoCBuffSettings.LeftTable[index]==nil)
		then
			DAoCBuffSettings.LeftTable[index]=effect
			UpdateLeftList()
		end
	end
end
