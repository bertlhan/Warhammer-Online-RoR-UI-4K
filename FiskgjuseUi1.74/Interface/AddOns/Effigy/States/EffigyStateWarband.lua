if not Effigy then Effigy = {} end
local Addon = Effigy
if (nil == Addon.Name) then Addon.Name = "Effigy" end

Addon.player = {} -- hold temporary data about the player
Addon.player.playerName = GameData.Player.name:match(L"([^^]+)^?([^^]*)")

function Addon.RegisterStateInfoForWarband()

--[[	for i=1,6 do
		for j=1,6 do
			state = HUDUFState:new("bg"..i..j.."hp")
			--Addon.States["bg"..i..j.."hp"].valid = 0
			--Addon.States["bg"..i..j.."hp"].hidden = 1
		end
	end ]]--
	
	RegisterEventHandler(SystemData.Events.BATTLEGROUP_UPDATED, 
						 Addon.Name..".UpdateWarband")
    RegisterEventHandler(SystemData.Events.SCENARIO_END, 
						 Addon.Name..".UpdateWarband")

	CreateWindowFromTemplate("HUDUFWarbandThrottle", "HUDUFEmpty", "Root")
	WindowSetShowing("HUDUFWarbandThrottle", true)
--	WindowRegisterCoreEventHandler("HUDUFWarbandThrottle", 
--								   "OnUpdate", 
--								   Addon.Name..".WarbandThrottle")

end


Addon.WarbandTime = 0.0
Addon.WarbandFreq = 0.5
Addon.InWarband = false
Addon.WindowsShown = false
function Addon.WarbandThrottle(elapsed)
	Addon.WarbandTime = Addon.WarbandTime + elapsed

	-- Make sure it updates during quiet time, in case we missed something
	-- due to throttle
	if (Addon.WarbandTime > 2) then
		Addon.UpdateWarband(true)
	end
end

function Addon.UpdateWarband(timed)
	if (Addon.WarbandTime > Addon.WarbandFreq) then
		Addon.WarbandTime = 0.0
	else
		return
	end
	
-- 1.2 TODO checkme, might be moved to EA_Window_OpenParty

	local groups = GetBattlegroupMemberData()
	if (
		-- 1.2 TODO checkme, might have moved, or use EA_Window_OpenParty isinwarbandthingy if such a thing exists
		(0 == #groups[1].players) and
		(0 == #groups[2].players) and
		(0 == #groups[3].players) and
		(0 == #groups[4].players)
		)
	then
		if (true == Addon.FakeParty) then
			return 
		end
		--[[
		-- hide old windows
		if (true == Addon.InWarband) then
			for i=1,6 do
			-- 1.2 TODO checkme, zero indexed?
				for j=1,6 do
					--local state = HUDUFState:GetState("bg"..i..j.."hp")
					--Addon.RemoveWBState(state)
					--state:SetValid(0)
					--state:render()
				end
			end
		end
		Addon.HideWBNubs()
		Addon.WindowsShown = false
		]]
		Addon.InWarband = false
		return
	else
		Addon.InWarband = true
	end

	--[[
	-- when in scenario use scenario data, no need to display the battlegroup
	-- also no need to show them if they are disabled
	if ((
			(nil ~= Addon.WindowSettings["WB"].disabled)
			and
		 	(true == Addon.WindowSettings["WB"].disabled)
			) 
		or (true == Addon.InSP)
		) 
	then 
		if Addon.WindowsShown
		then
			Addon.HideWBNubs()
			Addon.WindowsShown = false
			 -- 1.2 TODO checkme - zero indexed?
			for i=1,6 do
				for j=1,6 do
					local state = HUDUFState:GetState("bg"..i..j.."hp")
					Addon.RemoveWBState(state)
					state:SetValid(0)
					state:render()
				end
			end
		end
	end]]--



	-- hide group frames if the user disabled them from the warband menu
	if ((Addon.WindowSettings["WB"].showgroup == nil) 
			or (Addon.WindowSettings["WB"].showgroup == false)) 
	then
		if (1 == Addon.States["grp1hp"].valid) then
			for j=1,5 do -- so hide it
				Addon.States["grp"..j.."hp"].valid = 0
				Addon.States["grp"..j.."ap"].valid = 0
				Addon.States["grp"..j.."morale"].valid = 0

				Addon.States["grp"..j.."hp"]:render()
				Addon.States["grp"..j.."ap"]:render()
				Addon.States["grp"..j.."morale"]:render()
			end
		end
	end
	
	
	-- if nothing else needs to be done return early
	if (
			(
				(Addon.WindowSettings["WB"].showgroup == nil) 
				or (Addon.WindowSettings["WB"].showgroup == false)
			) 
			and 
			(
				(Addon.WindowSettings["WB"].disabled ~= nil)
				and	(Addon.WindowSettings["WB"].disabled == true)
		 	)
		 	or
		 	(true == Addon.InSP)
		)
	then
		return
	end




	--Addon.ShowWBNubs()
	Addon.WindowsShown = true
	-- 1.2 TODO checkme, zero indexed?
	for i=1,6 do
		-- determin players group for group frames in warband, the players position in the warband is saved
		-- if no saved position is found or the player is no longer on the saved position it tries to find the player
		-- by comparing the players name and the names of all wb members
		if (
				(
					(Addon.WindowSettings["WB"].showgroup ~= nil) and
					(Addon.WindowSettings["WB"].showgroup == true)
				) 
				and
				(
					(Addon.player.WBGgroup == nil) or
					(groups[Addon.player.WBgroup].players[Addon.player.WBposition] == nil) or
					(groups[Addon.player.WBgroup].players[Addon.player.WBposition].name:match(L"([^^]+)^?([^^]*)") ~= Addon.player.playerName)
				))
		then
		-- 1.2 TODO checkme, zero indexed?
			if #groups[i].players
			then
				for p = 1,#groups[i].players do
					if (groups[i].players[p].name:match(L"([^^]+)^?([^^]*)") == Addon.player.playerName)
					then
						Addon.player.WBgroup = i
						Addon.player.WBposition = p
						d("found myself")
					end
				end
			end
		end
		-- GetBattlegroupMemberData includes the player as well, using our own position counter for the grp states
		local p = 1

	-- 1.2 TODO checkme, zero indexed?
		for j=1,6 do
			-- my group but not myself, so it should be one of my group members
			if ((
						(Addon.player.WBgroup == i ) and 
						(Addon.player.WBposition ~= j)
					) 
					and 
					(
						(Addon.WindowSettings["WB"].showgroup ~= nil) and
						(Addon.WindowSettings["WB"].showgroup == true)
					))
			then
				local m 
				if ( groups[i].players[j] ~= nil)
				then
					m = groups[i].players[j]
					Addon.UpdateGroupMember(p,m)
				elseif (1 == Addon.States["grp"..p.."hp"].valid) then -- if this is no longer a valid grp member
					Addon.States["grp"..p.."hp"].valid = 0
					Addon.States["grp"..p.."hp"]:renderElements()
					Addon.States["grp"..p.."ap"].valid = 0
					Addon.States["grp"..p.."ap"]:renderElements()
					Addon.States["grp"..p.."morale"].valid = 0
					Addon.States["grp"..p.."morale"]:renderElements()
				end
				p = p +1
			end

			--[[
			if ((j <= #groups[i].players) and
				((nil == Addon.WindowSettings["WB"].disabled) or
		 		(false == Addon.WindowSettings["WB"].disabled))) 
			then
				local state = HUDUFState:GetState("bg"..i..j.."hp")
				
				if  (state:GetValue() ~= groups[i].players[j].healthPercent) or
					(state:GetExtraInfo("career") ~= groups[i].players[j].careerLine ) or
					(state:GetTitle() ~= groups[i].players[j].name) or
					(state:GetEntityID() ~= groups[i].players[j].worldObjNum) or
					(0 == state:IsValid())
				then -- Only re-render the bar if we need too
					local old_valid = state:IsValid()
					
					state:SetValue(groups[i].players[j].healthPercent)
					state:SetMax(100)
					state:SetExtraInfo("career", groups[i].players[j].careerLine)
					
					if (groups[i].players[j].name ~= state:GetTitle()) then
						old_valid = 0
						-- TODO verify me
						Addon.RemoveWBState(state)
					end
					
					state:SetTitle(groups[i].players[j].name)
					state:SetExtraInfo("group", i)
					state:SetEntityID(groups[i].players[j].worldObjNum)
					
					state:SetExtraInfo("isPlayer", true)
					-- at least i hope so, sometimes im in doubt ;)
					stateSetExtraInfo("isFriendly", true)
					stateSetExtraInfo("isEnemy", false)

					state:SetValid(1)

					Addon.AddWBState(state)
					state:render()
					-- Set the action for this window for new target
					-- mech in 1.0.5
					
					if (0 == old_valid) then
						for k,v in ipairs(state.bars) do
							local bar = Addon.Bars[v]
							if (nil ~= bar) then
								WindowSetGameActionData(bar.name, GameData.PlayerActions.SET_TARGET, 0, groups[i].players[j].name)
							end
						end
					end
				end
			else
				if (0 ~= Addon.States["bg"..i..j.."hp"].valid) then
					-- only re-render if we need too
					Addon.RemoveWBState(Addon.States["bg"..i..j.."hp"])
					Addon.States["bg"..i..j.."hp"].valid = 0
					Addon.States["bg"..i..j.."hp"]:renderElements()
				end
			end
			]]	
		end
	end
end