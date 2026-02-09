
local CD_FADE_START=0
local FONTS={"font_clear_small_bold","font_clear_medium_bold","font_clear_large","font_clear_large_bold"}
local CDS_PER_ROW = { 5,6,7,8,9,10,11,12,13,14,15 }
local BAR_MAXCD = {5, 6, 7, 8, 9, 10}
local FONT = ""
local pairs=pairs
local ipairs=ipairs
local LabelSetText = LabelSetText
local WindowStartAlphaAnimation = WindowStartAlphaAnimation
local WindowStopAlphaAnimation = WindowStopAlphaAnimation
local DynamicImageSetTexture = DynamicImageSetTexture
local WindowSetAlpha = WindowSetAlpha
local WindowAddAnchor = WindowAddAnchor
local WindowClearAnchors = WindowClearAnchors
local WindowSetTintColor = WindowSetTintColor
local WindowSetShowing = WindowSetShowing
local WindowSetDimensions = WindowSetDimensions
local sortT=table.sort
local mmax=math.max




CCDownFrame={}
CCDownFrameN=Frame:Subclass("CDownContainer")
CCDownFrameB=Frame:Subclass("CDownContainerWithBar")

function CCDownFrame:Create(windowName,parentWindow,CDSlot,tracker)
	local name=windowName..CDSlot
	local CDFrame = self:CreateFromTemplate(name,parentWindow)

	if(CDFrame ~= nil)
	then
		CDFrame.m_CDSlot			= CDSlot
		CDFrame.m_IsFading			= false
		CDFrame.m_name=windowName
		CDFrame.hpte=tracker.hpte
		CDFrame.tfont=FONTS[tracker.tfont]
		WindowSetShowing(name.."Frame",tracker.showborder==true)
		WindowSetShowing(name.."Glass",tracker.glass==true)
		if(tracker.CDsbelow==1)
		then
			WindowClearAnchors(name.."Time")
			WindowAddAnchor(name.."Time","bottom",name,"top",0,0)
		end
		CDFrame.UpdateI=CCDownFrame.UpdateI0

		CDFrame:SetScale()
	end
	return CDFrame
end
CCDownFrameN.Create=CCDownFrame.Create
CCDownFrameB.CreateP=CCDownFrame.Create

function CCDownFrameB:Create(windowName,parentWindow,CDSlot,tracker)
	local CDFrame = self:CreateP(windowName,parentWindow,CDSlot,tracker)
	local name=windowName..CDSlot

	CDFrame.width=tracker.width
	CDFrame.name=tracker.name
	CDFrame.nfont=FONTS[tracker.nfont]

	local Time=name.."Time"
	local Icon=name.."Icon"
	local BackBar=name.."BackBar"
	local TimeBar=name.."TimeBar"
	local TimeBarEnd=name.."TimeBarEnd"
	WindowClearAnchors(Time)
	WindowClearAnchors(BackBar)
	WindowClearAnchors(TimeBar)
	WindowClearAnchors(TimeBarEnd)
	if(tracker.horizontal==1)
	then
		WindowSetDimensions(name,23+50+tracker.width,23)
		if(tracker.growleft==1)
		then
			WindowAddAnchor(BackBar,"right",Icon,"left",0,0)
			WindowAddAnchor(TimeBarEnd,"right",TimeBar,"left",0,0)
			if(tracker.bend)
			then
				WindowAddAnchor(TimeBar,"right",Icon,"left",-20,0)
			else
				WindowAddAnchor(TimeBar,"right",Icon,"left",0,0)
			end
			if(tracker.CDsbelow~=1)
			then
				WindowAddAnchor(Time,"right",BackBar,"left",0,0)
			else
				WindowClearAnchors(Icon)
				WindowAddAnchor(Time,"left",name,"left",0,0)
				WindowAddAnchor(Icon,"right",Time,"left",0,0)
			end
		else
			WindowClearAnchors(Icon)
			WindowAddAnchor(Icon,"topright",name,"topright",0,0)
			WindowAddAnchor(BackBar,"left",Icon,"right",0,0)
			WindowAddAnchor(TimeBarEnd,"left",TimeBar,"right",0,0)
			DynamicImageSetTextureOrientation(TimeBarEnd,true)
			if(tracker.bend)
			then
				WindowAddAnchor(TimeBar,"left",Icon,"right",20,0)
			else
				WindowAddAnchor(TimeBar,"left",Icon,"right",0,0)
			end
			if(tracker.CDsbelow~=1)
			then
				WindowAddAnchor(Time,"left",BackBar,"right",0,0)
			else
				WindowClearAnchors(Icon)
				WindowAddAnchor(Time,"right",name,"right",0,0)
				WindowAddAnchor(Icon,"left",Time,"right",0,0)
			end
		end
		WindowSetDimensions(name.."Name",tracker.width,23)
		if(tracker.bend)
		then
			WindowSetDimensions(TimeBarEnd,20,46)
		end
		DynamicImageSetTexture(BackBar,"CDown_Statusbar",0,0)
		DynamicImageSetTexture(TimeBar,"CDown_Statusbar",0,0)
		DynamicImageSetTexture(TimeBarEnd,"CDown_StatusbarEnd",0,0)
		WindowSetDimensions(BackBar,tracker.width,23)
		CCDownFrameB.UpdateDurI=CCDownFrameB.UpdateDurI1H
		CCDownFrameB.UpdateDurI2=CCDownFrameB.UpdateDurI2H
	else
		if (tracker.tfont == 1) then
			WindowSetDimensions(name,27,23+50+tracker.width)
		elseif (tracker.tfont == 2) then
			WindowSetDimensions(name,32,23+50+tracker.width)
		elseif (tracker.tfont == 3) then
			WindowSetDimensions(name,36,23+50+tracker.width)
		else
			WindowSetDimensions(name,40,23+50+tracker.width)
		end
		if(tracker.growup==1)
		then
			WindowAddAnchor(BackBar,"bottom",Icon,"top",0,0)
			WindowAddAnchor(TimeBarEnd,"bottom",TimeBar,"top",0,0)
			if(tracker.bend)
			then
				WindowAddAnchor(TimeBar,"bottom",Icon,"top",0,-20)
			else
				WindowAddAnchor(TimeBar,"bottom",Icon,"top",0,0)
			end
			if(tracker.CDsbelow~=1)
			then
				WindowAddAnchor(Time,"bootom",BackBar,"top",0,0)
			else
				WindowClearAnchors(Icon)
				WindowAddAnchor(Time,"topleft",name,"topleft",-26,0)
				WindowAddAnchor(Icon,"bottom",Time,"top",0,0)
			end
			DynamicImageSetTexture(TimeBarEnd,"CDown_StatusbarEndR2",0,0)
		else
			WindowClearAnchors(Icon)
			WindowAddAnchor(Icon,"bottomleft",name,"bottomleft",0,0)
			WindowAddAnchor(BackBar,"top",Icon,"bottom",0,0)
			WindowAddAnchor(TimeBarEnd,"top",TimeBar,"bottom",0,0)
			if(tracker.bend)
			then
				WindowAddAnchor(TimeBar,"top",Icon,"bottom",0,20)
			else
				WindowAddAnchor(TimeBar,"top",Icon,"bottom",0,0)
			end
			if(tracker.CDsbelow~=1)
			then
				WindowAddAnchor(Time,"top",BackBar,"bottom",0,0)
			else
				WindowClearAnchors(Icon)
				WindowAddAnchor(Time,"bottomleft",name,"bottomleft",-26,0)
				WindowAddAnchor(Icon,"top",Time,"bottom",0,0)
			end
			DynamicImageSetTexture(TimeBarEnd,"CDown_StatusbarEndR1",0,0)
		end
		LabelSetWordWrap(name.."Name",true)
		if(tracker.bend)
		then
			WindowSetDimensions(TimeBarEnd,46,20)
		end
		DynamicImageSetTexture(BackBar,"CDown_StatusbarR",0,0)
		DynamicImageSetTexture(TimeBar,"CDown_StatusbarR",0,0)
		WindowSetDimensions(BackBar,23,tracker.width)
		CCDownFrameB.UpdateDurI=CCDownFrameB.UpdateDurI1V
		CCDownFrameB.UpdateDurI2=CCDownFrameB.UpdateDurI2V
	end

	if(tracker.back)
	then
		WindowSetShowing(BackBar,true)
		WindowSetTintColor(BackBar,0,0,0)
	else
		WindowSetShowing(BackBar,false)
	end
	if(tracker.bend)
	then
		WindowSetShowing(TimeBarEnd,true)
	else
		WindowSetShowing(TimeBarEnd,false)
	end

	return CDFrame
end

function CCDownFrame:SetScale()
	if(WindowGetScale(self.m_name) ~= WindowGetScale(self:GetName())) then
		WindowSetScale(self:GetName(),WindowGetScale(self.m_name))
	end
end
CCDownFrameN.SetScale=CCDownFrame.SetScale
CCDownFrameB.SetScale=CCDownFrame.SetScale

function CCDownFrame:GetScale()
	return WindowGetScale(self:GetName())
end
CCDownFrameN.GetScale=CCDownFrame.GetScale
CCDownFrameB.GetScale=CCDownFrame.GetScale

function CCDownFrame:UpdateI0()
	if(self:IsShowing()~=false)
	then
		self:Show(false)
	end
end

local ret=false
function CCDownFrame:UpdateI1()
	local shouldShow=false
	local duration=self.m_CDData.duration
	if(duration>0)
	then
		shouldShow=true
		if(duration < CD_FADE_START)
		then
			self:StartFading()
		end

		if(self.hpte) then
			if(duration<3.1) then
				ret=true
			end
			if(duration>2.1) then
				LabelSetText(self:GetName().."Time",TimeUtils.FormatTimeCondensed(duration))
			else
				LabelSetText(self:GetName().."Time",TimeUtils.FormatRoundedSeconds(duration,0.1,true))
			end
		else
			LabelSetText(self:GetName().."Time",TimeUtils.FormatTimeCondensed(duration))
		end
	end
	if(self:IsShowing()~=shouldShow)
	then
		self:StopFading()
		self:Show(shouldShow)
	end
end

function CCDownFrameB:UpdateI1()
	local shouldShow=false
	local duration=self.m_CDData.duration
	if(duration>0)
	then
		shouldShow=true
		if(self.hpte and duration<=2.1)
		then
			shouldShow=true
			self.UpdateDurI=CCDownFrameB.UpdateDurI2
			self:UpdateDurI(duration,self.m_CDData.reuseTimerMax)
		else
			self:UpdateDurI(duration,self.m_CDData.reuseTimerMax)
		end
	end
	if(self:IsShowing()~=shouldShow)
	then
		self:Show(shouldShow)
	end
end

function CCDownFrameB:UpdateDurI1H(duration,rtMax)
	local windowName=self:GetName()
	LabelSetText(windowName.."Time",TimeUtils.FormatTimeCondensed(duration))
	WindowSetDimensions(windowName.."TimeBar",duration/rtMax*self.width,23)
end

function CCDownFrameB:UpdateDurI2H(duration,rtMax)
	local windowName=self:GetName()
	LabelSetText(windowName.."Time",TimeUtils.FormatRoundedSeconds(duration,0.1,true))
	WindowSetDimensions(windowName.."TimeBar",duration/rtMax*self.width,23)
	ret=true
end

function CCDownFrameB:UpdateDurI1V(duration,rtMax)
	local windowName=self:GetName()
	LabelSetText(windowName.."Time",TimeUtils.FormatTimeCondensed(duration))
	WindowSetDimensions(windowName.."TimeBar",23,duration/rtMax*self.width)
end

function CCDownFrameB:UpdateDurI2V(duration,rtMax)
	local windowName=self:GetName()
	LabelSetText(windowName.."Time",TimeUtils.FormatRoundedSeconds(duration,0.1,true))
	WindowSetDimensions(windowName.."TimeBar",23,duration/rtMax*self.width)
	ret=true
end

function CCDownFrameN:StopFading()
	if(self.m_IsFading == true)
	then
		local windowName=self:GetName()
		WindowStopAlphaAnimation(windowName.."Icon")
		WindowStopAlphaAnimation(windowName.."Frame")
		self.m_IsFading = false
	end
end

function CCDownFrameN:StartFading()
	if(self.m_IsFading == false)
	then
		local windowName=self:GetName()
		WindowStartAlphaAnimation(windowName.."Icon",Window.AnimationType.LOOP,1,0.5,1,true,0,0)
		WindowStartAlphaAnimation(windowName.."Frame",Window.AnimationType.LOOP,1,0.5,1,true,0,0)
		self.m_IsFading = true
	end
end

function CCDownFrameN:SetCD(CDData)
	self.m_CDData=CDData

	local isValidCD =(CDData ~= nil and CDData.iconNum ~= nil and CDData.iconNum >0)

	if(isValidCD)
	then
		local windowName = self:GetName()
		local texture,x,y = GetIconData(CDData.iconNum)
		DynamicImageSetTexture(windowName.."Icon",texture,x,y)
		WindowSetAlpha(windowName,1.0)
		LabelSetFont(windowName.."Time",self.tfont,10)

		local CDRed,CDGreen,CDBlue = unpack(CDData.color)

		if(CDRed and CDGreen and CDBlue)
		then
			WindowSetTintColor(windowName.."Frame",CDRed,CDGreen,CDBlue)
		else
			WindowSetTintColor(windowName.."Frame",255,255,255)
		end

		if(CDData.duration>0) then
			LabelSetText(windowName.."Time",TimeUtils.FormatTimeCondensed(CDData.duration))
			self.UpdateI=CCDownFrame.UpdateI1
		else
			self.UpdateI=CCDownFrame.UpdateI0
		end

 		if(CDData.duration < CD_FADE_START)
		then
			self:StartFading()
		else
			self:StopFading()
		end
	else
		self.UpdateI=CCDownFrame.UpdateI0
	end

	self:Show(isValidCD)
end

function CCDownFrameB:SetCD(CDData)
	self.m_CDData=CDData

	local isValidCD =(CDData ~= nil and CDData.iconNum ~= nil and CDData.iconNum >0)

	if(isValidCD)
	then
		local windowName = self:GetName()
		local texture,x,y = GetIconData(CDData.iconNum)
		DynamicImageSetTexture(windowName.."Icon",texture,x,y)
		WindowSetAlpha(windowName,1.0)
		LabelSetFont(windowName.."Time",self.tfont,10)
		LabelSetFont(windowName.."Name",self.nfont,10)
		if(self.name)
		then
			LabelSetText(windowName.."Name",CDData.name)
		end

		local CDRed,CDGreen,CDBlue = unpack(CDData.color)

		if(CDRed and CDGreen and CDBlue)
		then
			WindowSetTintColor(windowName.."Frame",CDRed,CDGreen,CDBlue)
			WindowSetTintColor(windowName.."TimeBar",CDRed,CDGreen,CDBlue)
			WindowSetTintColor(windowName.."TimeBarEnd",CDRed,CDGreen,CDBlue)
		else
			WindowSetTintColor(windowName.."Frame",255,255,255)
			WindowSetTintColor(windowName.."TimeBar",255,255,255)
			WindowSetTintColor(windowName.."TimeBarEnd",255,255,255)
		end

		if(CDData.duration>0) then
			self.UpdateI=CCDownFrameB.UpdateI1
			self.UpdateDurI=nil
			self:UpdateDurI(CDData.duration,self.m_CDData.reuseTimerMax)
		else
			self.UpdateI=CCDownFrame.UpdateI0
		end
	else
		self.UpdateI=CCDownFrame.UpdateI0
	end

	self:Show(isValidCD)
end


CCDownTracker = {}
CCDownTracker.__index = CCDownTracker

function CCDownTracker:Create(windowName,parentName,initialAnchor,options)

	local newTracker =
	{
		m_CDData={},
		m_CDMapping={},
		m_maxCDs=options.maxCDCount,
		m_CDFrames={},
		m_CDRowStride=CDS_PER_ROW[options.CDRowStride],
		m_CDorder=options.CDorder,
	}

	CD_FADE_START=options.fade_start

	local YOffset=0

	local currentAnchor = initialAnchor
	if(options.growleft~=1)
	then
		currentAnchor.Point="topright"
		currentAnchor.RelativePoint="topright"
	end

	newTracker.SortKeys=
	{
		["duration"] 					= { fallback = "name" ,sortOrder = DataUtils.SORT_ORDER_DOWN},
		["name"]						= { sortOrder = DataUtils.SORT_ORDER_UP },
	}
	if(options.CDorder==1)
	then
		newTracker.SortKeys["duration"].sortOrder=DataUtils.SORT_ORDER_DOWN
	else
		newTracker.SortKeys["duration"].sortOrder=DataUtils.SORT_ORDER_UP
	end

	if(not options.bar)
	then
		if(options.CDsbelow==1)then
			if(options.tfont==1)then YOffset=40
			elseif(options.tfont==2)then YOffset=44
			elseif(options.tfont==3)then YOffset=50
			elseif(options.tfont==4)then YOffset=50
			end
		else
			YOffset=0
		end

		for CDSlot = 1,options.maxCDCount
		do
			local CDFrame=CCDownFrameN:Create(windowName,parentName,CDSlot,options)
			if(CDFrame ~= nil)
			then
				newTracker.m_CDFrames[CDSlot]=CDFrame
				CDFrame:SetAnchor(currentAnchor)
				local nextSlot=CDSlot + 1
				local remainder=math.fmod(nextSlot,newTracker.m_CDRowStride)
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
					currentAnchor.RelativeTo				=windowName..(nextSlot - newTracker.m_CDRowStride)
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
					currentAnchor.RelativeTo				=windowName..CDSlot
				end
				currentAnchor.XOffset						=0
			end
		end
	else
		if (options.horizontal == 2) then
			options.name = false
		end
		for CDSlot = 1,newTracker.m_maxCDs
		do
			local CDFrame=CCDownFrameB:Create(windowName,parentName,CDSlot,options)
			if(CDFrame ~= nil)
			then
				newTracker.m_CDFrames[CDSlot]=CDFrame
				CDFrame:SetAnchor(currentAnchor)
				if(options.horizontal==1)
				then
					if(options.growup==1)
					then
						currentAnchor.Point				="bottomleft"
						currentAnchor.RelativePoint		="topleft"
						currentAnchor.YOffset			=0
					else
						currentAnchor.Point				="topleft"
						currentAnchor.RelativePoint		="bottomleft"
						currentAnchor.YOffset			=0
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
				currentAnchor.RelativeTo				=windowName..CDSlot
				currentAnchor.XOffset					=0
			end
		end
	end

	newTracker = setmetatable(newTracker,self)
	newTracker.__index = self

	return newTracker
end

function CCDownTracker:Shutdown()
	self:ClearAllCDs()
	for CDSlot,CDFrame in ipairs(self.m_CDFrames)
	do
		CDFrame:Destroy()
	end
end

function CCDownTracker:ClearAllCDs()
	if(self.m_CDFrames ~= nil) then
		for _,frame in pairs(self.m_CDFrames)
		do
			frame:SetCD(nil)
		end
	end
end

local sk
local cd_sort=CDown.Sort

local function SortCDs(CD1,CD2)
	return cd_sort(CD1,CD2,"duration",sk)
end

function CCDownTracker:Refresh()
	local CDTable			= CDown.GetCDs()
	local CDTableMaxSlot
	local offset

	sk=self.SortKeys

	sortT(CDTable,SortCDs)
	CDTableMaxSlot=#CDTable
	offset=mmax(CDTableMaxSlot-self.m_maxCDs,0)

	for CDSlot,CDFrame in ipairs(self.m_CDFrames)
	do
		if(CDSlot <= CDTableMaxSlot)
		then
			CDFrame:SetCD(CDTable[CDSlot+offset])
		else
			CDFrame:SetCD(nil)
		end
	end

end

function CCDownTracker:Update()
	ret=false
	if(CDown.LES)
	then
		for CDSlot,CDFrame in ipairs(self.m_CDFrames)
		do
			CDFrame:SetScale()
			CDFrame:UpdateI()
		end
	else
		for CDSlot,CDFrame in ipairs(self.m_CDFrames)
		do
			CDFrame:UpdateI()
		end
	end
	return ret
end

function CCDownTracker:UpdateScale()
	for CDSlot,CDFrame in ipairs(self.m_CDFrames)
	do
		CDFrame:SetScale()
	end
end
