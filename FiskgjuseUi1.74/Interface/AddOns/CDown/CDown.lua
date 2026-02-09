-------------------------------------------------------
-------------------------------------------------------
-- CDownWindow
-------------------------------------------------------
-------------------------------------------------------

CDown = {}

local timeLeft=0.5
local C_elapsed=0
local C_elapsed_R=0
local update=false
local Cools={}
local MIN_COOLDOWN=0
local MAX_COOLDOWN=18000
local tt
local CPA
local CP
local CDs
local GetColors


-- ARRAYs FÜR OPTIONS
local CDS_PER_ROW = {5, 6, 7, 8, 9, 10}
local CD_ROWS = {1, 2, 3, 4}
local N_CD_REFRESH_DELAY = {0.25, 0.5, 0.75, 1.0}
local S_CD_REFRESH_DELAY = { 0.05, 0.075, 0.1, 0.15 }
local FONTTEXT = { "small", "medium", "large", "large bold"}
local FONTS	= { "font_clear_small_bold", "font_clear_medium", "font_clear_large", "font_clear_large_bold"}
local CDORDER = { "descending", "ascending"}
local GROWLEFT = { "left to right", "right to left"}
local GROWUP = { "downwards", "upwards"}
local HORIZONTAL = { "vertical", "horizontal"}
local MIN_CD = {0, 5, 8, 10, 20, 30}
local MAX_CD = {8, 10, 20, 30, 60, 18000}

local GetHotbarData = GetHotbarData
local GetHotbarCooldown = GetHotbarCooldown
local Tinsert = table.insert

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

local function GetColorsPA(abilityData)
	local tmp=CPA[abilityData.id]
	if(tmp==nil)
	then
		tmp=GetColorsWAR(abilityData)
		CPA[abilityData.id]=tmp
	end
	return tmp
end

local function GetColorsP()
	return CP
end

function CDown.Initialize()

	if not CDownVar then
		CDownVar =
		{
			version			= 0.94,
			refresh			= 2,
			minCD			= 1,
			maxCD			= 6,
			color			= 1,
			CP				= {255,210,0},
			CPA				= {}
		}
		CDownVar.optCDs=
		{
			maxCDCount=15,
			CDRowStride=1,
			rowcount=3,
			CDorder=1,
			CDsbelow=0,
			growleft=1,
			growup=1,
			horizontal=2,
			fade_start=0,
			showborder=true,
			glass=true,
			name=true,
			bar=false,
			width=340,
			bend=true,
			back=false,
			bar_maxCDCount=6,
			hpte=true,
			tfont=3,
			nfont=2
		}
	end

	CDown.VersionHandler()

	if (CDownVar.CPA[tostring(GameData.Account.ServerName)..tostring(GameData.Player.name)] == nil) then
		CDownVar.CPA[tostring(GameData.Account.ServerName)..tostring(GameData.Player.name)] = { }
	end

	CreateWindow("CDownWindow", true)
	LayoutEditor.RegisterWindow("CDownWindow", L"CDown", L"Alternative Cooldownwindow.",false,false,true,nil)

	RegisterEventHandler(SystemData.Events.PLAYER_COOLDOWN_TIMER_SET,"CDown.PCTS")
	RegisterEventHandler(SystemData.Events.PLAYER_HOT_BAR_UPDATED,"CDown.AbilitiesUpdated")
	RegisterEventHandler(SystemData.Events.ENTER_WORLD,"CDown.RegisterAbilities")
	RegisterEventHandler(SystemData.Events.INTERFACE_RELOADED,"CDown.RegisterAbilities")
	RegisterEventHandler(SystemData.Events.LOADING_END,"CDown.RegisterAbilities")

	LibSlash.RegisterSlashCmd("CDown", function(input) CDown.HandleSlash(input) end)
	LayoutEditor.RegisterEditCallback(CDown.LEH)
	CDown.LES=false
	math.randomseed(GameData.Player.money)

	CDown.StartTracker()

	TextLogAddEntry("Chat", 0, L"CDown initialized ! - Use '/cdown' to open the Optionswindow")
end

function CDown.RestartTracker()
	CDown.StopTracker()
	LayoutEditor.UnregisterWindow("CDownWindow")
	local o=CDownVar.optCDs
	if(o.bar)
	then
		if(o.horizontal==1)
		then
			WindowSetDimensions("CDownWindow",23+50+o.width,23)
		else
			WindowSetDimensions("CDownWindow",23,23+50+o.width)
		end
	else
		WindowSetDimensions("CDownWindow",500,100)
	end
	LayoutEditor.RegisterWindow("CDownWindow", L"CDown", L"Alternative Cooldownwindow.",false,false,true,nil)
	CDown.StartTracker()
end

function CDown.StartTracker()
	if(CDownVar.color==3)
	then
		CP=CDownVar.CP
		GetColors=GetColorsP
	elseif(CDownVar.color==2)
	then
		CPA=CDownVar.CPA[tostring(GameData.Account.ServerName)..tostring(GameData.Player.name)]
		GetColors=GetColorsPA
	else
		GetColors=GetColorsWAR
	end

	MIN_COOLDOWN = MIN_CD[CDownVar.minCD]
	MAX_COOLDOWN = MAX_CD[CDownVar.maxCD]

	if (CDownVar.optCDs.bar) then
		tt=S_CD_REFRESH_DELAY[CDownVar.refresh]
	else
		tt=N_CD_REFRESH_DELAY[CDownVar.refresh]
	end

	local CDAnchor =
	{
		Point		   = "topleft",
		RelativePoint   = "topleft",
		RelativeTo	  = "CDownWindow",
		XOffset		 = 0,
		YOffset		 = 0,
	}
	CDs=CCDownTracker:Create("CDownWindow","Root",CDAnchor,CDownVar.optCDs)
	CDown.RegisterAbilities()
end

function CDown.StopTracker()
	if(CDs~=nil)
	then
		CDs:Shutdown()
		CDs=nil
	end
end

function CDown.Shutdown()
	CDown.StopTracker()
	UnregisterEventHandler(SystemData.Events.PLAYER_COOLDOWN_TIMER_SET,"CDown.PCTS")
	UnregisterEventHandler(SystemData.Events.PLAYER_HOT_BAR_UPDATED,"CDown.AbilitiesUpdated")
	UnregisterEventHandler(SystemData.Events.ENTER_WORLD,"CDown.RegisterAbilities")
	UnregisterEventHandler(SystemData.Events.INTERFACE_RELOADED,"CDown.RegisterAbilities")
	UnregisterEventHandler(SystemData.Events.LOADING_END,"CDown.RegisterAbilities")
	LibSlash.UnregisterSlashCmd("CDown")
end

function CDown.RegisterAbilities()
	local abilityData,ID,i,cooldown
	Cools={}
	for i=0,121
	do
		_,ID=GetHotbarData(i)
		abilityData=GetAbilityData(ID)
		if(abilityData.reuseTimerMax>MIN_COOLDOWN and abilityData.reuseTimerMax<MAX_COOLDOWN)
		then
			abilityData.slot={[i]=true}
			abilityData.x=false
			abilityData.color=GetColors(abilityData)
			cooldown=GetHotbarCooldown(i)
			if(cooldown>2.1)
			then
				abilityData.duration=cooldown
			else
				abilityData.duration=0
			end
			Cools[ID]=abilityData
		end
	end
	if(CDs~=nil)then CDs:Refresh() end
end

local j
local function UpdateCD(cd)
	local done=false
	for j,_ in pairs(cd.slot)
	do
		local _,ID=GetHotbarData(j)
		if(cd.id==ID)
		then
			local cooldown=GetHotbarCooldown(j)
			if(cooldown>2.1)
			then
				if(cd.duration<1.3)
				then
					cd.duration=cooldown
					cd.x=false
				else
					if(cooldown>cd.duration)
					then
						cd.duration=cd.duration-C_elapsed*3/4
						timeLeft=tt/2
						cd.x=true
					else
						cd.duration=cooldown
						cd.x=false
					end
				end
			else
				if(cooldown==0 and cd.duration>2.3+C_elapsed)
				then
					cd.duration=cooldown
				else
					cd.duration=math.max(cd.duration-C_elapsed,0)
				end
				cd.x=false
			end
			done=true
			break
		else
			cd.slot[j]=nil
		end
	end
	if(not done)then cd.duration=math.max(cd.duration-C_elapsed,0) end
end

local function UpdateCD_Testmode(cd)
	if(cd.duration>0)
	then
		cd.duration=math.max(cd.duration-C_elapsed,0)
	else
		cd.duration=cd.reuseTimerMax-(math.random(cd.reuseTimerMax*10/3)/10)
		cd.x=true
		update=true
	end
end

function CDown.UpdateWindow(elapsed)
	timeLeft=timeLeft-elapsed
	C_elapsed=C_elapsed+elapsed
	C_elapsed_R=C_elapsed_R+elapsed

	if(not update and C_elapsed_R<5)
	then
		if(timeLeft<0)
		then
			timeLeft=tt
			for i,k in pairs(Cools)
			do
				if(k.x)
				then
					UpdateCD(k)
				else
					k.duration=math.max(k.duration-C_elapsed,0)
				end
			end
			if(CDs:Update())then timeLeft=0.05 end
			C_elapsed=0
		end
	else
		CDs:Refresh()
		update=false
		timeLeft=0.05
	end
end

function CDown.PCTS()
	update=true
end

function CDown.LEH(LECode)
	if(LECode==LayoutEditor.EDITING_BEGIN)
	then
		CDown.LES=true
	end
	if(LECode==LayoutEditor.EDITING_END)
	then
		CDown.LES=false
		CDs:UpdateScale()
	end
end

function CDown.AbilitiesUpdated(slot,_,ID)
	if(ID~=0)
	then
		local cooldown
		local abilityData
		if(Cools[ID]~=nil)
		then
			abilityData=Cools[ID]
			abilityData.slot[slot]=true
			abilityData.x=true
		else
			abilityData=GetAbilityData(ID)
			if(abilityData.reuseTimerMax>MIN_COOLDOWN and abilityData.reuseTimerMax<MAX_COOLDOWN)
			then
				abilityData.slot={[slot]=true}
				abilityData.x=true
				Cools[ID]=abilityData
				cooldown=GetHotbarCooldown(slot)
				abilityData.color=GetColors(abilityData)
				if(cooldown>2.1)
				then
					abilityData.duration=cooldown
				else
					abilityData.duration=0
				end
			end
		end
	end
	update=true
end

function CDown.GetCDs()
	local tab={}
	local _,ID
	local cooldown
	for i,k in pairs(Cools)
	do
		UpdateCD(k)
		if(k.duration>0)
		then
			Tinsert(tab,k)
		end
	end
	C_elapsed=0
	C_elapsed_R=0
	return tab
end

function CDown.StartTestmode()
	if(CDown.UpdateCD_bak==nil)
	then
		CDown.UpdateCD_bak=UpdateCD
		UpdateCD=UpdateCD_Testmode
	end
	CDs:Refresh()
end

function CDown.StopTestmode()
	if(CDown.UpdateCD_bak~=nil)
	then
		UpdateCD=CDown.UpdateCD_bak
		CDown.UpdateCD_bak=nil
	end
	CDs:Refresh()
end

function CDown.GetAb()
	local abilityData,ID,i
	ret={}
	for i=0,121
	do
		_,ID=GetHotbarData(i)
		abilityData=GetAbilityData(ID)
		if(abilityData.reuseTimerMax>MIN_COOLDOWN and abilityData.reuseTimerMax<MAX_COOLDOWN)
		then
			ret[ID]=abilityData
		end
	end
	return ret
end

function CDown.HandleSlash(input)
	local opt, val = input:match("([a-z0-9]+)[ ]?(.*)")

	if not(opt)then
		CDownSettings.Show()
	end
end

function CDown.VersionHandler()
	if(CDownVar.version==0.90)
	then
		CDownVar.version=0.91
		CDownVar.optCDs.fade_start=0
	end
	if(CDownVar.version==0.91)
	then
		CDownVar.version=0.92
	end
	if(CDownVar.version==0.92)
	then
		CDownVar.version=0.93
		CDownVar.optCDs.showborder = true
		CDownVar.optCDs.glass = true
	end
	if(CDownVar.version<0.94)
	then
		CDownVar.version=0.94
		CDownVar.optCDs.name=true
		CDownVar.optCDs.bar=false
		CDownVar.optCDs.width=340
		CDownVar.optCDs.bend=true
		CDownVar.optCDs.back=false
		CDownVar.optCDs.bar_maxCDCount=6
		CDownVar.optCDs.hpte=true
		CDownVar.optCDs.tfont=CDownVar.font
		if(CDownVar.font>1)
		then
			CDownVar.optCDs.nfont=CDownVar.font-1
		else
			CDownVar.optCDs.nfont=CDownVar.font
		end
		CDownVar.font=nil

		CDownVar.color = 1
		CDownVar.CP = { 255, 210, 0 }
		CDownVar.CPA = { }
	end
end

local ValidOrderingValueTypes =
{
	["number"]  = true,
	["string"]  = true,
	["wstring"] = true,
	["boolean"] = true
}

function CDown.Sort(table1, table2, sortKey, sortKeys)
	local value1		= table1[sortKey]
	local value2		= table2[sortKey]

	if (value1 == value2)
	then
		local fallback = sortKeys[sortKey].fallback

		if(fallback)
		then
			return CDown.Sort(table1, table2, fallback, sortKeys)
		end
	else
		if (sortKeys[sortKey].sortOrder == DataUtils.SORT_ORDER_UP)
		then
			return value1 < value2
		end

		return value1 > value2
	end

	return false
end
