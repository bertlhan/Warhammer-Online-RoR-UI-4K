--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################


local FONTS = { "font_clear_small_bold", "font_clear_medium", "font_clear_large", "font_clear_large_bold"}
local BUFFS_PER_ROW = { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }
local pairs=pairs
local ipairs=ipairs
local WindowAddAnchor=WindowAddAnchor
local WindowClearAnchors=WindowClearAnchors
local AttachWindowToWorldObject=AttachWindowToWorldObject
local DetachWindowFromWorldObject=DetachWindowFromWorldObject
local GetBuffs = GetBuffs
local ti=table.insert
local tr=table.remove
local Thostile=GameData.BuffTargetType.TARGET_HOSTILE

local function IsValidBuff(buffData)
	return(buffData~=nil and buffData.effectIndex~=nil and buffData.iconNum~=nil and buffData.duration<40 and not buffData.permanentUntilDispelled)
end

local Head=Frame:Subclass("DAoCBuffHeadTemplate")
local Center=Frame:Subclass("DAoCBuffHeadTemplateCenter")
function Head:Create(windowName,parentWindow,tracker)
	local num
	for i = 1,150
	do
		if(tracker.pool[i]==nil)
		then
			tracker.pool[i]=true
			num=i
			break
		end
	end
	local windowName=windowName..num.."_"
	local CwindowName=windowName.."Center"
	local newHead=self:CreateFromTemplate(windowName,parentWindow)
	newHead.center=Center:CreateFromTemplate(CwindowName,parentWindow)
	WindowAddAnchor(CwindowName,"bottom",windowName,"bottom",0,0)
	WindowSetScale(CwindowName,WindowGetScale(tracker.m_windowName))
	newHead.m_buffFrames={}
	newHead.m_buffData={}
	newHead.tracker=tracker
	newHead.windowName=windowName
	newHead.num=num
	if(tracker.hpte)
	then
		newHead.hpf={}
	end
	local currentAnchor = 
	{
			Point			="topleft",
			RelativePoint	="topleft",
			RelativeTo		=CwindowName,
			XOffset			=1,
			YOffset			=-196,
	}

	for buffSlot = 1, tracker.m_maxBuffs
	do
		local buffFrame=DAoCBuffFrame:Create(CwindowName,windowName,buffSlot,tracker)
		if(buffFrame~=nil)
		then
			newHead.m_buffFrames[buffSlot]=buffFrame
			buffFrame:SetAnchor(currentAnchor)
			currentAnchor.Point				="right"
			currentAnchor.RelativePoint		="left"
			currentAnchor.RelativeTo		=CwindowName..buffSlot
			currentAnchor.YOffset			=0
		end
	end
	newHead.maxframes=#newHead.m_buffFrames
	newHead._Destroy=newHead.Destroy
	newHead.Destroy=newHead.DestroyH
	return newHead
end

function Head:DestroyH()
	self:Disable()
	for _,k in ipairs(self.m_buffFrames)
	do
		k:Destroy()
	end
	self.center:Destroy()
	self:_Destroy()
	self.tracker.pool[self.num]=nil
end

function Head:Enable(id,x)
	if(self.id==nil)
	then
		AttachWindowToWorldObject(self.windowName,id)
		self.id=id
	end
	self.center:SetDimensions(x*50,50)
end

function Head:Disable()
	if(self.id~=nil)
	then
		for _,k in ipairs(self.m_buffFrames)
		do
			k:SetBuff(nil)
		end
		DetachWindowFromWorldObject(self.windowName,self.id)
		self.id=nil
	end
end

function Head:SetScale(scale)
	WindowSetScale(self.windowName.."Center",scale)
	for _,k in ipairs(self.m_buffFrames)
	do
		k:SetScale()
	end
end


DAoCBuffHeadTracker={}
function DAoCBuffHeadTracker:Create(windowName,parentName,options)
	local newTracker={}

	newTracker.m_targetType		=options.buffTargetType
	newTracker.m_maxBuffs		=BUFFS_PER_ROW[options.buffRowStride]
	newTracker.m_buffFrames		={}
	newTracker.m_sparseFrames	={}
	newTracker.delay			={}
	newTracker.pool				={}
	newTracker.sparsetimer		=0
	newTracker.m_windowName		=windowName
	newTracker.m_parentName		=parentName
	newTracker.m_font			=FONTS[options.font]
	newTracker.m_fontnum		=options.font
	newTracker.m_divide			=options.divide
	newTracker.m_ismine			=options.ismine
	newTracker.m_horizontal		=options.horizontal
	newTracker.m_growleft		=options.growleft
	newTracker.m_growup			=options.growup
	newTracker.m_buffsbelow		=options.buffsbelow
	newTracker.m_C_elapsedTime	=0
	newTracker.m_update			=options.update
	newTracker.FA				=options.FA
	newTracker._bw				=options
	newTracker.longtoperma		=false
	newTracker.showborder		=options.showborder
	newTracker.glass			=options.glass
	newTracker.hpte				=options.hpte

	newTracker.SortKeys=
	{
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
	else
		newTracker.SortKeys["permanentUntilDispelled"].sortOrder=DataUtils.SORT_ORDER_UP
	end

	CreateWindowFromTemplate(windowName,"DAoCBuffTemplate","Root")
	WindowClearAnchors(windowName)
	if(options.anchor~=nil and options.anchor.scale~=nil)
	then
		if(options.anchor.scale~=nil)
		then
			WindowSetScale(windowName,options.anchor.scale)
		end
		WindowAddAnchor(windowName,"center","Root","center",0,-600)
	end
	LayoutEditor.RegisterWindow(windowName,towstring(windowName),L"Alternative Buffwindow. (Head)",false,false,true,nil)
	WindowSetShowing(windowName,false)

	for i=1,3 do ti(newTracker.m_sparseFrames,Head:Create(windowName,parentName,newTracker)) end

	newTracker=setmetatable(newTracker,{__index = self})

	if(newTracker.FA)
	then
		newTracker:InitA(options.filters)
	end

	return newTracker
end

function DAoCBuffHeadTracker:InitA(filters)
	self.funcA={}
	for _,k in ipairs(filters)
	do
		if(k.condense~=true)
		then
			DAoCBuff.CreateFilter(self,k)
		end
	end
end

function DAoCBuffHeadTracker:BeginTestMode()
end

function DAoCBuffHeadTracker:EndTestMode()
end

function DAoCBuffHeadTracker:Shutdown()
	for _,k in pairs(self.m_buffFrames)
	do
		k:Destroy()
	end
	for _,k in ipairs(self.m_sparseFrames)
	do
		k:Destroy()
	end
	LayoutEditor.UnregisterWindow(self.m_windowName)
	self._bw.anchor={["scale"]=WindowGetScale(self.m_windowName)}
	DestroyWindow(self.m_windowName)
end

function DAoCBuffHeadTracker:ClearAllBuffs()
	for i,k in pairs(self.m_buffFrames)
	do
		k.m_buffData={}
		k:Disable()
		ti(self.m_sparseFrames,k)
		self.m_buffFrames[i]=nil
	end
	self.delay={}
end

function DAoCBuffHeadTracker:Filter(BuffTable,add)
	local del={}
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

function DAoCBuffHeadTracker:CheckSparse(elapsed)
	local num=#self.m_sparseFrames
	if(num<1)
	then
		ti(self.m_sparseFrames,Head:Create(self.m_windowName,self.m_parentName,self))
		self.sparsetimer=0
	else
		if(num>3)
		then
			if(self.sparsetimer>5)
			then
				local head=tr(self.m_sparseFrames,num)
				head:Destroy()
				self.sparsetimer=0
			else
				self.sparsetimer=self.sparsetimer+elapsed
			end
		else
			self.sparsetimer=0
		end
	end
end

function DAoCBuffHeadTracker:GetHead(id)
	if(id==0 or id==GameData.Player.worldObjNum)then return nil end
	local head=self.m_buffFrames[id]
	if(head==nil)
	then
		if(#self.m_sparseFrames>0)
		then
			head=tr(self.m_sparseFrames,1)
		else
			head=Head:Create(self.m_windowName,self.m_parentName,self)
		end
		self.m_buffFrames[id]=head
	end
	return head
end

function DAoCBuffHeadTracker:UpdateHead(id,head,elapsed)
	local x=0
	for i,k in pairs(head.m_buffData)
	do
		k.duration=k.duration-elapsed
		if(k.duration>0)
		then
			x=x+1
		else
			head.m_buffData[i]=nil
		end
	end
	if(x>0)
	then
		if(x>head.maxframes)then x=head.maxframes end
		head.center:SetDimensions(x*50,50)
	else
		head:Disable()
		ti(self.m_sparseFrames,head)
		self.m_buffFrames[id]=nil
	end
end

function DAoCBuffHeadTracker:Update(elapsedTime)
	self.m_C_elapsedTime=self.m_C_elapsedTime+elapsedTime
	local e=self.m_C_elapsedTime

	if(self.hpte)
	then
		for i,k in pairs(self.m_buffFrames)
		do
			for j,l in ipairs(k.hpf)
			do
				if(l:UpdateI_hpte(elapsedTime)~=true)
				then
					table.remove(k.hpf,j)
				end
			end
		end
	end

	if(e<self.m_update)
	then
		self:CheckSparse(elapsedTime)
		return
	end

	if(elapsedTime>0.07)
	then
		if(e<self.m_update*2 and elapsedTime>0.1)
		then
			return
		end
	end

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
	for i,k in pairs(self.m_buffFrames)
	do
		self:UpdateHead(i,k,e)
	end

	if(DAoCBuff.LES)
	then
		for i,k in pairs(self.m_buffFrames)
		do
			WindowSetScale(k.windowName.."Center",WindowGetScale(self.m_windowName))
			for _,buffFrame in ipairs(k.m_buffFrames)
			do
				buffFrame:SetScale()
				if(buffFrame:UpdateI()==true)
				then
					ti(k.hpf,buffFrame)
				end
			end
		end
	else
		for i,k in pairs(self.m_buffFrames)
		do
			for _,buffFrame in ipairs(k.m_buffFrames)
			do
				if(buffFrame:UpdateI()==true)
				then
					ti(k.hpf,buffFrame)
				end
			end
		end
	end
	self.m_C_elapsedTime=0
end

function DAoCBuffHeadTracker:UpdateBuffs(updateBuffTable,isFullList,id)
	if(not updateBuffTable)then return end
	local head=self:GetHead(id)
	if(head==nil)then return end
	local changed=false
	local data=head.m_buffData
	local del

	if(isFullList)
	then
		head.m_buffData={}
		changed,del=self:Filter(updateBuffTable,head.m_buffData)
		changed=true
	else
		changed,del=self:Filter(updateBuffTable,data)
		if(not changed)
		then
			for _,i in ipairs(del)
			do
				if(data[i]~=nil)
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
			data[i]=nil
		end
		self:OnBuffsChanged(id,head)
	end
end

function DAoCBuffHeadTracker:Refresh(id)
	local head=self:GetHead(id)
	if(head==nil)then return end
	local BuffTable=GetBuffs(self.m_targetType)

	head.m_buffData={}
	if(BuffTable~=nil)
	then
		self:Filter(BuffTable,head.m_buffData)
	end

	self:OnBuffsChanged(id,head)
end

local insert=DAoCBuff.insert

function DAoCBuffHeadTracker:OnBuffsChanged(id,head)
	local sortedData={nil,nil}
	local sortedDataMaxSlot=0
	local maxB=self.m_maxBuffs
	local sk=self.SortKeys
	for _,k in pairs(head.m_buffData)
	do
		insert(sortedData,k,"permanentUntilDispelled",sk,maxB)
	end


	sortedDataMaxSlot=#sortedData
	if(sortedDataMaxSlot>0)
	then
		head:Enable(id,math.min(sortedDataMaxSlot,maxB))
		if(self.hpte)
		then
			head.hpf={}
		end
		if(DAoCBuff.LES)
		then
			WindowSetScale(head.windowName.."Center",WindowGetScale(self.m_windowName))
			for buffSlot,buffFrame in ipairs(head.m_buffFrames)
			do
				buffFrame:SetScale()
				if(buffSlot<=sortedDataMaxSlot)
				then
					if(buffFrame:SetBuff(sortedData[buffSlot])==true)
					then
						ti(head.hpf,buffFrame)
					end
				else
					buffFrame:SetBuff(nil)
				end
			end
		else
			for buffSlot,buffFrame in ipairs(head.m_buffFrames)
			do
				if(buffSlot<=sortedDataMaxSlot)
				then
					if(buffFrame:SetBuff(sortedData[buffSlot])==true)
					then
						ti(head.hpf,buffFrame)
					end
				else
					buffFrame:SetBuff(nil)
				end
			end
		end
	else
		head:Disable()
	end
end

function DAoCBuffHeadTracker:UpdateScale()
	local scale=WindowGetScale(self.m_windowName)
	for i,k in pairs(self.m_buffFrames)
	do
		k:SetScale(scale)
	end
	for i,k in pairs(self.m_sparseFrames)
	do
		k:SetScale(scale)
	end
end
