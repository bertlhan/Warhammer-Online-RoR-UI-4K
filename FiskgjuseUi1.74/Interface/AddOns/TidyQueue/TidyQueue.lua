


-----------------------------------
-- Global variables
-----------------------------------

if( not TidyQueue ) then
	TidyQueue = {}
end

TidyQueue.dVersion = L"1.5"

-----------------------------------
-- Local variables
-----------------------------------

local c_DELAY = 4
local c_MAX_SCENARIOS = #GameData.ScenarioQueueData

local c_TIDY_QUEUE_WINDOW		= "TidyQueue"
local c_TIDY_QUEUE_TIMER_WINDOW = "TidyQueueTimer"

local c_MAIN_WIDTH = 200
local c_TOP_HEIGHT = 95
local c_BOTTOM_HEIGHT = 55
local c_CHECKBOX_HEIGHT = 28


local TidyQueue = TidyQueue

local pairs = pairs
local ipairs = ipairs
local tinsert = table.insert
local tremove = table.remove

-- Settings
local TidyQueueData
local setting_autojoin		= false

local ScenarioQueueData		= GameData.ScenarioQueueData
local GetScenarioQueueData	= GetScenarioQueueData
local GetScenarioName		= GetScenarioName
local BroadcastEvent		= BroadcastEvent
local WindowSetShowing		= WindowSetShowing
local SystemData			= SystemData

local rVersion = 6

local firstLoad			= true
local timeCount			= c_DELAY
local tqueue_debug		= false

local queuedScenarioData

local modeLeave = false
local modeJoin	= false

local joinQueue = {}

-- HOOKS
local TidyQueueHooks = {}


-----------------------------------
-- End Local variables
-----------------------------------





-----------------------------------
-- Body
-----------------------------------

local function IsAlreadyQueued(id)
	if( queuedScenarioData ) then
		
		for _, scenarioData in ipairs(queuedScenarioData) do
			
			if( scenarioData.id == id ) then
				return true
			end
		end
	end
	
	return false
end


local function SetWorking(flag)
	timeCount = c_DELAY
	WindowSetShowing(c_TIDY_QUEUE_TIMER_WINDOW, flag)
end


local function ForceStopWork()
	if( tqueue_debug ) then DEBUG(L"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! FORCED STOPING WORK !!!!!!!!!!!!!!!!!!!!!!") end
	
	SetWorking(false)
	modeJoin = false
	modeLeave = false
	if( joinQueue[1] ) then joinQueue = {} end
	
	WindowSetShowing("EA_Window_ScenarioJoinPrompt", false)
	WindowSetShowing("EA_Window_ScenarioStarting", false)
end




function TidyQueue.OnUpdate( timePassed )
	timeCount = timeCount - timePassed
	
	if( timeCount < 0 ) then
		ForceStopWork()
	end
	
	if( WindowGetShowing("EA_Window_ScenarioJoinPrompt") ) then
		if (ButtonGetDisabledFlag("EA_Window_ScenarioJoinPromptBoxJoinWaitButton") == false 
			and (EA_Window_ScenarioLobby.autoCancelTime > 0 and EA_Window_ScenarioLobby.autoCancelTime < 5) 
			and setting_autojoin and GetAFKFlag() == false) then 
			
			EA_Window_ScenarioLobby.OnJoinInstanceWait()
		end
	end
end


function TidyQueue.ShowScenarioQueueList()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.ShowScenarioQueueList") end
	
	TidyQueue.ResetWindow()
	WindowSetShowing(c_TIDY_QUEUE_WINDOW, ScenarioQueueData[1].id ~= 0)
end


function TidyQueue.OnHidden()
	WindowUtils.OnHidden()
	WindowSetShowing(c_TIDY_QUEUE_WINDOW, false)
end


function TidyQueue.UpdateScenarioQueueData()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.UpdateScenarioQueueData") end
	
	queuedScenarioData = GetScenarioQueueData()
	
	TidyQueue.DoTask()
end


function TidyQueue.JoinPromptShowed()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.JoinPromptShowed") end
	
	timeCount = 130
	WindowSetShowing(c_TIDY_QUEUE_TIMER_WINDOW, true)
end


function TidyQueue.DoTask()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.DoTask") end
		
	if( WindowGetShowing("EA_Window_ScenarioJoinPrompt") or WindowGetShowing("EA_Window_ScenarioStarting") ) then
		modeJoin = false
		modeLeave = false
		if( joinQueue[1] ) then joinQueue = {} end
		
		return
    end
    
    
    if( modeLeave ) then
		if( queuedScenarioData ) then
			SetWorking(true)
			
			EA_ChatWindow.Print( GetStringFormat( StringTables.Default.TEXT_LEAVE_SCENARIO, {GetScenarioName(queuedScenarioData[1].id)} ) )
			ScenarioQueueData.selectedId = queuedScenarioData[1].id
			BroadcastEvent( SystemData.Events.INTERACT_LEAVE_SCENARIO_QUEUE )
		else
			modeLeave = false
			SetWorking(false)
			
			if( tqueue_debug ) then DEBUG(L"Leave done... 1 repeat") end
			TidyQueue.DoTask()
		end
		
	elseif( modeJoin ) then
		local len = #joinQueue
		
		if( len > 0 ) then
			local id = joinQueue[len]
			tremove(joinQueue, len)
			
			if( not IsAlreadyQueued(id) ) then
				SetWorking(true)
			
				ScenarioQueueData.selectedId = id
				BroadcastEvent(EA_Window_ScenarioLobby.joinModes[EA_Window_ScenarioLobby.joinMode].joinSingleEvent)
			else
				if( tqueue_debug ) then DEBUG(L"Already Queued... repeat") end
				TidyQueue.DoTask()
			end
			
		else
			if( tqueue_debug ) then DEBUG(L"Join done.. stop") end
			modeJoin = false
			SetWorking(false)
		end
		
	end
end


function TidyQueue.LeaveAllScenarios()
	local startWork = (not modeLeave) and (not modeJoin)
	
	modeJoin = false
	if( joinQueue[1] ) then joinQueue = {} end
	
	modeLeave = true
	if( startWork ) then
		if( tqueue_debug ) then DEBUG(L"Start Work") end
		TidyQueue.DoTask()
	end
end


function TidyQueue.JoinSelectedScenarios()
	if( joinQueue[1] ) then
		local startWork = (not modeLeave) and (not modeJoin)
		
		modeJoin = true
		if( startWork ) then
			if( tqueue_debug ) then DEBUG(L"Start Work") end
			TidyQueue.DoTask()
		end
	end
end


function TidyQueue.OnLoad()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.OnLoad") end
		
	if( firstLoad ) then
		firstLoad = false
		
		-- HOOKS
		TidyQueueHooks.SetupHooks()
	end
	-- end firstLoad
end


function TidyQueue.Initialize()
	TidyQueue.Settings					= TidyQueue.Settings or {}
	TidyQueue.Settings.TidyQueueData	= TidyQueue.Settings.TidyQueueData or {}
	TidyQueue.Settings.rVersion			= rVersion
	TidyQueueData						= TidyQueue.Settings.TidyQueueData
	
	if( type(TidyQueue.Settings.autojoin) == type(setting_autojoin) ) then
		setting_autojoin = TidyQueue.Settings.autojoin
	else
		TidyQueue.Settings.autojoin = setting_autojoin
	end
	
	
	TidyQueue.CreateWindow()
	
	WindowUnregisterCoreEventHandler("EA_Window_ScenarioLobby", "OnHidden")
	WindowRegisterCoreEventHandler("EA_Window_ScenarioLobby", "OnHidden", "TidyQueue.OnHidden")
	
	RegisterEventHandler( SystemData.Events.INTERACT_SHOW_SCENARIO_QUEUE_LIST,  "TidyQueue.ShowScenarioQueueList" )
	RegisterEventHandler( SystemData.Events.SCENARIO_ACTIVE_QUEUE_UPDATED,  "TidyQueue.UpdateScenarioQueueData" )
	RegisterEventHandler( SystemData.Events.INTERACT_UPDATED_SCENARIO_QUEUE_LIST,  "TidyQueue.ResetWindow" )
	RegisterEventHandler( SystemData.Events.SCENARIO_SHOW_JOIN_PROMPT,   "TidyQueue.JoinPromptShowed" )
	
	RegisterEventHandler( SystemData.Events.LOADING_END,  "TidyQueue.OnLoad")
	RegisterEventHandler( SystemData.Events.RELOAD_INTERFACE,  "TidyQueue.OnLoad")
	
	TidyQueue.UpdateScenarioQueueData()
	TidyQueue.ResetWindow()
end


-----------------------------------
-- end Body
-----------------------------------





-----------------------------------
-- Hooks
-----------------------------------
do


local function JoinQueueHook(func, ...)
	local flags = ...
	
	if( flags ~= 0 ) then
		TidyQueue.OnJoinSelected()
		return
	end
	
	func(...)
end


local function AddLeaveAllButton()
	if( queuedScenarioData ) then
		EA_Window_ContextMenu.AddMenuItem( GetStringFormat( StringTables.Default.TEXT_LEAVE_SCENARIO, { L"All Scenarios" } ), TidyQueue.LeaveAllScenarios, false, true )
		EA_Window_ContextMenu.Finalize()
	end
end


local function ListQueueHooks(func, ...)
	local flags = ...
	
	if( flags ~= 0 ) then
		TidyQueue.LeaveAllScenarios()
		return
	end
	
	func(...)
	
	AddLeaveAllButton()
end






function TidyQueueHooks.SetupHooks()
	if( DoesWindowExist("EA_Window_OverheadMapMapScenarioQueue") ) then
		TidyQueueHooks.oldOnScenarioQueueLButtonUp				= EA_Window_OverheadMap.OnScenarioQueueLButtonUp
		EA_Window_OverheadMap.OnScenarioQueueLButtonUp			= TidyQueueHooks.OnScenarioQueueLButtonUpHook
		
		TidyQueueHooks.oldOnScenarioQueueRButtonUp				= EA_Window_OverheadMap.OnScenarioQueueRButtonUp
		EA_Window_OverheadMap.OnScenarioQueueRButtonUp			= TidyQueueHooks.OnScenarioQueueRButtonUpHook
	end
	
	if( DoesWindowExist("CMapWindowMapScenarioQueue") ) then
		TidyQueueHooks.oldCMapWindow_OnScenarioQueueLButtonUp	= CMapWindow.OnScenarioQueueLButtonUp
		CMapWindow.OnScenarioQueueLButtonUp						= TidyQueueHooks.CMapWindow_OnScenarioQueueLButtonUpHook
		
		TidyQueueHooks.oldCMapWindow_OnScenarioQueueRButtonUp	= CMapWindow.OnScenarioQueueRButtonUp
		CMapWindow.OnScenarioQueueRButtonUp						= TidyQueueHooks.CMapWindow_OnScenarioQueueRButtonUpHook
	end
	
	if( DoesWindowExist("MinmapMapScenarioQueue") ) then
		TidyQueueHooks.oldMinmap_OnScenarioQueueLButtonUp		= Minmap.OnScenarioQueueLButtonUp
		Minmap.OnScenarioQueueLButtonUp							= TidyQueueHooks.Minmap_OnScenarioQueueLButtonUpHook
		
		TidyQueueHooks.oldMinmap_OnMouseoverScenarioQueue		= Minmap.OnMouseoverScenarioQueue
		Minmap.OnMouseoverScenarioQueue							= TidyQueueHooks.Minmap_OnMouseoverScenarioQueueHook
		
		TidyQueueHooks.oldMinmap_ToggleFilterMenu				= Minmap.ToggleFilterMenu
		Minmap.ToggleFilterMenu									= TidyQueueHooks.Minmap_ToggleFilterMenuHook
	end
end

-- EA_Window_OverheadMap
function TidyQueueHooks.OnScenarioQueueLButtonUpHook(...)
	JoinQueueHook(TidyQueueHooks.oldOnScenarioQueueLButtonUp, ...)
end


function TidyQueueHooks.OnScenarioQueueRButtonUpHook(...)
	ListQueueHooks(TidyQueueHooks.oldOnScenarioQueueRButtonUp, ...)
end

-- CMapWindow
function TidyQueueHooks.CMapWindow_OnScenarioQueueLButtonUpHook(...)
	JoinQueueHook(TidyQueueHooks.oldCMapWindow_OnScenarioQueueLButtonUp, ...)
end


function TidyQueueHooks.CMapWindow_OnScenarioQueueRButtonUpHook(...)
	ListQueueHooks(TidyQueueHooks.oldCMapWindow_OnScenarioQueueRButtonUp, ...)
end

-- Minmap
function TidyQueueHooks.Minmap_OnScenarioQueueLButtonUpHook(...)
	JoinQueueHook(TidyQueueHooks.oldMinmap_OnScenarioQueueLButtonUp, ...)
end


function TidyQueueHooks.Minmap_OnMouseoverScenarioQueueHook(...)
	TidyQueueHooks.oldMinmap_OnMouseoverScenarioQueue(...)
	AddLeaveAllButton()
end


function TidyQueueHooks.Minmap_ToggleFilterMenuHook(...)
	local flags = ...
	
	if( flags ~= 0 ) then
		TidyQueue.LeaveAllScenarios()
		return
	end

	TidyQueueHooks.oldMinmap_ToggleFilterMenu(...)
end


end
-----------------------------------
-- end Hooks
-----------------------------------





-----------------------------------
-- GUI
-----------------------------------

local function MassSetPressedFlag(pressedFlag)
	for index = 1, c_MAX_SCENARIOS do
		local checkboxName = c_TIDY_QUEUE_WINDOW .. "Checkbox" .. index
		
		if( WindowGetShowing(checkboxName) ) then
			TidyQueueData[ScenarioQueueData[index].id] = pressedFlag
			ButtonSetPressedFlag(checkboxName .. "Button", pressedFlag)
		end
	end
end


function TidyQueue.OnScenarioQueueLButtonUpHook(...)
	local flags = ...
	
	if( flags == 0 ) then
		oldOnScenarioQueueLButtonUp(...)
	else
		TidyQueue.OnJoinSelected()
	end
end


function TidyQueue.OnScenarioQueueRButtonUpHook(...)
	local flags = ...
	
	if( flags ~= 0 ) then
		TidyQueue.LeaveAllScenarios()
		return
	end
	
	oldOnScenarioQueueRButtonUp(...)
	
	if( queuedScenarioData ) then
		EA_Window_ContextMenu.AddMenuItem( GetStringFormat( StringTables.Default.TEXT_LEAVE_SCENARIO, { L"All Scenarios" } ), TidyQueue.LeaveAllScenarios, false, true )
		EA_Window_ContextMenu.Finalize()
	end
end


function TidyQueue.OnSelectAll()
	MassSetPressedFlag(true)
end


function TidyQueue.OnSelectNone()
	MassSetPressedFlag(false)
end


function TidyQueue.OnAutojoinLBU()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.OnAutojoinLBU") end
	
	local checkboxName	= SystemData.MouseOverWindow.name .. "Button"
	local newState		= not ButtonGetPressedFlag(checkboxName)
	
	setting_autojoin				= newState
	TidyQueue.Settings.autojoin		= newState
	
	ButtonSetPressedFlag(checkboxName, newState)
end


function TidyQueue.OnCheckboxLBU()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.OnCheckboxLBU") end
	
	local checkboxName = SystemData.MouseOverWindow.name .. "Button"
	local windowId = WindowGetId(SystemData.MouseOverWindow.name)
	local newState = not ButtonGetPressedFlag(checkboxName)
	
	TidyQueueData[ScenarioQueueData[windowId].id] = newState
	
	ButtonSetPressedFlag(checkboxName, newState)	
end


function TidyQueue.OnCheckboxRBU()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.OnCheckboxRBU") end
	
	local windowId = WindowGetId(SystemData.MouseOverWindow.name)
	local id = ScenarioQueueData[windowId].id
	
	if( id ~= 0 ) then
		tinsert(joinQueue, 1, id)
	end
	
	TidyQueue.JoinSelectedScenarios()
end


function TidyQueue.OnJoinSelected()
	for index, scenarioData in ipairs(ScenarioQueueData) do
		if( scenarioData.id ~= 0 ) then
			local id = scenarioData.id
			
			if( TidyQueueData[id] ) then
				tinsert(joinQueue, 1, id)
			end
			
		end
	end
	
	TidyQueue.JoinSelectedScenarios()
	
	if( modeJoin ) then
		WindowSetShowing("EA_Window_ScenarioLobby", false)
	end
end


function TidyQueue.ResetWindow()
	if( tqueue_debug ) then DEBUG(L"TidyQueue.ResetWindow") end
	
	ButtonSetPressedFlag(c_TIDY_QUEUE_WINDOW .. "AutojoinCheckboxButton", setting_autojoin)
	
	local count = 0
	
	for index, scenarioData in ipairs(ScenarioQueueData) do
		local checkboxName = c_TIDY_QUEUE_WINDOW .. "Checkbox" .. index
		local correct = scenarioData.id ~= 0
		
		if( correct ) then
			local id = scenarioData.id
			
			ButtonSetPressedFlag(checkboxName .. "Button", TidyQueueData[id] == true)
			LabelSetText(checkboxName .. "Label", GetScenarioName(id))
			
			count = count + 1
		end
		
		WindowSetShowing(checkboxName, correct)
	end
	
	WindowSetDimensions( c_TIDY_QUEUE_WINDOW, c_MAIN_WIDTH, (c_TOP_HEIGHT + c_BOTTOM_HEIGHT + c_CHECKBOX_HEIGHT * count) )
end


function TidyQueue.CreateWindow()
	CreateWindow(c_TIDY_QUEUE_WINDOW, false)
	CreateWindow(c_TIDY_QUEUE_TIMER_WINDOW, false)
	
	WindowAddAnchor(c_TIDY_QUEUE_WINDOW, "bottomright", "EA_Window_ScenarioLobby", "bottomleft", 0, 0)
	
	WindowSetScale(c_TIDY_QUEUE_WINDOW .. "SelectAll", 0.9 * InterfaceCore.GetScale())
	WindowSetScale(c_TIDY_QUEUE_WINDOW .. "SelectNone", 0.9 * InterfaceCore.GetScale())
	
	LabelSetText(c_TIDY_QUEUE_WINDOW .. "AutojoinCheckboxLabel", L"Autojoin (by pressing 'Wait a minute')")
	ButtonSetText(c_TIDY_QUEUE_WINDOW .. "SelectAll", L"Sel All ")
	ButtonSetText(c_TIDY_QUEUE_WINDOW .. "SelectNone", L"Sel None")
	ButtonSetText(c_TIDY_QUEUE_WINDOW .. "JoinSelected", L"Join Selected")
	
	local anchor = {
		RelativeTo = c_TIDY_QUEUE_WINDOW .. "CheckboxesWindow",
		Point = "top",
		RelativePoint = "top",
		XOffset = 0,
		YOffset = 0,
	}
	
	for index = 1, c_MAX_SCENARIOS do
		local checkboxName = c_TIDY_QUEUE_WINDOW .. "Checkbox" .. index
		
		if( CreateWindowFromTemplate(checkboxName, "TQueueCheckboxTemplate", c_TIDY_QUEUE_WINDOW) ) then
			WindowAddAnchor(checkboxName, anchor.Point, anchor.RelativeTo, anchor.RelativePoint, anchor.XOffset, anchor.YOffset)
			WindowSetId(checkboxName, index)
			
			anchor.RelativeTo = checkboxName
			anchor.Point = "bottom"
		end
	end
end


-----------------------------------
-- end GUI
-----------------------------------


