--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################

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


local activeconditionindex
local Filter
local FilterSettings={}
DAoCBuffSettings.FilterSettings=FilterSettings
local fwindow="DAoCBuff_Settings_Filter"
local FilterWindow = fwindow.."Frame_ScrollChild_"

local ImExport={}
DAoCBuffSettings.ImExport=ImExport
local iewindow="DAoCBuff_Settings_ImExport"
local ImExportWindow = iewindow.."Frame_ScrollChild_"

local G5DURATION = {{text=L"5 min",wert=300},{text=L"10 min",wert=600},{text=L"20 min",wert=1200},{text=L"30 min",wert=1800}}
local FILTER_PROPERTIES = { "isBuff", "isDebuff", "isHealing", "isDamaging"}
local EXPORT_TYPE = {"All","Frame","Filter","List"}
local EXPORT_TYPE_REV={}
for i,k in ipairs(EXPORT_TYPE)
do
	EXPORT_TYPE_REV[k]=i
end


local CONDITIONS		  = { "isBuff", "isDebuff", "castByPlayer", "isHealing", "isDamaging", "abilityId",
							  "duration", "permanentUntilDispelled", "isHex", "isCurse", "isCripple", "isAilment",
							  "isBolster", "isAugmentation", "isBlessing", "isEnchantment", "trackerPriority",
							  "InCombat", "layer"
							}

local CONDITION_TEMPLATES = { ["duration"] = 5, ["abilityId"] = 2, ["isHex"] = 1,
							  ["isCurse"] = 1, ["isCripple"] = 1, ["isAilment"] = 1,
							  ["isBolster"] = 1, ["isAugmentation"] = 1, ["isBlessing"] = 1,
							  ["isEnchantment"] = 1, ["isDamaging"] = 1, ["isHealing"] = 1,
							  ["isDebuff"] = 1, ["isBuff"] = 1, ["castByPlayer"] = 1,
							  ["permanentUntilDispelled"] = 1, ["InCombat"] = 6 ,["layer"] = 4,
							  ["trackerPriority"] = 1
							}

local CLASSTABLE={}
do
	local tmp
	for i,k in ipairs(GameData.Account.CharacterCreation.DestructionCareers)
	do
		for j,l in ipairs(k)
		do
			tmp={}
			tmp.name=l.MaleCareerName:match(L"([^^]+)^?([^^]*)")
			tmp.id=l.Career
			table.insert(CLASSTABLE,tmp)
		end
	end
	for i,k in ipairs(GameData.Account.CharacterCreation.OrderCareers)
	do
		for j,l in ipairs(k)
		do
			tmp={}
			tmp.name=l.MaleCareerName:match(L"([^^]+)^?([^^]*)")
			tmp.id=l.Career
			table.insert(CLASSTABLE,tmp)
		end
	end
end

function FilterSettings.Create()
	CreateWindow(fwindow,false)
	WindowSetShowing(fwindow,false)
	WindowSetHandleInput(fwindow,false)
	FilterSettings.SetLabels()
end

function FilterSettings.Open(filter,typ)
	DAoCBuffSettings.Disable()
	WindowSetHandleInput(fwindow,true)
	WindowSetShowing(fwindow,true)
	WindowStartAlphaAnimation(fwindow,Window.AnimationType.SINGLE_NO_RESET,0,1,0.4,true,0,0)
	Filter=filter
	if(typ~=1)
	then
		Filter.condense=false
		ButtonSetDisabledFlag(FilterWindow .. "CondenseCheckBoxButton",true)
	else
		ButtonSetDisabledFlag(FilterWindow .. "CondenseCheckBoxButton",false)
	end
	FilterSettings.PopulateFilter()
end

function FilterSettings.Close()
	WindowSetHandleInput(fwindow,false)
	WindowStartAlphaAnimation(fwindow,Window.AnimationType.EASE_OUT,1,0,0.4,true,0,0)
	DAoCBuffSettings.Reactivate()
	RegisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.FilterSettings.Cleanup")
end

function FilterSettings.Cleanup()
	if(WindowGetAlpha(fwindow)==0)
	then
		WindowSetShowing(fwindow,false)
		UnregisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.FilterSettings.Cleanup")
	end
end

function FilterSettings.SetLabels()

	LabelSetText(FilterWindow .. "ActionLabel", L"Actions")
	LabelSetText(FilterWindow .. "ConditionLabel", L"Conditions for an Action")
	LabelSetText(FilterWindow .. "EnvironmentLabel", L"Environment for the Conditions")
	LabelSetText(FilterWindow .. "MiscLabel", L"Miscellaneous Filtersettings")

	LabelSetText(FilterWindow .. "EnableFilterCheckBoxText", L"Enable this filter")
	LabelSetText(FilterWindow .. "DeleteCheckBoxText", L"Delete effects afterwards")
	LabelSetText(FilterWindow .. "EndaCheckBoxText", L"End filtering afterwards")
	LabelSetText(FilterWindow .. "CondenseCheckBoxText", L"Condense filter")

	LabelSetText(FilterWindow .. "ColorCCheckBoxText", L"Icon Color")
	LabelSetText(FilterWindow .. "ColorBCheckBoxText", L"Border Color")

	LabelSetText(FilterWindow .. "TextureText", L"Condense icon")
	for i,k in pairs(DAoCBuff.textures) do
		ComboBoxAddMenuItem(FilterWindow .. "TextureTypeComboBox", towstring(i))
	end
	LabelSetText(FilterWindow .. "CombatHideCheckBoxText", L"Hide condense while in combat")
	LabelSetText(FilterWindow .. "InvertResultCheckBoxText", L"Invert result")

	LabelSetText(FilterWindow .. "UseandComboBoxText", L"Link condition results with")
	ComboBoxAddMenuItem(FilterWindow .. "UseandComboBox", L"AND")
	ComboBoxAddMenuItem(FilterWindow .. "UseandComboBox", L"OR")

	LabelSetText(FilterWindow .. "EnableClasstableCheckBoxText", L"Use this filter only for selected classes ?")
	LabelSetText(FilterWindow .. "ClassTableComboText", L"Enable / Disable classes:")

	LabelSetText(FilterWindow .. "FilterPropertyComboText", L"Property of this condense")
	for i,k in ipairs(FILTER_PROPERTIES) do
		ComboBoxAddMenuItem(FilterWindow .. "FilterPropertyComboBox", towstring(k))
	end

	ButtonSetText(FilterWindow .. "AddConditionButton", L"Add Condition")
	ButtonSetText(FilterWindow .. "RemoveConditionButton", L"Delete Condition")

	LabelSetText(FilterWindow .. "G4HistoryBrowserComboText", L"")
	LabelSetText(FilterWindow .. "ConditionComboText", L"Select Condition")
	LabelSetText(FilterWindow .. "ConditionTypeComboText", L"Condition type")

	for i,k in ipairs(CONDITIONS) do
		ComboBoxAddMenuItem(FilterWindow .. "ConditionTypeComboBox", towstring(k))
	end

	LabelSetText(FilterWindow .. "G1FilterWindow_G1ComboText", L"")
	ComboBoxAddMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", L"true")
	ComboBoxAddMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", L"false")

	LabelSetText(FilterWindow .. "G4FilterWindow_G4UseandComboText", L"")
	ComboBoxAddMenuItem(FilterWindow .. "G4FilterWindow_G4UseandComboBox", L"AND")
	ComboBoxAddMenuItem(FilterWindow .. "G4FilterWindow_G4UseandComboBox", L"OR")

	LabelSetText(FilterWindow .. "G5FilterWindow_G5ComboText", L"")
	ComboBoxAddMenuItem(FilterWindow .. "G5FilterWindow_G5ComboBox", L">")
	ComboBoxAddMenuItem(FilterWindow .. "G5FilterWindow_G5ComboBox", L"<")

	LabelSetText(FilterWindow .. "G5FilterWindow_G5DurationComboText", L"")
	for i,k in ipairs(G5DURATION) do
		ComboBoxAddMenuItem(FilterWindow .. "G5FilterWindow_G5DurationComboBox", k.text)
	end

	LabelSetText(FilterWindow .. "G4FilterWindow_G4NotResultCheckBoxText", L"Invert results")
	ButtonSetText(FilterWindow .. "G4FilterWindow_G4RecursiveConditionsButton", L"Edit Conditions")
end

function FilterSettings.EnableFilterChanged(checked)
	Filter.active = checked
	ListBoxSetDisplayOrder("DAoCBuff_Settings_FrameSettings_ScrollChild_FilterList", DAoCBuffSettings.CreateFilterDisplayOrder() )
end

function FilterSettings.DeleteChanged(checked)
	Filter.delete = checked
end

function FilterSettings.EndaChanged(checked)
	Filter.enda = checked
end

function FilterSettings.CondenseChanged(checked)
	Filter.condense = checked
	FilterSettings.DisableCondenseSettings(not checked)

	if (checked) then
		ButtonSetPressedFlag(FilterWindow .. "CombatHideCheckBoxButton", Filter.combathide)

		for i,k in ipairs(FILTER_PROPERTIES) do
			if (Filter.addPrefs[k] == true) then
				ComboBoxSetSelectedMenuItem(FilterWindow .. "FilterPropertyComboBox", i)
			end
		end

		local typeindex = 0
		local textureindex
		local breakvar = false

		for i,k in pairs(DAoCBuff.textures) do
			typeindex = typeindex + 1
			for j,l in ipairs(k) do
				if (l == Filter.icon) then
					textureindex = j
					breakvar = true
					break
				end
			end
			if (breakvar) then
				break
			end
		end

		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureTypeComboBox", typeindex)
		FilterSettings.PopulateTextureComboBox()
		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureComboBox", textureindex)
		DynamicImageSetTexture(FilterWindow .. "CondenseIconPreview", Filter.icon, 0, 0)
		FilterSettings.DisableCondenseSettings(false)
	end
end

function FilterSettings.ColorCChanged(checked)
	if(checked)
	then
		Filter.iconC={255,255,255}
		SliderBarSetCurrentPosition(FilterWindow.."SliderCR",255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCG",255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCB",255)
	else
		Filter.iconC=nil
	end
	FilterSettings.PopulateColor()
end

function FilterSettings.ColorBChanged(checked)
	if(checked)
	then
		Filter.borderC={255,255,255}
		SliderBarSetCurrentPosition(FilterWindow.."SliderBR",255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBG",255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBB",255)
	else
		Filter.borderC=nil
	end
	FilterSettings.PopulateColor()
end

function FilterSettings.PopulateColor()
	if(Filter.iconC~=nil)
	then
		WindowSetShowing(FilterWindow.."Icon",true)
		WindowSetTintColor(FilterWindow.."Icon",Filter.iconC[1],Filter.iconC[2],Filter.iconC[3])
		SliderBarSetCurrentPosition(FilterWindow.."SliderCR",Filter.iconC[1]/255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCG",Filter.iconC[2]/255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCB",Filter.iconC[3]/255)
		LabelSetText(FilterWindow .. "SliderCRLabel", towstring(Filter.iconC[1]))
		LabelSetText(FilterWindow .. "SliderCGLabel", towstring(Filter.iconC[2]))
		LabelSetText(FilterWindow .. "SliderCBLabel", towstring(Filter.iconC[3]))
	else
		WindowSetShowing(FilterWindow.."Icon",false)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCR",0)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCG",0)
		SliderBarSetCurrentPosition(FilterWindow.."SliderCB",0)
		LabelSetText(FilterWindow .. "SliderCRLabel", L"")
		LabelSetText(FilterWindow .. "SliderCGLabel", L"")
		LabelSetText(FilterWindow .. "SliderCBLabel", L"")
	end
	if(Filter.borderC~=nil)
	then
		WindowSetShowing(FilterWindow.."Frame",true)
		WindowSetTintColor(FilterWindow.."Frame",Filter.borderC[1],Filter.borderC[2],Filter.borderC[3])
		SliderBarSetCurrentPosition(FilterWindow.."SliderBR",Filter.borderC[1]/255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBG",Filter.borderC[2]/255)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBB",Filter.borderC[3]/255)
		LabelSetText(FilterWindow .. "SliderBRLabel", towstring(Filter.borderC[1]))
		LabelSetText(FilterWindow .. "SliderBGLabel", towstring(Filter.borderC[2]))
		LabelSetText(FilterWindow .. "SliderBBLabel", towstring(Filter.borderC[3]))
	else
		WindowSetShowing(FilterWindow.."Frame",false)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBR",0)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBG",0)
		SliderBarSetCurrentPosition(FilterWindow.."SliderBB",0)
		LabelSetText(FilterWindow .. "SliderBRLabel", L"")
		LabelSetText(FilterWindow .. "SliderBGLabel", L"")
		LabelSetText(FilterWindow .. "SliderBBLabel", L"")
	end
end

function FilterSettings.OnSlideCR(pos)
	if(Filter.iconC~=nil)
	then
		Filter.iconC[1] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderCR",0)
	end
end

function FilterSettings.OnSlideCG(pos)
	if(Filter.iconC~=nil)
	then
		Filter.iconC[2] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderCG",0)
	end
end

function FilterSettings.OnSlideCB(pos)
	if(Filter.iconC~=nil)
	then
		Filter.iconC[3] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderCB",0)
	end
end

function FilterSettings.OnSlideBR(pos)
	if(Filter.borderC~=nil)
	then
		Filter.borderC[1] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderBR",0)
	end
end

function FilterSettings.OnSlideBG(pos)
	if(Filter.borderC~=nil)
	then
		Filter.borderC[2] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderBG",0)
	end
end

function FilterSettings.OnSlideBB(pos)
	if(Filter.borderC~=nil)
	then
		Filter.borderC[3] = math.floor(255 * pos + 0.5)
		FilterSettings.PopulateColor()
	else
		SliderBarSetCurrentPosition(FilterWindow.."SliderBB",0)
	end
end

function FilterSettings.CombatHideChanged(checked)
	Filter.combathide = checked
end

function FilterSettings.TextureTypeChanged()
	FilterSettings.PopulateTextureComboBox()
	ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureComboBox", 1)
	FilterSettings.TextureChanged()
end

function FilterSettings.TextureChanged()
	local typeindex = ComboBoxGetSelectedMenuItem(FilterWindow .. "TextureTypeComboBox")
	local index = ComboBoxGetSelectedMenuItem(FilterWindow .. "TextureComboBox")

	if (typeindex < 1 or index < 1) then
		return
	else
		local texturetable

		for i,k in pairs(DAoCBuff.textures) do
			if (typeindex == 1) then
				texturetable = k
				break
			else
				typeindex = typeindex - 1
			end
		end

		Filter.icon = texturetable[index]
		DynamicImageSetTexture(FilterWindow .. "CondenseIconPreview", Filter.icon, 0, 0)
	end
end

function FilterSettings.InvertResultChanged(checked)
	Filter.notresult = checked
end

function FilterSettings.EnableClasstableChanged(checked)
	if (checked) then
		Filter.classtable = {}
		ComboBoxSetDisabledFlag(FilterWindow .. "ClassTableComboBox",false)
		ButtonSetDisabledFlag(FilterWindow .. "AddClassTableButton",false)
		FilterSettings.PopulateClassTable()
		local myId=GameData.Player.career.id
		local acl=Filter.classtable
		for i,k in ipairs(CLASSTABLE)
		do
			if(myId==k.id)
			then
				if(acl[k.id])
				then
					ButtonSetText(FilterWindow .. "AddClassTableButton", L"Deactivate")
				else
					ButtonSetText(FilterWindow .. "AddClassTableButton", L"Activate")
				end
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ClassTableComboBox",i)
				break
			end
		end
	else
		Filter.classtable = nil
		ComboBoxSetDisabledFlag(FilterWindow .. "ClassTableComboBox",true)
		ButtonSetDisabledFlag(FilterWindow .. "AddClassTableButton",true)
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ClassTableComboBox",0)
	end
end

function FilterSettings.UseandChanged()
	if (ComboBoxGetSelectedMenuItem(FilterWindow .. "UseandComboBox") == 1) then
		Filter.useand = true
	else
		Filter.useand = false
	end
end

function FilterSettings.FilterPropertyChanged()
	local prop = FILTER_PROPERTIES[ComboBoxGetSelectedMenuItem(FilterWindow .. "FilterPropertyComboBox")]

	Filter.addPrefs = {}
	Filter.addPrefs[prop] = true
end

function FilterSettings.ClassTableChanged()
	if (ComboBoxGetSelectedMenuItem(FilterWindow .. "ClassTableComboBox") < 1) then
		return
	else
		if(Filter.classtable[CLASSTABLE[ComboBoxGetSelectedMenuItem(FilterWindow .. "ClassTableComboBox")].id])
		then
			ButtonSetText(FilterWindow .. "AddClassTableButton", L"Deactivate")
		else
			ButtonSetText(FilterWindow .. "AddClassTableButton", L"Activate")
		end
	end
end

function FilterSettings.AddClassTable()
	if( ButtonGetDisabledFlag( FilterWindow .. "AddClassTableButton" ) ) then
		return
	end

	local index = ComboBoxGetSelectedMenuItem(FilterWindow .. "ClassTableComboBox")
	local id=CLASSTABLE[index].id
	local acl=Filter.classtable
	if(acl[id])
	then
		acl[id]=nil
		ButtonSetText(FilterWindow .. "AddClassTableButton", L"Activate")
	else
		acl[id]=true
		ButtonSetText(FilterWindow .. "AddClassTableButton", L"Deactivate")
	end
	FilterSettings.PopulateClassTable()
	ComboBoxSetSelectedMenuItem(FilterWindow .. "ClassTableComboBox",index)
end

function FilterSettings.G4NotResultChanged(checked)
	ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex][4] = checked
end

function FilterSettings.AddCondition()
	if(#ACTIVE_CONDITION>0)
	then
		local condition={}
		table.insert(ACTIVE_CONDITION[#ACTIVE_CONDITION],condition)
		condition[1]=1
		condition[2]="isHealing"
		condition[3]=true
		activeconditionindex=#ACTIVE_CONDITION[#ACTIVE_CONDITION]
		FilterSettings.PopulateCondition()
	end
end

function FilterSettings.RemoveCondition()
	if(#ACTIVE_CONDITION>0)
	then
		local indx = ComboBoxGetSelectedMenuItem(FilterWindow .. "ConditionComboBox")

		if (indx == 0) then
			return
		end

		local list=ACTIVE_CONDITION[#ACTIVE_CONDITION]
		if(list[indx]~=nil)
		then
			table.remove(list,indx)
		else
			if(#list+1==indx)
			then
				Filter.external=nil
			end
		end
		if(activeconditionindex>#list or (Filter.external~=nil and activeconditionindex>#list+1))
		then
			activeconditionindex=activeconditionindex-1
			if(activeconditionindex<1)then activeconditionindex=1 end
		end
		FilterSettings.PopulateCondition()
	end
end

----------------------------------------------------------------------------------------------------
--# FilterSettings.ConditionChanged()
--# Used to change selected Condition
----------------------------------------------------------------------------------------------------
function FilterSettings.ConditionChanged()
	local indx = ComboBoxGetSelectedMenuItem(FilterWindow .. "ConditionComboBox")

	if (indx == 0) then
		return
	end

	local condition = ACTIVE_CONDITION[#ACTIVE_CONDITION][indx]
	activeconditionindex=indx

	if (condition == nil) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", #CONDITIONS-1)
		FilterSettings.PopulateG6Settings()
	elseif (condition[1] == 4) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", #CONDITIONS)
		FilterSettings.PopulateG4Settings(condition)
	else
		for i,k in ipairs(CONDITIONS) do
			if (k == condition[2]) then
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", i)
				break
			end
		end
		if(condition[1]==1)
		then
			FilterSettings.PopulateG1Settings(condition)
		elseif(condition[1]==2)
		then
			FilterSettings.PopulateG2Settings(condition)
		elseif(condition[1]==5)
		then
			FilterSettings.PopulateG5Settings(condition)
		end
	end
end

----------------------------------------------------------------------------------------------------
--# FilterSettings.PopulateG1Settings()
--# Used when ConditionChanged
--# 
--# Parameters:
--# 	condition				- (table)		conditions
--#
--# Returns:
--#
--# Notes:
--#
----------------------------------------------------------------------------------------------------
function FilterSettings.PopulateG1Settings(condition)
	FilterSettings.ShowFilterSettings(1)

	if (condition[3]==true or condition[3]==100) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", 1)
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", 2)
	end
end

function FilterSettings.PopulateG2Settings(condition)
	FilterSettings.ShowFilterSettings(2)

	if (DAoCBuffVar.Tables[condition[3]] == nil) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G2FilterWindow_G2ComboBox", 0)
	end

	local index = 1

	for i, k in pairs(DAoCBuffVar.Tables) do
		if (type(i) ~= "number") then
			if (i == condition[3]) then
				ComboBoxSetSelectedMenuItem(FilterWindow .. "G2FilterWindow_G2ComboBox", index)
				LabelSetText(FilterWindow.."G2FilterWindow_ErrorText",L"")
				for j,l in pairs(k)
				do
					if(type(j)~="number")
					then
						LabelSetText(FilterWindow.."G2FilterWindow_ErrorText",L"This list contains entries with no ID specified, this will sow down the whole filter.")
						break
					end
				end
				break
			else
				index = index + 1
			end
		end
	end
end

function FilterSettings.PopulateG4Settings(condition)
	FilterSettings.ShowFilterSettings(4)

	if (condition[3]) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G4FilterWindow_G4UseandComboBox", 1)
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G4FilterWindow_G4UseandComboBox", 2)
	end

	if (condition[4]) then
		ButtonSetPressedFlag(FilterWindow .. "G4FilterWindow_G4NotResultCheckBoxButton", true)
	else
		ButtonSetPressedFlag(FilterWindow .. "G4FilterWindow_G4NotResultCheckBoxButton", false)
	end
end

function FilterSettings.PopulateG5Settings(condition)
	FilterSettings.ShowFilterSettings(5)

	if (condition[4]) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G5FilterWindow_G5ComboBox", 1)
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G5FilterWindow_G5ComboBox", 2)
	end

	for i,k in ipairs(G5DURATION) do
		if (k.wert >= condition[3]) then
			ComboBoxSetSelectedMenuItem(FilterWindow .. "G5FilterWindow_G5DurationComboBox", i)
			condition[3] = k.wert
			break
		end
	end
end

function FilterSettings.PopulateG6Settings()
	FilterSettings.ShowFilterSettings(6)

	local result
	if(#ACTIVE_CONDITION>1)
	then
		result=ACTIVE_CONDITION[#ACTIVE_CONDITION][5][1][2]
	else
		result=Filter.external[1][2]
	end
	if (result) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", 1)
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox", 2)
	end
end

----------------------------------------------------------------------------------------------------
--# FilterSettings.ConditionTypeChanged()
--# Used to change ConditionTypeChanged
----------------------------------------------------------------------------------------------------
function FilterSettings.ConditionTypeChanged()

	if (#ACTIVE_CONDITION<1) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox",0)
		return
	end

	local condtype = CONDITIONS[ComboBoxGetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox")]
	local activecondition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]
	local save = nil

	if(activeconditionindex~=0)
	then
		local newcondnum=CONDITION_TEMPLATES[condtype]
		if(activecondition~=nil)
		then
			if(newcondnum==1)
			then
				if (type(activecondition[3]) == "bool") then
					save = activecondition[3]
				end
				for i,k in ipairs(activecondition) do
					activecondition[i] = nil
				end
				activecondition[1]=newcondnum
				activecondition[2]=condtype
				if(condtype=="trackerPriority")
				then
					activecondition[3]=100
				else
					if(save~=nil)
					then
						activecondition[3]=save
					else
						activecondition[3]=true
					end
				end
			elseif(newcondnum==2)
			then
				for i,k in ipairs(activecondition) do
					activecondition[i] = nil
				end
				activecondition[1]=newcondnum
				activecondition[2]="abilityId"
				activecondition[3]=nil
			elseif(newcondnum==4)
			then
				for i,k in ipairs(activecondition) do
					activecondition[i] = nil
				end
				activecondition[1]=newcondnum
				activecondition[2]={}
				activecondition[3]=true
				activecondition[4]=false
			elseif(newcondnum==5)
			then
				for i,k in ipairs(activecondition) do
					activecondition[i] = nil
				end
				activecondition[1]=newcondnum
				activecondition[2]=condtype
				activecondition[3]=600
				activecondition[4]=true
			elseif(newcondnum==6)
			then
				local ex
				if(#ACTIVE_CONDITION>1)
				then
					ex=ACTIVE_CONDITION[#ACTIVE_CONDITION][5][1]
				else
					if(Filter.external==nil)
					then
						Filter.external={{}}
					end
					ex=Filter.external[1]
				end
				ex[1]={}
				ex[1][1]="GameData"
				ex[1][2]="Player"
				ex[1][3]="inCombat"
				if (type(activecondition[3]) == "bool") then
					ex[2]=activecondition[3]
				else
					ex[2]=true
				end
				table.remove(ACTIVE_CONDITION[#ACTIVE_CONDITION],activeconditionindex)
			end
		else
			local condition={}
			table.insert(ACTIVE_CONDITION[#ACTIVE_CONDITION],condition)
			if(newcondnum==1)
			then
				condition[1]=newcondnum
				condition[2]=condtype
				if(#ACTIVE_CONDITION>1)
				then
					save=ACTIVE_CONDITION[#ACTIVE_CONDITION][5][1][2]
				else
					save=Filter.external[1][2]
				end
				if(save~=nil)
				then
					condition[3]=save
				else
					condition[3]=true
				end
			elseif(newcondnum==2)
			then
				condition[1]=newcondnum
				condition[2]="abilityId"
				condition[3]=nil
			elseif(newcondnum==4)
			then
				condition[1]=newcondnum
				condition[2]={}
				condition[3]=true
				condition[4]=false
			elseif(newcondnum==5)
			then
				condition[1]=newcondnum
				condition[2]=condtype
				condition[3]=600
				condition[4]=true
			end
		end
		FilterSettings.PopulateCondition()
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox",0)
	end
end


----------------------------------------------------------------------------------------------------
--# FilterSettings.G1FilterChanged()
--# Used to change G1Filter
----------------------------------------------------------------------------------------------------
function FilterSettings.G1FilterChanged()
	local activecondition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]
	local result=ComboBoxGetSelectedMenuItem(FilterWindow .. "G1FilterWindow_G1ComboBox")
	if(activecondition~=nil)
	then
		if(activecondition[2]=="trackerPriority")
		then
			if(result==1)
			then
				activecondition[3]=100
			else
				activecondition[3]=0
			end
		else
			activecondition[3]=(result==1)
		end
	else
		result=(result==1)
		if(#ACTIVE_CONDITION>1)
		then
			ACTIVE_CONDITION[#ACTIVE_CONDITION][5][1][2]=result
		else
			Filter.external[1][2]=result
		end
	end
	FilterSettings.PopulateCondition()
end

function FilterSettings.G2ListChanged()
	local index=ComboBoxGetSelectedMenuItem(FilterWindow .. "G2FilterWindow_G2ComboBox")

	if (index == 0) then
		return
	end

	local activecondition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]

	for i, k in pairs(DAoCBuffVar.Tables) do
		if (type(i)~="number") then
			if(index<=1)
			then
				activecondition[3]=i
				LabelSetText(FilterWindow.."G2FilterWindow_ErrorText",L"")
				for j,l in pairs(k)
				do
					if(type(j)~="number")
					then
						LabelSetText(FilterWindow.."G2FilterWindow_ErrorText",L"This list contains entries with no ID specified, this will sow down the whole filter.")
						break
					end
				end
				break
			else
				index=index-1
			end
		end
	end
	FilterSettings.PopulateCondition()
end

function FilterSettings.G4UseandChanged()
	local activecondition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]
	if (ComboBoxGetSelectedMenuItem(FilterWindow .. "G4FilterWindow_G4UseandComboBox") == 1) then
		activecondition[3] = true
	else
		activecondition[3] = false
	end
end

function FilterSettings.ChangeG4RecursiveConditions()
	table.insert(ACTIVE_CONDITION,ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex][2])
	FilterSettings.PopulateCondition()
end

local wedo=false
function FilterSettings.G4HistoryBrowserChanged()
	if(not wedo)
	then
		local x=ComboBoxGetSelectedMenuItem(FilterWindow .. "G4HistoryBrowserComboBox")
		while(#ACTIVE_CONDITION>x)
		do
			table.remove(ACTIVE_CONDITION)
		end
		FilterSettings.PopulateCondition()
	end
end

function FilterSettings.G5FilterChanged()
	local activecondition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]
	if (ComboBoxGetSelectedMenuItem(FilterWindow .. "G5FilterWindow_G5ComboBox") == 1) then
		activecondition[4] = true
	else
		activecondition[4] = false
	end
	FilterSettings.PopulateCondition()
end

function FilterSettings.G5DurationChanged()
	ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex][3] = G5DURATION[ComboBoxGetSelectedMenuItem(FilterWindow .. "G5FilterWindow_G5DurationComboBox")].wert
	FilterSettings.PopulateCondition()
end

function FilterSettings.PopulateCondition()
	FilterSettings.PopulateHistoryBrowser()
	ComboBoxClearMenuItems(FilterWindow .. "ConditionComboBox")

	if (#ACTIVE_CONDITION == 0) then
		return
	end

	local name
	for i,k in ipairs(ACTIVE_CONDITION[#ACTIVE_CONDITION]) do
		name = L""
		if (k[1] == 1) then
			name = towstring(k[2]:sub(1,12) .. " == " .. tostring(k[3]))
		elseif (k[1] == 2) then
			name = towstring(k[2])
		elseif (k[1] == 4) then
			local n=0
			name=name..L"layer: "
			for j,l in ipairs(k[2])
			do
				if(type(l[2])=="string")
				then
					name=name..towstring(l[2]:sub(1,5))..L" "
				else
					name=name..L"lay"..towstring(j)..L"  "
				end
				if(n>3)then break
				else n=n+1 end
			end
			if(n<4)
			then
				if(k[5]~=nil)
				then
					name=name..L"inCom"
				end
			end
		elseif (k[1] == 5) then
			name = towstring(k[2])
			if (k[4]) then
				name = name .. L" > "
			else
				name = name .. L" < "
			end
			name = name .. k[3]
		end
		ComboBoxAddMenuItem(FilterWindow .. "ConditionComboBox", name)
	end
	if(#ACTIVE_CONDITION>1)
	then
		if(ACTIVE_CONDITION[#ACTIVE_CONDITION][5]~=nil)
		then
			ComboBoxAddMenuItem(FilterWindow .. "ConditionComboBox",towstring("inCombat=="..tostring(ACTIVE_CONDITION[#ACTIVE_CONDITION][5][1][2])))
		end
	else
		if(Filter.external~=nil)
		then
			ComboBoxAddMenuItem(FilterWindow .. "ConditionComboBox",towstring("inCombat=="..tostring(Filter.external[1][2])))
		end
	end

	if ((#ACTIVE_CONDITION[#ACTIVE_CONDITION]>0 or Filter.external~=nil) and activeconditionindex>0) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionComboBox",activeconditionindex)
		local condition = ACTIVE_CONDITION[#ACTIVE_CONDITION][activeconditionindex]
		if(condition==nil)
		then
			if(Filter.external~=nil)
			then
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", #CONDITIONS-1)
				DAoCBuffSettings.PopulateG6Settings()
			else
				DAoCBuffSettings.ShowFilterSettings(0)
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionComboBox", 0)
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", 0)
			end
		elseif (condition[1] == 4) then
			ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", #CONDITIONS)
			FilterSettings.PopulateG4Settings(condition)
		else
			for i,k in ipairs(CONDITIONS) do
				if (k == condition[2]) then
					ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", i)
					break
				end
			end
			if(condition[1]==1)
			then
				FilterSettings.PopulateG1Settings(condition)
			elseif(condition[1]==2)
			then
				FilterSettings.PopulateG2Settings(condition)
			elseif(condition[1]==4)
			then
				FilterSettings.PopulateG4Settings(condition)
			elseif(condition[1]==5)
			then
				FilterSettings.PopulateG5Settings(condition)
			end
		end
	else
		FilterSettings.ShowFilterSettings(0)
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionComboBox", 0)
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ConditionTypeComboBox", 0)
	end
end

function FilterSettings.PopulateHistoryBrowser()
	wedo=true
	ComboBoxClearMenuItems(FilterWindow .. "G4HistoryBrowserComboBox")
	local name
	local n
	for i,k in ipairs(ACTIVE_CONDITION)
	do
		if(i==1)then name=L"1-root: "
		else name=towstring(i)..L"-layer: " end
		n=1
		for j,l in ipairs(k)
		do
			if(type(l[2])=="string")
			then
				name=name..towstring(l[2]:sub(1,5))..L" "
			else
				name=name..L"lay"..towstring(j)..L"  "
			end
			if(n>3)then break
			else n=n+1 end
		end
		if(n<4)
		then
			if(i==1)
			then 
				if(Filter.external~=nil)
				then
					name=name..L"inCom"
				end
			else
				if(k[5]~=nil)
				then
					name=name..L"inCom"
				end
			end
		end
		ComboBoxAddMenuItem(FilterWindow .. "G4HistoryBrowserComboBox", name)
	end
	ComboBoxSetSelectedMenuItem(FilterWindow .. "G4HistoryBrowserComboBox",#ACTIVE_CONDITION)
	wedo=false
end

function FilterSettings.PopulateFilter()
	ButtonSetPressedFlag(FilterWindow .. "EnableFilterCheckBoxButton", Filter.active)
	ButtonSetPressedFlag(FilterWindow .. "CombatHideCheckBoxButton", Filter.combathide)
	ButtonSetPressedFlag(FilterWindow .. "CondenseCheckBoxButton", Filter.condense)
	ButtonSetPressedFlag(FilterWindow .. "DeleteCheckBoxButton", Filter.delete)
	ButtonSetPressedFlag(FilterWindow .. "EndaCheckBoxButton", Filter.enda)
	ButtonSetPressedFlag(FilterWindow .. "InvertResultCheckBoxButton", Filter.notresult)

	if (Filter.useand) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "UseandComboBox", 1)
	else
		ComboBoxSetSelectedMenuItem(FilterWindow .. "UseandComboBox", 2)
	end

	if (Filter.condense) then
		for i,k in ipairs(FILTER_PROPERTIES) do
			if (Filter.addPrefs[k] == true) then
				ComboBoxSetSelectedMenuItem(FilterWindow .. "FilterPropertyComboBox", i)
			end
		end

		local typeindex = 0
		local textureindex
		local breakvar = false

		for i,k in pairs(DAoCBuff.textures) do
			typeindex = typeindex + 1
			for j,l in ipairs(k) do
				if (l == Filter.icon) then
					textureindex = j
					breakvar = true
					break
				end
			end
			if (breakvar) then
				break
			end
		end

		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureTypeComboBox", typeindex)
		FilterSettings.PopulateTextureComboBox()
		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureComboBox", textureindex)
		DynamicImageSetTexture(FilterWindow .. "CondenseIconPreview", Filter.icon, 0, 0)
		FilterSettings.DisableCondenseSettings(false)
	else
		FilterSettings.DisableCondenseSettings(true)
	end

	ButtonSetPressedFlag(FilterWindow.."ColorCCheckBoxButton",Filter.iconC~=nil)
	ButtonSetPressedFlag(FilterWindow.."ColorBCheckBoxButton",Filter.borderC~=nil)
	FilterSettings.PopulateColor()

	ACTIVE_CONDITION = {[1] = Filter.conditions}
	if(#ACTIVE_CONDITION[1]>0)
	then
		activeconditionindex=1
	else
		activeconditionindex=0
	end
	ComboBoxClearMenuItems(FilterWindow .. "G2FilterWindow_G2ComboBox")
	for i, k in pairs(DAoCBuffVar.Tables) do
		if (type(i) ~= "number") then
			ComboBoxAddMenuItem(FilterWindow .. "G2FilterWindow_G2ComboBox", towstring(i))
		end
	end
	ComboBoxSetSelectedMenuItem(FilterWindow .. "G2FilterWindow_G2ComboBox", 0)
	LabelSetText(FilterWindow.."G2FilterWindow_ErrorText",L"")

	if(Filter.classtable)
	then
		ButtonSetPressedFlag(FilterWindow .. "EnableClasstableCheckBoxButton", true)
		ComboBoxSetDisabledFlag(FilterWindow .. "ClassTableComboBox",false)
		ButtonSetDisabledFlag(FilterWindow .. "AddClassTableButton",false)

		FilterSettings.PopulateClassTable()
		local myId=GameData.Player.career.id
		local acl=Filter.classtable
		for i,k in ipairs(CLASSTABLE)
		do
			if(myId==k.id)
			then
				if(acl[k.id])
				then
					ButtonSetText(FilterWindow .. "AddClassTableButton", L"Deactivate")
				else
					ButtonSetText(FilterWindow .. "AddClassTableButton", L"Activate")
				end
				ComboBoxSetSelectedMenuItem(FilterWindow .. "ClassTableComboBox",i)
				break
			end
		end
	else
		ButtonSetPressedFlag(FilterWindow .. "EnableClasstableCheckBoxButton", false)
		ComboBoxSetDisabledFlag(FilterWindow .. "ClassTableComboBox",true)
		ButtonSetDisabledFlag(FilterWindow .. "AddClassTableButton",true)
		ComboBoxSetSelectedMenuItem(FilterWindow .. "ClassTableComboBox",0)
	end

	FilterSettings.PopulateCondition()
end

function FilterSettings.PopulateClassTable()
	ComboBoxClearMenuItems(FilterWindow .. "ClassTableComboBox")
	if(Filter.classtable)
	then
		local name
		local acl=Filter.classtable
		for i,k in ipairs(CLASSTABLE)
		do
			if(acl[k.id])
			then
				name=L"ON  - "..k.name
			else
				name=L"OFF - "..k.name
			end
			ComboBoxAddMenuItem(FilterWindow .. "ClassTableComboBox", name)
		end
	end
end

function FilterSettings.PopulateTextureComboBox()
	local index = ComboBoxGetSelectedMenuItem(FilterWindow .. "TextureTypeComboBox")

	if (index < 1) then
		return
	end

	local texturetable

	for i,k in pairs(DAoCBuff.textures) do
		if (index == 1) then
			texturetable = k
			break
		else
			index = index - 1
		end
	end

	ComboBoxClearMenuItems(FilterWindow .. "TextureComboBox")
	for i,k in ipairs(texturetable) do
		ComboBoxAddMenuItem(FilterWindow .. "TextureComboBox", towstring(k))
	end
end

----------------------------------------------------------------------------------------------------
--# FilterSettings.ShowFilterSettings(filtertype)
--# 
--# 
--# Parameters:
--# 	filtertype				- (int)		
--#
--# Returns:
--#
--# Notes:
--#
----------------------------------------------------------------------------------------------------
function FilterSettings.ShowFilterSettings(filtertype)
	if(filtertype==6)		--we use the same for G6 as for G1
	then
		filtertype=1
	end
	WindowSetShowing(FilterWindow .. "G1FilterWindow", filtertype == 1)
	WindowSetShowing(FilterWindow .. "G4FilterWindow", filtertype == 4)
	WindowSetShowing(FilterWindow .. "LayerTooltip",   filtertype == 4)
	WindowSetShowing(FilterWindow .. "G5FilterWindow", filtertype == 5)
	WindowSetShowing(FilterWindow .. "G2FilterWindow", filtertype == 2)
end

function FilterSettings.DisableCondenseSettings(disable)
	if (disable) then
		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureTypeComboBox", 0)
		ComboBoxSetSelectedMenuItem(FilterWindow .. "TextureComboBox", 0)
		DynamicImageSetTexture(FilterWindow .. "CondenseIconPreview", "DAoC_new_qm", 0, 0)
	end
	ButtonSetDisabledFlag(FilterWindow .. "CombatHideCheckBoxButton", disable)
	ComboBoxSetDisabledFlag(FilterWindow .. "FilterPropertyComboBox", disable)
	ComboBoxSetDisabledFlag(FilterWindow .. "TextureTypeComboBox", disable)
	ComboBoxSetDisabledFlag(FilterWindow .. "TextureComboBox", disable)
end


local p,acc
function ImExport.Create()
	CreateWindow(iewindow,false)
	WindowSetShowing(iewindow,false)
	WindowSetHandleInput(iewindow,false)
	ImExport.SetLabels()
end

function ImExport.Open()
	DAoCBuffSettings.Disable()
	WindowSetHandleInput(iewindow,true)
	WindowSetShowing(iewindow,true)
	WindowStartAlphaAnimation(iewindow,Window.AnimationType.SINGLE_NO_RESET,0,1,0.4,true,0,0)
	ImExport.PopulateImEx()
end

function ImExport.Close()
	WindowSetHandleInput(iewindow,false)
	WindowStartAlphaAnimation(iewindow,Window.AnimationType.EASE_OUT,1,0,0.4,true,0,0)
	DAoCBuffSettings.Reactivate()
	RegisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.ImExport.Cleanup")
end

function ImExport.Cleanup()
	if(WindowGetAlpha(iewindow)==0)
	then
		WindowSetShowing(iewindow,false)
		UnregisterEventHandler(SystemData.Events.UPDATE_PROCESSED,"DAoCBuffSettings.ImExport.Cleanup")
	end
end

function ImExport.SetLabels()
	LabelSetText(ImExportWindow.."TypeComboText", L"Import/Export")
	ComboBoxAddMenuItem(ImExportWindow.."TypeComboBox",L"Import")
	ComboBoxAddMenuItem(ImExportWindow.."TypeComboBox",L"Export")
	ComboBoxSetSelectedMenuItem(ImExportWindow.."TypeComboBox",1)

	LabelSetText(ImExportWindow.."ExportTypeComboText",L"Export Type")
	for i,k in ipairs(EXPORT_TYPE)
	do
		ComboBoxAddMenuItem(ImExportWindow.."ExportTypeComboBox",towstring(k))
	end

	LabelSetText(ImExportWindow.."FilterComboText", L"Filter")
	ButtonSetText(ImExportWindow.."ImExportButton",L"Import")
end

function ImExport.PopulateImEx()
	if(ComboBoxGetSelectedMenuItem(ImExportWindow.."TypeComboBox")==1)
	then
		WindowSetShowing(ImExportWindow.."ExportTypeComboText",false)
		WindowSetShowing(ImExportWindow.."ExportTypeComboBox",false)
		ImExport.PopulateExportTypeSettings(0)
		ButtonSetText(ImExportWindow.."ImExportButton",L"Import")
	else
		WindowSetShowing(ImExportWindow.."ExportTypeComboText",true)
		WindowSetShowing(ImExportWindow.."ExportTypeComboBox",true)
		ImExport.PopulateExportTypeSettings()
		ButtonSetText(ImExportWindow.."ImExportButton",L"Export")
		p=nil
		acc=nil
	end
end

function ImExport.PopulateExportTypeSettings(id)
	if(id==nil)
	then
		id=ComboBoxGetSelectedMenuItem(ImExportWindow.."ExportTypeComboBox")
	end

	if(id>1)
	then
		WindowSetShowing(ImExportWindow.."FrameComboText",true)
		WindowSetShowing(ImExportWindow.."FrameComboBox",true)
	else
		WindowSetShowing(ImExportWindow.."FrameComboText",false)
		WindowSetShowing(ImExportWindow.."FrameComboBox",false)
	end
	if(id==3)
	then
		WindowSetShowing(ImExportWindow.."FilterComboText",true)
		WindowSetShowing(ImExportWindow.."FilterComboBox",true)
	else
		WindowSetShowing(ImExportWindow.."FilterComboText",false)
		WindowSetShowing(ImExportWindow.."FilterComboBox",false)
	end

	if(id==2 or id==3)
	then
		LabelSetText(ImExportWindow.."FrameComboText", L"Frame")
		ComboBoxClearMenuItems(ImExportWindow.."FrameComboBox")
		for i,k in ipairs(DAoCBuffVar.Frames)
		do
			ComboBoxAddMenuItem(ImExportWindow.."FrameComboBox",k.name)
		end
	end
	if(id==4)
	then
		LabelSetText(ImExportWindow.."FrameComboText", L"List")
		ComboBoxClearMenuItems(ImExportWindow.."FrameComboBox")
		for i,k in pairs(DAoCBuffVar.Tables)
		do
			if(type(i)=="string")
			then
				ComboBoxAddMenuItem(ImExportWindow.."FrameComboBox",towstring(i))
			end
		end
	end
	if(id==3)
	then
		ImExport.PopulateFilter()
	end
end

function ImExport.PopulateFilter()
	ComboBoxClearMenuItems(ImExportWindow.."FilterComboBox")
	local frame=ComboBoxGetSelectedMenuItem(ImExportWindow.."FrameComboBox")
	if(ComboBoxGetSelectedMenuItem(ImExportWindow.."ExportTypeComboBox")==3 and frame~=0)
	then
		for i,k in ipairs(DAoCBuffVar.Frames[frame].filters)
		do
			ComboBoxAddMenuItem(ImExportWindow.."FilterComboBox",k.name)
		end
	end
end

local function ProtectedSetText(s)
	TextEditBoxSetText(ImExportWindow.."EditBox",L"_\n"..towstring(s))
end

function ImExport.FrameChanged()
	if(ComboBoxGetSelectedMenuItem(ImExportWindow.."TypeComboBox")==1)
	then
		if(acc.type=="Filter")
		then
			local i=ComboBoxGetSelectedMenuItem(ImExportWindow.."FrameComboBox")
			if(i>0)
			then
				acc.i=nil
				for i,k in ipairs(DAoCBuffVar.Frames[i].filters)
				do
					if(k.name==acc.item.name)
					then
						acc.i=i
						break
					end
				end
				if(acc.i)
				then
					ProtectedSetText(L"In this Frame a Filter with the name \""..acc.item.name..L"\" already exists,\nit will be overwritten if you press Import.")
				else
					ProtectedSetText(L"Press the Import button to add the Filter \""..acc.item.name..L"\".")
				end
			end
		else
			ImExport.PopulateExportTypeSettings(0)
		end
	else
		ImExport.PopulateFilter()
	end
end

local function AddLists(c,l)
	for i,k in ipairs(c)
	do
		if(k[1]==2)
		then
			l[k[3]]=DAoCBuffVar.Tables[k[3]]
		else
			if(k[1]==4)
			then
				AddLists(k[2],l)
			end
		end
	end
end

function ImExport.ImExport()
	if(ComboBoxGetSelectedMenuItem(ImExportWindow.."TypeComboBox")==1)
	then
		if(acc~=nil)
		then
			if(acc.type=="All")
			then
				DAoCBuffVar=acc.item
				ProtectedSetText("All your settings have been overwritten.")
			elseif(acc.type=="Frame")
			then
				if(acc.i)
				then
					DAoCBuffVar.Frames[acc.i]=acc.item
					ProtectedSetText(L"Overwritten Frame "..acc.item.name..L".")
				else
					table.insert(DAoCBuffVar.Frames,acc.item)
					ProtectedSetText(L"Added Frame "..acc.item.name..L".")
				end
				ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )
				DAoCBuffSettings.PopulateGlobalChangeComboBoxes()
			elseif(acc.type=="Filter")
			then
				local i=ComboBoxGetSelectedMenuItem(ImExportWindow.."FrameComboBox")
				if(i>0)
				then
					if(acc.i)
					then
						DAoCBuffVar.Frames[i].filters[acc.i]=acc.item
						ProtectedSetText(L"Overwritten Filter "..towstring(acc.item.name)..L" in Frame "..towstring(DAoCBuffVar.Frames[i].name)..L".")
					else
						table.insert(DAoCBuffVar.Frames[i].filters,acc.item)
						ProtectedSetText(L"Added Filter "..towstring(acc.item.name)..L" in Frame "..towstring(DAoCBuffVar.Frames[i].name)..L".")
					end
					ImExport.PopulateExportTypeSettings(0)
				else
					ProtectedSetText(L"Please choose a Frame where the Filter "..towstring(acc.item.name)..L" should be imported.")
					return
				end
			elseif(acc.type=="List")
			then
				local s
				if(DAoCBuffVar.Tables[acc.i])
				then
					s=L"Overwritten"
				else
					s=L"Added"
				end
				DAoCBuffVar.Tables[acc.i]=acc.item
				ProtectedSetText(s..L" List "..towstring(acc.i)..L".")
			end
			for i,k in pairs(acc.lists)
			do
				DAoCBuffVar.Tables[i]=k
			end
			acc=nil
			ListBoxSetDisplayOrder( "DAoCBuff_SettingsList", DAoCBuffSettings.CreateDisplayOrder() )
		else
			if(p~=nil)
			then
				local hit=1
				for i=1,p.n
				do
					if(p[i]==nil)
					then
						hit=i
						break
					end
				end
				ProtectedSetText("The packet set is not complete yet.\nPlease inser the packet number "..hit.." next.")
			else
				ProtectedSetText("Got no input to Import.")
			end
		end
	else
		local item,name
		local id=ComboBoxGetSelectedMenuItem(ImExportWindow.."ExportTypeComboBox")
		if(id==1)
		then
			item=DAoCBuffVar
		else
			if(id==2 or id==3)
			then
				local frame=ComboBoxGetSelectedMenuItem(ImExportWindow.."FrameComboBox")
				if(id==2)
				then
					item=DAoCBuffVar.Frames[frame]
				else
					if(DAoCBuffVar.Frames[frame]~=nil)
					then
						item=DAoCBuffVar.Frames[frame].filters[ComboBoxGetSelectedMenuItem(ImExportWindow.."FilterComboBox")]
					end
				end
				if(item~=nil)then name=item.name end
			else
				if(id==4)
				then
					local index=ComboBoxGetSelectedMenuItem(ImExportWindow.."FrameComboBox")
					for i,k in pairs(DAoCBuffVar.Tables)
					do
						if(type(i)=="string")
						then
							if(index==1)
							then
								item=DAoCBuffVar.Tables[i]
								name=i
								break
							else
								index=index-1
							end
						end
					end
				end
			end
		end

		if(item~=nil)
		then
			local export={["type"]=EXPORT_TYPE[id],["version"]=DAoCBuffVar.version,["name"]=name,["item"]=item,lists={}}
			if(id==2)
			then
				for i,k in ipairs(item.filters)
				do
					AddLists(k.conditions,export.lists)
				end
			else
				if(id==3)
				then
					AddLists(item.conditions,export.lists)
				end
			end
			local es=DAoCBuff.PacketManager.Create(DAoCBuff.Encode(export))
			local s="DAoCBuff v."..export.version.."\nExport: "
			if(export.type=="All")
			then
				s=s.."Complete Settings\n"
			else
				s=towstring(s)..towstring(name)..L" ("..towstring(export.type)..L")\n"
			end
			local d=GetTodaysDate()
			s=towstring(s)..L"created by "..GameData.Player.name..L" of "..GameData.Account.ServerName..L" on "..d.todaysMonth..L"/"..d.todaysDay..L"/"..d.todaysYear..L"\n"
			if(type(es)=="table")
			then
				s=s..L"Packets: "..#es..L"\n"
				for i=1,#es
				do
					s=s..L"\nPacket number "..i..L"\n"..towstring(es[i])..L"\n"
				end
				s=s..L"\nHow to Import:\nStart with the first packet.\nCopy the complete string of the packet into your clipboard\nand paste it with Ctrl+v into DAoCBuff.\nDo this for every packet.\n"
			else
				s=s..L"\n"..towstring(es)..L"\n\nHow to Import:\nCopy the complete string above into your clipboard\nand paste it with Ctrl+v into DAoCBuff.\n"
			end
			s=s..L"DAoCBuff will guide you through the importprocess."
			ProtectedSetText(s)
		else
			ProtectedSetText("Nothing specified to export.")
		end
	end
end

function ImExport.TextChanged(s)
	if(ComboBoxGetSelectedMenuItem(ImExportWindow.."TypeComboBox")==1 and s~=L"" and s:sub(1,1)~=L"_")
	then
		acc=nil
		ImExport.PopulateExportTypeSettings(0)
		p,s=DAoCBuff.PacketManager.Add(p,tostring(s))
		if(type(p)=="string")
		then
			s=towstring(s)..ImExport.CheckImport(p)
		else
			if(p~=nil and p.complete)
			then
				s=ImExport.CheckImport(DAoCBuff.PacketManager.Combine(p))
			end
		end
		ProtectedSetText(s)
	end
end

local Templates={}
do
	local List			={{["template"]={["normal"]={["name"]="skip",["abilityId"]="skip",["effectText"]="skip",["iconNum"]="skip"}}}}
	local conditions=	{
							{["idx"]=1,["mark"]=1,["template"]={["normal"]={
							"number","string","skip"}}},
							{["idx"]=1,["mark"]=2,["template"]={["normal"]={
							"number","string","string","skip"}}},
							{["idx"]=1,["mark"]=5,["template"]={["normal"]={
							"number","string","number","boolean"}}},
							{["idx"]=1,["mark"]=4,["template"]={["normal"]={
							"number","blubb","boolean","boolean","skip"}}},
						}
	conditions[4].template.normal[2]=conditions
	local Filter	={["normal"]={["enda"]="boolean",["delete"]="boolean",["icon"]="string",["combathide"]="boolean",["addPrefs"]={["normal"]={}},["useand"]="boolean",["name"]="wstring",["active"]="boolean",["condense"]="boolean",["conditions"]=conditions,["borderC"]="skip",["iconC"]="skip",["notresult"]="boolean",["external"]="skip",["classtable"]="skip"}}
	local Frame		={["normal"]={["glass"]="boolean",["active"]="boolean",["maxBuffCount"]="number",["FA"]="boolean",["update"]="number",["rowcount"]="number",["ismine"]="number",["buffTargetType"]="number",["anchor"]="skip",["filters"]={{["template"]=Filter}},["hpte"]="boolean",["type"]="number",["permabuffs"]="number",["divide"]="number",["growup"]="number",["buffsbelow"]="number",["bufforder"]="number",["longtimehide"]="boolean",["font"]="number",["staticcondense"]="boolean",["name"]="wstring",["showborder"]="boolean",["longtoperma"]="boolean",["horizontal"]="number",["buffRowStride"]="number",["growleft"]="number",["Stickname"]="skip"}}
	local All		={["normal"]={["killbuffs"]="boolean",["Frames"]={{["template"]=Frame}},["version"]="number",["Tables"]={{["template"]=List}}}}
	for i,k in ipairs(FILTER_PROPERTIES)
	do
		Filter.normal.addPrefs.normal[k]="skip"
	end
	Templates.List=List
	Templates.Filter=Filter
	Templates.Frame=Frame
	Templates.All=All
end

function ImExport.CheckImport(s)
	local t=DAoCBuff.Decode(s)
	if(t~=nil and t.version>=1.01 and t.version<=DAoCBuffVar.version and EXPORT_TYPE_REV[t.type]~=nil and t.item~=nil)
	then
		DAoCBuff.Update[t.type](t.item,t.version)
		local main,pass=DAoCBuff.Verify(t.item,Templates[t.type])
		local lists={}
		local tmp
		if(pass)
		then
			for i,k in pairs(t.lists)
			do
				tmp,pass=DAoCBuff.Verify(k,Templates["List"])
				if(pass)
				then
					lists[i]=tmp
				else
					break
				end
			end
		end
		if(pass)
		then
			acc={["type"]=t.type,["item"]=main,["lists"]=lists}
			p=nil
			if(t.type=="All")
			then
				return L"A complete Set of Settings für DAoCBuff has been loaded,\nif you press Import, ALL your settings will be overwritten."
			elseif(t.type=="Frame")
			then
				acc.i=nil
				for i,k in ipairs(DAoCBuffVar.Frames)
				do
					if(k.name==main.name)
					then
						acc.i=i
						break
					end
				end
				local s=L"The "..towstring(t.type)..L" \""..main.name..L"\" was successfully unpacked.\n"
				if(acc.i)
				then
					s=s..L"A "..towstring(t.type)..L" with the name \""..main.name..L"\" already exists,\nit will be overwritten if you don't change its name before the import.\n"
				end
				for i,k in pairs(acc.lists)
				do
					if(DAoCBuffVar.Tables[i]~=nil)
					then
						s=s..L"The List \""..towstring(i)..L"\" already exists it will be overwritten.\n"
					end
				end
				return s..L"Press the Import button to add the "..towstring(t.type)..L"."
			elseif(t.type=="Filter")
			then
				ImExport.PopulateExportTypeSettings(2)
				local s=L"The "..towstring(t.type)..L" \""..main.name..L"\" was successfully unpacked.\n"
				for i,k in pairs(acc.lists)
				do
					if(DAoCBuffVar.Tables[i]~=nil)
					then
						s=s..L"The List "..towstring(i)..L" already exists it will be overwritten.\n"
					end
				end
				return s..L"Please choose a Frame in the combobox above\nwhere you want to add this filter to."
			elseif(t.type=="List")
			then
				acc.i=t.name
				if(DAoCBuffVar.Tables[t.name]~=nil)
				then
					return L"The "..towstring(t.type)..L" \""..towstring(t.name)..L"\" was successfully unpacked.\nA "..towstring(t.type)..L" with the name \""..towstring(t.name)..L"\" already exists,\nit will be overwritten.\nPress the Import button to add the "..towstring(t.type)..L"."
				else
					return L"The "..towstring(t.type)..L" \""..towstring(t.name)..L"\" was successfully unpacked.\nPress the Import button to add the "..towstring(t.type)..L"."
				end
			end
		else
			return L"The imported data was not consistent.\nPlease try export again and file a bug report in the ticketsystem if that doesn't help."
		end
	else
		if(not t)then return L"The inputstring seems to be damaged,\nplease create a bug report in the ticket system and provide the import data." end
		if(not (t.version>=1.01))then return L"The imported data is from a too old version of DAoCBuff to be imported." end
		if(not (t.version<=DAoCBuffVar.version))then return L"The imported data is from a newer version of DAoCBuff,\nplease update your DAoCBuff to the latest version." end
		if(not EXPORT_TYPE_REV[t.type])then return L"Couldn't recognize import type,\nplease open a bug report in the ticket system and provide the import data." end
		if(not t.item)then return L"Couldn't find payload data,\nplease create a bug report in the ticket system and provide the import data." end
	end
end
