Swinger = {}
local version = "1.1"

function Swinger.OnInitialize()
SwingSpeed =  GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[GameData.EquipSlots.RIGHT_HAND].speed )
Swinger.HasAttacked = false

RegisterEventHandler(TextLogGetUpdateEventId("Combat"), "Swinger.OnCombatLogUpdated")
TextLogAddEntry("Chat", 0, L"<icon00057> Swinger "..towstring(version)..L" Loaded.")

CreateWindow("SwingerWindow2", true)

LayoutEditor.RegisterWindow( "SwingerWindow2", L"SwingerWindow2", L"SwingerWindow2", true, true, true, nil )

end
function Swinger.OnCombatLogUpdated(updateType, filterType)
	if( updateType == SystemData.TextLogUpdate.ADDED ) then --only check if new posts where added on the CombatLog
		if filterType == SystemData.ChatLogFilters.YOUR_HITS then	-- only check for Your damage filter
			local _, filterId, text = TextLogGetEntry( "Combat", TextLogGetNumEntries("Combat") - 1 ) --Get the latest post in CombatLog
			if text:find(L"attack") then --if it finds this string in the post..
				local _,_,attack_Type = Swinger.Autoattack()
				--SwingSpeed = GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[attack_Type].speed )
				Swinger.HasAttacked = true	
				
			end		
		end
	end
end


function Swinger.Autoattack()
		local c_icon = 0
		local ability_name = L""
		local attackType = 0
			
			local MainHand = CharacterWindow.equipmentData[GameData.EquipSlots.RIGHT_HAND]
			local OffHand = CharacterWindow.equipmentData[GameData.EquipSlots.LEFT_HAND]
			local RangeHand = CharacterWindow.equipmentData[GameData.EquipSlots.RANGED]
			local TempAbilityData = GetAbilityData(2490)
			if OffHand.iconNum == TempAbilityData.iconNum then
				ability_name = OffHand.name
				attackType = GameData.EquipSlots.LEFT_HAND
			elseif RangeHand.iconNum == TempAbilityData.iconNum then
				ability_name = RangeHand.name
				attackType = GameData.EquipSlots.RANGED
			else
				ability_name = MainHand.name
				attackType = GameData.EquipSlots.RIGHT_HAND
			end
			c_icon = TempAbilityData.iconNum
		

return c_icon,ability_name,attackType
end


function Swinger.Update(timeElapsed)
local _,attackName,attack_Type = Swinger.Autoattack()
if GameData.Player.inCombat then

WindowSetShowing("SwingerWindow2",true)
else
SwingSpeed = GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[attack_Type].speed )
WindowSetShowing("SwingerWindow2",false)
end


if Swinger.HasAttacked == true then
SwingSpeed = SwingSpeed-timeElapsed
end


if SwingSpeed <= 0 and Swinger.HasAttacked == true then
Swinger.HasAttacked = false	
SwingSpeed = GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[attack_Type].speed )
end

StatusBarSetForegroundTint( "SwingerWindow2TimerBuildUp", 255, 255,255)	
StatusBarSetMaximumValue("SwingerWindow2TimerBuildUp",GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[attack_Type].speed ))
StatusBarSetCurrentValue("SwingerWindow2TimerBuildUp", GetBonus( GameData.BonusTypes.EBONUS_AUTO_ATTACK_SPEED, CharacterWindow.equipmentData[attack_Type].speed )-SwingSpeed )

LabelSetText("SwingerWindow2RangeLabel",wstring.format(L"%.01f", (SwingSpeed)))
LabelSetText("SwingerWindow2RangeLabelBG",wstring.format(L"%.01f", (SwingSpeed)))

end