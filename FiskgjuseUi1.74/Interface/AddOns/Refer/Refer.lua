ReferWindow = {}

local originalShowMenu = nil
local originalAddGroupMenuItems = nil

ReferWindow.Settings = {
    BoxTimer = 120,
}

ReferWindow.References = {}
ReferWindow.NextRefId = 1
ReferWindow.RefCount = 0

ReferWindow.PendingDestruction = {}
ReferWindow.DestructionDelay = {}

function ReferWindow.Initialize()
    d("Refer addon: Initializing...")
    
    originalShowMenu = PlayerMenuWindow.ShowMenu
    originalAddGroupMenuItems = PlayerMenuWindow.AddGroupMenuItems
    
    PlayerMenuWindow.ShowMenu = ReferWindow.ModifiedShowMenu
    PlayerMenuWindow.AddGroupMenuItems = ReferWindow.ModifiedAddGroupMenuItems
    
    RegisterEventHandler(TextLogGetUpdateEventId("Chat"), "ReferWindow.OnChatLogUpdated")
    
    RegisterEventHandler(SystemData.Events.GROUP_UPDATED, "ReferWindow.OnGroupUpdated")
    RegisterEventHandler(SystemData.Events.BATTLEGROUP_UPDATED, "ReferWindow.OnGroupUpdated")
    
    d("Refer addon: Creating button...")
    CreateWindow("ReferList_Button", true)
    
    ReferWindow.LoadSettings()
    
    d("Refer addon: Initialization complete")
end

function ReferWindow.Shutdown()
    UnregisterEventHandler(TextLogGetUpdateEventId("Chat"), "ReferWindow.OnChatLogUpdated")
    UnregisterEventHandler(SystemData.Events.GROUP_UPDATED, "ReferWindow.OnGroupUpdated")
    UnregisterEventHandler(SystemData.Events.BATTLEGROUP_UPDATED, "ReferWindow.OnGroupUpdated")
    
    ReferWindow.SaveSettings()
    
    if originalShowMenu then
        PlayerMenuWindow.ShowMenu = originalShowMenu
    end
    
    if originalAddGroupMenuItems then
        PlayerMenuWindow.AddGroupMenuItems = originalAddGroupMenuItems
    end
end

function ReferWindow.LoadSettings()
    if not ReferWindow.SavedSettings then
        ReferWindow.SavedSettings = {}
        ReferWindow.SavedSettings.BoxTimer = ReferWindow.Settings.BoxTimer
    end
    
    ReferWindow.Settings.BoxTimer = ReferWindow.SavedSettings.BoxTimer
end

function ReferWindow.SaveSettings()
    ReferWindow.SavedSettings = {}
    ReferWindow.SavedSettings.BoxTimer = ReferWindow.Settings.BoxTimer
end

function ReferWindow.IsPlayerInAGroup()
    for i = 1, GroupWindow.MAX_GROUP_MEMBERS do
        if GroupWindow.groupData[i].name ~= L"" and GroupWindow.groupData[i].name ~= GameData.Player.name then
            return true
        end
    end
    
    if IsWarBandActive() then
        return true
    end
    
    return false
end

function ReferWindow.HasInvitePermission()
    if GameData.Player.isGroupLeader then
        return true
    end
    
    if GameData.Player.isWarbandLeader then
        return true
    end
    
    if GameData.Player.isWarbandAssistant then
        return true
    end
    
    return false
end

function ReferWindow.IsPlayerInPlayerGroup(playerName)
    for i = 1, GroupWindow.MAX_GROUP_MEMBERS do
        if GroupWindow.groupData[i].name == playerName then
            return true
        end
    end
    
    if IsWarBandActive() then
        return (PartyUtils.IsPlayerInWarband(playerName) ~= nil)
    end
    
    return false
end

function ReferWindow.ModifiedShowMenu(playerName, playerObjNum, customItems)
    ReferWindow.targetPlayerName = playerName
    
    originalShowMenu(playerName, playerObjNum, customItems)
end

function ReferWindow.ModifiedAddGroupMenuItems(targetSelf)
    local isGroupMember = GroupWindow.IsPlayerInGroup(PlayerMenuWindow.curPlayer.name)
    local isBattleGroupMember = (PartyUtils.IsPlayerInWarband(PlayerMenuWindow.curPlayer.name) ~= nil)
    local inFullGroup = GroupWindow.groupData[GroupWindow.MAX_GROUP_MEMBERS].name ~= L"" and IsWarBandActive() == false
    
    local disableGroupInvite = (inFullGroup == true) or (isGroupMember == true) or (isBattleGroupMember == true) or (targetSelf == true)
    local disableGroupKick = ((GameData.Player.isGroupLeader == false) and (GameData.Player.isWarbandAssistant == false)) or ((isGroupMember == false) and (isBattleGroupMember == false)) or (targetSelf == true)
    local disableGroupJoin = (isGroupMember == true) or (isBattleGroupMember == true) or (targetSelf == true)
    
    local hasInvitePermission = ReferWindow.HasInvitePermission()
    local selfInGroup = ReferWindow.IsPlayerInAGroup()
    
    local disableRefer = (hasInvitePermission == true) or (isGroupMember == true) or (isBattleGroupMember == true) or (targetSelf == true) or (not selfInGroup)
    
    EA_Window_ContextMenu.AddMenuDivider(EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.AddMenuItem(GetString(StringTables.Default.LABEL_PLAYER_MENU_GROUP_INVITE), PlayerMenuWindow.OnGroupInvite, disableGroupInvite, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.AddMenuItem(L"Refer", ReferWindow.OnRefer, disableRefer, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.AddMenuItem(GetString(StringTables.Default.LABEL_PLAYER_MENU_GROUP_KICK), PlayerMenuWindow.OnGroupKick, disableGroupKick, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.AddMenuItem(GetString(StringTables.Default.LABEL_PLAYER_MENU_GROUP_JOIN), PlayerMenuWindow.OnGroupJoin, disableGroupJoin, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    if ((not targetSelf) and 
        (not GameData.Player.isInScenario and not GameData.Player.isInSiege) and
        (isGroupMember or isBattleGroupMember)) then
        
        local playerName = PlayerMenuWindow.curPlayer.name
        local player = nil
        if (isGroupMember) then
            player = GroupWindow.GetGroupMember(playerName)
        else
            player = BattlegroupHUD.GetWarbandMember(playerName)
        end
        
        if (not player) then
            ERROR(L"Invalid group / warband member")
            return
        end
        
        local singleSummonInvSlot = DataUtils.HasRequiredSummoningStone(player.level)
        local disablePlayerSummon = GameData.Player.inCombat or singleSummonInvSlot == nil
        EA_Window_ContextMenu.AddMenuItem(GetString(StringTables.Default.LABEL_SUMMON_PLAYER), PartyUtils.OnSummonPlayer, disablePlayerSummon, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
        
        if (GameData.Player.isChicken == false) then
            if (player.level < GameData.Player.level) then
                local bolsterText, bolsterCallback = PartyUtils.GetBolsterMenuText(playerName)
                if (bolsterText and bolsterCallback) then
                    EA_Window_ContextMenu.AddMenuItem(bolsterText, bolsterCallback, false, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
                end
            end
        end
    end
end

function ReferWindow.FormatPlayerName(playerName)
    local nameFormatted = wstring.gsub(playerName, L"(^.)", L"")
    local nameLower = wstring.lower(nameFormatted)
    local firstChar = wstring.upper(wstring.sub(nameLower, 1, 1))
    local restChars = wstring.sub(nameLower, 2)
    return firstChar .. restChars
end

function ReferWindow.OnRefer()
    if ButtonGetDisabledFlag(SystemData.ActiveWindow.name) == true then
        return
    end
    
    local targetPlayerName = ReferWindow.targetPlayerName
    
    if not targetPlayerName or targetPlayerName == L"" then
        targetPlayerName = SystemData.UserInput.selectedGroupMember or 
                          (PlayerMenuWindow.curPlayer and PlayerMenuWindow.curPlayer.name)
    end
    
    local formattedName = ReferWindow.FormatPlayerName(targetPlayerName)
    
    local color = {236, 94, 96}
    local playerLink = CreateHyperLink(L"PLAYER:" .. formattedName, L"@" .. formattedName, color, {})
    
    local chatMessage, chatCommand
    if IsWarBandActive() then
        chatCommand = L"/wb"
        chatMessage = L"[Refer Addon] " .. playerLink .. L" !"
    else
        chatCommand = L"/p"
        chatMessage = L"[Refer Addon] " .. playerLink .. L" !"
    end
    
    SendChatText(chatMessage, chatCommand)
    
    if PlayerMenuWindow.Done then
        PlayerMenuWindow.Done()
    end
end

function ReferWindow.OnChatLogUpdated(updateType, filterType)
    if updateType ~= SystemData.TextLogUpdate.ADDED then
        return
    end
    
    if filterType ~= SystemData.ChatLogFilters.GROUP and filterType ~= SystemData.ChatLogFilters.BATTLEGROUP then
        return
    end
    
    local _, _, text = TextLogGetEntry("Chat", TextLogGetNumEntries("Chat") - 1)
    
    if not text:find(L"[Refer Addon]") then
        return
    end
    
    if not ReferWindow.HasInvitePermission() then
        return
    end
    
    local playerName = text:match(L"@([^%s]+)")
    
    if playerName then
        ReferWindow.AddPlayerReferBox(playerName)
    end
end

function ReferWindow.OnGroupUpdated()
    for id, ref in pairs(ReferWindow.References) do
        if ReferWindow.IsPlayerInPlayerGroup(ref.name) then
            ReferWindow.RemovePlayerReferBox(id)
        end
    end
end

function ReferWindow.AddPlayerReferBox(playerName)
    if ReferWindow.IsPlayerInPlayerGroup(playerName) then
        return
    end
    
    for id, ref in pairs(ReferWindow.References) do
        if ref.name == playerName then
            ref.timer = ReferWindow.Settings.BoxTimer
            return
        end
    end
    
    local refId = ReferWindow.NextRefId
    ReferWindow.NextRefId = ReferWindow.NextRefId + 1
    
    local windowName = "ReferBox_" .. refId
    CreateWindowFromTemplate(windowName, "ReferPlayerBox_Template", "Root")
    
    WindowSetId(windowName, refId)
    
    ReferWindow.References[refId] = {
        name = playerName,
        timer = ReferWindow.Settings.BoxTimer,
        windowName = windowName
    }
    
    ReferWindow.RefCount = ReferWindow.RefCount + 1
    
    LabelSetText(windowName.."Name", playerName)
    
    ButtonSetText(windowName.."YesBtn", L"Yes")
    ButtonSetText(windowName.."NoBtn", L"No")
    
    if ReferWindow.Settings.BoxTimer == -1 then
        LabelSetText(windowName.."Timer", L"Unlimited")
    else
        local timerText = TimeUtils.FormatClock(ReferWindow.Settings.BoxTimer)
        LabelSetText(windowName.."Timer", timerText)
    end
    
    ReferWindow.RepositionReferBoxes()
    
    WindowSetShowing(windowName, true)
end

function ReferWindow.RemovePlayerReferBox(refId)
    local ref = ReferWindow.References[refId]
    if not ref then return end
    
    if DoesWindowExist(ref.windowName) then
        WindowSetShowing(ref.windowName, false)
        ReferWindow.PendingDestruction[ref.windowName] = true
        ReferWindow.DestructionDelay[ref.windowName] = 0.1
    end
    
    ReferWindow.References[refId] = nil
    
    ReferWindow.RefCount = ReferWindow.RefCount - 1
    
    ReferWindow.RepositionReferBoxes()
end

function ReferWindow.RepositionReferBoxes()
    local boxHeight = 60
    
    local sortedRefs = {}
    for id, ref in pairs(ReferWindow.References) do
        table.insert(sortedRefs, {id = id, ref = ref})
    end
    
    table.sort(sortedRefs, function(a, b) return a.id > b.id end)
    
    for index, refData in ipairs(sortedRefs) do
        local ref = refData.ref
        
        WindowClearAnchors(ref.windowName)
        
        if index == 1 then
            WindowAddAnchor(ref.windowName, "bottomright", "ReferList_Button", "topleft", 0, 0)
        else
            local prevRef = sortedRefs[index-1].ref
            WindowAddAnchor(ref.windowName, "bottomleft", prevRef.windowName, "topleft", 0, 5)
        end
    end
end

function ReferWindow.OnAccept()
    local windowName = WindowGetParent(SystemData.ActiveWindow.name)
    local refId = WindowGetId(windowName)
    
    local ref = ReferWindow.References[refId]
    if ref then
        SendChatText(L"/invite " .. ref.name, L"")
        
        ReferWindow.RemovePlayerReferBox(refId)
    end
end

function ReferWindow.OnDecline()
    local windowName = WindowGetParent(SystemData.ActiveWindow.name)
    local refId = WindowGetId(windowName)
    
    ReferWindow.RemovePlayerReferBox(refId)
end

function ReferWindow.OnClickName()
    local windowName = WindowGetParent(SystemData.ActiveWindow.name)
    local refId = WindowGetId(windowName)
    
    local ref = ReferWindow.References[refId]
    if ref then
        WindowSetGameActionData(SystemData.ActiveWindow.name, GameData.PlayerActions.SET_TARGET, 0, ref.name)
    end
end

function ReferWindow.SetBoxTimer(duration)
    ReferWindow.Settings.BoxTimer = duration
    ReferWindow.SaveSettings()
end

function ReferWindow.OnMouseOverStart()
    Tooltips.CreateTextOnlyTooltip(SystemData.MouseOverWindow.name, nil)
    Tooltips.SetTooltipText(1, 1, L"Refer Addon")
    Tooltips.SetTooltipColorDef(1, 1, Tooltips.MAP_DESC_TEXT_COLOR)
    Tooltips.SetTooltipText(1, 3, L"Right-click for options")
    Tooltips.Finalize()
    Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
end

function ReferWindow.OnTabRBU()
    local function MakeBoxTimerCallback(seconds)
        return function() ReferWindow.SetBoxTimer(seconds) end
    end
    
    EA_Window_ContextMenu.CreateContextMenu(SystemData.MouseOverWindow.name, EA_Window_ContextMenu.CONTEXT_MENU_1, L"Refer Addon Options")
    
    EA_Window_ContextMenu.AddMenuDivider(EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"Refer Box Duration:", nil, true, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"   30 seconds", MakeBoxTimerCallback(30), ReferWindow.Settings.BoxTimer == 30, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"   1 minute", MakeBoxTimerCallback(60), ReferWindow.Settings.BoxTimer == 60, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"   2 minutes", MakeBoxTimerCallback(120), ReferWindow.Settings.BoxTimer == 120, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"   5 minutes", MakeBoxTimerCallback(300), ReferWindow.Settings.BoxTimer == 300, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"   Unlimited", MakeBoxTimerCallback(-1), ReferWindow.Settings.BoxTimer == -1, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.AddMenuDivider(EA_Window_ContextMenu.CONTEXT_MENU_1)
    EA_Window_ContextMenu.AddMenuItem(L"Clear All References", ReferWindow.ClearAllReferences, ReferWindow.RefCount == 0, true, EA_Window_ContextMenu.CONTEXT_MENU_1)
    
    EA_Window_ContextMenu.Finalize(EA_Window_ContextMenu.CONTEXT_MENU_1)
end

function ReferWindow.ClearAllReferences()
    for id, _ in pairs(ReferWindow.References) do
        ReferWindow.RemovePlayerReferBox(id)
    end
end

function ReferWindow.OnUpdate(timePassed)
    for windowName, _ in pairs(ReferWindow.PendingDestruction) do
        ReferWindow.DestructionDelay[windowName] = ReferWindow.DestructionDelay[windowName] - timePassed
        if ReferWindow.DestructionDelay[windowName] <= 0 then
            if DoesWindowExist(windowName) then
                DestroyWindow(windowName)
            end
            ReferWindow.PendingDestruction[windowName] = nil
            ReferWindow.DestructionDelay[windowName] = nil
        end
    end
    
    for id, ref in pairs(ReferWindow.References) do
        if ref.timer ~= -1 then
            ref.timer = ref.timer - timePassed
            
            if DoesWindowExist(ref.windowName) then
                local timerText = TimeUtils.FormatClock(math.max(0, ref.timer))
                LabelSetText(ref.windowName.."Timer", timerText)
            end
            
            if ref.timer <= 0 then
                ReferWindow.RemovePlayerReferBox(id)
            end
        end
    end
end