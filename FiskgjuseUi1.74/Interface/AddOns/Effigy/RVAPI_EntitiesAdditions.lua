if not RVAPI_EntitiesAdditions then RVAPI_EntitiesAdditions = {} end
local Addon = RVAPI_EntitiesAdditions
Addon.Name = "RVAPI_EntitiesAdditions"

if not RVAPI_Entities then RVAPI_Entities = {} end
local CoreAddon = RVAPI_Entities
local oldRVAPI_EntitiesAPI_Update = nil

---------------------------------------
-- Addon functions
---------------------------------------
function Addon.Initialize()
    -- post-hook the RVAPI_Entities.API_Update() function (we want to be faster than all other RVAPI_Entities.Events.ENTITY_LOADING_END handlers
    oldRVAPI_EntitiesAPI_Update = RVAPI_Entities.API_Update
    RVAPI_Entities.API_Update = function(self, ...)
        oldRVAPI_EntitiesAPI_Update(self, ...)
        
		local gameDataPlayer = GameData.Player
		
		-- RVAPI_Entities will only update player after first targeted or groupchanged, so we need to create an Entity
		local PlayerEntityData = {
			EntityId = gameDataPlayer.worldObjNum,
			EntityType = 1,
			Name = L""..gameDataPlayer.name,
			Title = L"",
			CareerName = gameDataPlayer.career.name,
			CareerLine = gameDataPlayer.career.line,
			Level = gameDataPlayer.level,
			--Tier = 0,
			--DifficultyMask = 0,
			IsNPC = false,
			IsPet = false,
			IsPVP = gameDataPlayer.rvrPermaFlagged or gameDataPlayer.rvrZoneFlagged,
			--ShowHealthBar = false,
			--HitPointPercent = 0,
			--ActionPointPercent = 0,
			--MoraleLevel = 0,
			--RelationshipColor = {r=0,g=0,b=0},
			Online = true,
			ZoneNumber = gameDataPlayer.zone,
			IsDistant = false,
			IsInSameRegion = true,
			IsGroupLeader = gameDataPlayer.isGroupLeader,
			IsAssistant = gameDataPlayer.isWarbandAssistant,
			--IsMainAssist = false,
			--IsMasterLooter = false,
			IsSelf = true,
			--IsGroupMember = false,
			IsScenarioGroupMember = gameDataPlayer.isInScenarioGroup,
			--IsWarbandMember = false,
			--IsTargeted = false,
			--IsMouseOvered = false,
			Pet = {healthPercent = gameDataPlayer.Pet.healthPercent},
			--ConType = 0,
			--MapPinType = 0,
			--SigilEntryId = 0,
			--RangeMin = RVAPI_Range.MIN_RANGE,
			--RangeMax = RVAPI_Range.MAX_RANGE,
			--GroupIndex = 0,
			--MemberIndex = 0,
		}
		-- maybe we should fire this later...
		RVAPI_Entities.API_SetEntityData(GameData.Player.worldObjNum, PlayerEntityData)
    end

end
