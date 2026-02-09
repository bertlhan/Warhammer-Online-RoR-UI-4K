if not AggroMeter then AggroMeter = {} end
if not AggroMeter.Settings then AggroMeter.Settings = {} end

-- LUA locals for performance
local pairs = pairs
local ipairs = ipairs
local tostring = tostring
local tonumber = tonumber
local towstring = towstring
local string_find = string.find
local StringSplit = StringSplit

local format_clock = TimeUtils.FormatClock

local TextLogGetNumEntries = TextLogGetNumEntries
local TextLogGetEntry = TextLogGetEntry

local LabelSetText = LabelSetText
local LabelSetTextColor = LabelSetTextColor
local StatusBarSetBackgroundTint = StatusBarSetBackgroundTint
local StatusBarSetMaximumValue = StatusBarSetMaximumValue

local DestroyWindow = DestroyWindow
local CreateWindowFromTemplate = CreateWindowFromTemplate
local DoesWindowExist = DoesWindowExist
local WindowStartAlphaAnimation = WindowStartAlphaAnimation
local WindowSetShowing = WindowSetShowing
local WindowClearAnchors = WindowClearAnchors
local WindowSetDimensions = WindowSetDimensions
local WindowGetParent = WindowGetParent
local WindowSetGameActionData = WindowSetGameActionData
local WindowGetDimensions = WindowGetDimensions
local WindowGetShowing = WindowGetShowing
local WindowAddAnchor = WindowAddAnchor
local WindowStartAlphaAnimation = WindowStartAlphaAnimation
local CircleImageSetTexture = CircleImageSetTexture
local GetIconData = GetIconData

local Version = "1.1"
local PlayerName;
local parsingEnabled = true;

local function Print(str)
	EA_ChatWindow.Print(towstring(str));
end

function AggroMeter.Initialize()

	PlayerName = wstring.sub(GameData.Player.name,1,-3);

	AggroMeter.HideChannel(65);

	AggroMeter.PlayersAggro = {}
	AggroMeter.AggroHolder = {}
	AggroMeter.MobID = {}
	AggroMeter.MobName = {}
	AggroMeter.MobRank	= {}
	AggroMeter.MaxAggro = {}
	AggroMeter.Timers = {}
	AggroMeter.Stacks = {}
	AggroMeter.CombatTime = {}
	AggroMeter.Fader = {}
	
	if (AggroMeter.Settings.Style == nil) then AggroMeter.Settings.Style = 2 end
	if (AggroMeter.Settings.ShowRank == nil) then AggroMeter.Settings.ShowRank = {false,true,true} end

 --[[ 	
	if (not AggroMeter.Settings.ShowOutOfCombat) then AggroMeter.Settings.ShowOutOfCombat = false; end

	if (AggroMeter.Settings.ParsingEnabled == nil) then AggroMeter.Settings.ParsingEnabled = true; end
	parsingEnabled = AggroMeter.Settings.ParsingEnabled;
]]--	

	AggroMeter.Settings.ParsingEnabled = false;
	parsingEnabled = AggroMeter.Settings.ParsingEnabled;

	
	if (DoesWindowExist("AggroMeter_Button") == false) then
		CreateWindow("AggroMeter_Button", false);
	end
	
	WindowSetShowing("AggroMeter_Button", parsingEnabled);
	
	RegisterEventHandler(TextLogGetUpdateEventId("Chat"), "AggroMeter.OnChatLogUpdated");
	
	if LibSlash then
		LibSlash.RegisterSlashCmd("aggro", function(args) AggroMeter.SlashCmd(args) end);
	end	
	
	Print("<LINK data=\"0\" text=\"[AggroMeter]\" color=\"50,255,10\"> Addon initialized.");
	
end

function AggroMeter.SlashCmd(args)

	local command;
	local parameter;	
	if string.find(args," ") then
		command = string.sub(args,0,string.find(args," ")-1);
		parameter = string.sub(args,string.find(args," ")+1,-1);
	else
		command = args;
	end
	
	if command == "" then AggroMeter.ToggleParsing();
	else Print("<LINK data=\"0\" text=\"[AggroMeter]\" color=\"255,50,50\"> Unknown command.");
	end
	
end

function AggroMeter.Shutdown()
	--UnregisterEventHandler(TextLogGetUpdateEventId("Chat"), "AggroMeter.OnChatLogUpdated");
end

local TIME_DELAY = 0.02
local timeLeft = TIME_DELAY

function AggroMeter.OnUpdate(timeElapsed)

	if (parsingEnabled ~= true) then return end	
	--if (GameData.Player.inCombat == false) then return end	
	
	timeLeft = timeLeft - timeElapsed
    if (timeLeft > 0) then
        return
    end

	for k,v in pairs(AggroMeter.Timers) do
	
		LabelSetText("AggroMeterWindow"..k.."CombatLabel",towstring(TimeUtils.FormatClock(AggroMeter.CombatTime[k])))	
		
		AggroMeter.Timers[k] = v - timeElapsed
		AggroMeter.CombatTime[k] = AggroMeter.CombatTime[k] + timeElapsed
		
		if (v <= 0.6) and (AggroMeter.Fader[k] == false) then
			AggroMeter.Fader[k] = true
			WindowStartAlphaAnimation("AggroMeterWindow"..k, 3, 1.0, 0.0, 0.6, true, 0, 0 )
		end
		
		if (v <= 0) or (AggroMeter.Settings.ShowRank[tonumber(AggroMeter.MobRank[k])] == false) then
			DestroyWindow( "AggroMeterWindow"..k )
			AggroMeter.Timers[k] = nil
			AggroMeter.Stacks[k] = nil	
			AggroMeter.CombatTime[k] = nil	
			AggroMeter.Fader[k] = nil			
		end
		
	end
end

function AggroMeter.OnChatLogUpdated(updateType, filterType)
	
	if (parsingEnabled ~= true) then return end

	if (updateType ~= SystemData.TextLogUpdate.ADDED ) then return end	
	if (filterType ~= SystemData.ChatLogFilters.CHANNEL_9) then	return end

	local _, filterId, text = TextLogGetEntry( "Chat", TextLogGetNumEntries("Chat") - 1 ) 
	text = tostring(text);
	
	if string_find(text,"NPC_AGGRO") then 
		AggroMeter.SplitText(text);
	end
	
end

function AggroMeter.SplitText(text)

	if (parsingEnabled ~= true) then return end
	
	if ((AggroMeter.Settings.ShowOutOfCombat == false) and (GameData.Player.inCombat == false)) then return end
	if not text then return end
	
	text = tostring(text)
	
	xListSplit = StringSplit(text, ";")
	xListSplit[#xListSplit] = nil
	local MobID = tostring(xListSplit[2])
	local MobRank = tostring(xListSplit[3])	
	local MobName = tostring(xListSplit[4])
	if AggroMeter.Settings.ShowRank[tonumber(MobRank)] == true then
		
		if (DoesWindowExist("AggroMeterWindow"..MobID) == false) then
			CreateWindowFromTemplate("AggroMeterWindow"..MobID, "AggroMeterWindow", "Root")
			WindowStartAlphaAnimation("AggroMeterWindow"..MobID, Window.AnimationType.SINGLE_NO_RESET, 0, 1, 0.5, false, 0, 0)
			for i=1,6 do	
				
				local LabelW,LabelH = WindowGetDimensions("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText")			
				WindowSetDimensions("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText",100,LabelH)
				LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label",L"Aggro"..towstring(i))					
				DynamicImageSetTexture("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Tactic","icon022709",0,0)		
				StatusBarSetMaximumValue("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBar", 100 )
				StatusBarSetForegroundTint( "AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBar", DefaultColor.GREEN.r, DefaultColor.GREEN.g, DefaultColor.GREEN.b )
				StatusBarSetBackgroundTint( "AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBar", DefaultColor.BLACK.r, DefaultColor.BLACK.g, DefaultColor.BLACK.b )	
				LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText",L"")	
			end	
			LabelSetText("AggroMeterWindow"..MobID.."NameLabel",L"MobName "..towstring(MobID))
			AggroMeter.Stacks[MobID] = 1
			AggroMeter.CombatTime[MobID] = 0
		end
		
		AggroMeter.MobID[MobID] = tostring(xListSplit[2])	
		AggroMeter.MobRank[MobID] = tostring(xListSplit[3])	
		AggroMeter.MobName[MobID] = tostring(xListSplit[4])	
		AggroMeter.PlayersAggro[MobID] = (#xListSplit-4)/4
		AggroMeter.AggroHolder[MobID] = {}
		AggroMeter.Fader[MobID] = false
		
		for i=1,6 do
			LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label",L"")
			WindowSetShowing("AggroMeterWindow"..MobID.."_AggroWindow"..i,false)	
		end
		
		AggroMeter.MaxAggro[MobID] = 0
		
		for i=1,(AggroMeter.PlayersAggro[MobID]) do
			AggroMeter.AggroHolder[MobID][i] = {}
			AggroMeter.AggroHolder[MobID][i].name = tostring(xListSplit[(1+(i*4))])
			AggroMeter.AggroHolder[MobID][i].aggro = tonumber(xListSplit[(2+(i*4))])
			AggroMeter.AggroHolder[MobID][i].tactic = tonumber(xListSplit[(3+(i*4))])	
			AggroMeter.AggroHolder[MobID][i].career = tonumber(xListSplit[(4+(i*4))])				
			AggroMeter.MaxAggro[MobID] = AggroMeter.AggroHolder[MobID][1].aggro
		end
		
		for i=1,(AggroMeter.PlayersAggro[MobID]) do
		
			--if (i > 3) then break; end
		
			LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label",towstring(AggroMeter.AggroHolder[MobID][i].name))	
			StatusBarSetForegroundTint( "AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBar", 255*(((AggroMeter.AggroHolder[MobID][i].aggro/AggroMeter.MaxAggro[MobID])*100)/100), 255*(1-(((AggroMeter.AggroHolder[MobID][i].aggro/AggroMeter.MaxAggro[MobID])*100)/100)), 0)
			StatusBarSetCurrentValue("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBar", (AggroMeter.AggroHolder[MobID][i].aggro/AggroMeter.MaxAggro[MobID])*100 )
			
			if towstring(AggroMeter.AggroHolder[MobID][i].name) == PlayerName then
				LabelSetTextColor("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label", 0, 250, 100)
			else
				LabelSetTextColor("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label", 255, 255, 77)
			end
			
			if AggroMeter.Settings.Style == 1 then
				if	AggroMeter.AggroHolder[MobID][i].aggro > 0 then
					LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText",wstring.format(L"%.01f",(AggroMeter.AggroHolder[MobID][i].aggro/AggroMeter.MaxAggro[MobID])*100)..L"%")
				else
					LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText",L"0%")
				end
			else
				LabelSetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."TimerBarText",towstring(AggroMeter.AggroHolder[MobID][i].aggro))
			end
			
			WindowSetShowing("AggroMeterWindow"..MobID.."_AggroWindow"..i,true)	
			WindowSetShowing("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Tactic",AggroMeter.AggroHolder[MobID][i].tactic > 0)	
			WindowSetShowing("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Timer",(LabelGetText("AggroMeterWindow"..MobID.."_AggroWindow"..i.."Label") ~= ""))
			
			local txtr, x, y, disabledTexture = GetIconData(Icons.GetCareerIconIDFromCareerLine(tonumber(AggroMeter.AggroHolder[MobID][i].career)))	
			CircleImageSetTexture("AggroMeterWindow"..MobID.."_AggroWindow"..i.."ButtonIcon",txtr, 16, 16)
			
		end
		
		LabelSetText("AggroMeterWindow"..MobID.."NameLabel",towstring(AggroMeter.MobName[MobID]))	
		AggroMeter.Timers[MobID] = 3
		WindowSetDimensions("AggroMeterWindow"..MobID,310,45+(30*AggroMeter.PlayersAggro[MobID]))		

		local StackHeight = 33
		for k,v in pairs(AggroMeter.Stacks) do
			local width,height = WindowGetDimensions("AggroMeterWindow"..k)
			WindowClearAnchors("AggroMeterWindow"..k)
			WindowAddAnchor("AggroMeterWindow"..k, "topright", "AggroMeter_Button", "topright",0,StackHeight)		
			StackHeight = StackHeight + (height+5)
		end
		
	end
end

function AggroMeter.OnMouseOverStart()

	local WinParent = WindowGetParent(SystemData.MouseOverWindow.name)
	local WindowName = towstring(SystemData.MouseOverWindow.name)
	
	if WindowName:match(L"Timer") then
		local MobNumber = 	tostring(WindowName:match(L"AggroMeterWindow([%d.]+)."))
		local TimerNumber = tonumber(WindowName:match(L"_AggroWindow([^%.]+)Timer"))
		local Ttip = L""
		Tooltips.CreateTextOnlyTooltip(SystemData.MouseOverWindow.name,nil)
		Tooltips.SetTooltipText( 1, 1,towstring(AggroMeter.AggroHolder[tostring(MobNumber)][tonumber(TimerNumber)].name))
		Tooltips.SetTooltipColorDef( 1, 1, Tooltips.MAP_DESC_TEXT_COLOR )
		if AggroMeter.AggroHolder[tostring(MobNumber)][tonumber(TimerNumber)].aggro > 0 then
			Ttip = wstring.format(L"%.01f",(AggroMeter.AggroHolder[tostring(MobNumber)][tonumber(TimerNumber)].aggro/AggroMeter.MaxAggro[tostring(MobNumber)])*100)..L"%"
		else
			Ttip = L"0%"
		end
		Tooltips.SetTooltipText( 1, 3, Ttip)
		Tooltips.SetTooltipText( 2, 1, L"Hatred: "..towstring(AggroMeter.AggroHolder[tostring(MobNumber)][TimerNumber].aggro)..L" / "..towstring(AggroMeter.MaxAggro[tostring(MobNumber)]))		
	elseif WindowName:match(L"Tactic") then
		local MobNumber = 	tostring(WindowName:match(L"AggroMeterWindow([%d.]+)."))
		local TacticNumber = tonumber(WindowName:match(L"_AggroWindow([^%.]+)Tactic"))
		Tooltips.CreateTextOnlyTooltip(SystemData.MouseOverWindow.name,nil)
		Tooltips.SetTooltipText( 1, 1,L"This player is using "..towstring(GetAbilityName(tonumber(AggroMeter.AggroHolder[tostring(MobNumber)][tonumber(TacticNumber)].tactic)))..L" Tactic")
		Tooltips.SetTooltipColorDef( 1, 1, Tooltips.MAP_DESC_TEXT_COLOR )
	elseif WindowName:match(L"AggroMeter_Button") then
		Tooltips.CreateTextOnlyTooltip(SystemData.MouseOverWindow.name,nil)
		Tooltips.SetTooltipText( 1, 1,L"AggroMeter")
		Tooltips.SetTooltipColorDef( 1, 1, Tooltips.MAP_DESC_TEXT_COLOR )
		Tooltips.SetTooltipText( 1, 3, L"Ver: "..towstring(Version))
		Tooltips.SetTooltipText( 2, 1, L"Run /aggro to hide");
	end
	
	Tooltips.Finalize() 
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	
end

function AggroMeter.SelectChar()
	local WinParent = WindowGetParent(SystemData.MouseOverWindow.name)
	local WindowName = towstring(SystemData.MouseOverWindow.name)
	local MobNumber = 	tostring(WindowName:match(L"AggroMeterWindow([%d.]+)."))
	local LabelNumber = tonumber(WindowName:match(L"_AggroWindow([^%.]+)Label"))
	
	WindowSetGameActionData(tostring(WindowName),GameData.PlayerActions.SET_TARGET,0,towstring(AggroMeter.AggroHolder[tostring(MobNumber)][tonumber(LabelNumber)].name))	
end

function AggroMeter.OnTabRBU()
	
	local function MakeCallBack( SelectedOption )
		return function() AggroMeter.ToggleShow(SelectedOption) end
	end
	
	EA_Window_ContextMenu.CreateContextMenu( SystemData.MouseOverWindow.name, EA_Window_ContextMenu.CONTEXT_MENU_1,L"Options")
	EA_Window_ContextMenu.AddMenuDivider( EA_Window_ContextMenu.CONTEXT_MENU_1 )	
	if AggroMeter.Enabled == true then 
		EA_Window_ContextMenu.AddMenuItem( L"<icon00057> Enabled" , AggroMeter.ToggeEnable, false, true )
	else
		EA_Window_ContextMenu.AddMenuItem( L"<icon00058> Disabled" , AggroMeter.ToggeEnable, false, true )
	end
	
	if AggroMeter.Settings.ShowRank[1] == true then
		EA_Window_ContextMenu.AddMenuItem( L" <icon00057> Champions" , MakeCallBack(1), not AggroMeter.Enabled, true )	
	else
		EA_Window_ContextMenu.AddMenuItem( L" <icon00058> Champions" , MakeCallBack(1), not AggroMeter.Enabled, true )	
	end
	
	if AggroMeter.Settings.ShowRank[2] == true then
		EA_Window_ContextMenu.AddMenuItem( L" <icon00057> Heroes" , MakeCallBack(2), not AggroMeter.Enabled, true )	
	else
		EA_Window_ContextMenu.AddMenuItem( L" <icon00058> Heroes" , MakeCallBack(2), not AggroMeter.Enabled, true )	
	end	
	
	if AggroMeter.Settings.ShowRank[3] == true then
		EA_Window_ContextMenu.AddMenuItem( L" <icon00057> Lords" , MakeCallBack(3), not AggroMeter.Enabled, true )	
	else
		EA_Window_ContextMenu.AddMenuItem( L" <icon00058> Lords" , MakeCallBack(3), not AggroMeter.Enabled, true )	
	end
	
	EA_Window_ContextMenu.AddMenuDivider( EA_Window_ContextMenu.CONTEXT_MENU_1 )
	
	if AggroMeter.Settings.Style == 1 then
		EA_Window_ContextMenu.AddMenuItem( L"Aggro by percentage" , AggroMeter.ToggeBar, false, true )	
	else
		EA_Window_ContextMenu.AddMenuItem( L"Aggro by value" , AggroMeter.ToggeBar, false, true )	
	end
	
	--[[ 
	if (AggroMeter.Settings.ShowAnchor == true) then
		--EA_Window_ContextMenu.AddMenuItem( L"Hide anchor" , AggroMeter.ToggleAnchor, false, true)
	else
		--EA_Window_ContextMenu.AddMenuItem( L"Show anchor" , AggroMeter.ToggleAnchor, false, true)
	end
	]]--
	
	if (AggroMeter.Settings.ShowOutOfCombat == true) then
		--EA_Window_ContextMenu.AddMenuItem( L"Hide out of combat" , AggroMeter.ToggleCombat, false, true)
	else
		--EA_Window_ContextMenu.AddMenuItem( L"Show out of combat" , AggroMeter.ToggleCombat, false, true)
	end	
	
	EA_Window_ContextMenu.Finalize()	
end

function AggroMeter.ToggleCombat()
	AggroMeter.Settings.ShowOutOfCombat = not AggroMeter.Settings.ShowOutOfCombat
	--AggroMeter.OnTabRBU()
end

function AggroMeter.ToggleAnchor()
	--AggroMeter.Settings.ShowAnchor = not AggroMeter.Settings.ShowAnchor
	--WindowSetShowing("AggroMeter_Button", AggroMeter.Settings.ShowAnchor)
	--AggroMeter.OnTabRBU()
end

function AggroMeter.ToggeEnable()
	parsingEnabled = not parsingEnabled;
	--AggroMeter.OnTabRBU()
end

function AggroMeter.ToggleParsing()

	

	if (parsingEnabled == true) then
	
		parsingEnabled = false;
		WindowSetShowing("AggroMeter_Button", false);
		AggroMeter.Settings.ShowAnchor = false;
		AggroMeter.Settings.ParsingEnabled = false
		
		for mobId, v in pairs(AggroMeter.Stacks) do
			local windowName = "AggroMeterWindow"..mobId;
			if (DoesWindowExist(windowName) == true) then
				WindowSetShowing(windowName, false);
			end
		end	
	
	elseif (parsingEnabled == false) then
	
		parsingEnabled = true;
		WindowSetShowing("AggroMeter_Button", true);
		AggroMeter.Settings.ShowAnchor = true;
		AggroMeter.Settings.ParsingEnabled = true;
		
	end
	
end

function AggroMeter.ToggeBar()
	if AggroMeter.Settings.Style == 1 then 
		AggroMeter.Settings.Style = 2 
	else 
		AggroMeter.Settings.Style = 1 
	end
end

function AggroMeter.ToggleShow(SelectedOption)
	SelectedOption = tonumber(SelectedOption)
	AggroMeter.Settings.ShowRank[SelectedOption] = not AggroMeter.Settings.ShowRank[SelectedOption]	
end

function AggroMeter.HideChannel(channelId)
	for _, wndGroup in ipairs(EA_ChatWindowGroups) do 
		if wndGroup.used == true then
			for tabId, tab in ipairs(wndGroup.Tabs) do
				local tabName = EA_ChatTabManager.GetTabName( tab.tabManagerId )		
				if tabName then
					if tab.tabText ~= L"Debug" then
						LogDisplaySetFilterState(tabName.."TextLog", "Chat", channelId, false)
					else
						LogDisplaySetFilterState(tabName.."TextLog", "Chat", channelId, true)
						LogDisplaySetFilterColor(tabName.."TextLog", "Chat", channelId, 168, 187, 160 )
					end
				end
			end
		end
	end
end


