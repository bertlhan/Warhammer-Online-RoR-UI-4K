--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################


DAoCBuff = {}
DAoCBuff.textures={}

local HaveHostile	=0
local HaveFriendly	=0
local tracker={}
tracker[1]={}
tracker[2]={}
tracker[3]={}
tracker[4]={}

local Tself=GameData.BuffTargetType.SELF
local Thostile=GameData.BuffTargetType.TARGET_HOSTILE
local Tfriendly=GameData.BuffTargetType.TARGET_FRIENDLY

local ipairs = ipairs
local pairs = pairs

function DAoCBuff.Initialize()

	LibSlash.RegisterSlashCmd("resetdaocbuff", function(input) DAoCBuff.ResetDAoCBuff(input) end)

	if(DAoCBuffVar==nil)then
		DAoCBuff.LoadPresets()
	end

	DAoCBuff.VersionHandler()

	RegisterEventHandler(SystemData.Events.ENTER_WORLD,			 			"DAoCBuff.TargetsCleared")
	RegisterEventHandler(SystemData.Events.RELEASE_CORPSE,					"DAoCBuff.TargetsCleared")
	RegisterEventHandler(SystemData.Events.PLAYER_DEATH_CLEARED,			"DAoCBuff.TargetsCleared")
	RegisterEventHandler(SystemData.Events.INTERFACE_RELOADED,				"DAoCBuff.OnReload")
	RegisterEventHandler(SystemData.Events.ENTER_WORLD,						"DAoCBuff.OnReload")
	RegisterEventHandler(SystemData.Events.PLAYER_COMBAT_FLAG_UPDATED,		"DAoCBuff.CombatUpdate")
	RegisterEventHandler(SystemData.Events.CUSTOM_UI_SCALE_CHANGED,			"DAoCBuff.U")
	RegisterEventHandler(SystemData.Events.PLAYER_EFFECTS_UPDATED,			"DAoCBuff.OnEvent")
	RegisterEventHandler(SystemData.Events.PLAYER_TARGET_EFFECTS_UPDATED,	"DAoCBuff.OnEventH")
	RegisterEventHandler(SystemData.Events.PLAYER_TARGET_UPDATED,			"DAoCBuff.OnEventHC")
	RegisterEventHandler(SystemData.Events.GROUP_EFFECTS_UPDATED,			"DAoCBuff.OnEventG")
	RegisterEventHandler(SystemData.Events.GROUP_UPDATED,					"DAoCBuff.OnEventGU")

	LibSlash.RegisterSlashCmd("daocbuff", function(input) DAoCBuff.HandleSlash(input) end)
	LayoutEditor.RegisterEditCallback(DAoCBuff.LEH)
	DAoCBuff.LES=false

	DAoCBuff.StartTracker()

	TextLogAddEntry("Chat", 0, L"DAoCBuff initialized ! - Use '/daocbuff' to open the Optionswindow");
end

function DAoCBuff.U()
	DAoCBuff.StopTracker()
	DAoCBuff.StartTracker()
end

function DAoCBuff.StartTracker()

	if(DAoCBuffVar.killbuffs)
	then
		DAoCBuff.InstallSBDestroyer()
	end

	local tmp
	local list={}
	for _,k in ipairs(DAoCBuffVar.Frames)
	do
		list[tostring(k.name)]=k
	end
	for _,k in ipairs(DAoCBuffVar.Frames)
	do
		if(k.Stickname)
		then
			if (k.name==k.Stickname)
			then
				k.Stickname=nil
			else
				tmp=list[tostring(k.Stickname)]
				if(k.type~=1 or k.buffTargetType==100 or (tmp~=nil and (tmp.type~=1 or tmp.buffTargetType==100)))
				then
					k.Stickname=nil
				else
					tmp=k
					repeat
						tmp=list[tostring(k.Stickname)]
					until(tmp==nil or tmp.Stickname==nil)
					if(tmp~=nil)
					then
						k.growleft=tmp.growleft
						k.growup=tmp.growup
						k.horizontal=tmp.horizontal
					end
				end
			end
		end
	end
	list={}
	for _,k in ipairs(DAoCBuffVar.Frames)
	do
		if(k.active)
		then
			tmp="DAoCBuff_"..tostring(k.name)
			if(k.type==1)
			then
				if(k.buffTargetType==Tself)
				then
					tmp=DAoCBuffTracker:Create(tmp,"Root",k)
					table.insert(tracker[1],tmp)
				elseif(k.buffTargetType==Tfriendly)
				then
					tmp=DAoCBuffTracker:Create(tmp,"Root",k)
					table.insert(tracker[2],tmp)
				elseif(k.buffTargetType==Thostile)
				then
					tmp=DAoCBuffTracker:Create(tmp,"Root",k)
					table.insert(tracker[3],tmp)
				elseif(k.buffTargetType==100 and tracker[7]==nil)
				then
					tracker[7]={}
					for i=GameData.BuffTargetType.GROUP_MEMBER_START,GameData.BuffTargetType.GROUP_MEMBER_END-1
					do
						k.buffTargetType=i+101
						tracker[7][i+1]=DAoCBuffTracker:Create(tmp..i,"Root",k)
					end
					k.buffTargetType=100
				end
				list[tostring(k.name)]=tmp
			else
				if(k.buffTargetType==Tfriendly)
				then
					if(tracker[5]==nil)
					then
						tracker[5]=DAoCBuffHeadTracker:Create(tmp,"Root",k)
					end
				elseif(k.buffTargetType==Thostile)
				then
					if(tracker[6]==nil)
					then
						tracker[6]=DAoCBuffHeadTracker:Create(tmp,"Root",k)
					end
				end
			end
		end
	end

	for _,k in ipairs(DAoCBuffVar.Frames)
	do
		if(k.active and k.Stickname and list[tostring(k.Stickname)])
		then
			list[tostring(k.name)]:initStick(list[tostring(k.Stickname)])
			table.insert(tracker[4],list[tostring(k.name)])
		end
	end

	if(HaveFriendly==0)
	then
		for _,k in pairs(tracker[2])
		do
			k:ClearAllBuffs()
			k:OnBuffsChanged()
		end
	end
	if(HaveHostile==0)
	then
		for _,k in pairs(tracker[3])
		do
			k:ClearAllBuffs()
			k:OnBuffsChanged()
		end
	end
	for _,k in pairs(tracker[4])
	do
		k:Stick()
	end
end

function DAoCBuff.StopTracker()
	for i,k in pairs(tracker[1])
	do
		k:Shutdown()
		tracker[1][i]=nil
	end
	for i,k in pairs(tracker[2])
	do
		k:Shutdown()
		tracker[2][i]=nil
	end
	for i,k in pairs(tracker[3])
	do
		k:Shutdown()
		tracker[3][i]=nil
	end
	tracker[4]={}
	if(tracker[5]~=nil)
	then
		tracker[5]:Shutdown()
		tracker[5]=nil
	end
	if(tracker[6]~=nil)
	then
		tracker[6]:Shutdown()
		tracker[6]=nil
	end
	if(tracker[7]~=nil)
	then
		for i,k in pairs(tracker[7])
		do
			k:Shutdown()
		end
		tracker[7]=nil
	end
end

function DAoCBuff.Shutdown()
	DAoCBuff.StopTracker()
	UnregisterEventHandler(SystemData.Events.ENTER_WORLD,			 		"DAoCBuff.TargetsCleared")
	UnregisterEventHandler(SystemData.Events.RELEASE_CORPSE,				"DAoCBuff.TargetsCleared")
	UnregisterEventHandler(SystemData.Events.PLAYER_DEATH_CLEARED,			"DAoCBuff.TargetsCleared")
	UnregisterEventHandler(SystemData.Events.INTERFACE_RELOADED,			"DAoCBuff.OnReload")
	UnregisterEventHandler(SystemData.Events.ENTER_WORLD,					"DAoCBuff.OnReload")
	UnregisterEventHandler(SystemData.Events.PLAYER_COMBAT_FLAG_UPDATED,	"DAoCBuff.CombatUpdate")
	UnregisterEventHandler(SystemData.Events.CUSTOM_UI_SCALE_CHANGED,		"DAoCBuff.U")
	UnregisterEventHandler(SystemData.Events.PLAYER_EFFECTS_UPDATED,		"DAoCBuff.OnEvent")
	UnregisterEventHandler(SystemData.Events.PLAYER_TARGET_EFFECTS_UPDATED,	"DAoCBuff.OnEventH")
	UnregisterEventHandler(SystemData.Events.PLAYER_TARGET_UPDATED,			"DAoCBuff.OnEventHC")
	UnregisterEventHandler(SystemData.Events.GROUP_EFFECTS_UPDATED,			"DAoCBuff.OnEventG")
	UnregisterEventHandler(SystemData.Events.GROUP_UPDATED,					"DAoCBuff.OnEventGU")
	LibSlash.UnregisterSlashCmd("daocbuff")
	LibSlash.UnregisterSlashCmd("resetdaocbuff")
end

function DAoCBuff.UpdateWindow(elapsed)
	for _,k in pairs(tracker[1])
	do
		k:Update(elapsed)
	end
	if(HaveFriendly~=0)
	then
		for _,k in pairs(tracker[2])
		do
			k:Update(elapsed)
		end
	end
	if(HaveHostile~=0)
	then
		for _,k in pairs(tracker[3])
		do
			k:Update(elapsed)
		end
	end
	for _,k in pairs(tracker[4])
	do
		k:Stick()
	end
	if(tracker[5]~=nil)then tracker[5]:Update(elapsed) end
	if(tracker[6]~=nil)then tracker[6]:Update(elapsed) end
	if(tracker[7]~=nil)
	then
		for i,k in ipairs(tracker[7])
		do
			k:Update(elapsed)
		end
	end
end

function DAoCBuff.OnReload()
	for _,k in pairs(tracker[1])
	do
		k:Refresh()
	end
	if(HaveFriendly~=0)
	then
		for _,k in pairs(tracker[2])
		do
			k:Refresh(HaveFriendly)
		end
		if(tracker[5]~=nil)then tracker[5]:Refresh(HaveFriendly) end
	end
	if(HaveHostile~=0)
	then
		for _,k in pairs(tracker[3])
		do
			k:Refresh(HaveHostile)
		end
		if(tracker[6]~=nil)then tracker[6]:Refresh(HaveHostile) end
	end
end

function DAoCBuff.OnEvent(BuffTable,isFullList)
	for _,k in pairs(tracker[1])
	do
		k:UpdateBuffs(BuffTable,isFullList)
	end
end

function DAoCBuff.OnEventH(ttype,BuffTable,isFullList)
	if(HaveFriendly~=0 and ttype==Tfriendly)
	then
		for _,k in pairs(tracker[2])
		do
			k:UpdateBuffs(BuffTable,isFullList,HaveFriendly)
		end
		if(tracker[5]~=nil)then tracker[5]:UpdateBuffs(BuffTable,isFullList,HaveFriendly) end
	end

	if(HaveHostile~=0 and ttype==Thostile)
	then
		for _,k in pairs(tracker[3])
		do
			k:UpdateBuffs(BuffTable,isFullList,HaveHostile)
		end
		if(tracker[6]~=nil)then tracker[6]:UpdateBuffs(BuffTable,isFullList,HaveHostile) end
	end
end

function DAoCBuff.OnEventHC(targetClassification,targetId,targetType)
	if(targetClassification=="selffriendlytarget")
	then
		if(targetId~=0 or targetType~=0)
		then
			HaveFriendly=targetId
			for _,k in pairs(tracker[2])
			do
				k:Refresh(HaveFriendly)
			end
			if(tracker[5]~=nil)then tracker[5]:Refresh(0) end
		else
			HaveFriendly=0
			for _,k in pairs(tracker[2])
			do
				k:ClearAllBuffs()
				k:OnBuffsChanged()
			end
		end
	end

	if(targetClassification=="selfhostiletarget")
	then
		if(targetId~=0 or targetType~=0)
		then
			HaveHostile=targetId
			for _,k in pairs(tracker[3])
			do
				k:Refresh(HaveHostile)
			end
			if(tracker[6]~=nil)then tracker[6]:Refresh(0) end
		else
			HaveHostile=0
			for _,k in pairs(tracker[3])
			do
				k:ClearAllBuffs()
				k:OnBuffsChanged()
			end
		end
	end
end

function DAoCBuff.OnEventG(ttype,BuffTable,isFullList)
	if(tracker[7]~=nil)
	then
		tracker[7][ttype+1]:UpdateBuffs(BuffTable,isFullList)
	end
end

function DAoCBuff.OnEventGU()
	if(tracker[7]~=nil)
	then
		for i,k in ipairs(tracker[7])
		do
			k:Refresh()
		end
	end
end

function DAoCBuff.TargetsCleared()
	HaveFriendly=0
	HaveHostile=0
	for _,k in pairs(tracker[2])
	do
		k:ClearAllBuffs()
		k:OnBuffsChanged()
	end
	for _,k in pairs(tracker[3])
	do
		k:ClearAllBuffs()
		k:OnBuffsChanged()
	end
	if(tracker[5]~=nil)then tracker[5]:ClearAllBuffs() end
	if(tracker[6]~=nil)then tracker[6]:ClearAllBuffs() end
end

function DAoCBuff.LEH(LECode)
	if(LECode==LayoutEditor.EDITING_BEGIN)
	then
		DAoCBuff.LES=true
	end
	if(LECode==LayoutEditor.EDITING_END)
	then
		DAoCBuff.LES=false
		for _,k in pairs(tracker[1])
		do
			k:UpdateScale()
		end
		for _,k in pairs(tracker[2])
		do
			k:UpdateScale()
		end
		for _,k in pairs(tracker[3])
		do
			k:UpdateScale()
		end
		if(tracker[5]~=nil)then tracker[5]:UpdateScale() end
		if(tracker[6]~=nil)then tracker[6]:UpdateScale() end
		if(tracker[7]~=nil)
		then
			for _,k in pairs(tracker[7])
			do
				k:UpdateScale()
			end
		end
	end
end

function DAoCBuff.CombatUpdate(param)
	if(param==nil)
	then
		DAoCBuff.OnReload()
	end
end


function DAoCBuff.Testmode(start)
	if(start)
	then
		for _,k in pairs(tracker[1])
		do
			k:BeginTestMode()
		end
		for _,k in pairs(tracker[2])
		do
			k:BeginTestMode()
		end
		for _,k in pairs(tracker[3])
		do
			k:BeginTestMode()
		end
	else
		for _,k in pairs(tracker[1])
		do
			k:EndTestMode()
		end
		for _,k in pairs(tracker[2])
		do
			k:EndTestMode()
		end
		for _,k in pairs(tracker[3])
		do
			k:EndTestMode()
		end
	end
end

function DAoCBuff.HandleSlash(input)
	local opt, val = input:match("([a-z0-9]+)[ ]?(.*)")

	if not(opt)then
		if(DAoCBuffSettings) then
			DAoCBuffSettings.OpenOptionswindow()
		else
			TextLogAddEntry("Chat", 0, L"An error occurred while creating the settingswindow")
		end
	end
end

function DAoCBuff.SetSize(targetWnd, sourceWnd)
	WindowSetScale(targetWnd, WindowGetScale(sourceWnd))
end

function DAoCBuff.LoadPresets()
	DAoCBuffVar =
	{
		version			= 1.01,
		killbuffs		=false,
		Frames			= {},
		Tables			= 
		{
			[GameData.BuffTargetType.SELF]  = {},
			[GameData.BuffTargetType.TARGET_FRIENDLY] = {},
			[GameData.BuffTargetType.TARGET_HOSTILE] = {},
		},
	}
	DAoCBuffVar.Frames[1]=
	{
		name			=L"Self_All",
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

	DAoCBuffVar.Frames[2]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[1])
	DAoCBuffVar.Frames[2].name=L"Self_Buffs"
	DAoCBuffVar.Frames[2].divide=1
	DAoCBuffVar.Frames[3]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[1])
	DAoCBuffVar.Frames[3].name=L"Self_Debuffs"
	DAoCBuffVar.Frames[3].divide=2

	DAoCBuffVar.Frames[4]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[1])
	DAoCBuffVar.Frames[4].name=L"Friendly_All"
	DAoCBuffVar.Frames[4].buffTargetType=GameData.BuffTargetType.TARGET_FRIENDLY
	DAoCBuffVar.Frames[5]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[4])
	DAoCBuffVar.Frames[5].name=L"Friendly_Buffs"
	DAoCBuffVar.Frames[5].divide=1
	DAoCBuffVar.Frames[6]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[4])
	DAoCBuffVar.Frames[6].name=L"Friendly_Debuffs"
	DAoCBuffVar.Frames[6].divide=2

	DAoCBuffVar.Frames[7]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[1])
	DAoCBuffVar.Frames[7].name=L"Hostile_All"
	DAoCBuffVar.Frames[7].buffTargetType=GameData.BuffTargetType.TARGET_HOSTILE
	DAoCBuffVar.Frames[8]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[7])
	DAoCBuffVar.Frames[8].name=L"Hostile_Buffs"
	DAoCBuffVar.Frames[8].divide=1
	DAoCBuffVar.Frames[9]=DAoCBuff.CopyTable(DAoCBuffVar.Frames[7])
	DAoCBuffVar.Frames[9].name=L"Hostile_Debuffs"
	DAoCBuffVar.Frames[9].divide=2

	DAoCBuffVar.Frames[1].active=true
end


-------------------------------------------------------
-------------------------------------------------------
-- VERSIONHANDLER
-------------------------------------------------------
-------------------------------------------------------
function DAoCBuff.VersionHandler()
	if(DAoCBuffVar.version <= 0.99)
	then
		if(DAoCBuffVar.version <= 0.96)
		then
			DAoCBuff.LoadPresets()
		else
			local oldSV=DAoCBuffVar
			DAoCBuff.LoadPresets()
			DAoCBuffVar.version 			= 1.00

			for i,k in ipairs(DAoCBuffVar.Frames)
			do
				k.active=false
				k.font=oldSV.font
			end

			DAoCBuff.MergeTables(DAoCBuffVar.Frames[1],oldSV.optBuffs,true)
			DAoCBuffVar.Frames[1].divide=0
			DAoCBuff.MergeTables(DAoCBuffVar.Frames[2],oldSV.optBuffs,true)
			DAoCBuffVar.Frames[2].divide=1
			DAoCBuff.MergeTables(DAoCBuffVar.Frames[3],oldSV.optDebuffs,true)
			if(oldSV.splitdebuffs==0)
			then
				DAoCBuffVar.Frames[1].active=true
			else
				DAoCBuffVar.Frames[2].active=true
				DAoCBuffVar.Frames[3].active=true
				if(oldSV.debuffstick==1)
				then
					DAoCBuffVar.Frames[3].Stickname=DAoCBuffVar.Frames[2].name
				end
			end

			if(oldSV.optFriendly.divide==0)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[4],oldSV.optFriendly,true)
				if(oldSV.showfriendly~=0)
				then
					DAoCBuffVar.Frames[4].active=true
				end
			elseif(oldSV.optFriendly.divide==1)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[5],oldSV.optFriendly,true)
				if(oldSV.showfriendly~=0)
				then
					DAoCBuffVar.Frames[5].active=true
				end
			elseif(oldSV.optFriendly.divide==2)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[6],oldSV.optFriendly,true)
				if(oldSV.showfriendly~=0)
				then
					DAoCBuffVar.Frames[6].active=true
				end
			end

			if(oldSV.optDebuffs.divide==0)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[7],oldSV.optDebuffs,true)
				if(oldSV.showhostile~=0)
				then
					DAoCBuffVar.Frames[7].active=true
				end
			elseif(oldSV.optDebuffs.divide==1)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[8],oldSV.optDebuffs,true)
				if(oldSV.showhostile~=0)
				then
					DAoCBuffVar.Frames[8].active=true
				end
			elseif(oldSV.optDebuffs.divide==2)
			then
				DAoCBuff.MergeTables(DAoCBuffVar.Frames[9],oldSV.optDebuffs,true)
				if(oldSV.showhostile~=0)
				then
					DAoCBuffVar.Frames[9].active=true
				end
			end
			if(oldSV.killbuffs==1)
			then
				DAoCBuffVar.killbuffs=true
			else
				DAoCBuffVar.killbuffs=false
			end
		end
	end
	if(DAoCBuffVar.version < 1.003)
	then
		DAoCBuffVar.version 			= 1.003
		for i,k in pairs(DAoCBuffVar.Frames)
		do
			k.Stickname=nil
		end
	end
	if(DAoCBuffVar.version < 1.008)
	then
		DAoCBuffVar.version 			= 1.008
		for _,f in pairs(DAoCBuffVar.Frames)
		do
			for i,k in ipairs(f.filters)
			do
				for j,l in ipairs(k.conditions)
				do
					if(l[1]==2 and l[3]=="Unstoppable")
					then
						local condition={}
						k.conditions[j]=condition
						condition[1]=1
						condition[2]="trackerPriority"
						condition[3]=100
					end
				end
			end
		end
		DAoCBuffVar.Tables.Unstoppable=nil
	end
	if(DAoCBuffVar.version < 1.01)
	then
		DAoCBuff.ShowMessageWindow()
	end
	DAoCBuff.Update.All(DAoCBuffVar,DAoCBuffVar.version)
end

DAoCBuff.Update={}
function DAoCBuff.Update.All(item,version)
	for i,k in pairs(item.Tables)
	do
		DAoCBuff.Update.List(k,version)
	end
	for i,k in ipairs(item.Frames)
	do
		DAoCBuff.Update.Frame(k,version)
	end
	local newversion=1.0191
	if(version<newversion)
	then
		item.version=newversion
		EA_ChatWindow.Print(L"Updated DAoCBuff to Version 1.01.91 !")
	end
end

function DAoCBuff.Update.List(item,version)
	if(version<1.01)
	then
		for i,k in pairs(item)
		do
			k.abilityId=i
		end
	end
end

function DAoCBuff.Update.Frame(item,version)
	for i,k in ipairs(item.filters)
	do
		DAoCBuff.Update.Filter(k,version)
	end
	if(version<1.01)
	then
		item.type=1
		item.hpte=false
	end
end

function DAoCBuff.Update.Filter(item,version)
	for i,k in pairs(item.conditions)
	do
		DAoCBuff.Update.Condition(k,version)
	end
	if(version<1.01)
	then
		item.cache=nil
	end
end

function DAoCBuff.Update.Condition(item,version)
	if(version<1.05)
	then
		if(item[1]==1 and item[2]=="trackerPriority")
		then
			if(item[3])
			then
				item[3]=100
			else
				item[3]=0
			end
		end
	end
end

function DAoCBuff.ShowMessageWindow()
	CreateWindow("DAoCBuffMessageWindow", false)

	LabelSetText("DAoCBuffMessageWindowTitle", L"DAoCBuff Update Information")
	ButtonSetText("DAoCBuffMessageWindowScrollWindowScrollChildOpenOptions", L"Open Optionswindow")

	LabelSetText("DAoCBuffMessageWindowScrollWindowScrollChildTitleLabel", L"DAoCBuff Version 1.01")
	LabelSetText("DAoCBuffMessageWindowScrollWindowScrollChildTitleLabel1",L"Changelog:\n")
	LabelSetText("DAoCBuffMessageWindowScrollWindowScrollChildLabel1",L"* Performance increase\n* more consistent display of Effects\n* added support for Group as target\n* added Headframe support\n* added option for highprecision timer display\n* restructured Filtersettings window\n* Filter can now change the Border and Icon color\n* settings can now be exported and imported\n* Effect Lists for Filter can now be manually edited")

	ScrollWindowUpdateScrollRect("DAoCBuffMessageWindowScrollWindow")

	WindowSetShowing("DAoCBuffMessageWindow", true)
end

function DAoCBuff.CloseMessageWindow()
	WindowSetShowing("DAoCBuffMessageWindow",false)
	DestroyWindow("DAoCBuffMessageWindow")
end

function DAoCBuff.ResetDAoCBuff(input)
	DAoCBuff.LoadPresets()
	EA_ChatWindow.Print(L"All settings of DAoCBuff have been reseted !")
	DAoCBuff.U()
	DAoCBuffSettings.OpenOptionswindow()
end
