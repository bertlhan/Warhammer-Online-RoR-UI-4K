--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################


local BUFF_FADE_START			=5	-- The time remaining on a buff at which the buff begins to fade out
local BUFF_TOOLTIP_UPDATE_ALL	=true	-- update all fields in the buff tooltip
local BUFF_TOOLTIP_UPDATE_TIME	=false -- only update the time field in the buff tooltip
local g_currentMouseOverBuff	=nil	-- Used to update the current buff tooltip...
local FONTS = { "font_clear_small_bold", "font_clear_medium", "font_clear_large", "font_clear_large_bold"}
local BUFFS_PER_ROW = { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
local pairs=pairs
local ipairs=ipairs
local LabelSetText=LabelSetText
local WindowStartAlphaAnimation=WindowStartAlphaAnimation
local WindowStopAlphaAnimation=WindowStopAlphaAnimation
local DynamicImageSetTexture=DynamicImageSetTexture
local WindowSetAlpha=WindowSetAlpha
local WindowAddAnchor=WindowAddAnchor
local WindowClearAnchors=WindowClearAnchors
local WindowSetTintColor=WindowSetTintColor
local WindowSetShowing=WindowSetShowing
local GetBuffs=GetBuffs
local GetIconData=GetIconData
local ti=table.insert
local mf=math.floor
local GetTime=DAoCBuff.GetTime
local wf=wstring.format
local s=GetStringFormat(StringTables.Default.LABEL_X_S,{L"%0.1f"})
local loop=Window.AnimationType.LOOP
local Thostile=GameData.BuffTargetType.TARGET_HOSTILE

local function IsValidBuff(buffData)
	return(buffData~=nil and buffData.effectIndex~=nil and buffData.iconNum~=nil)
end

DAoCBuffFrame = Frame:Subclass("DAoCBuffContainer")

function DAoCBuffFrame:Create(windowName,parentWindow,buffSlot,tracker)
	local name=windowName..buffSlot
	local buffFrame = self:CreateFromTemplate(name, parentWindow)
	local timelabel=name.."Time"

	if(buffFrame ~= nil)
	then
		buffFrame.m_buffSlot			=buffSlot
		buffFrame.m_buffTargetType		=tracker.m_targetType
		buffFrame.m_IsFading			=false
		buffFrame.m_name				=name
		buffFrame.m_parentname			=windowName
		buffFrame.m_longtoperma			=tracker.longtoperma
		buffFrame.hpte					=tracker.hpte
		buffFrame.time					=timelabel
		buffFrame.icon					=name.."Icon"
		buffFrame.frame					=name.."Frame"
		WindowSetFontAlpha(windowName,1.0)
		LabelSetFont(timelabel,tracker.m_font,10)
		WindowSetShowing(buffFrame.frame,tracker.showborder==true)
		WindowSetShowing(name.."Glass",tracker.glass==true)
		if(tracker.m_buffsbelow==1)
		then
			WindowClearAnchors(timelabel)
			WindowAddAnchor(timelabel,"bottom",name,"top",0,0)
		end

		buffFrame:SetScale()
	end
	return buffFrame
end

function DAoCBuffFrame:SetScale()
	if(WindowGetScale(self.m_parentname) ~= WindowGetScale(self.m_name))then
		WindowSetScale(self.m_name, WindowGetScale(self.m_parentname))
	end
end

function DAoCBuffFrame:UpdateI0()
end

function DAoCBuffFrame:UpdateI1()
	local buffData=self.m_buffData
	local sc=buffData.stackCount
	if(sc~=buffData.lastU)
	then
		LabelSetText(self.time,L"x"..sc)
		buffData.lastU=sc
	end
end

function DAoCBuffFrame:UpdateI2()
	local ret
	local buffData=self.m_buffData
	local duration=buffData.duration
	if(duration>0)
	then
		local fd=mf(duration)
		if(fd~=buffData.lastU)
		then
			LabelSetText(self.time,GetTime(duration))
			if(duration < BUFF_FADE_START)
			then
				self:StartFading()
			end
			if(self.hpte and duration<3.1)
			then
				ret=true
				self.UpdateI=self.UpdateI0
				self.duration=duration
			end
			buffData.lastU=fd
		end
	else
		self.UpdateI=self.UpdateI0
		self:StopFading()
		self:Show(false)
	end
	return ret
end

function DAoCBuffFrame:UpdateI_hpte(elapsed)
	local duration=self.duration-elapsed
	if(duration>0)
	then
		if(duration>2.1)
		then
			LabelSetText(self.time,GetTime(duration))
		else
			LabelSetText(self.time,wf(s,(duration*10)/10))
		end
		self.duration=duration
		return true
	else
		self.UpdateI=self.UpdateI0
		self:StopFading()
		self:Show(false)
		return false
	end
end

function DAoCBuffFrame:StopFading()
	if(self.m_IsFading == true)
	then
		WindowStopAlphaAnimation(self.icon)
		WindowStopAlphaAnimation(self.frame)
		self.m_IsFading = false
	end
end

function DAoCBuffFrame:StartFading()
	if(self.m_IsFading == false)
	then
		WindowStartAlphaAnimation(self.icon,loop,1,0.5,1,true,0,0)
		WindowStartAlphaAnimation(self.frame,loop,1,0.5,1,true,0,0)
		self.m_IsFading = true
	end
end

function DAoCBuffFrame:SetBuff(buffData)
	local old=self.m_buffData
	self.m_buffData=buffData
	local ret=false
	local isValidBuff=(buffData~=nil and (buffData.duration>0 or buffData.permanentUntilDispelled))

	if(isValidBuff)
	then
		local iconNum=buffData.iconNum
		if(type(iconNum)=="number")
		then
			if(iconNum>0)
			then
				local texture,x,y=GetIconData(iconNum)
				DynamicImageSetTexture(self.icon,texture,x,y)
			else
				DynamicImageSetTexture(self.icon,"DAoC_new_qm",0,0)
			end
		else
			DynamicImageSetTexture(self.icon,iconNum,0,0)
		end
		local c=buffData.borderC
		WindowSetTintColor(self.frame,c[1],c[2],c[3])
		c=buffData.iconC
		if(c~=nil)
		then
			WindowSetTintColor(self.icon,c[1],c[2],c[3])
		else
			if(old~=nil and old.iconC~=nil)
			then
				WindowSetTintColor(self.icon,255,255,255)
			end
		end

		local timew=self.time
		if(buffData.stackCount > 1 or buffData.iscondensed)
		then
			LabelSetText(timew,L"x"..buffData.stackCount)
			WindowSetShowing(timew,true)
			if(buffData.iscondensed)
			then
				self.UpdateI=self.UpdateI1
			else
				self.UpdateI=self.UpdateI0
			end
		elseif(buffData.duration>0 and (not buffData.permanentUntilDispelled))
		then
			local duration=buffData.duration
			if(self.m_longtoperma and duration>300)
			then
				WindowSetShowing(timew,false)
				self.UpdateI=self.UpdateI0
			else
				buffData.lastU=mf(duration)
				LabelSetText(timew,GetTime(duration))
				WindowSetShowing(timew,true)
				if(self.hpte and duration<3.1)
				then
					ret=true
					self.UpdateI=self.UpdateI0
					self.duration=duration
				else
					self.UpdateI=self.UpdateI2
				end
			end
		else
			WindowSetShowing(timew,false)
			self.UpdateI=self.UpdateI0
		end

		if((buffData.duration < BUFF_FADE_START) and(not buffData.permanentUntilDispelled))
		then
			self:StartFading()
		else
			self:StopFading()
		end
	else
		if(old~=nil and old.iconC~=nil)
		then
			WindowSetTintColor(self.icon,255,255,255)
		end
		self.UpdateI=self.UpdateI0
	end

	self:Show(isValidBuff)
	return ret
end

function DAoCBuffFrame.OnMouseOver()
	local buffFrame = FrameManager:GetMouseOverWindow()

	if(buffFrame == nil or buffFrame.m_buffData == nil)
	then
		return
	end

	local buffData = buffFrame.m_buffData

	if(buffData ~= nil)
	then
		local tooltip_anchor = { Point = "bottom",	RelativeTo = SystemData.ActiveWindow.name, RelativePoint = "top",	XOffset = 0, YOffset = 40 }
		g_currentMouseOverBuff = buffFrame

		if (not buffData.iscondensed) then
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, nil)
			Tooltips.SetTooltipColorDef(1, 1, Tooltips.COLOR_HEADING)
			Tooltips.SetTooltipColorDef(1, 2, Tooltips.COLOR_HEADING)
			Tooltips.SetTooltipActionText(GetString(StringTables.Default.TEXT_R_CLICK_TO_REMOVE_EFFECT))

			DAoCBuffFrame.PopulateTooltipFields(buffData, BUFF_TOOLTIP_UPDATE_ALL)
			Tooltips.AnchorTooltip(tooltip_anchor)
		else
			DAoCTooltips.CreateCondenseTooltip(buffData.name, L"", buffData.entries, buffData.stackCount, SystemData.ActiveWindow.name, tooltip_anchor)
		end

		Tooltips.SetUpdateCallback(DAoCBuffFrame.MouseOverUpdate)
	end
end

function DAoCBuffFrame.OnMouseOverEnd()
	g_currentMouseOverBuff = nil
end

function DAoCBuffFrame.OnRButtonUp()
	local buffFrame = FrameManager:GetActiveWindow()
	if(buffFrame ~= nil and buffFrame.m_buffData ~= nil and buffFrame.m_buffTargetType == GameData.BuffTargetType.SELF)
	then
		RemoveEffect(buffFrame.m_buffData.effectIndex)
	end
end

function DAoCBuffFrame.OnLButtonUp()
	local buffFrame = FrameManager:GetActiveWindow()

	if(buffFrame~=nil and buffFrame.m_buffData~=nil and buffFrame.m_buffData.iscondensed~=true)
	then
		if(DAoCBuffVar.Tables~=nil and DAoCBuffVar.Tables[buffFrame.m_buffTargetType]~=nil)
		then
			local item={}
			local data=buffFrame.m_buffData.effect
			DAoCBuffVar.Tables[buffFrame.m_buffTargetType][data.abilityId]=item
			item.name=data.name
			item.effectText=data.effectText
			item.iconNum=data.iconNum
		end
	end 
end

function DAoCBuffFrame.PopulateTooltipFields(buffData, updateType)
	local durationText = GetTime(buffData.duration)

	if(updateType == BUFF_TOOLTIP_UPDATE_ALL)
	then
		Tooltips.SetTooltipText(1, 1, buffData.name)
		Tooltips.SetTooltipText(3, 1, buffData.effect.effectText)

		-- buffData is not an abilityData, but the fields required by this function should be present...
		Tooltips.SetTooltipText(1, 2, DataUtils.GetAbilityTypeText(buffData.effect))
	end

	if(buffData.duration > 1)
	then
		Tooltips.SetTooltipText(2, 1, durationText)
	else
		Tooltips.SetTooltipText(2, 1, L"")
	end

	Tooltips.Finalize()
end

function DAoCBuffFrame.MouseOverUpdate(elapsedTime)
	if(g_currentMouseOverBuff == nil or g_currentMouseOverBuff.m_buffData == nil)
	then
		return
	end

	if (not g_currentMouseOverBuff.m_buffData.iscondensed) then
		if (WindowGetShowing("DAoCBuffCondenseTooltip")) then
			WindowSetShowing("DAoCBuffCondenseTooltip", false)
		end
		DAoCBuffFrame.PopulateTooltipFields(g_currentMouseOverBuff.m_buffData, BUFF_TOOLTIP_UPDATE_TIME)
	else
		DAoCTooltips.UpdateCondenseTooltip(g_currentMouseOverBuff.m_buffData.entries, g_currentMouseOverBuff.m_buffData.stackCount, elapsedTime)
	end
end

DAoCBuffTracker=Frame:Subclass("DAoCBuffTemplate")
function DAoCBuffTracker:Create(windowName,parentName,options)
	local newTracker=self:CreateFromTemplate(windowName,parentName)

	newTracker.m_buffData		={}
	newTracker.m_targetType		=options.buffTargetType
	newTracker.m_maxBuffs		=options.maxBuffCount
	newTracker.m_buffFrames		={}
	newTracker.delay			={}
	newTracker.m_windowName		=windowName
	newTracker.m_buffRowStride	=BUFFS_PER_ROW[options.buffRowStride]
	newTracker.m_font			=FONTS[options.font]
	newTracker.m_fontnum		=options.font
	newTracker.m_divide			=options.divide
	newTracker.m_ismine			=options.ismine
	newTracker.m_actualRows		=0
	newTracker.m_horizontal		=options.horizontal
	newTracker.m_growleft		=options.growleft
	newTracker.m_growup			=options.growup
	newTracker.m_buffsbelow		=options.buffsbelow
	newTracker.m_testmode		=false
	newTracker.m_C_elapsedTime	=0
	newTracker.m_C_elapsedTimeR	=0
	newTracker.m_update			=options.update
	newTracker.isslowmode1		=false
	newTracker.isslowmode2		=false
	newTracker.shouldupdate		=true
	newTracker.maxDataC			=0
	newTracker.x				=0
	newTracker.Condense			={}
	newTracker.FA				=options.FA
	newTracker._bw				=options
	newTracker.staticcondense	=options.staticcondense
	newTracker.longtimehide		=options.longtimehide
	newTracker.longtoperma		=options.longtoperma
	newTracker.showborder		=options.showborder
	newTracker.glass			=options.glass
	newTracker.hpte				=options.hpte

	newTracker.SortKeys=
	{
		["iscondensed"]					= { fallback = "permanentUntilDispelled" , sortOrder = DataUtils.SORT_ORDER_DOWN},
		["permanentUntilDispelled"]		= { fallback = "duration" , sortOrder = DataUtils.SORT_ORDER_DOWN},
		["duration"] 					= { fallback = "name" , sortOrder = DataUtils.SORT_ORDER_DOWN},
		["name"]						= { sortOrder = DataUtils.SORT_ORDER_UP},
	}
	if(options.bufforder==1)
	then
		newTracker.SortKeys["duration"].sortOrder=DataUtils.SORT_ORDER_DOWN
	else
		newTracker.SortKeys["duration"].sortOrder=DataUtils.SORT_ORDER_UP
	end
	if(options.permabuffs==1)
	then
		newTracker.SortKeys["permanentUntilDispelled"].sortOrder=DataUtils.SORT_ORDER_DOWN
		newTracker.SortKeys["iscondensed"].sortOrder=DataUtils.SORT_ORDER_DOWN
	else
		newTracker.SortKeys["permanentUntilDispelled"].sortOrder=DataUtils.SORT_ORDER_UP
		newTracker.SortKeys["iscondensed"].sortOrder=DataUtils.SORT_ORDER_UP
	end

	if(newTracker.m_targetType>100)
	then
		newTracker.m_targetType=newTracker.m_targetType-101
	end

	WindowClearAnchors(windowName)
	if(options.anchor~=nil)
	then
		if(options.anchor[options.buffTargetType-100]~=nil)
		then
			local anc=options.anchor[options.buffTargetType-100]
			WindowAddAnchor(windowName,"topleft",parentName,"topleft",anc.x,anc.y)
			if(anc.scale~=nil)
			then
				WindowSetScale(windowName,anc.scale)
			end
		else
			WindowAddAnchor(windowName,"topleft",parentName,"topleft",options.anchor.x,options.anchor.y)
			if(options.anchor.scale~=nil)
			then
				WindowSetScale(windowName,options.anchor.scale)
			end
		end
	else
		WindowAddAnchor(windowName,"center","Root","center",0,-400)
	end

	LayoutEditor.RegisterWindow(windowName,towstring(windowName),L"Alternative Buffwindow.",false,false,true,nil)

	local YOffset=0
	if(options.buffsbelow == 1)then
		if(newTracker.m_fontnum==1)then YOffset=40
		elseif(newTracker.m_fontnum==2)then YOffset=44
		elseif(newTracker.m_fontnum==3)then YOffset=50
		elseif(newTracker.m_fontnum==4)then YOffset=50
		end
	end

	local currentAnchor = 
	{
			Point			="topleft",
			RelativePoint	="topleft",
			RelativeTo		=windowName,
			XOffset			=0,
			YOffset			=0,
	}
	if(options.growleft~=1)
	then
		currentAnchor.Point="topright"
		currentAnchor.RelativePoint="topright"
	end

	for buffSlot = 1, options.maxBuffCount
	do
		local buffFrame=DAoCBuffFrame:Create(windowName,parentName,buffSlot,newTracker)
		if(buffFrame ~= nil)
		then
			newTracker.m_buffFrames[buffSlot]=buffFrame
			buffFrame:SetAnchor(currentAnchor)
			local nextSlot=buffSlot + 1
			local remainder=math.fmod(nextSlot,newTracker.m_buffRowStride)
			if(remainder==1)
			then
				if(options.horizontal==1)
				then
					if(options.growleft==1)
					then
						currentAnchor.Point				="right"
						currentAnchor.RelativePoint		="left"
						currentAnchor.YOffset			=0
					else
						currentAnchor.Point				="left"
						currentAnchor.RelativePoint		="right"
						currentAnchor.YOffset			=0
					end
				else
					if(options.growup==1)
					then
						currentAnchor.Point				="bottomleft"
						currentAnchor.RelativePoint		="topleft"
						currentAnchor.YOffset			=YOffset
					else
						currentAnchor.Point				="topleft"
						currentAnchor.RelativePoint		="bottomleft"
						currentAnchor.YOffset			=0-YOffset
					end
				end
				currentAnchor.RelativeTo				=windowName..(nextSlot - newTracker.m_buffRowStride)
			else
				if(options.horizontal==1)
				then
					if(options.growup==1)
					then
						currentAnchor.Point				="bottomleft"
						currentAnchor.RelativePoint		="topleft"
						currentAnchor.YOffset			=YOffset
					else
						currentAnchor.Point				="topleft"
						currentAnchor.RelativePoint		="bottomleft"
						currentAnchor.YOffset			=0-YOffset
					end
				else
					if(options.growleft==1)
					then
						currentAnchor.Point				="right"
						currentAnchor.RelativePoint		="left"
						currentAnchor.YOffset			=0
					else
						currentAnchor.Point				="left"
						currentAnchor.RelativePoint		="right"
						currentAnchor.YOffset			=0
					end
				end
				currentAnchor.RelativeTo				=windowName..buffSlot
			end
			currentAnchor.XOffset						=0
		end
	end
	newTracker.shouldrestick=true

	if(newTracker.hpte)
	then
		newTracker.hpf={}
	end
	if(newTracker.FA)
	then
		newTracker:InitA(options.filters)
	end
	newTracker:Refresh()

	return newTracker
end

function DAoCBuffTracker:InitA(filters)
	self.CondenseGlobal={}
	self.funcA={}
	for _,k in ipairs(filters)
	do
		DAoCBuff.CreateFilter(self,k)
	end
end

function DAoCBuffTracker:initStick(StickMe)
	if(StickMe~=nil)
	then
		self.m_Sname=StickMe.m_windowName
		self.m_StickMe=StickMe
	end
end

function DAoCBuffTracker:Stick()
	if(self.m_StickMe~=nil)
	then
		if(self.m_StickMe.shouldrestick)
		then
			local rows=(self.m_StickMe.m_actualRows-1)
			local pos=rows*self.m_StickMe.m_buffRowStride+1
			if(pos<1)then pos=1 end
			WindowClearAnchors(self.m_windowName)
			self.m_StickMe.shouldrestick=false

			if(self.m_StickMe.m_horizontal==1)
			then
				if(self.m_StickMe.m_growleft==1)
				then
					if(self.m_StickMe.m_growup~=1)
					then
						WindowAddAnchor(self.m_windowName,"topright",self.m_Sname..pos,"topleft",0,0)
					else
						WindowAddAnchor(self.m_windowName,"bottomright",self.m_Sname..pos,"bottomleft",0,0)
					end
				else
					if(self.m_StickMe.m_growup~=1)
					then
						WindowAddAnchor(self.m_windowName,"topleft",self.m_Sname..pos,"topright",0,0)
					else
						WindowAddAnchor(self.m_windowName,"bottomleft",self.m_Sname..pos,"bottomright",0,0)
					end
				end
			else
				local YOffset=0
				if(self.m_StickMe.m_growup~=1)
				then
					if(self.m_buffsbelow == 1)then
						if(self.m_fontnum==1)then YOffset=40
						elseif(self.m_fontnum==2)then YOffset=44
						elseif(self.m_fontnum==3)then YOffset=50
						elseif(self.m_fontnum==4)then YOffset=50
						end
					end
					if(self.m_StickMe.m_growleft==1)
					then
						WindowAddAnchor(self.m_windowName,"topleft",self.m_Sname..pos,"bottomleft",0,YOffset)
					else
						WindowAddAnchor(self.m_windowName,"topright",self.m_Sname..pos,"bottomright",0,YOffset)
					end
				else
					if(self.m_StickMe.m_buffsbelow == 1)then
						if(self.m_StickMe.m_fontnum==1)then YOffset=40
						elseif(self.m_StickMe.m_fontnum==2)then YOffset=44
						elseif(self.m_StickMe.m_fontnum==3)then YOffset=50
						elseif(self.m_StickMe.m_fontnum==4)then YOffset=50
						end
					end
					if(self.m_StickMe.m_growleft==1)
					then
						WindowAddAnchor(self.m_windowName,"bottomleft",self.m_Sname..pos,"topleft",0,YOffset)
					else
						WindowAddAnchor(self.m_windowName,"bottomright",self.m_Sname..pos,"topright",0,YOffset)
					end
				end
			end
		end
	end
end

function DAoCBuffTracker:BeginTestMode()
	self.m_testmode=true

	local abilityData=GetAbilityTable(GameData.AbilityType.STANDARD)
	local pool={}

	for i,k in pairs(abilityData)
	do
		k.duration=1380
		k.stackCount=1
		k.effectText=L"There is never enough time, unless you're serving it."
		k.effectIndex=0
		ti(pool,k)
	end

	local tmp={}
	local pmax=#pool
	for buffSlot, buffFrame in ipairs(self.m_buffFrames)
	do
		buffFrame:SetBuff(DAoCBuff.GetLWEffect(tmp,pool[math.mod(buffSlot,pmax)+1],1,0))
	end

	self.m_actualRows=math.ceil(self.m_maxBuffs/self.m_buffRowStride)
	self.shouldrestick=true
end

function DAoCBuffTracker:EndTestMode()
	self.m_testmode=false
	self:Refresh()
end

function DAoCBuffTracker:Shutdown()
	self:ClearAllBuffs()
	for buffSlot, buffFrame in ipairs(self.m_buffFrames)
	do
		buffFrame:Destroy()
	end
	local x,y=WindowGetOffsetFromParent(self.m_windowName)
	local anchor={["scale"]=WindowGetScale(self.m_windowName)}
	local windowscale = anchor.scale / InterfaceCore.GetScale()
	anchor.x=x * windowscale
	anchor.y=y * windowscale
	LayoutEditor.UnregisterWindow(self.m_windowName)
	if(self.m_targetType<=GameData.BuffTargetType.GROUP_MEMBER_END)
	then
		if(self._bw.anchor==nil)then self._bw.anchor={} end
		self._bw.anchor[self.m_targetType+1]=anchor
	else
		self._bw.anchor=anchor
	end
	self:Destroy()
end

function DAoCBuffTracker:ClearAllBuffs()
	self:ClearBuffData()
	for _,k in ipairs(self.m_buffFrames)
	do
		k:SetBuff(nil)
	end
	self.x=0
	self.isslowmode1=false
	self.isslowmode2=false
end

function DAoCBuffTracker:ClearBuffData()
	self.m_buffData={}
	self.CondenseGlobal={}
	for i,k in ipairs(self.Condense)
	do
		k.stackCount=0
		k.entries={}
	end
	self.delay={}
	self.m_C_elapsedTime=0
end

function DAoCBuffTracker:Filter(BuffTable)
	local add=self.m_buffData
	local del={nil,nil}
	local SetLWEffect,funcs
	local changed=false
	local delay=self.m_C_elapsedTime
	local d=self.delay

	if(self.FA)
	then
		SetLWEffect=DAoCBuff.SetLWEffectA
		funcs=self.funcA
	else
		SetLWEffect=DAoCBuff.SetLWEffect
	end

	if(self.m_divide==0)then
		if(self.m_ismine==1)
		then
			if(self.m_targetType==Thostile)
			then
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			else
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			end
		else
			if(self.m_targetType==Thostile)
			then
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						else
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							elseif	(k.isDebuff)		then changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							elseif	(k.isBuff)			then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isStatsBuff)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isOffensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isDefensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			else
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						else
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							elseif	(k.isDebuff)		then changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							elseif	(k.isBuff)			then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isStatsBuff)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isOffensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isDefensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			end
		end
	end

	if(self.m_divide==1)
	then
		if(self.m_targetType==Thostile)
		then
			if(self.m_ismine~=1)
			then
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(not k.castByPlayer)
						then
							if		(k.isHex)			then
							elseif	(k.isCurse)			then
							elseif	(k.isCripple)		then
							elseif	(k.isAilment)		then
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							elseif	(k.isDebuff)		then
							elseif	(k.isBuff)			then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isStatsBuff)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isOffensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isDefensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			end
		else
			if(self.m_ismine==1)
			then
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			else
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						else
							if		(k.isHex)			then
							elseif	(k.isCurse)			then
							elseif	(k.isCripple)		then
							elseif	(k.isAilment)		then
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							elseif	(k.isDebuff)		then
							elseif	(k.isBuff)			then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isStatsBuff)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isOffensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							elseif	(k.isDefensive)		then changed=SetLWEffect(add,i,d,k,1,3,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			end
		end
	end

	if(self.m_divide==2)
	then
		if(self.m_targetType==Thostile)
		then
			if(self.m_ismine==1)
			then
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			else
				for i,k in pairs(BuffTable) do
					if(IsValidBuff(k))
					then
						if(k.castByPlayer)
						then
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isAugmentation)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isBlessing)		then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isEnchantment)	then changed=SetLWEffect(add,i,d,k,1,5,delay,funcs) or changed
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then changed=SetLWEffect(add,i,d,k,1,2,delay,funcs) or changed
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						else
							if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
							elseif	(k.isBolster)		then
							elseif	(k.isAugmentation)	then
							elseif	(k.isBlessing)		then
							elseif	(k.isEnchantment)	then
							elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
							elseif	(k.isHealing)		then
							elseif	(k.isDebuff)		then changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							elseif	(k.isBuff)			then
							elseif	(k.isStatsBuff)		then
							elseif	(k.isOffensive)		then
							elseif	(k.isDefensive)		then
							else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
							end
						end
					else
						del[#del+1]=i
					end
				end
			end
		else
			for i,k in pairs(BuffTable) do
				if(IsValidBuff(k))
				then
					if(not k.castByPlayer)
					then
						if		(k.isHex)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
						elseif	(k.isCurse)			then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
						elseif	(k.isCripple)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
						elseif	(k.isAilment)		then changed=SetLWEffect(add,i,d,k,0,5,delay,funcs) or changed
						elseif	(k.isBolster)		then
						elseif	(k.isAugmentation)	then
						elseif	(k.isBlessing)		then
						elseif	(k.isEnchantment)	then
						elseif	(k.isDamaging)		then changed=SetLWEffect(add,i,d,k,0,1,delay,funcs) or changed
						elseif	(k.isHealing)		then
						elseif	(k.isDebuff)		then changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
						elseif	(k.isBuff)			then
						elseif	(k.isStatsBuff)		then
						elseif	(k.isOffensive)		then
						elseif	(k.isDefensive)		then
						else changed=SetLWEffect(add,i,d,k,0,4,delay,funcs) or changed
						end
					end
				else
					del[#del+1]=i
				end
			end
		end
	end

	if(changed~=false)
	then
		changed=true
	end
	return changed,del
end

function DAoCBuffTracker:UpdateA(del)
	local changed=false
	local all=self.Condense
	local Global=self.CondenseGlobal

	for _,i in ipairs(del)
	do
		if(Global[i]~=nil)
		then
			Global[i]=nil
			for _,l in ipairs(all)
			do
				if(l.entries[i]~=nil)
				then
					l.entries[i]=nil
					l.stackCount=l.stackCount-1
				end
			end
		end
	end

	if(not self.staticcondense)
	then
		for _,l in ipairs(all)
		do
			if(l.enabled~=(l.stackCount>0))
			then
				changed=true
				l.enabled=not l.enabled
			end
		end
	end

	return changed
end

function DAoCBuffTracker:Update(elapsedTime)
	self.m_C_elapsedTime=self.m_C_elapsedTime+elapsedTime
	local e=self.m_C_elapsedTime

	if(self.hpte)
	then
		for i,k in ipairs(self.hpf)
		do
			if(k:UpdateI_hpte(elapsedTime)~=true)
			then
				table.remove(self.hpf,i)
			end
		end
	end

	if(e<self.m_update)
	then
		return
	end

	if(elapsedTime>0.07)
	then
		self.isslowmode2=true
		if(e<self.m_update*2 and elapsedTime>0.1)
		then
			return
		end
	else
		self.isslowmode2=false
	end

	if(self.x>2)then self.x=1
	else self.x=0 end
	self.m_C_elapsedTimeR=self.m_C_elapsedTimeR+e
	if((self.m_C_elapsedTimeR<20 or self.isslowmode1 or self.isslowmode2) and self.m_C_elapsedTimeR<90)
	then
		local ndelay=#self.delay
		if(ndelay>0)
		then
			local delay=self.delay
			local k
			for i=1,ndelay
			do
				k=delay[i]
				k.duration=k.duration+k.delay
				k.delay=nil
			end
			self.delay={}
		end
		for i,k in pairs(self.m_buffData)
		do
			k.duration=k.duration-e
		end
		for i,k in pairs(self.CondenseGlobal)
		do
			if(not k.marked)
			then
				k.duration=k.duration-e
			end
		end
		self.m_C_elapsedTime=0

		if(self.shouldupdate)
		then
			self:OnBuffsChanged()
		else
			if(DAoCBuff.LES)
			then
				for buffSlot, buffFrame in ipairs(self.m_buffFrames)
				do
					buffFrame:SetScale()
					if(buffFrame:UpdateI()==true)
					then
						ti(self.hpf,buffFrame)
					end
				end
			else
				for buffSlot, buffFrame in ipairs(self.m_buffFrames)
				do
					if(buffFrame:UpdateI()==true)
					then
						ti(self.hpf,buffFrame)
					end
				end
			end
		end
	else
		local BuffTable=GetBuffs(self.m_targetType)

		self:ClearBuffData()
		if(BuffTable~=nil)
		then
			self:Filter(BuffTable)
		end
		self:OnBuffsChanged()
		self.m_C_elapsedTimeR=0
	end
end

function DAoCBuffTracker:UpdateBuffs(updateBuffTable,isFullList)
	if(not updateBuffTable)then return end

	local changed=false
	local del

	if(isFullList)
	then
		self:ClearBuffData()
		changed,del=self:Filter(updateBuffTable)
		self.m_C_elapsedTimeR=0
		changed=true
	else
		changed,del=self:Filter(updateBuffTable)
		if(self.FA)
		then
			changed=self:UpdateA(del) or changed
		end
		if(not changed)
		then
			for _,i in ipairs(del)
			do
				if(self.m_buffData[i]~=nil)
				then
					changed=true
					break
				end
			end
		end
	end

	if(changed==true)
	then
		for _,i in ipairs(del)
		do
			self.m_buffData[i]=nil
		end
		if(self.isslowmode1 or self.isslowmode2)
		then
			self.shouldupdate=true
		else
			self:OnBuffsChanged()
		end
		self:UpdateSlowMode()
	end
end

function DAoCBuffTracker:Refresh()
	local BuffTable=GetBuffs(self.m_targetType)

	self:ClearBuffData()
	if(BuffTable~=nil)
	then
		self:Filter(BuffTable)
	end

	if(self.isslowmode1 or self.isslowmode2)
	then
		self.shouldupdate=true
	else
		self:OnBuffsChanged()
	end
	self:UpdateSlowMode()
	self.m_C_elapsedTimeR=0
end

local insert=DAoCBuff.insert

function DAoCBuffTracker:OnBuffsChanged()
	if(self.m_testmode)then return end

	local sortedData={nil,nil,nil,nil}
	local sortedDataMaxSlot=0

	local sk=self.SortKeys
	local g
	local maxB=self.m_maxBuffs
	if(self.FA)
	then
		g="iscondensed"
		if(GameData.Player.inCombat)
		then
			if(self.staticcondense)
			then
				for i,k in ipairs(self.Condense)
				do
					if(not k.combathide)
					then
						insert(sortedData,k,g,sk,maxB)
					end
				end
			else
				for i,k in ipairs(self.Condense)
				do
					if(k.stackCount>0 and not k.combathide)
					then
						insert(sortedData,k,g,sk,maxB)
					end
				end
			end
		else
			if(self.staticcondense)
			then
				for i,k in ipairs(self.Condense)
				do
					insert(sortedData,k,g,sk,maxB)
				end
			else
				for i,k in ipairs(self.Condense)
				do
					if(k.stackCount>0)
					then
						insert(sortedData,k,g,sk,maxB)
					end
				end
			end
		end
	else
		g="permanentUntilDispelled"
	end

	if(self.longtimehide and GameData.Player.inCombat)
	then
		for _,k in pairs(self.m_buffData)
		do
			if(not(k.duration>300 or k.permanentUntilDispelled))
			then
				insert(sortedData,k,g,sk,maxB)
			end
		end
	else
		for _,k in pairs(self.m_buffData)
		do
			insert(sortedData,k,g,sk,maxB)
		end
	end

	sortedDataMaxSlot=#sortedData

	if(self.hpte)
	then
		self.hpf={}
	end
	if(DAoCBuff.LES)
	then
		for buffSlot,buffFrame in ipairs(self.m_buffFrames)
		do
			buffFrame:SetScale()
			if(buffSlot<=sortedDataMaxSlot)
			then
				if(buffFrame:SetBuff(sortedData[buffSlot])==true)
				then
					ti(self.hpf,buffFrame)
				end
			else
				buffFrame:SetBuff(nil)
			end
		end
	else
		for buffSlot,buffFrame in ipairs(self.m_buffFrames)
		do
			if(buffSlot<=sortedDataMaxSlot)
			then
				if(buffFrame:SetBuff(sortedData[buffSlot])==true)
				then
					ti(self.hpf,buffFrame)
				end
			else
				buffFrame:SetBuff(nil)
			end
		end
	end

	self.maxDataC=sortedDataMaxSlot
	self.shouldupdate=false
	local actualRows=math.ceil(math.min(sortedDataMaxSlot,self.m_maxBuffs)/self.m_buffRowStride)
	self.shouldrestick=((actualRows~=self.m_actualRows) or self.shouldrestick)
	self.m_actualRows=actualRows
end

function DAoCBuffTracker:UpdateSlowMode()
	if(self.maxDataC*self.x>15)
	then
		self.isslowmode1=true
	else
		self.isslowmode1=false
	end
	self.x=self.x+1
end

function DAoCBuffTracker:UpdateScale()
	for buffSlot, buffFrame in ipairs(self.m_buffFrames)
	do
		buffFrame:SetScale()
	end
end
