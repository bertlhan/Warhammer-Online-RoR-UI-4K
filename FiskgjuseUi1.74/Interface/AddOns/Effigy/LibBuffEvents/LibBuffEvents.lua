-- Shameless rip off of SquaredBuffIndicators3 by Aiiane
--[[local MAJOR, MINOR = "LibBuffEvents", 1

local LibBuffEvents, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not LibBuffEvents then return end
]]--
if not LibBuffEvents then LibBuffEvents = {} end


-- add this to string functions
function string.startsWith(String, Start)
	return string.sub(String, 1, string.len(Start))==Start
end

function string.endsWith(String, End)
	return End=='' or string.sub(String, -string.len(End))==End
end

-- Settings
local UNITS_UPDATED_PER_FRAME = 1 -- How many units' buff caches are processed per frame for potential updates (includes timeouts)

local EventCallbacks = {}

-- Make utility functions local for performance
local pairs = pairs
local unpack = unpack
local tonumber = tonumber
local tostring = tostring
local towstring = towstring
local next = next
local max = math.max
local min = math.min
local random = math.random
local wstring_sub = wstring.sub
local wstring_format = wstring.format
local tinsert = table.insert
local tremove = table.remove
local GetBuffs = GetBuffs
local WStringsCompareIgnoreGrammer = WStringsCompareIgnoreGrammer -- Yes, the function name is misspelt in the API.
local bttSelf = GameData.BuffTargetType.SELF
local bttTFriendly = GameData.BuffTargetType.TARGET_FRIENDLY
local bttTHostile = GameData.BuffTargetType.TARGET_HOSTILE
local bttGrpMemberStart = GameData.BuffTargetType.GROUP_MEMBER_START
local bttGrpMemberEnd = GameData.BuffTargetType.GROUP_MEMBER_END-1

-- time counter
local currentTime = 0

-- Efficient Lua queue for updates
local updates = {
    queue = {},
    front = 0,
    back = -1,
    dequeue = function(self) -- value = updates:dequeue()
        local front = self.front
        if front > self.back then return end
        local value = self.queue[front]
        self.queue[front] = nil -- garbage collection
        self.front = front + 1
        return value
    end,
    enqueue = function(self, value) -- updates:enqueue(value)
        local back = self.back + 1
        self.back = back
        self.queue[back] = value
    end,
    uniqueEnqueue = function(self, value) -- updates:enqueue(value)
        local i = self.front
        local queue = self.queue
        while i <= self.back do
            if queue[i] == value then return end
        end
        self:enqueue(value)
    end
}

-- From the lua wiki: http://lua-users.org/wiki/CopyTable
local function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, _copy( getmetatable(object)))
    end
    return _copy(object)
end

-- cache for the units we're looking for
--local UnitCache = {}

-- So as it turns out, it's actually about 2-4x faster to go through and set about 10 values to nil, then it is to set something equal to {} every time.
local buffCache = setmetatable({}, {__index=function(t,k) t[k] = {} return t[k] end})
local function CreateStatusCache(t, unit)
    -- If this unit doesn't have a cache entry yet, create it
    t[unit] =
        {
            ailments = {},
            curses = {},
            hexes = {},
            debuffs = {},
            healings = {},
            buffs = {},
            defensives = {},
            damagings = {},
            offensives = {},
            passives = {},
            granteds = {},
            selfcasts = {},
			--
			cripples = {},
			bolsters = {},
			augmentations = {},
			statsBuffs = {},
			enchantments = {},
			blessings = {},
        }
    return t[unit]
end
local statusCache = setmetatable({}, {__index = CreateStatusCache})

local function ClearStatusCache(unit)
    
    local s = statusCache[unit]
    for k,v in pairs(s.curses) do s.curses[k] = nil end
    for k,v in pairs(s.ailments) do s.ailments[k] = nil end
    for k,v in pairs(s.hexes) do s.hexes[k] = nil end
    for k,v in pairs(s.debuffs) do s.debuffs[k] = nil end
    for k,v in pairs(s.healings) do s.healings[k] = nil end
    for k,v in pairs(s.buffs) do s.buffs[k] = nil end
    for k,v in pairs(s.defensives) do s.defensives[k] = nil end
    for k,v in pairs(s.damagings) do s.damagings[k] = nil end
    for k,v in pairs(s.offensives) do s.offensives[k] = nil end
    for k,v in pairs(s.passives) do s.passives[k] = nil end
    for k,v in pairs(s.granteds) do s.granteds[k] = nil end
    for k,v in pairs(s.selfcasts) do s.selfcasts[k] = nil end
	--
    for k,v in pairs(s.cripples) do s.cripples[i] = nil end
	for k,v in pairs(s.bolsters) do s.bolsters[i] = nil end
	for k,v in pairs(s.augmentations) do s.augmentations[i] = nil end
	--for k,v in pairs(s.statsBuffs) do s.statsBuffs[i] = nil end
	--for k,v in pairs(s.enchantments) do s.enchantments[i] = nil end
	--for k,v in pairs(s.blessings) do s.blessings[i] = nil end
	
    local b = buffCache[unit]
    for k,v in pairs(b) do b[k] = nil end
end

local function UpdateStatusCache(unit, i, data)
    
    local changed = false
    local s = statusCache[unit]

    if (data and data.effectIndex and data.iconNum and data.iconNum > 0) then
        s.ailments[i]       = data.isAilment            or nil
        s.curses[i]         = data.isCurse              or nil
        s.hexes[i]          = data.isHex                or nil
        s.debuffs[i]        = data.isDebuff             or nil
        s.healings[i]       = data.isHealing            or nil
        s.buffs[i]          = data.isBuff               or nil
        s.defensives[i]     = data.isDefensive          or nil
        s.damagings[i]      = data.isDamaging           or nil
        s.offensives[i]     = (not data.isDefensive)    or nil
        s.passives[i]       = data.isPassive            or nil
        s.granteds[i]       = data.isGranted            or nil
        s.selfcasts[i]      = data.castByPlayer         or nil
		--
		s.cripples[i]		= data.isCripple			or nil
		s.bolsters[i]		= data.isBolster			or nil
		s.augmentations[i]	= data.isAugmentation		or nil
		
		s.statsBuffs[i]		= data.isStatsBuff			or nil
		s.enchantments[i]	= data.isEnchantment		or nil
		s.blessings[i]		= data.isBlessing			or nil
        
        -- Cache the buff data as well
        if (not buffCache[unit][i]) or (buffCache[unit][i].abilityId ~= data.abilityId) then
            changed = true
        end
        buffCache[unit][i] = data
        
        -- Calculate the expiry timestamp for the buff
        data.expiryTime = data.duration + currentTime --unused atm
        
        -- Also calculate a lower-case version of the buff name for quick case-insensitive comparisons later
        data.lowerName = (data.name):lower()
        
    else
        -- No buff data for this index, so clear out the entries
        s.curses[i]         = nil
        s.ailments[i]       = nil
        s.hexes[i]          = nil
        s.debuffs[i]        = nil
        s.healings[i]       = nil
        s.buffs[i]          = nil
        s.defensives[i]     = nil
        s.damagings[i]      = nil
        s.offensives[i]     = nil
        s.passives[i]       = nil
        s.granteds[i]       = nil
        s.selfcasts[i]      = nil
        --
		s.cripples[i]		= nil
		s.bolsters[i]		= nil
		s.augmentations[i]	= nil
		s.statsBuffs[i]		= nil
		s.enchantments[i]	= nil
		s.blessings[i]		= nil
		
        -- Clear the buff data cache for this buff index
        if buffCache[unit][i] then changed = true end
        buffCache[unit][i] = nil
        
    end
    
    return changed
end

local playerName = L"" -- cache this, no need to do a pattern match each time

-- Lookup table for what careers can display which types of debuffs
local dispels = nil
local function makeDispels()
   dispels = {
        [GameData.CareerLine.IRON_BREAKER] = {},
        [GameData.CareerLine.SWORDMASTER] = {},
        [GameData.CareerLine.CHOSEN] = {},
        [GameData.CareerLine.BLACK_ORC] = {},
        [GameData.CareerLine.WITCH_HUNTER] = {},
        [GameData.CareerLine.KNIGHT] = {},
        [GameData.CareerLine.BLACKGUARD or GameData.CareerLine.SHADE] = {},
        [GameData.CareerLine.WHITE_LION or GameData.CareerLine.SEER] = {}, -- White Lion (go figure?)
        [GameData.CareerLine.MARAUDER or GameData.CareerLine.WARRIOR] = {}, -- Marauder
        [GameData.CareerLine.WITCH_ELF or GameData.CareerLine.ASSASSIN] = {}, -- Witch Elf
        [GameData.CareerLine.BRIGHT_WIZARD] = { ["Hex"] = "self", ["Ailment"] = "self", ["Curse"] = "self" },
        [GameData.CareerLine.MAGUS] = {},
        [GameData.CareerLine.SORCERER] = {},
        [GameData.CareerLine.ENGINEER] = {},
        [GameData.CareerLine.SHADOW_WARRIOR] = {},
        [GameData.CareerLine.SQUIG_HERDER] = {},
        [GameData.CareerLine.CHOPPA] = {},
        [GameData.CareerLine.SLAYER] = {},
        [GameData.CareerLine.WARRIOR_PRIEST] = { [ "Hex"] = "all", ["Curse"] = "all" },
        [GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = { ["Hex"] = "all", ["Ailment"] = "all" }, -- Disciple of Khaine
        [GameData.CareerLine.ARCHMAGE] = { ["Hex"] = "all", ["Ailment"] = "all" },
        [GameData.CareerLine.SHAMAN] = { [ "Curse"] = "all", ["Ailment"] = "all" },
        [GameData.CareerLine.RUNE_PRIEST] = { [ "Curse"] = "all", ["Ailment"] = "all" },
        [GameData.CareerLine.ZEALOT] = { [ "Hex"] = "all", ["Curse"] = "all" },
    }
end

local HDTable = {
	["Destruction"] = {
		["25"] = {
		   -- Chosen
		   [8348] = 25, -- Discordant Turbulence 25%
		   [3409] = 25, -- Discordant Turbulence 25%
		   [3776] = 25, -- Discordant Turbulence 25%
		   -- Marauder
		   [8401] = 25, -- Tainted Claw 25%
		   -- Witch Elf
		   [10412] = 25,-- Guile 25%
		   [10717] = 25 -- Guile
		},
		["50"] = {
		   -- Zealot
		   [8613] = 50, -- Windblock 50%
		   -- Disciple Of Khaine
		   [9602] = 50, -- Curse Of Khaine 50%
		   [3428] = 50, -- Curse Of Khaine 50%
		   -- Witch Elf
		   [9424] = 50, -- Black Lotus Blade 50%
		   -- Marauder
		   [8440] = 50, -- Deadly Clutch 50%
		   -- Squig Herder
		   [1853] = 50, -- Rotten Arrer
		   -- Choppa
		   [1773] = 50, -- No More Helpin
		   [1803] = 50, -- Yer Goin Down
		   -- Blackguard
		   -- [9373] = 50, -- Soul Killer
		   -- Shaman
		   [1905] = 50, -- Gork's Barbs
		   [3352] = 50, -- Gork's Barbs
		},
		["out"] = {
			-- With Elf
			[3811] = 50, -- Kiss of Death
			[3598] = 50, -- Kiss of Death
			[9407] = 50, -- Kiss of Death
			-- Blackguard
			[9317] = 50, -- Mind Killer
		},
	},
	["Order"] = {
		["25"] = {
			-- Knight of the blazing sun
		   [8036] = 25, -- Now's Our Chance! 25%
		   [3493] = 25, -- Now's Our Chance! 25%
		},
		["50"] = {
			-- Witch Hunter
		   [8112] = 50, -- Punish The False 50 %
		   [20324] = 50, -- Punish The False 50 %
		   -- Shadowwarrior
		   [9109] = 50, -- Shadow Sting 50%
		   -- Slayer
		   [1434] = 50, -- Deep Wound 50%
		   [12692] = 50, -- Deep Wound 50%
		   [1501] = 50, -- Looks like a Challenge 50%
		   -- White Lion
		   [9191] = 50, -- Thin the Herd 50%
		},
		["out"] = {
			-- Witch Hunter
			[3002] = 50, -- Blessed Bullets of Confession
			[3784] = 50, -- Blessed Bullets of Confession
			[8099] = 50, -- Blessed Bullets of Confession
		},
	},
}

local HotTable = {
	["15"] = {
		[GameData.CareerLine.SHAMAN] = 3908, -- 'Ey, Quit Bleedin'
		[GameData.CareerLine.ZEALOT] = 8558, -- Tzeentch's Cordial
		[GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = 3366, -- Soul Infusion
		[GameData.CareerLine.ARCHMAGE] = 3914, -- Lambent Aura
		[GameData.CareerLine.RUNE_PRIEST] = 1590, -- Rune of Regeneration
		[GameData.CareerLine.WARRIOR_PRIEST] = 3365, -- Healing Hand		
	},
	["5"] = {
		[GameData.CareerLine.SHAMAN] = 3552, -- Gork'll Fix It
		[GameData.CareerLine.ZEALOT] = 3554, -- Dark Medicine
		[GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = 3695, -- Restore Essence
		[GameData.CareerLine.ARCHMAGE] = 3558, -- Healing Energy
		[GameData.CareerLine.RUNE_PRIEST] = 3551, -- Rune of Mending
		[GameData.CareerLine.WARRIOR_PRIEST] = 3553, -- Divine Aid
	},
	["ExtraHot"] = {
		[GameData.CareerLine.SHAMAN] = 3274, -- Do Sumfin Useful (13 mastery)
		[GameData.CareerLine.ZEALOT] = 3998, -- Leaping Alteration (bounce)
		[GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = 9573, -- Khaine's Vigor (group, 9 mastery)
		[GameData.CareerLine.ARCHMAGE] = 9258, -- Funnel Essence (13 mastery) -- consistency
		[GameData.CareerLine.RUNE_PRIEST] = 3016, -- Rune of Serenity (bounce) 
		[GameData.CareerLine.WARRIOR_PRIEST] = 8265, -- Pious Restoration (group, 9 mastery)
	},
	["Shield"] = {
		[GameData.CareerLine.SHAMAN] = 3911, -- Don' Feel Nuthin
		[GameData.CareerLine.ZEALOT] = 8564, -- Veil Of Chaos
		[GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = 9574, -- Soul Shielding (group shield, 5 mastery)
		[GameData.CareerLine.ARCHMAGE] = 3919, -- Shield Of Saphery
		[GameData.CareerLine.RUNE_PRIEST] = 1593, -- Rune Of Shielding
		[GameData.CareerLine.WARRIOR_PRIEST] = 8264, -- Divine Light (group shield, 5 mastery)
	},
	["Extra"] = {		
		[GameData.CareerLine.SHAMAN] = 1928, -- Shrug It Off
		[GameData.CareerLine.ZEALOT] = 8561, -- Daemonic Fortitude (wounds increase)
		[GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST] = 9579, -- Khaine`s Refreshment (13 mastery)
		[GameData.CareerLine.ARCHMAGE] = 9272, -- Magical Infusion (9 mastery)
		[GameData.CareerLine.RUNE_PRIEST] = 1606, -- Protection of the Ancestors (wounds increase)
		[GameData.CareerLine.WARRIOR_PRIEST] = 8266, -- Martyr`s Blessing (13 mastery)
	},
}
-- [GameData.CareerLine.ZEALOT] = 8622, -- Embrace the Warp (damage reduce on self)
-- [GameData.CareerLine.RUNE_PRIEST] = 1592, -- Grimnir`s Shield (damage reduce on self)

-- tactic procs rp
--[[
[GameData.CareerLine.RUNE_PRIEST] = 3875, -- Regenerative Shielding
[GameData.CareerLine.RUNE_PRIEST] = 3410, -- Blessing of Grungni
[GameData.CareerLine.RUNE_PRIEST] = 3437, -- Restorative Burst
]]--

-- Returns true or false for the given condition on the specified unit.
-- called by itself and GenerateIndicatorsForUnit(unit)
local function ProcessConditionForUnit(unit, condition)
    if not (unit and condition) then return end
    
    local ctype = condition.type
	local cSelfCast = condition.selfcast
	
    --EA_ChatWindow.Print(L"ProcessConditionForUnit: "..towstring(unit)..L", type: "..towstring(ctype))
    if ctype == "AND" then
        -- [1] = first condition to check
        -- [2] = second condition to check
        return
            (
                ProcessConditionForUnit(unit, condition[1])
            and
                ProcessConditionForUnit(unit, condition[2])
            )
            
    elseif ctype == "OR" then
        -- [1] = first condition to check
        -- [2] = second condition to check
        return
            (
                ProcessConditionForUnit(unit, condition[1])
            or
                ProcessConditionForUnit(unit, condition[2])
            )
            
    elseif ctype == "NOT" then
        -- [1] = condition to negate
        return not ProcessConditionForUnit(unit, condition[1])
            
    elseif ctype == "BUFFTYPE" then								-- has no table support yet
        -- [1] = type of buff to check the presence of
		if cSelfCast == nil then
			return (next(statusCache[unit][condition[1]]) and true or false)
		end
		local b = buffCache[unit]
		for k,_ in pairs(statusCache[unit][condition[1]]) do	-- intersection with statusCache[unit].selfcasts or just check...?
			if b[k].castByPlayer == cSelfCast then return true end
		end
		return false
		
    elseif ctype == "ABILITYID" then
        -- each numerical index will be looked for, this condition is true as long as at least one is present
        local b = buffCache[unit]
		if cSelfCast == nil then
			for _,v in pairs(b) do
				for _,aid in ipairs(condition) do
					if v.abilityId == aid then return true end
				end
			end
		else
			for _,v in pairs(b) do
				for _,aid in ipairs(condition) do
					if v.abilityId == aid and v.castByPlayer == cSelfCast then return true end
				end
			end
		end
        return false
        
    elseif ctype == "BUFFNAME" then
        -- each numerical index will be looked for, this condition is true as long as at least one is present
        -- (each name should be specified in lower case)
        local b = buffCache[unit]
		if cSelfCast == nil then
			for k,v in pairs(b) do
				for _,bname in ipairs(condition) do
					if v.lowerName == bname then return true end
				end
			end
		else
			for k,v in pairs(b) do
				for _,bname in ipairs(condition) do
					if v.lowerName == bname and v.castByPlayer == cSelfCast then return true end
				end
			end
		end
        return false
        
    elseif ctype == "DISPELLABLE" then
        local dtypes = dispels[GameData.Player.career.line]
        local s = statusCache[unit]
		
        if unit == bttSelf then
            if dtypes["Ailment"] and next(s.ailments) then return true end
            if dtypes["Curse"] and next(s.curses) then return true end
            if dtypes["Hex"] and next(s.hexes) then return true end
        elseif unit ~= bttTHostile then
            if dtypes["Ailment"] == "all" and next(s.ailments) then return true end
            if dtypes["Curse"] == "all" and next(s.curses) then return true end
            if dtypes["Hex"] == "all" and next(s.hexes) then return true end
        end
        return false

	-- switched _,aid to aid,_
	elseif ctype == "HEALDEBUFF" then
		-- recycle AbilityId check
		-- GameData.Player.realm == GameData.Realm.ORDER,DESTRUCTION(,NONE)
		-- condition[1] -> "25", "50", "out", 
        local b = buffCache[unit]
		-- each numerical index will be looked for, this condition is true as long as at least one is present
		if ((GameData.Player.realm == GameData.Realm.DESTRUCTION) and (unit ~= bttTHostile)) or
				((GameData.Player.realm == GameData.Realm.ORDER) and (unit == bttTHostile)) then
			-- check if ORDER debuffs are on destro unit
			if cSelfCast == nil then
				for _,v in pairs(b) do
					for aid,_ in ipairs(HDTable.Order[condition[1] ]) do
						if v.abilityId == aid then return true end
					end
				end
			else
				for _,v in pairs(b) do
					for aid,_ in ipairs(HDTable.Order[condition[1] ]) do
						if v.abilityId == aid and v.castByPlayer == cSelfCast then return true end
					end
				end
			end
		else
			-- check if DESTRO debuffs are on order unit
			if cSelfCast == nil then
				for _,v in pairs(b) do
					for aid,_ in ipairs(HDTable.Destruction[condition[1] ]) do
						if v.abilityId == aid then return true end
					end
				end
			else
				for _,v in pairs(b) do
					for aid,_ in ipairs(HDTable.Destruction[condition[1] ]) do
						if v.abilityId == aid and v.castByPlayer == cSelfCast then return true end
					end
				end
			end
		end		   
        return false
	elseif ctype == "HOT" then	
		local s = statusCache[unit].defensives -- only thing that matches all in HotTable
		if nil ~= s then
			local b = buffCache[unit]
			if cSelfCast == nil then
				for effectIndex,_ in pairs(s) do
					for _,aid in ipairs(condition) do
						if b[effectIndex].abilityId == aid then return true end
					end
				end
			else
				for effectIndex,_ in pairs(s) do
					for _,aid in ipairs(condition) do
						if b[effectIndex].abilityId == aid and b[effectIndex].castByPlayer == cSelfCast then return true end
					end
				end
			end
		end
		return false
    end
end

-- replaced GenerateIndicatorsForUnit(unit)
local eventResultCache = {}
local function GenerateEventsForUnit(buffTargetType)
	--EA_ChatWindow.Print(L"GenerateEventsForUnit: "..towstring(buffTargetType))
	local u = EventCallbacks[buffTargetType]
	if not u then return end
	
	if not eventResultCache[buffTargetType] then eventResultCache[buffTargetType] = {} end
	
	for condition,_ in pairs(u) do
		local result = ProcessConditionForUnit(buffTargetType, condition)
		
		if eventResultCache[buffTargetType][condition] == result then continue end
		
		eventResultCache[buffTargetType][condition] = result
		local event = {buffTargetType, condition}
		LibBuffEvents.BroadcastEvent(event, {Event = event, Result = result})
    end
	
end

function LibBuffEvents.EffectsUpdated(buffTargetType, effects, isFull)
    --EA_ChatWindow.Print(L"EffectsUpdated: "..towstring(buffTargetType))
        
    -- Since PLAYER_EFFECTS_UPDATED doesn't bother to specify the buffTargetType, swap the arguments around
    if type(buffTargetType) == "table" then
        effects, isFull, buffTargetType = buffTargetType, effects, bttSelf
    end
    
    -- Ignore silly update events (ones called with no arguments).
    if not buffTargetType then return end
	if not EventCallbacks[buffTargetType] then return end
	
    if isFull then
		ClearStatusCache(buffTargetType)
    end
    
    -- Okay, so it's a unit we know and care about! What's happened to it now?
    local changes = false
    for index,data in pairs(effects) do
		changes = UpdateStatusCache(buffTargetType, index, data) or changes
    end
   
    if changes then
		--updates:uniqueEnqueue(buffTargetType)
		GenerateEventsForUnit(buffTargetType)
    end
	
end

local entityIdFT = 0
local entityIdHT = 0
function LibBuffEvents.OnPlayerTargetUpdated(targetClassification,_,_) --targetClassification,targetId,targetType
	if targetClassification == "mouseovertarget" then return end
	
	if(targetClassification=="selffriendlytarget") and (EventCallbacks[bttTFriendly] ~= nil) then
		TargetInfo:UpdateFromClient()	-- I have no idea if this is still necessary
		local newEntityIdFT = TargetInfo:UnitEntityId("selffriendlytarget")
		if entityIdFT ~= newEntityIdFT then
			ClearStatusCache(bttTFriendly)
			--updates:uniqueEnqueue(bttTFriendly)
			GenerateEventsForUnit(bttTFriendly)
			entityIdFT = newEntityIdFT			
		end
	elseif (targetClassification=="selfhostiletarget") and (EventCallbacks[bttTHostile] ~= nil) then
		TargetInfo:UpdateFromClient()	-- I have no idea if this is still necessary
		local newEntityIdHT = TargetInfo:UnitEntityId("selfhostiletarget")
		if entityIdHT ~= newEntityIdHT then
			ClearStatusCache(bttTHostile)
			--updates:uniqueEnqueue(bttTHostile)
			GenerateEventsForUnit(bttTHostile)
			entityIdHT = newEntityIdHT			
		end
	end
end

local groupNames = {}
function LibBuffEvents.OnGroupUpdated()
	local groupData = PartyUtils.GetPartyData()
	for i = 1,5 do
		if EventCallbacks[i-1] == nil then continue end
		
		if groupNames[i] ~= groupData[i].name then	-- groupMember changed
			ClearStatusCache(i-1)
			--updates:uniqueEnqueue(i-1)
			GenerateEventsForUnit(i-1)
			groupNames[i] = groupData[i].name
		end
	end
end

-- ToDo: Check this
function LibBuffEvents.TargetsCleared()
	if (EventCallbacks[bttSelf] ~= nil) then
		ClearStatusCache(bttSelf)
		--updates:uniqueEnqueue(bttSelf)
	end
	if (EventCallbacks[bttTFriendly] ~= nil) then
		ClearStatusCache(bttTFriendly)
		--updates:uniqueEnqueue(bttTFriendly)
	end
	if (EventCallbacks[bttTHostile] ~= nil) then
		ClearStatusCache(bttTHostile)
		--updates:uniqueEnqueue(bttTHostile)
	end
	for i = bttGrpMemberStart, bttGrpMemberEnd do
		if (EventCallbacks[i] ~= nil) then
			ClearStatusCache(i)
			--updates:uniqueEnqueue(i)
		end
	end
end

function LibBuffEvents.OnUpdate(timePassed)
    currentTime = currentTime + timePassed
    
    -- Process one unit's worth of updates per frame, if any need processing
    for _=1,UNITS_UPDATED_PER_FRAME do
        local updateUnit = updates:dequeue()
        if updateUnit then
            --GenerateIndicatorsForUnit(updateUnit)
			GenerateEventsForUnit(updateUnit)
        else
            break
        end	
    end
	
end

function LibBuffEvents.Initialize()
    RegisterEventHandler(SystemData.Events.PLAYER_TARGET_EFFECTS_UPDATED, 	"LibBuffEvents.EffectsUpdated")
    RegisterEventHandler(SystemData.Events.PLAYER_EFFECTS_UPDATED, 			"LibBuffEvents.EffectsUpdated")
    RegisterEventHandler(SystemData.Events.GROUP_EFFECTS_UPDATED, 			"LibBuffEvents.EffectsUpdated")
	RegisterEventHandler(SystemData.Events.ENTER_WORLD,			 			"LibBuffEvents.TargetsCleared")
	RegisterEventHandler(SystemData.Events.RELEASE_CORPSE,					"LibBuffEvents.TargetsCleared")
	RegisterEventHandler(SystemData.Events.PLAYER_DEATH_CLEARED,			"LibBuffEvents.TargetsCleared")
	RegisterEventHandler(SystemData.Events.PLAYER_TARGET_UPDATED,			"LibBuffEvents.OnPlayerTargetUpdated")
	RegisterEventHandler(SystemData.Events.GROUP_UPDATED,					"LibBuffEvents.OnGroupUpdated")
	--SystemData.Events.SCENARIO_GROUP_JOIN
	--SystemData.Events.SCENARIO_GROUP_LEAVE
	
	-- if we haven't yet initialized this, then do it... need to do it at some point anyways
    if not dispels then makeDispels() end

	--LibBuffEvents.Test()
end

function LibBuffEvents.Shutdown()
	UnregisterEventHandler(SystemData.Events.PLAYER_TARGET_EFFECTS_UPDATED, "LibBuffEvents.EffectsUpdated")
	UnregisterEventHandler(SystemData.Events.PLAYER_EFFECTS_UPDATED, "LibBuffEvents.EffectsUpdated")
	UnregisterEventHandler(SystemData.Events.GROUP_EFFECTS_UPDATED, "LibBuffEvents.EffectsUpdated")
end
--------------------------------------------------------------------------------
--								LibBuffEvents API							  --
--------------------------------------------------------------------------------
-- CallbackOwner is actually an arbitrary object
-- Event = { buffTargetType,{<condition>} }
function LibBuffEvents.BroadcastEvent(Event, EventData)
	--[[
	-- First step: broadcast events to its handlers
	if EventCallbacks[Event] ~= nil then
		for k, callbck in ipairs(EventCallbacks[Event]) do
			callbck.Func(callbck.Owner, EventData)
		end
	end
	]]--
	-- First step: broadcast events to its handlers
	if EventCallbacks[Event[1] ] ~= nil and EventCallbacks[Event[1] ][Event[2] ] ~= nil then 
		for _, callbck in ipairs(EventCallbacks[Event[1] ][Event[2] ]) do
			EventData.Event[2] = callbck.Condition -- replace translatedCondition with original condition
			callbck.Func(callbck.Owner, EventData)
		end
	end
	
end


function LibBuffEvents.RegisterEventHandler(Event, CallbackOwner, CallbackFunction)
	--[[
	-- First step: initialize event base if needed
	if EventCallbacks[Event] == nil then
		EventCallbacks[Event] = {}
	end

	-- Second step: insert new event handler
	table.insert(EventCallbacks[Event], {Owner = CallbackOwner, Func = CallbackFunction})
	]]--
	--[[if Event[2][1] ~= nil then
		EA_ChatWindow.Print(L"Registered "..towstring(Event[2].type)..L" "..towstring(Event[2][1])..L" for BuffTargetType: "..towstring(Event[1]))
	else
		EA_ChatWindow.Print(L"Registered "..towstring(Event[2].type)..L" for BuffTargetType: "..towstring(Event[1]))
	end
	]]--
	
	local buffTargetType = Event[1]
	local condition = Event[2]--deepcopy(Event[2])
	
	if EventCallbacks[buffTargetType] == nil then 
		EventCallbacks[buffTargetType] = {}
	end
	-- translate some conditions to ABILITYID
	local translatedCondition = deepcopy(condition)
	if condition.type == "HOT" then
		for i, conditionStr in ipairs(condition) do
			local hotType = ""
			if string.endsWith(conditionStr, "15") then
				hotType = "15"
			elseif string.endsWith(conditionStr, "5") then
				hotType = "5"
			elseif string.endsWith(conditionStr, "ExtraHot") then
				hotType = "ExtraHot"
			elseif string.endsWith(conditionStr, "Shield") then
				hotType = "Shield"
			elseif string.endsWith(conditionStr, "Extra") then
				hotType = "Extra"
			else
				hotType = "15" -- fallback
			end

			local careerLine = 0
			if string.startsWith( string.lower(conditionStr), "shm" ) then
				careerLine = GameData.CareerLine.SHAMAN
			elseif string.startsWith( string.lower(conditionStr), "zel" ) then
				careerLine = GameData.CareerLine.ZEALOT
			elseif string.startsWith( string.lower(conditionStr), "dok" ) then
				careerLine = GameData.CareerLine.DISCIPLE or GameData.CareerLine.BLOOD_PRIEST
			elseif string.startsWith( string.lower(conditionStr), "am" ) then
				careerLine = GameData.CareerLine.ARCHMAGE
			elseif string.startsWith( string.lower(conditionStr), "rp" ) then
				careerLine = GameData.CareerLine.RUNE_PRIEST
			elseif string.startsWith( string.lower(conditionStr), "wp" ) then
				careerLine = GameData.CareerLine.WARRIOR_PRIEST
			else -- myclass
				careerLine = GameData.Player.career.line
			end

			translatedCondition[i] = HotTable[hotType][careerLine]
			--DEBUG(L"hotType: "..towstring(hotType)..L"; careerLine: "..towstring(careerLine)..L"; translatedCondition"..towstring(i)..L": "..towstring(translatedCondition[i]))
		end
	end
	
	if EventCallbacks[buffTargetType][translatedCondition] == nil then 
		EventCallbacks[buffTargetType][translatedCondition] = {}
	end
	-- Second step: insert new event handler
	--table.insert(EventCallbacks[buffTargetType], condition)
	table.insert(EventCallbacks[buffTargetType][translatedCondition], {Owner = CallbackOwner, Func = CallbackFunction, Condition = condition}) -- save original condition
	
end

function LibBuffEvents.UnregisterEventHandler(Event, CallbackOwner, CallbackFunction)

	-- First step: find and remove event handler
	for k, callbck in ipairs(EventCallbacks[Event[1] ][Event[2] ]) do
		if callbck.Owner == CallbackOwner and callbck.Func == CallbackFunction then
			table.remove(EventCallbacks[Event[1] ][Event[2] ], k)
		end
	end
	-- if table is empty, eliminate it
	if next(EventCallbacks[Event[1] ]) == nil then
		EventCallbacks[Event[1] ] = nil
	end
end

function LibBuffEvents.Reset()
	--UnitCache = {}
	-- First step: list all known entities
	--[[for k, entity in pairs(Entities) do
		-- Final step: clear entity data
		Entities[k] = nil
	end]]--
end

--[===[@debug@
-- return what are normally local tables
function SBIT()
    return {statusCache, buffCache, unitCache}
end
--@end-debug@]===]
LibBuffEvents.statusCache = statusCache
LibBuffEvents.EventCallbacks = EventCallbacks
LibBuffEvents.buffcache = buffCache

function LibBuffEvents.Test()
	--local condition = {"selfcasts", type = "BUFFTYPE"}
	--local event = {bttSelf, condition}
	
	local conditions = {
		--{"25", type = "HEALDEBUFF"},wd
		{"ailments", type = "BUFFTYPE"},
		--w{"out", type = "HEALDEBUFF"},
	}
	LibBuffEvents.RegisterEventHandler({bttSelf, {"selfcasts", type = "BUFFTYPE"} }, "self selfcast", LibBuffEvents.TestHandler)
	LibBuffEvents.RegisterEventHandler({bttSelf, {"ailments", type = "BUFFTYPE"} }, "self ailment", LibBuffEvents.TestHandler)
	--LibBuffEvents.RegisterEventHandler({bttTFriendly, {"selfcasts", type = "BUFFTYPE"} }, "FT selfcast", LibBuffEvents.TestHandler)
	
	--[[for i = bttGrpMemberStart, bttGrpMemberEnd do
		for _,v in ipairs(conditions) do
			LibBuffEvents.RegisterEventHandler({i, {"selfcasts", type = "BUFFTYPE"} }, "Grp", LibBuffEvents.TestHandler)
		end
	end]]--
end

function LibBuffEvents.TestHandler(object, EventData)
-- EventData.Event, EventData.Result
	--[[
	if not eventResultCache[EventData.Event[1] ] then eventResultCache[EventData.Event[1] ] = {} end
	if eventResultCache[EventData.Event[1] ][EventData.Event[2] ] == EventData.Result then
		--EA_ChatWindow.Print(towstring(object)..L": "..towstring(EventData.Event[1])..L": Return")
		return
	end
	eventResultCache[EventData.Event[1] ][EventData.Event[2] ] = EventData.Result
	]]--
	
	if EventData.Result == true then
		EA_ChatWindow.Print(towstring(object)..L": "..towstring(EventData.Event[1])..L": true")
	else
		EA_ChatWindow.Print(towstring(object)..L": "..towstring(EventData.Event[1])..L": false")
	end
	
end