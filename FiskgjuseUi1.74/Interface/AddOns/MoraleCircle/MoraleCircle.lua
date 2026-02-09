MoraleCircle = {}
local version = "1.2.9"
local MoralePerC = 0
local FillStart = 130
local FillEnd = 280




	function MoraleCircle.init()

	MoraleCircle.Flash = {}
	local txtr, x, y, disabledTexture = GetIconData (005118)

	CreateWindow("MoraleSlidersEmpty", false)
	CreateWindow("MoraleSlidersFill", false)
	CreateWindow("MoraleSlidersFull", false)
	CreateWindow("MoraleSliders", false)
	LabelSetText("MoraleSlidersCustomColorRedText", L"Red")
	LabelSetText("MoraleSlidersCustomColorBlueText", L"Blue")
	LabelSetText("MoraleSlidersCustomColorGreenText", L"Green")
	LabelSetText("MoraleSlidersFullCustomColorRedText", L"Red")
	LabelSetText("MoraleSlidersFullCustomColorBlueText", L"Blue")
	LabelSetText("MoraleSlidersFullCustomColorGreenText", L"Green")
	LabelSetText("MoraleSlidersFillCustomColorRedText", L"Red")
	LabelSetText("MoraleSlidersFillCustomColorBlueText", L"Blue")
	LabelSetText("MoraleSlidersFillCustomColorGreenText", L"Green")
	LabelSetText("MoraleSlidersEmptyCustomColorRedText", L"Red")
	LabelSetText("MoraleSlidersEmptyCustomColorBlueText", L"Blue")
	LabelSetText("MoraleSlidersEmptyCustomColorGreenText", L"Green")

	for i=1,4 do

		CreateWindowFromTemplate ("MoraleWindow"..i, "MoraleTemplate", "Root")
		CircleImageSetTexture ("MoraleWindow"..i.."Icon", txtr, 32, 32)
		CircleImageSetTexture ("MoraleWindow"..i.."BG", txtr, 32, 32)
		CircleImageSetTexture ("MoraleWindow"..i.."IconBG", txtr, 32, 32)
		WindowSetTintColor( "MoraleWindow"..i.."BG", 0,0,0 )
		WindowSetTintColor( "MoraleWindow"..i.."IconBG", 0,0,0 )
		AnimatedImageStartAnimation ("MoraleWindow"..i.."Glow", 0, true, true, 0)
		WindowSetScale("MoraleWindow"..i.."MoraleBindLabelBG",0.78)
		WindowSetScale("MoraleWindow"..i.."MoraleBindLabel",0.75)
		--WindowSetShowing("MoraleSliders", false)

		LayoutEditor.RegisterWindow( "MoraleWindow"..i, L"Morale "..towstring(i), L"Morale "..towstring(i), true, true, true, nil )
		MoraleCircle.Flash[i] = false
	end

	RegisterEventHandler (SystemData.Events.PLAYER_MORALE_UPDATED,          "MoraleCircle.OnMoraleUpdated")
	RegisterEventHandler (SystemData.Events.KEYBINDINGS_UPDATED,          "MoraleCircle.BindingsUpdate")
		RegisterEventHandler (SystemData.Events.PLAYER_MORALE_BAR_UPDATED,         "MoraleCircle.Morale_Bar")

if not MoraleCircle.Colors then
	MoraleCircle.Colors={}
	MoraleCircle.Colors.FillColor = {r=40,g=143,b=40}
	MoraleCircle.Colors.FullColor = {r=30,g=255,b=30}
	MoraleCircle.Colors.EmptyColor = {r=255,g=30,b=30}
	MoraleCircle.Colors.ColorGlower={r=0, g=255, b=0}
	MoraleCircle.Colors.Keybindings=true
	MoraleCircle.Colors.Tint=true
end



	MoraleCircle.M_Counter = {}
	MoraleCircle.M_Counter[1] = 10
	MoraleCircle.M_Counter[2] = 20
	MoraleCircle.M_Counter[3] = 50
	MoraleCircle.M_Counter[4] = 100

	TextLogAddEntry("Chat", 0, L"<icon57> MoraleCircle "..towstring(version)..L" Loaded.")

	MoraleCircle.BindingsUpdate()


end

function MoraleCircle.BindingsUpdate()
	for q=1,4 do
		local moraleBarNameUsed="MORALE_BAR_"..q
		local	moraleBarlongBindName=KeyUtils.GetFirstBindingNameForAction(moraleBarNameUsed)
		local moraleBarbindNameUsed=KeyUtils.ShortenBindingName(moraleBarlongBindName)
		LabelSetText("MoraleWindow"..q.."MoraleBindLabel", moraleBarbindNameUsed)
		LabelSetText("MoraleWindow"..q.."MoraleBindLabelBG",moraleBarbindNameUsed)
		if not MoraleCircle.Colors.Keybindings then
		WindowSetShowing("MoraleWindow"..q.."MoraleBindLabel", false)
		WindowSetShowing("MoraleWindow"..q.."MoraleBindLabelBG", false)
		end
	end
		MoraleCircle.Morale_Bar()
end

function MoraleCircle.update()
	for q=1,4 do
		local _, currentlySlottedMoraleAbilityId = GetMoraleBarData (q)
		local AbilityIcon = GetAbilityData(currentlySlottedMoraleAbilityId).iconNum
		local abilityId = GetAbilityData(currentlySlottedMoraleAbilityId).id
		local texture, x, y, disabledTexture = GetIconData (AbilityIcon)


		WindowSetTintColor("MoraleWindow"..q.."AbilityCooldown",10,0,0)
		WindowSetAlpha("MoraleWindow"..q.."AbilityCooldown",0.7)
		WindowSetShowing("MoraleWindow"..q,true)



		local M_Cdown,M_MaxCdown = GetMoraleCooldown (q)
		CircleImageSetTexture ("MoraleWindow"..q.."Icon", texture, 32, 32)

		if (texture == nil or texture == "icon000000") and SystemData.MouseOverWindow.name ~= "MoraleWindow"..q then
			WindowSetShowing("MoraleWindow"..q,false)
--			WindowSetAlpha("MoraleWindow"..q,0)
			WindowSetShowing("MoraleWindow"..q.."MoraleLabel" ,false)
			WindowSetShowing("MoraleWindow"..q.."MoraleLabelBG" ,false)
		else
--			WindowSetAlpha("MoraleWindow"..q,1)
			WindowSetShowing("MoraleWindow"..q,true)
			WindowSetShowing("MoraleWindow"..q.."MoraleLabel" ,true)
			WindowSetShowing("MoraleWindow"..q.."MoraleLabelBG" ,true)

		end

		if M_Cdown >= ActionButton.GLOBAL_COOLDOWN then
			CooldownDisplaySetCooldown( "MoraleWindow"..q.."AbilityCooldown", M_Cdown,60)
			LabelSetText("MoraleWindow"..q.."CooldownLabel",towstring(TimeUtils.FormatSeconds(M_Cdown, true)))
		else
			CooldownDisplaySetCooldown( "MoraleWindow"..q.."AbilityCooldown", M_Cdown, M_MaxCdown)
			LabelSetText("MoraleWindow"..q.."CooldownLabel",L"")
		end


		if MoralePerC >= MoraleCircle.M_Counter[q] then

			CircleImageSetFillParams( "MoraleWindow"..q.."Empty", FillStart,  FillEnd)
			WindowSetTintColor( "MoraleWindow"..q.."Empty", MoraleCircle.Colors.EmptyColor.r,MoraleCircle.Colors.EmptyColor.g,MoraleCircle.Colors.EmptyColor.b )


			CircleImageSetFillParams( "MoraleWindow"..q.."FillBG", FillStart,  FillEnd)
			WindowSetTintColor( "MoraleWindow"..q.."FillBG", 0,0,0 )
			CircleImageSetFillParams( "MoraleWindow"..q.."Fill", FillStart,  FillEnd)
			WindowSetTintColor( "MoraleWindow"..q.."Fill", MoraleCircle.Colors.FullColor.r,MoraleCircle.Colors.FullColor.g,MoraleCircle.Colors.FullColor.b )
			LabelSetText("MoraleWindow"..q.."MoraleLabel", L"100%")
			LabelSetText("MoraleWindow"..q.."MoraleLabelBG",L"100%")
			WindowSetAlpha("MoraleWindow"..q.."Glow",1)
			WindowSetTintColor("MoraleWindow"..q.."Glow",MoraleCircle.Colors.ColorGlower.r,MoraleCircle.Colors.ColorGlower.g,MoraleCircle.Colors.ColorGlower.b)
			WindowSetTintColor("MoraleWindow"..q.."Flash",MoraleCircle.Colors.ColorGlower.r,MoraleCircle.Colors.ColorGlower.g,MoraleCircle.Colors.ColorGlower.b)
			LabelSetTextColor("MoraleWindow"..q.."MoraleLabel",255,255,255)

			if WindowGetShowing("MoraleWindow"..q.."Flash") == false and MoraleCircle.Flash[q] == false then
				MoraleCircle.Flash[q] = true
				WindowSetShowing("MoraleWindow"..q.."Flash",true)
				WindowSetAlpha("MoraleWindow"..q.."Flash",1)
				WindowSetTintColor("MoraleWindow"..q.."Flash",MoraleCircle.Colors.ColorGlower.r,MoraleCircle.Colors.ColorGlower.g,MoraleCircle.Colors.ColorGlower.b)
				AnimatedImageStartAnimation ("MoraleWindow"..q.."Flash", 0, false, true, 0)
			end

		elseif MoralePerC <= MoraleCircle.M_Counter[q] then

			MoraleCircle.Flash[q] = false
			WindowSetShowing("MoraleWindow"..q.."Flash",false)
			WindowSetAlpha("MoraleWindow"..q.."Flash",0)
			AnimatedImageStopAnimation ("MoraleWindow"..q.."Flash")

			local startFill = 280 * (1 - (MoralePerC / GetMoralePercentForLevel(q)))


			CircleImageSetFillParams( "MoraleWindow"..q.."Empty", FillStart,  FillEnd)
			WindowSetTintColor( "MoraleWindow"..q.."Empty",  MoraleCircle.Colors.EmptyColor.r,MoraleCircle.Colors.EmptyColor.g,MoraleCircle.Colors.EmptyColor.b )
			CircleImageSetFillParams( "MoraleWindow"..q.."FillBG", FillStart,  FillEnd - (startFill-4))
			WindowSetTintColor( "MoraleWindow"..q.."FillBG",0,10,20 )
			CircleImageSetFillParams( "MoraleWindow"..q.."Fill", FillStart,  FillEnd - startFill )
			WindowSetTintColor( "MoraleWindow"..q.."Fill",MoraleCircle.Colors.FillColor.r,MoraleCircle.Colors.FillColor.g,MoraleCircle.Colors.FillColor.b )
			LabelSetText("MoraleWindow"..q.."MoraleLabel",towstring(math.abs(MoralePerC/GetMoralePercentForLevel (q))*100)..L"%")
			LabelSetText("MoraleWindow"..q.."MoraleLabelBG",towstring(math.abs(MoralePerC/GetMoralePercentForLevel (q))*100)..L"%")
			WindowSetAlpha("MoraleWindow"..q.."Glow",0)
			LabelSetTextColor("MoraleWindow"..q.."MoraleLabel",255,255,255)




		end


		local isBlocked = Player.IsAbilityBlocked( abilityId, GameData.AbilityType.MORALE )
		local isTargetValid, hasRequiredUnitTypeTargeted = IsTargetValid (abilityId)
		local isTargetValid = (isTargetValid or (hasRequiredUnitTypeTargeted == false))
		local MoraleCalc = (tonumber(MoralePerC)/tonumber(GetMoralePercentForLevel(q)))*100
		local isnotready=MoraleCalc <= 99

		if (isTargetValid and not isBlocked) then
			WindowSetTintColor( "MoraleWindow"..q.."Icon", 255,255,255 )
		else
			WindowSetTintColor( "MoraleWindow"..q.."Icon", 255,0,0 )
		end
		if isnotready and MoraleCircle.Colors.Tint then
			WindowSetTintColor("MoraleWindow"..q.."Icon", 65, 65, 65)
		else
			WindowSetTintColor("MoraleWindow"..q.."Icon", 255, 255, 255)
		end


  end
end


function MoraleCircle.OnMouseOverStart(flags)
	local MouseOverWindowName = SystemData.MouseOverWindow.name
	local anchor = nil
    if  DoesWindowExist( "MouseOverTargetWindow" )and ( SystemData.Settings.GamePlay.staticAbilityTooltipPlacement or SystemData.Settings.GamePlay.staticTooltipPlacement ) then
        anchor = Tooltips.ANCHOR_MOUSE_OVER_TARGET_WINDOW
    else
        anchor = topleft
    end

	for i=1,4 do
		if MouseOverWindowName == "MoraleWindow"..i then
			if not (flags == SystemData.ButtonFlags.SHIFT) then
				WindowSetMovable( "MoraleWindow"..i, false )
				local _, currentlySlottedMoraleAbilityId = GetMoraleBarData (i)
				local abilityId = GetAbilityData(currentlySlottedMoraleAbilityId).id
				local MData = Player.GetAbilityData (GetAbilityData(currentlySlottedMoraleAbilityId).id, Player.AbilityType.MORALE)
				Tooltips.CreateAbilityTooltip( MData, SystemData.MouseOverWindow.name, anchor,L"<icon49>MoraleCircle",{ r = 50, g = 150, b =255 })
			else
				WindowSetMovable( "MoraleWindow"..i, true )
			end
		end
	end
end


function MoraleCircle.Click(flags)
	if GameData.Player.inCombat == true then return end
	local MouseOverWindowName = SystemData.MouseOverWindow.name
	for i=1,4 do
		if MouseOverWindowName == "MoraleWindow"..i then
			if  flags == SystemData.ButtonFlags.SHIFT then
				WindowSetGameActionData( "MoraleWindow"..i, 0, 0, L"" )
			else
				local _, currentlySlottedMoraleAbilityId = GetMoraleBarData (i)
				local AbilityIcon = GetAbilityData(currentlySlottedMoraleAbilityId).iconNum
				local abilityId = GetAbilityData(currentlySlottedMoraleAbilityId).id
				WindowSetGameActionData ("MoraleWindow"..i, GameData.PlayerActions.DO_ABILITY, abilityId, L"")
			end
		end
	end
end

function MoraleCircle.Morale_Bar()
	for i=1,4 do
				local _, currentlySlottedMoraleAbilityId = GetMoraleBarData (i)
				local AbilityIcon = GetAbilityData(currentlySlottedMoraleAbilityId).iconNum
				local abilityId = GetAbilityData(currentlySlottedMoraleAbilityId).id
				WindowSetGameActionData ("MoraleWindow"..i, GameData.PlayerActions.DO_ABILITY, abilityId, L"")
	end
end



function MoraleCircle.Reset(flags)
	local MouseOverWindowName = SystemData.MouseOverWindow.name
	for i=1,4 do
		if MouseOverWindowName == "MoraleWindow"..i then
			if  flags == SystemData.ButtonFlags.SHIFT then
				WindowSetScale("MoraleWindow"..i,1)
				WindowSetScale("MoraleWindow"..i.."MoraleBindLabel",0.75)
				WindowSetScale("MoraleWindow"..i.."MoraleBindLabelBG",0.78)
				WindowSetAlpha("MoraleWindow"..i,1)
			end
		end
	end
end

function MoraleCircle.OnMouseWheel(x, y, delta, flags)
	local MouseOverWindowName = SystemData.MouseOverWindow.name
	if flags == SystemData.ButtonFlags.SHIFT then
		for i=1,4 do
			if MouseOverWindowName == "MoraleWindow"..i then
				if (delta > 0) then
					--d(L"Scroll Up on "..towstring(i))
					WindowSetScale("MoraleWindow"..i,WindowGetScale("MoraleWindow"..i)+0.1)
					WindowSetScale("MoraleWindow"..i.."MoraleBindLabel",0.75)
					WindowSetScale("MoraleWindow"..i.."MoraleBindLabelBG",0.78)
				elseif (delta < 0) then
					WindowSetScale("MoraleWindow"..i,WindowGetScale("MoraleWindow"..i)-0.1)
					WindowSetScale("MoraleWindow"..i.."MoraleBindLabel",0.75)
					WindowSetScale("MoraleWindow"..i.."MoraleBindLabelBG",0.78)
					--d(L"Scroll Down on "..towstring(i))
				end
			end
		end
	end
end

function MoraleCircle.RightClick(flags)
	local MouseOverWindowName = SystemData.MouseOverWindow.name
	if not (flags == SystemData.ButtonFlags.SHIFT) then
		for i=1,4 do
			if  MouseOverWindowName == "MoraleWindow"..i then
				local M_Cdown,M_MaxCdown = GetMoraleCooldown (i)
				local _, currentlySlottedMoraleAbilityId = GetMoraleBarData (i)
				local abilityId = GetAbilityData(currentlySlottedMoraleAbilityId).id
				local MData = Player.GetAbilityData (GetAbilityData(currentlySlottedMoraleAbilityId).id, Player.AbilityType.MORALE)
				local MoraleCalc = (tonumber(MoralePerC)/tonumber(GetMoralePercentForLevel(i)))*100
				local SmartChannel = MoraleCircle.GetSmartChannel()
				local LinkName = L"[Morale "..towstring(i)..L": "..towstring(MData.name)..L"]"
				local DoneLink = CreateHyperLink(L"0",LinkName, {229, 77, 255}, {} )
				if (MoraleCalc >= 99) and (M_Cdown <= ActionButton.GLOBAL_COOLDOWN ) then
						SendChatText(towstring(SmartChannel)..towstring(DoneLink)..L" - <LINK data=\"0\" text=\"READY!\" color=\"50,255,50\">", L"")
				else
					if M_Cdown > ActionButton.GLOBAL_COOLDOWN then MoraleCD = L" - "..towstring("<LINK data=\"0\" text=\"")..towstring(math.modf(M_Cdown))..L"s\" color=\"255,50,50\">" else MoraleCD = L"" end
					if MoraleCalc <= 99 then MoralePercent = L" - <LINK data=\"0\" text=\""..towstring(math.modf(MoraleCalc))..L"%\" color=\"255,255,50\">" else MoralePercent = L"" end
					SendChatText(towstring(SmartChannel)..towstring(DoneLink)..towstring(MoralePercent)..towstring(MoraleCD), L"")
				end
			end
		end

	else

		local showBindMoraleKeyvalue=""
		local showTintvalue=""
		for q=1,4 do
		if WindowGetShowing("MoraleWindow"..q.."MoraleBindLabel") then
			showBindMoraleKeyvalue="Hide"
				else
			showBindMoraleKeyvalue="Show"
		end
		if MoraleCircle.Colors.Tint then
			showTintvalue="On"
		else
			showTintvalue="Off"
		end
	end





    EA_Window_ContextMenu.CreateContextMenu(SystemData.MouseOverWindow.name)
		EA_Window_ContextMenu.AddMenuItem( towstring("Keybindings: "..showBindMoraleKeyvalue), MoraleCircle.ShowKeybinds, false, true )
		EA_Window_ContextMenu.AddMenuItem( towstring("Tint: "..showTintvalue), MoraleCircle.ShowTint, false, true )
    EA_Window_ContextMenu.AddMenuItem( GetString( StringTables.Default.LABEL_SET_OPACITY ), EA_Window_ContextMenu.OnWindowOptionsSetAlpha, false, true )
		EA_Window_ContextMenu.AddCascadingMenuItem( L"Color", MoraleCircle.ColorChanger, false, 1 )
    EA_Window_ContextMenu.Finalize()
	end
end

function MoraleCircle.ShowKeybinds()
for q=1,4 do
if WindowGetShowing("MoraleWindow"..q.."MoraleBindLabel") then
	WindowSetShowing("MoraleWindow"..q.."MoraleBindLabel", false)
	WindowSetShowing("MoraleWindow"..q.."MoraleBindLabelBG", false)
	MoraleCircle.Colors.Keybindings=false;
else
	WindowSetShowing("MoraleWindow"..q.."MoraleBindLabel", true)
		WindowSetShowing("MoraleWindow"..q.."MoraleBindLabelBG", true)
		WindowSetScale("MoraleWindow"..q.."MoraleBindLabel",0.75)
		WindowSetScale("MoraleWindow"..q.."MoraleBindLabelBG",0.78)
		MoraleCircle.Colors.Keybindings=true;
end
end
end

function MoraleCircle.ShowTint()
	if MoraleCircle.Colors.Tint then
		MoraleCircle.Colors.Tint=false;
	else
		MoraleCircle.Colors.Tint=true;
	end
end




function MoraleCircle.ColorChanger()
EA_Window_ContextMenu.CreateContextMenu( "MoraleCircleColorMenu", 2, L"" )
EA_Window_ContextMenu.AddCascadingMenuItem( L"Glow Color", MoraleCircle.ColorChanger1, false, 2 )
EA_Window_ContextMenu.AddCascadingMenuItem( L"Fill Color", MoraleCircle.ColorChanger2, false, 2 )
EA_Window_ContextMenu.AddCascadingMenuItem( L"Full Color", MoraleCircle.ColorChanger3, false, 2 )
EA_Window_ContextMenu.AddCascadingMenuItem( L"Empty Color", MoraleCircle.ColorChanger4, false, 2 )
--EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSliders",2)
--EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSliderGreen",2)
--EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSliderBlue",2)
EA_Window_ContextMenu.Finalize( 2, nil )
end

function MoraleCircle.Round2(num, numDecimalPlaces)
  return towstring(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end


function MoraleCircle.ColorChanger1()
EA_Window_ContextMenu.CreateContextMenu( "MoraleCircleColorMenu", 3, L"" )

local color=MoraleCircle.Colors.ColorGlower
WindowSetTintColor("MoraleSlidersCustomColorSwatch", color.r,		 color.g,		 color.b)



redPos = color.r / 255
SliderBarSetCurrentPosition("MoraleSlidersCustomColorRedSlider", redPos)
LabelSetText("MoraleSlidersCustomColorRedValue", MoraleCircle.Round2(color.r))
grePos = color.g / 255
SliderBarSetCurrentPosition("MoraleSlidersCustomColorGreenSlider", grePos)
LabelSetText("MoraleSlidersCustomColorGreenValue", MoraleCircle.Round2(color.g))
bluPos = color.b / 255
SliderBarSetCurrentPosition("MoraleSlidersCustomColorBlueSlider", bluPos)
LabelSetText("MoraleSlidersCustomColorBlueValue", MoraleCircle.Round2(color.b))

EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSliders",3)
EA_Window_ContextMenu.Finalize( 3, nil )
end



function MoraleCircle.ColorChanger2()
EA_Window_ContextMenu.CreateContextMenu( "MoraleCircleColorMenu", 3, L"" )

local color=MoraleCircle.Colors.FillColor
WindowSetTintColor("MoraleSlidersFillCustomColorSwatch", color.r,		 color.g,		 color.b)

redPos = color.r / 255
SliderBarSetCurrentPosition("MoraleSlidersFillCustomColorRedSlider", redPos)
grePos = color.g / 255
SliderBarSetCurrentPosition("MoraleSlidersFillCustomColorGreenSlider", grePos)
bluPos = color.b / 255
SliderBarSetCurrentPosition("MoraleSlidersFillCustomColorBlueSlider", bluPos)

LabelSetText("MoraleSlidersFillCustomColorRedValue", MoraleCircle.Round2(color.r))
LabelSetText("MoraleSlidersFillCustomColorGreenValue", MoraleCircle.Round2(color.g))
LabelSetText("MoraleSlidersFillCustomColorBlueValue", MoraleCircle.Round2(color.b))

EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSlidersFill",3)
EA_Window_ContextMenu.Finalize( 3, nil )
end

function MoraleCircle.ColorChanger3()
EA_Window_ContextMenu.CreateContextMenu( "MoraleCircleColorMenu", 3, L"" )

local color=MoraleCircle.Colors.FullColor
WindowSetTintColor("MoraleSlidersFullCustomColorSwatch", color.r,		 color.g,		 color.b)

redPos = color.r / 255
SliderBarSetCurrentPosition("MoraleSlidersFullCustomColorRedSlider", redPos)
grePos = color.g / 255
SliderBarSetCurrentPosition("MoraleSlidersFullCustomColorGreenSlider", grePos)
bluPos = color.b / 255
SliderBarSetCurrentPosition("MoraleSlidersFullCustomColorBlueSlider", bluPos)

LabelSetText("MoraleSlidersFullCustomColorRedValue", MoraleCircle.Round2(color.r))
LabelSetText("MoraleSlidersFullCustomColorGreenValue", MoraleCircle.Round2(color.g))
LabelSetText("MoraleSlidersFullCustomColorBlueValue", MoraleCircle.Round2(color.b))


EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSlidersFull",3)
EA_Window_ContextMenu.Finalize( 3, nil )
end

function MoraleCircle.ColorChanger4()
EA_Window_ContextMenu.CreateContextMenu( "MoraleCircleColorMenu", 3, L"" )

local color=MoraleCircle.Colors.EmptyColor
WindowSetTintColor("MoraleSlidersEmptyCustomColorSwatch", color.r,		 color.g,		 color.b)

redPos = color.r / 255
SliderBarSetCurrentPosition("MoraleSlidersEmptyCustomColorRedSlider", redPos)
grePos = color.g / 255
SliderBarSetCurrentPosition("MoraleSlidersEmptyCustomColorGreenSlider", grePos)
bluPos = color.b / 255
SliderBarSetCurrentPosition("MoraleSlidersEmptyCustomColorBlueSlider", bluPos)

LabelSetText("MoraleSlidersEmptyCustomColorRedValue", MoraleCircle.Round2(color.r))
LabelSetText("MoraleSlidersEmptyCustomColorGreenValue", MoraleCircle.Round2(color.g))
LabelSetText("MoraleSlidersEmptyCustomColorBlueValue", MoraleCircle.Round2(color.b))


EA_Window_ContextMenu.AddUserDefinedMenuItem("MoraleSlidersEmpty",3)
EA_Window_ContextMenu.Finalize( 3, nil )
end



function MoraleCircle.OnSetCustomColor()
    local colorRatio = 0
    local color=MoraleCircle.Colors.ColorGlower
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersCustomColorBlueSlider")
    color.b = colorRatio * 255

    -- Update the color swatch
    WindowSetTintColor("MoraleSlidersCustomColorSwatch", color.r,
                                                       color.g,
                                                       color.b)

        -- Update the color
        MoraleCircle.Colors.ColorGlower.r = color.r
        MoraleCircle.Colors.ColorGlower.g = color.g
        MoraleCircle.Colors.ColorGlower.b = color.b

				-- Update the label

				LabelSetText("MoraleSlidersCustomColorRedValue", MoraleCircle.Round2(color.r))
				LabelSetText("MoraleSlidersCustomColorGreenValue", MoraleCircle.Round2(color.g))
				LabelSetText("MoraleSlidersCustomColorBlueValue", MoraleCircle.Round2(color.b))

end

function MoraleCircle.OnSetCustomColorFill()
    local colorRatio = 0
    local color=MoraleCircle.Colors.FillColor
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFillCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFillCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFillCustomColorBlueSlider")
    color.b = colorRatio * 255

    -- Update the color swatch
    WindowSetTintColor("MoraleSlidersFillCustomColorSwatch", color.r,
                                                       color.g,
																											 color.b)


        -- Update the color
        MoraleCircle.Colors.FillColor.r = color.r
        MoraleCircle.Colors.FillColor.g = color.g
        MoraleCircle.Colors.FillColor.b = color.b

				LabelSetText("MoraleSlidersFillCustomColorRedValue", MoraleCircle.Round2(color.r))
				LabelSetText("MoraleSlidersFillCustomColorGreenValue", MoraleCircle.Round2(color.g))
				LabelSetText("MoraleSlidersFillCustomColorBlueValue", MoraleCircle.Round2(color.b))

end

function MoraleCircle.OnSetCustomColorFull()
    local colorRatio = 0
    local color=MoraleCircle.Colors.FullColor
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFullCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFullCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersFullCustomColorBlueSlider")
    color.b = colorRatio * 255

    -- Update the color swatch
    WindowSetTintColor("MoraleSlidersFullCustomColorSwatch", color.r,
                                                       color.g,
                                                       color.b)

        -- Update the color
        MoraleCircle.Colors.FullColor.r = color.r
        MoraleCircle.Colors.FullColor.g = color.g
        MoraleCircle.Colors.FullColor.b = color.b

				LabelSetText("MoraleSlidersFullCustomColorRedValue", MoraleCircle.Round2(color.r))
				LabelSetText("MoraleSlidersFullCustomColorGreenValue", MoraleCircle.Round2(color.g))
				LabelSetText("MoraleSlidersFullCustomColorBlueValue", MoraleCircle.Round2(color.b))
end

function MoraleCircle.OnSetCustomColorEmpty()
    local colorRatio = 0
    local color=MoraleCircle.Colors.EmptyColor
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersEmptyCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersEmptyCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("MoraleSlidersEmptyCustomColorBlueSlider")
    color.b = colorRatio * 255

    -- Update the color swatch
    WindowSetTintColor("MoraleSlidersEmptyCustomColorSwatch", color.r,
                                                       color.g,
                                                       color.b)

        -- Update the color
        MoraleCircle.Colors.EmptyColor.r = color.r
        MoraleCircle.Colors.EmptyColor.g = color.g
        MoraleCircle.Colors.EmptyColor.b = color.b

				LabelSetText("MoraleSlidersEmptyCustomColorRedValue", MoraleCircle.Round2(color.r))
				LabelSetText("MoraleSlidersEmptyCustomColorGreenValue", MoraleCircle.Round2(color.g))
				LabelSetText("MoraleSlidersEmptyCustomColorBlueValue", MoraleCircle.Round2(color.b))
end


function MoraleCircle.GetSmartChannel()
    local switcher = L"/say "
    local groupData = GetGroupData()
    for k,v in pairs(groupData) do
        if v and v.name and v.name ~= L"" then
            switcher = L"/party "
        end
    end
    if IsWarBandActive() and ((not GameData.Player.isInScenario) or (not GameData.Player.isInSiege)) then
        switcher = L"/warband "
    end
    if GameData.Player.isInScenario or GameData.Player.isInSiege then
        switcher = L"/sc "
		end
		if IsWarBandActive() and GameData.Player.isInSiege then
			 switcher = L"/sc "
    end
    return switcher
end

function MoraleCircle.OnMoraleUpdated(moralePercent, moraleLevel)
	MoralePerC = math.abs(moralePercent)
end
