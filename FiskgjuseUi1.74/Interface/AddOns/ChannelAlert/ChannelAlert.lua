if not ChannelAlert then ChannelAlert = {} end

ChannelAlert.elapsed = 0
ChannelAlert.attackers = {}
ChannelAlert.attackersNew = {}
ChannelAlert.count = 0

local lastUpdate = 0;
local updateThrottle = 0.25;

-- LUA locals for performance
local tostring = tostring
local tonumber = tonumber
local stringfind = string.find
local stringmatch = string.match
local TextLogGetEntry = TextLogGetEntry
local TextLogGetNumEntries = TextLogGetNumEntries
local SendChatText = SendChatText

local ChannelAlertWindow = "ChannelAlertWindow"

local channels = {}
channels[L'Divine Assualt'] = 12;
channels[L'Rend Soul'] = 23;
channels[L'Bring It On'] = 6;
channels[L'Wrecking Ball'] = 14;
channels[L'Disastrous Cascade'] = 24;
channels[L'Big Bouncin!'] = 8;
channels[L'Git To Da Choppa'] = 6;
channels[L'Retribution'] = 2;
channels[L'Whirling Axe'] = 19;
channels[L'Annihilate'] = 11;
--channels[L'Raze'] = "raze";

local dmgMessagePattern = "'s ([^%.]+) hits you for (%d+) ";
local critMessagePattern = "'s ([^%.]+) critically hits you for (%d+) ";

local statusHeight = 20
local statusWidth = 50
local imageHeight = 20
local imageWidth = 40
local padding  = 5
local color1 = {r=254,g=240,b=1}

local status = {
    0,0,0,0,0,0
}
local nstatus = 6

local DMG_FROM_PC = SystemData.ChatLogFilters.YOUR_DMG_FROM_PC
local DMG_FROM_NPC = SystemData.ChatLogFilters.YOUR_DMG_FROM_NPC

function ChannelAlert.OnInitialize()
    CreateWindow(ChannelAlertWindow, true)
    WindowSetTintColor (ChannelAlertWindow.."Background", 0, 0, 0)
	WindowSetAlpha (ChannelAlertWindow.."Background", 0)
    WindowSetTintColor(ChannelAlertWindow.."Status1", color1.r, color1.g, color1.b)
    WindowSetTintColor(ChannelAlertWindow.."Status2", 255, 206, 3)
    WindowSetTintColor(ChannelAlertWindow.."Status3", 253, 154, 1)
    WindowSetTintColor(ChannelAlertWindow.."Status4", 253, 97, 4)
    WindowSetTintColor(ChannelAlertWindow.."Status5", 255, 44, 5)
    WindowSetTintColor(ChannelAlertWindow.."Status6", 240, 5, 5)
    WindowSetDimensions(ChannelAlertWindow, nstatus * (statusWidth+5) + 5, statusHeight + 10)

    for i,v in pairs(status) do
        WindowAddAnchor(ChannelAlertWindow.."Status"..tostring(i), "topleft", ChannelAlertWindow, "topleft", 5 + (i-1) * (statusWidth+padding), 5)
        WindowSetDimensions(ChannelAlertWindow.."Status"..tostring(i), statusWidth, statusHeight)
        WindowSetAlpha (ChannelAlertWindow.."Status"..tostring(i), 0.2)

        WindowAddAnchor(ChannelAlertWindow.."StatusText"..tostring(i), "topleft", ChannelAlertWindow, "topleft", 5 + (i-1) * (statusWidth+padding), -45)
        WindowSetDimensions(ChannelAlertWindow.."StatusText"..tostring(i), statusWidth, statusHeight)

        WindowAddAnchor(ChannelAlertWindow.."StatusImage"..tostring(i), "topleft", ChannelAlertWindow, "topleft", 7 + (i-1) * (statusWidth+padding), -20)
        WindowSetDimensions(ChannelAlertWindow.."StatusImage"..tostring(i), imageWidth, imageHeight)
    end

    RegisterEventHandler(TextLogGetUpdateEventId("Combat"), "ChannelAlert.OnChatLogUpdated")
    LayoutEditor.RegisterWindow (ChannelAlertWindow, L"ChannelAlert", L"ChannelAlert", false, false, true, nil)

    local events = {};
end



function ChannelAlert.OnChatLogUpdated(updateType, filterType)

    local damageType = DMG_FROM_NPC -- for NPC testing
    damageType = DMG_FROM_PC
    if (updateType ~= SystemData.TextLogUpdate.ADDED) then return end
	if filterType ~= damageType then return end

    if TextLogGetNumEntries("Combat") > 0 then
	    local timestamp, _, text = TextLogGetEntry("Combat", TextLogGetNumEntries("Combat") - 1);
        if (not (text)) then return end
        ChannelAlert.DoText(text)
    end
end



function ChannelAlert.DoText(text)
    text = tostring(text)
	local skill, damage = stringmatch(text,dmgMessagePattern);
	local skillcrit, damage = stringmatch(text, critMessagePattern);

    if skill then
        skill = towstring(skill)
    end

    if skillcrit then
        skillcrit = towstring(skillcrit)
    end

	if channels[skill] or channels[skillcrit] then
        local ability
        if channels[skill] then
            ability = channels[skill]
        else
            ability = channels[skillcrit]
        end

        if not ability then return end

        local enemyName = StringSplit(text, "'s")[1]

        local attack = {
            count = ChannelAlert.count,
            ability = ability
        }

        ChannelAlert.attackers[enemyName] = attack
        ChannelAlert.UpdateDisplay()
	end
end


function ChannelAlert.OnUpdate(elapsed)
    ChannelAlert.elapsed = ChannelAlert.elapsed + elapsed
	if (ChannelAlert.elapsed - lastUpdate >= updateThrottle) then
		lastUpdate = ChannelAlert.elapsed;
        local newAttackers = {}
        for i, a in pairs(ChannelAlert.attackers) do
            if a.count >= ChannelAlert.count - 1 then
               newAttackers[i] = a
            end
        end
        ChannelAlert.attackers = newAttackers
        ChannelAlert.count = ChannelAlert.count + 1
        ChannelAlert.UpdateDisplay()
	end
end

function ChannelAlert.UpdateDisplay()

    local count = 0
    local attackerStrings = {}
    for i in pairs(ChannelAlert.attackers) do
        count = count + 1
        table.insert(attackerStrings, tostring(i))
    end

    for var=1,nstatus do
        if count >= var then
            if attackerStrings[var] then                
				WindowSetAlpha (ChannelAlertWindow.."Status"..tostring(var), 1)
                local text = towstring(attackerStrings[var]):sub(1, 3)
                local iconValue = ChannelAlert.attackers[attackerStrings[var]].ability
                if iconValue == nil then
                    iconValue = 1
                end

                local txtr, x, y, disabledTexture = GetIconData (Icons.GetCareerIconIDFromCareerLine(tonumber(iconValue)))

                if iconValue == "raze" then
                    txtr, texX, texY = GetIconData(23176)
                    CircleImageSetTexture(ChannelAlertWindow.."StatusImage"..tostring(var),txtr, 32, 32)
                else
                    CircleImageSetTexture(ChannelAlertWindow.."StatusImage"..tostring(var),txtr, 16, 16)
                end
            end
        else
            WindowSetAlpha (ChannelAlertWindow.."Status"..tostring(var), 0)
            LabelSetText(ChannelAlertWindow.."StatusText"..tostring(var), L"")
            CircleImageSetTexture(ChannelAlertWindow.."StatusImage"..tostring(var),"", 16, 16)
		end
    end
end

function ChannelAlert.Test(enemy)
    local testText = "no match"
    if enemy == 0 then
        testText = "Dog's Bring It On hits you for 0 damage. (1 mitigated) (3 absorbed)"
        ChannelAlert.DoText(testText)
        testText = "Flip's Bring It On hits you for 0 damage. (1 mitigated) (3 absorbed)"
        ChannelAlert.DoText(testText)
        testText = "Cat's Wrecking Ball hits you for 0 damage. (1 mitigated) (3 absorbed)"
        ChannelAlert.DoText(testText)
        testText = "Bird's Disastrous Cascade hits you for 0 damage. (1 mitigated) (3 absorbed)"
        ChannelAlert.DoText(testText)
        testText = "Snakes's Raze hits you for 0 damage. (1 mitigated) (3 absorbed)"
        ChannelAlert.DoText(testText)
    elseif enemy == 1 then
        testText = "Dog's Bring It On hits you for 0 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 2 then
        testText = "Cat's Wrecking Ball hits you for 0 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 3 then
        testText = "Bird's Disastrous Cascade hits you for 0 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 4 then
        testText = "Snakes's Raze hits you for 0 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 5 then
        testText = "Lion's Whirling Axe hits you for 4 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 6 then
        testText = "Diaper's Retribution hits you for 4 damage. (1 mitigated) (3 absorbed)"
    elseif enemy == 7 then
        testText = "Bombay's Annihilate hits you for 4 damage. (1 mitigated) (3 absorbed)"
    end
    --d(testText)
    ChannelAlert.DoText(testText)
end



