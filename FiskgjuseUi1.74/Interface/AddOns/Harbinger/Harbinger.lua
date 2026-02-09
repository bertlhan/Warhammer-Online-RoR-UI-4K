Harbinger = {}	
Harbinger.Stance = 0	
local CurrentCareer = GameData.Player.career.id
local Pressed = false
Harbinger.HarbingerSlot = 0
Harbinger.KeySlot = 0

Harbinger.GFX = {[22]="Rune",[66]="Harbinger"}
	
function Harbinger.Initialize()	
	CurrentCareer = GameData.Player.career.id

	TextLogAddEntry("Chat", 0, L"<icon57> Harbinger v1.7c Loaded")

	if CurrentCareer ~= 22 and CurrentCareer ~= 66 then return end
	
	RegisterEventHandler(SystemData.Events.ALL_MODULES_INITIALIZED, "Harbinger.RegisterAbilitySlot")
	RegisterEventHandler(SystemData.Events.LOADING_END, "Harbinger.RegisterAbilitySlot")
	RegisterEventHandler (SystemData.Events.PLAYER_HOT_BAR_UPDATED,"Harbinger.RegisterAbilitySlot")
	Harbinger.RegisterAbilitySlot()
	Harbinger.CheckStance()

	CreateWindow("HarbingerWindow", false)
	LayoutEditor.RegisterWindow( "HarbingerWindow", L"Harbinger", L"Harbinger Recource", true, true, true, nil )	
	Harbinger.update()
	DynamicImageSetTexture("HarbingerWindowFrame",Harbinger.GFX[tonumber(CurrentCareer)],0,0)		
end

function Harbinger.OnShutdown()
	UnregisterEventHandler(SystemData.Events.ALL_MODULES_INITIALIZED, "Harbinger.RegisterAbilitySlot")
	UnregisterEventHandler(SystemData.Events.LOADING_END, "Harbinger.RegisterAbilitySlot")
	UnregisterEventHandler (SystemData.Events.PLAYER_HOT_BAR_UPDATED,"Harbinger.RegisterAbilitySlot")
end

--Find the Harbinger abilty slot
function Harbinger.RegisterAbilitySlot()
	Harbinger.HarbingerSlot = 0
	local ID,TYPE
	Harbinger.AbilitySlot={}
	for i=0,121	do
		TYPE,ID=GetHotbarData(i)
		if ID == 8550 or  ID == 1659 then
			Harbinger.HarbingerSlot = i
		break
		end
	end
	
		for i=1,GameDefs.HOTBAR_SWAPPABLE_SLOT_COUNT do
			local HotSlot = {}
			HotSlot[1],HotSlot[2],HotSlot[3],HotSlot[4],HotSlot[5] = GetHotbarData(i)
			if HotSlot[2] == 8550 or HotSlot[2] == 1659 then
						local Bar,Slot = ActionBarConstants:BarAndButtonFromSlot (i)
						local SlotName = "EA_ActionBar"..tostring(Bar).."Action"..tostring(Slot).."Action"
						Harbinger.KeySlot = SlotName
						break
			end
		end
end
	
function Harbinger.OnUpdate(timeElapsed)
if (CurrentCareer == 22) or (CurrentCareer == 66) then
	if Pressed == false then
		if (ButtonGetPressedFlag(tostring(Harbinger.KeySlot))) == true then
			Pressed = true
		end
	end
	
	if Pressed == true then		
		if (ButtonGetPressedFlag(tostring(Harbinger.KeySlot))) == false then
			Pressed = false
			local TYPE,ID=GetHotbarData(Harbinger.HarbingerSlot)
			if ID == 0 then return end
			local current,max = GetHotbarCooldown(Harbinger.HarbingerSlot)
			if current == 0 then
				
				local CP,_ = ActionBars:BarAndButtonIdFromSlot(Harbinger.HarbingerSlot)
				if CP.m_Buttons[math.mod(Harbinger.HarbingerSlot,12)].m_Windows[5].m_Showing == true then
					Harbinger.Stance = 1
					Harbinger.CheckStance()
				else
					Harbinger.Stance = 2
					Harbinger.CheckStance()
				end
			end
		end
	end
end	
end

function Harbinger.CheckStance()
	if DoesWindowExist("HarbingerWindowFrame") then
		if Harbinger.Stance == 0 then
		elseif Harbinger.Stance == 1 then
			DynamicImageSetTextureSlice("HarbingerWindowFrame","Healing")
		elseif Harbinger.Stance == 2 then
			DynamicImageSetTextureSlice("HarbingerWindowFrame","Damage")
		end
	end
end

function Harbinger.update()
	if (CurrentCareer == 22) or (CurrentCareer == 66) then
		WindowSetShowing("HarbingerWindow",true)
	else
		WindowSetShowing("HarbingerWindow",false)
	end
end
