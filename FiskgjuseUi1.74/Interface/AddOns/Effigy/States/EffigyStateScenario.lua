if not Effigy then Effigy = {} end
local Addon = Effigy
if (nil == Addon.Name) then Addon.Name = "Effigy" end

function Addon.RegisterStateInfoForScenario()

	--[[for i=1,6 do
		for j=1,6 do
			state = HUDUFState:new("sp"..i..j.."hp")
		end
	end]]

	CreateWindowFromTemplate("HUDUFSPThrottle", "HUDUFEmpty", "Root")
	WindowSetShowing("HUDUFSPThrottle", true)
	--WindowRegisterCoreEventHandler("HUDUFSPThrottle", "OnUpdate", Addon.Name..".SPThrottle")
				
end


Addon.SPTime = 0.0
Addon.SPFreq = 0.5
Addon.InSP = false

function Addon.SPThrottle(elapsed)
	Addon.SPTime = Addon.SPTime + elapsed
	--HUDUFBuffs.Onupdate(elapsed)
	-- Make sure it updates during quiet time, in case we missed something
	-- due to throttle
	if (Addon.SPTime > Addon.SPFreq) then
		Addon.UpdateSP()
	end
end

function Addon.UpdateSP()
	if (Addon.SPTime > Addon.SPFreq) then
		Addon.SPTime = 0.0
	else
		return
	end


	if (false == GameData.Player.isInScenario) then
		if (true == Addon.FakeParty) then return end --fake party timez!@
		if (true == Addon.InSP) then
			Addon.InSP = false
			for i=1,4 do
				for j=1,6 do
					Addon.States["sp"..i..j.."hp"].valid = 0
					Addon.RemoveSCState(Addon.States["sp"..i..j.."hp"])
					Addon.States["sp"..i..j.."hp"]:render()
				end
			end
		end
		Addon.HideSCNubs()

		return
	end

	if (Addon.WindowSettings["SC"].disabled)
	then 
		 Addon.HideSCNubs()
		 if (Addon.InSP) then
			 for i=1,4 do
				 for j=1,6 do
					 Addon.States["sp"..i..j.."hp"].valid = 0
					 Addon.RemoveSCState(Addon.States["sp"..i..j.."hp"])
					 Addon.States["sp"..i..j.."hp"]:render()
				 end
			 end
		 end
		 return 
	end

-- 1.2 TODO checkme, moved to partyutils?
  	local groupData = GameData.GetScenarioPlayerGroups()

--	d(groupData)

	if (
		(not groupData) or
		(0 == #groupData)
		)
	then
		return
	end

	for i=1,6 do
		for j=1,6 do
			local s = HUDUFState:GetState("sp"..i..j.."hp")
			s:SetExtraInfo("updated",0)
		end
	end

	Addon.InSP = true
	Addon.ShowSCNubs()

	for _, p in ipairs(groupData) do
	-- 1.2 TODO checkme, might be zero based
		if (p.sgroupindex > 0) then
			local state = HUDUFState:GetState("sp"..p.sgroupindex..p.sgroupslotnum.."hp")
			state:SetExtraInfo("updated",1)
			--d(p)
			local name = p.name:match(L"([^^]+)^?([^^]*)") --thx Aiiane
		
			if (name ~= state:GetTitle()) or
				(p.health ~= state:GetValue()) or
				
				(0 == state:IsValid())
			then
					if (name ~= state:GetTitle()) then
						--state.valid = 0
						Addon.RemoveSCState(state)
					end
					local old_valid = state:IsValid()
					state:SetTitle(name)
					state:SetValue(p.health)
					state:SetMax(100)
					state:SetLevel(p.rank)
					state:SetExtraInfo("career",Addon.ConvertCareerIDToLine[p.careerId])
					state:SetExtraInfo("group",p.sgroupindex)
				


					state:SetValid(1)
					state:renderElements()
					
					-- Set the action for this window for new target
					-- mech in 1.0.5
					--if (0 == old_valid) then
					Addon.AddSCState(state)
					--d(state.bars)
					for k,v in ipairs(state.bars) do
						--local bar = Addon.Bars[v]
						if (nil ~= v) then
							--d(bar.name)
							WindowSetGameActionData(v.name, GameData.PlayerActions.SET_TARGET, 0, p.name)
						end
					end
					--end
					

			end
		end
	end

	-- Re-render those that were valid and arn't now so they
	-- go away
	for i=1,4 do
		for j=1,6 do
			local s = HUDUFState:GetState("sp"..i..j.."hp")
			local up = s:GetExtraInfo("updated")
			local valid = s:IsValid()
			
			if (0 == up) and (1 == valid)
			then
				s:SetValid(0)	
				Addon.RemoveSCState(Addon.States["sp"..i..j.."hp"])
				--d("Removing state "..i..j)
				s:render()
			end
		end
	end
end