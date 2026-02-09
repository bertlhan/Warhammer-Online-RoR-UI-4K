local Version = 1.7

GuardList = {}

local SEND_BEGIN = 1
local SEND_FINISH = 2
GuardList.ShieldIcons = {[1]=4515,[5]=2558,[10]=8078,[13]=5172,[17]=13373,[21]=11018}
GuardList.StateTimer = 0.1
local L_Labels = {["true"]=L"true",["false"]=L"false"}
local L_OFFSET = {["up"]={["center"]={-40,-3,"bottom","top",-7},["left"]={-40,-3,"bottomleft","topleft",-7},["right"]={-40,-3,"bottomright","topright",-7}},["down"]={["center"]={40,3,"top","bottom",7},["left"]={40,3,"topleft","bottomleft",7},["right"]={40,3,"topright","bottomright",7}}}

--[[
GuardList.DefaultColor = {r=255,g=255,b=255}
GuardList.CloseColor = {r=50,g=255,b=50}
GuardList.MidColor = {r=100,g=100,b=255}
GuardList.FarColor = {r=255,g=50,b=50}
GuardList.Distant = {r=125,g=125,b=125}
--]]

function GuardList.Initialize()
CreateWindow("GuardList_Window0", true)

LayoutEditor.RegisterWindow( "GuardList_Window0", L"Guard List", L"Guard List", true, true, false)
CircleImageSetTexture("GuardList_Window0ShieldIcon","GuardIcon", 32, 32)

LabelSetText("GuardList_Window0Label",L"--")
LabelSetText("GuardList_Window0LabelBG",L"--")
GuardList.stateMachineName = "GuardList"
GuardList.state = {[SEND_BEGIN] = { handler=nil,time=GuardList.StateTimer,nextState=SEND_FINISH } , [SEND_FINISH] = { handler=GuardList.UpdateStateMachine,time=GuardList.StateTimer,nextState=SEND_BEGIN, } , }
GuardList.StartMachine()
AnimatedImageStartAnimation ("GuardList_Window0Glow", 0, true, true, 0)	

	if GuardList.Settings == nil or (GuardList.Settings.version < Version) then GuardList.ResetSettings() end

	if GuardLine == true and GuardLine.Settings.Colors and GuardList.Settings.UseGuardLineColors == true then
		GuardList.DefaultColor = GuardLine.Settings.Colors.Default
		GuardList.CloseColor = GuardLine.Settings.Colors.Close
		GuardList.MidColor = GuardLine.Settings.Colors.Mid
		GuardList.FarColor = GuardLine.Settings.Colors.Far
		GuardList.Distant = GuardLine.Settings.Colors.Distant
		GuardList.Dead = GuardLine.Settings.Colors.Dead
	else
		GuardList.DefaultColor = GuardList.Settings.Colors.Default
		GuardList.CloseColor = GuardList.Settings.Colors.Close
		GuardList.MidColor = GuardList.Settings.Colors.Mid
		GuardList.FarColor = GuardList.Settings.Colors.Far
		GuardList.Distant = GuardList.Settings.Colors.Distant
		GuardList.Dead = GuardList.Settings.Colors.Dead
	end


	for i=1,5 do
		CreateWindowFromTemplate("GuardList_Window"..i, "GuardList_Window0", "Root")
		WindowClearAnchors("GuardList_Window"..i)
		WindowAddAnchor( "GuardList_Window"..i , "bottom", "GuardList_Window"..(i-1), "top", 0,14)	
		WindowSetMovable( "GuardList_Window"..i, false )			
	end

	if LibGuard then 
		LibGuard.Register_Callback(GuardList.LG_Update)
	end

	if LibSlash then
		LibSlash.RegisterSlashCmd("guardlist", function(input) GuardList.Command(input) end)
		LibSlash.RegisterSlashCmd("guardrange", function(input) GuardList.Command(input) end)		
	end
end

function GuardList.StartMachine()
	local stateMachine = TimedStateMachine.New( GuardList.state,SEND_BEGIN)
	TimedStateMachineManager.AddStateMachine( GuardList.stateMachineName, stateMachine )
end

function GuardList.ComparePlayers( index,tablename )
    table.sort(index, function (a,b)
    return (a.distance < b.distance)
	end)

end

function GuardList.SortPlayers(array)
	if array == nil then return end
	
	local Index = 0
	local sortedPlayers = {};	
	for k, v in pairs(array)
	do		
		if v.distance ~= nil then
			table.insert(sortedPlayers,v);
			Index = Index+1
		end
	end	
	if Index > 1 then
		table.sort(sortedPlayers, function(a,b) return a.distance < b.distance end);
	end
	return sortedPlayers;	
end


function GuardList.UpdateStateMachine()

	if  LibGuard.registeredGuards then
		Guard_DisplayOrder = {}
		local IndexCount = 0
			for k, v in pairs (LibGuard.registeredGuards) do
				IndexCount = IndexCount+1
				if LibGuard.registeredGuards[k].Info ~= nil and type(LibGuard.registeredGuards[k].Info) ~= "number" and LibGuard.registeredGuards[k].Info.isDistant == true then
					LibGuard.registeredGuards[k].distance = 90000 + IndexCount
				end					
			end
		GuardListdata = GuardList.SortPlayers(LibGuard.registeredGuards)			
	end


WindowClearAnchors("GuardList_Window0Label")
WindowAddAnchor( "GuardList_Window0Label", tostring(GuardList.Settings.align), "GuardList_Window0", tostring(GuardList.Settings.align), 0,3)	

for i=1,5 do
WindowSetShowing("GuardList_Window"..i,false)
WindowSetScale("GuardList_Window"..i,(WindowGetScale("GuardList_Window0")*0.8))
WindowClearAnchors("GuardList_Window"..i)
WindowAddAnchor( "GuardList_Window"..i , L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][4], "GuardList_Window"..(i-1), L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][3], 0,L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][5])	
end
	if  GuardListdata then

		local function Offset(state)
		if state then
			return L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][1]
			else
			return L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][2]
			end
		end			
		
		WindowClearAnchors("GuardList_Window1")
		WindowAddAnchor( "GuardList_Window1" , L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][3], "GuardList_Window0", L_OFFSET[GuardList.Settings.orientation][GuardList.Settings.align][3], 0,Offset(WindowGetShowing("GuardList_Window0")))	
	
		local Index = 0
		for k, v in ipairs( GuardListdata ) do
			if ((LibGuard.GuarderData.XGuard == true) and (LibGuard.GuarderData.Name == GuardListdata[k].Name)) == false then
				Index = Index + 1
				WindowSetShowing("GuardList_Window"..Index,true)
				local GuardName = L""
				if GuardList.Settings.ShowGuardedName == true then GuardName = towstring(GuardListdata[k].Name) end
				
				

				if (GuardListdata[k].Info ~= nil and type(GuardListdata[k].Info) ~= "number" and GuardListdata[k].Info.isDistant ~= nil) and (GuardListdata[k].Info.isDistant == false) then
					local color = GuardList.DefaultColor
					local Distance = GuardListdata[k].distance
					local Distance_Label = towstring(Distance)				


						local function toggleText(state)
							if not state then
								return L" ft"
							else
								return L""
							end
						end			

						local IsDistant = true
						if GuardListdata[k].Info ~= nil then
						IsDistant = GuardListdata[k].Info.isDistant
						end
					
					if (GuardListdata[k].Info.healthPercent > 0) then
					
						if Distance < 0 then
						color = GuardList.DefaultColor
						elseif Distance <= 30 and Distance >= 0 then
							color = GuardList.CloseColor
						elseif Distance > 30 and Distance <= 50 then
							color = GuardList.MidColor
						elseif Distance > 50 then
							color = GuardList.FarColor
						else
							--Distance_Label = L" Distant"
							Distance_Label = GuardList.Settings.Labels.Distant.."  "
							color = GuardList.Distant
						end
					else
					IsDistant = true
					Distance_Label = GuardList.Settings.Labels.Dead.."  "
					color = GuardList.Dead
					end
				
				
					LabelSetText("GuardList_Window"..Index.."Label",GuardName..L" "..towstring(CreateHyperLink(L"Distance",towstring(Distance_Label), {color.r, color.g, color.b},{}))..toggleText(IsDistant))
					LabelSetText("GuardList_Window"..Index.."LabelBG",LabelGetText("GuardList_Window"..Index.."Label"))				
					
					WindowSetTintColor("GuardList_Window"..Index.."Shield", color.r, color.g, color.b )
					WindowSetTintColor("GuardList_Window"..Index.."ShieldIcon",255, 255, 255 )				
					
				else
					LabelSetText("GuardList_Window"..Index.."Label",GuardName..towstring(CreateHyperLink(L"Distance",L" "..towstring(GuardList.Settings.Labels.Distant.."  "), {GuardList.Distant.r, GuardList.Distant.g, GuardList.Distant.b},{})))
					LabelSetText("GuardList_Window"..Index.."LabelBG",LabelGetText("GuardList_Window"..Index.."Label"))
					
					WindowSetTintColor("GuardList_Window"..Index.."Shield", GuardList.Distant.r, GuardList.Distant.g, GuardList.Distant.b )
					WindowSetTintColor("GuardList_Window"..Index.."ShieldIcon",155, 155, 155 )				
				end

				local Guard_Icon = GuardList.ShieldIcons[GuardListdata[k].Career] or 0
				--local Guard_Icon = GetIconData( Icons.GetCareerIconIDFromCareerLine(GuardListdata[k].career ) )
				if GuardList.Settings.ShowGuardedIcon == true then
					local texture, x, y, disabledTexture = GetIconData(tonumber(Guard_Icon))
					CircleImageSetTexture("GuardList_Window"..Index.."ShieldIcon",texture, 32, 32)	
								
					WindowSetShowing("GuardList_Window"..Index.."Shield",true)
				else
					WindowSetShowing("GuardList_Window"..Index.."Shield",false)
				end
				
				local Fontwidth,FontHeight = LabelGetTextDimensions("GuardList_Window"..Index.."Label")
				WindowSetDimensions("GuardList_Window"..Index, Fontwidth, FontHeight)
				WindowSetAlpha("GuardList_Window"..Index, GuardList.Settings.alpha)
				WindowSetFontAlpha("GuardList_Window"..Index,GuardList.Settings.alpha)			
				--strange fix for linked label that gets alpha resetted after changing
				WindowSetFontAlpha("GuardList_Window"..Index.."Label",GuardList.Settings.alpha+0.1)
				WindowSetFontAlpha("GuardList_Window"..Index.."LabelBG",GuardList.Settings.alpha+0.1)
				WindowSetFontAlpha("GuardList_Window"..Index.."Label",GuardList.Settings.alpha)
				WindowSetFontAlpha("GuardList_Window"..Index.."LabelBG",GuardList.Settings.alpha)
			end

		end

	end	
	
	if LibGuard.GuarderData.IsGuarding then
	
			local color = GuardList.DefaultColor
			local Distance = LibGuard.GuarderData.distance
			local IsLive = false
			if LibGuard.GuarderData.Info ~= nil then
				IsLive = (LibGuard.GuarderData.Info.healthPercent > 0) or false
			else
				IsLive = false
			end
			
			
		if IsLive then
				if (LibGuard.GuarderData.Info ~= nil and type(LibGuard.GuarderData.Info) ~= "number" and LibGuard.GuarderData.Info.isDistant ~= nil) and (LibGuard.GuarderData.Info.isDistant == false) then	

					if Distance < 0 then
						color = GuardList.DefaultColor
						CircleImageSetTexture("GuardList_Window0ShieldIcon","PetIcon", 32, 32)
					elseif Distance <= 30 and Distance >= 0 then
						color = GuardList.CloseColor
						CircleImageSetTexture("GuardList_Window0ShieldIcon","GuardIcon", 32, 32)
					elseif Distance > 30 and Distance <= 50 then
						color = GuardList.MidColor
						CircleImageSetTexture("GuardList_Window0ShieldIcon","BreakIcon", 32, 32)
					elseif Distance > 50 then
						color = GuardList.FarColor
						CircleImageSetTexture("GuardList_Window0ShieldIcon","BreakIcon", 32, 32)
					else
						color = GuardList.DefaultColor
						CircleImageSetTexture("GuardList_Window0ShieldIcon","DistantIcon", 32, 32)
					end
				else
					--Distance = L"Distant "
					Distance = GuardList.Settings.Labels.Distant.."  "
					CircleImageSetTexture("GuardList_Window0ShieldIcon","DistantIcon", 32, 32)
					color = GuardList.Distant
				end
		else
		--Distance = L"Dead "	
		Distance = GuardList.Settings.Labels.Dead.."  "
		CircleImageSetTexture("GuardList_Window0ShieldIcon","DeadIcon", 32, 32)
		color = GuardList.Dead
		end
			
						local function toggleText(state)
							if not state then
								return L" "..towstring(GuardList.Settings.Labels.Range)
							else
								return L""
							end
						end			
			
				local IsDistant = true
				if LibGuard.GuarderData.Info ~= nil and LibGuard.GuarderData.Info ~= 0 then
				IsDistant = LibGuard.GuarderData.Info.isDistant or not IsLive
				end
				local Distance_Label = towstring(Distance)
				local GuardName = L""
				if GuardList.Settings.ShowGuardingName == true then GuardName = towstring(LibGuard.GuarderData.Name) end
				WindowSetTintColor("GuardList_Window0Shield", color.r, color.g, color.b )
				WindowSetTintColor("GuardList_Window0ShieldIcon", color.r, color.g, color.b )				
				WindowSetShowing("GuardList_Window0",true)
				WindowSetShowing("GuardList_Window0Glow",(LibGuard.GuarderData.XGuard and GuardList.Settings.ShowGuardingIcon) or false)
				WindowSetTintColor("GuardList_Window0Glow", color.r, color.g, color.b )
				
				if LibGuard.UsePet == true then
					if LibGuard.FakeGuarding == true and (GameData.Player.Pet.healthPercent > 0) then
						LabelSetText("GuardList_Window0Label",GuardName..L" "..towstring(CreateHyperLink(L"Distance",towstring(GameData.Player.Pet.healthPercent), {color.r, color.g, color.b},{}))..L"%")
						LabelSetText("GuardList_Window0LabelBG",LabelGetText("GuardList_Window0Label"))							
					else
						LabelSetText("GuardList_Window0Label",GuardName..L" "..towstring(CreateHyperLink(L"Distance",Distance_Label, {color.r, color.g, color.b},{}))..toggleText(IsDistant))
						LabelSetText("GuardList_Window0LabelBG",LabelGetText("GuardList_Window0Label"))			
					end
				end
				WindowSetShowing("GuardList_Window0Shield",GuardList.Settings.ShowGuardingIcon)


	else
	WindowSetShowing("GuardList_Window0",false)
	WindowSetShowing("GuardList_Window0Glow",false)
	LabelSetText("GuardList_Window0Label",L"--")
	LabelSetText("GuardList_Window0LabelBG",L"--")
	end	
				WindowSetAlpha("GuardList_Window0", GuardList.Settings.alpha)
				WindowSetFontAlpha("GuardList_Window0",GuardList.Settings.alpha)
				--strange fix for linked label that gets alpha resetted after changing
				WindowSetFontAlpha("GuardList_Window0Label",GuardList.Settings.alpha+0.1)
				WindowSetFontAlpha("GuardList_Window0LabelBG",GuardList.Settings.alpha+0.1)
				WindowSetFontAlpha("GuardList_Window0Label",GuardList.Settings.alpha)
				WindowSetFontAlpha("GuardList_Window0LabelBG",GuardList.Settings.alpha)
return		
end


function GuardList.ResetSettings()

GuardList.Settings = {
	version = Version,
	ShowGuardedName = true,
	ShowGuardingName = true,
	ShowGuardedIcon = true,
	ShowGuardingIcon = true,
	UseGuardLineColors = true,
	orientation = "down",
	align = "center",
	alpha = 1,
	Colors = {
		Default = {r=255,g=75,b=200},
		Close = {r=50,g=255,b=50},
		Mid = {r=255,g=175,b=10},
		Far = {r=255,g=50,b=50},
		Distant = {r=125,g=125,b=125},
		Dead = {r=175,g=175,b=175}
	},
	Labels = {
	Distant = "Distant",
	Dead = "Dead",
	Range = "ft"
	}
}
end

function GuardList.Command(input)
	local input1 = nil
	local input2 = nil
	
	input1 = string.sub(input,0,string.find(input," "))
	if string.find(input," ") ~= nil then
		input1 = string.sub(input,0,string.find(input," ")-1)
		input2 = string.sub(input,string.find(input," ")+1,-1)
	end


	if (input1 == "out") then
		if(input2 == "icon") then
			GuardList.Settings.ShowGuardingIcon = not GuardList.Settings.ShowGuardingIcon
		elseif(input2 == "name") then
			GuardList.Settings.ShowGuardingName = not GuardList.Settings.ShowGuardingName	
		else
			EA_ChatWindow.Print(L"GuardList Outgoing Settings:\n     show icon: "..towstring(L_Labels[GuardList.Settings.ShowGuardingIcon])..L"\n     show name: "..towstring(L_Labels[GuardList.Settings.ShowGuardingName]))
			return
		end
	elseif (input1 == "in") then
		if(input2 == "icon") then
			GuardList.Settings.ShowGuardedIcon = not GuardList.Settings.ShowGuardedIcon
		elseif(input2 == "name") then
			GuardList.Settings.ShowGuardedName = not GuardList.Settings.ShowGuardedName	
		else
			EA_ChatWindow.Print(L"GuardList Incomming Settings:\n     show icon: "..towstring(L_Labels[GuardList.Settings.ShowGuardedIcon])..L"\n     show name: "..towstring(L_Labels[GuardList.Settings.ShowGuardedName]))
			return
		end
	elseif (input1 == "orientation") then
		if(input2 == "up") then
			GuardList.Settings.orientation = "up"
		elseif(input2 == "down") then
			GuardList.Settings.orientation = "down"
		else
			EA_ChatWindow.Print(L"GuardList Orientation: "..towstring(GuardList.Settings.orientation)..L"\noptions: up, down")
			return
		end	
	elseif (input1 == "align") then
		if(input2 == "left") then
			GuardList.Settings.align = "left"
		elseif(input2 == "right") then
			GuardList.Settings.align = "right"
		elseif(input2 == "center") then
			GuardList.Settings.align = "center"			
		else
			EA_ChatWindow.Print(L"GuardList align: "..towstring(GuardList.Settings.align)..L"\noptions: left, right, center")
			return
		end			
	elseif (input1 == "color") then
		GuardList.Settings.UseGuardLineColors = not GuardList.Settings.UseGuardLineColors
	elseif (input1 == "alpha") then
		if input2 ~= nil then
			GuardList.Settings.alpha = tonumber(input2)
		else
			EA_ChatWindow.Print(L"Sets GuardLists alpha. Current value: "..towstring(GuardList.Settings.alpha))
		end
	elseif (input1 == "reset") then
		GuardList.ResetSettings()
	else		
		EA_ChatWindow.Print(L"\n GuardList Ver:"..towstring(Version))
		EA_ChatWindow.Print(L"\n Options for GuardList to toggle incomming/outgoing icon/name on or off:\n /GuardList <in/out> <icon/name>")
		EA_ChatWindow.Print(L"GuardList Outgoing Settings:\n     show icon: "..(L_Labels[tostring(GuardList.Settings.ShowGuardingIcon)])..L"\n     show name: "..(L_Labels[tostring(GuardList.Settings.ShowGuardingName)]))
		EA_ChatWindow.Print(L"GuardList Incomming Settings:\n     show icon: "..(L_Labels[tostring(GuardList.Settings.ShowGuardedIcon)])..L"\n     show name: "..(L_Labels[tostring(GuardList.Settings.ShowGuardedName)]))
		EA_ChatWindow.Print(L"GuardList alpha: "..towstring(GuardList.Settings.alpha))
		EA_ChatWindow.Print(L"GuardList orientation: "..towstring(GuardList.Settings.orientation))
		EA_ChatWindow.Print(L"GuardList align: "..towstring(GuardList.Settings.align))
	return
	end
	
end


function GuardList.LG_Update(state,GuardedName,GuardedID)
GuardList.UpdateStateMachine()
end
