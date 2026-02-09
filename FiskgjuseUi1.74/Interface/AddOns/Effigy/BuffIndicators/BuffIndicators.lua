--Create Edit Delete
-- Edit: Window, LibBuffEvents.RegisterEventHandler({bttSelf, {"selfcasts", type = "BUFFTYPE"} }, "self selfcast", LibBuffEvents.TestHandler), whatToDoWithBoolean

--------------------------------------------------------------------------------
-- File:      BuffIndicators.lua
-- Date:      2010-02-16
-- Author:    Philosound
-- Credits:   MrAngel, Reivan
-- Version:   v1.0
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

if not BuffIndicators then BuffIndicators = {} end
local Addon	= BuffIndicators
if (nil == Addon.Name) then Addon.Name = "BuffIndicators" end

local RVName				= "BuffIndicators"
local RVCredits				= "MrAngel, silverq, rozbuska"
local RVLicense				= "MIT License"
local RVProjectURL			= "none yet"
local RVRecentUpdates		= 
"24.02.2010 - v0.9 Release\n"..
"\t- Code clearance\n"..
"\t- Adapted to work with the RV Mods Manager v0.99"

local LibGUI = LibStub("LibGUI")

Addon.ButtonWidth = 260
Addon.ButtonInherits = "EA_Button_DefaultResizeable"
Addon.FontHeadline = "font_default_war_heading" 
Addon.FontBold = "font_default_medium_heading" --"font_clear_medium_bold"
Addon.FontText = "font_default_text" -- "font_clear_medium"

function Addon.SetToolTip(item, str, str2, str3, str4, str5, str6)
	Tooltips.CreateTextOnlyTooltip(item.name)
	if (nil ~= str) then
		Tooltips.SetTooltipText(1, 1, towstring(str))
	end
	if (nil ~= str2) then
		Tooltips.SetTooltipText(2, 1, towstring(str2))
	end
	if (nil ~= str3) then
		Tooltips.SetTooltipText(3, 1, towstring(str3))
	end
	if (nil ~= str4) then
		Tooltips.SetTooltipText(4, 1, towstring(str4))
	end
	if (nil ~= str5) then
		Tooltips.SetTooltipText(5, 1, towstring(str5))
	end
	if (nil ~= str6) then
		Tooltips.SetTooltipText(6, 1, towstring(str6))
	end

	Tooltips.Finalize()
	local anchor = { 
					Point = "topleft",  
					RelativeTo = item.name, 
					RelativePoint = "topright",   
					XOffset = -10, YOffset = -10 }

	Tooltips.AnchorTooltip(anchor)
end

--------------------------------------------------------------
-- var RVMOD
-- Description: module information/system configuration
--------------------------------------------------------------
Addon.RVMOD =
{
	--[[--------------------------------------------------------
	--	@type: (optional) 
	--	@description: put your full name here.
	--
	--	ATTENTION: UiMod name="RVMOD_YourModName" in the RVMOD_YourModName.mod should 
	--	be the same as your mod table name - i.e. RVMOD_YourModName
	--------------------------------------------------------]]--
	Name = "BuffIndicators",

	--[[--------------------------------------------------------
	--	@type: (optional) 
	--	@description: put your description here.
	--------------------------------------------------------]]--
	Description	= "Generic Buff Indicators",
}

local LastComboBoxName		= "" -- : hack, but no other way to do that at the moment
local WindowSettings		= Addon.Name.."SettingsWindow"
local WindowFrame			= Addon.Name.."Frame"
local Templates				= {}
local LastFrameId			= 1
local Frames				= {}


function Addon.Print(str)
	if str == nil then
		str = "nil"
	elseif type(str) == "boolean" then
		if str then str = "true" else str = "false" end
	end
	EA_ChatWindow.Print(towstring(Addon.Name)..L": "..towstring( str ) )
end
--------------------------------------------------------------
-- Create a Indicator
--------------------------------------------------------------
Addon.Indicator = {}
Addon.Indicator.__index = Addon.Indicator
Addon.DefaultIndicator = {
	name = "new indicator", 
	
	BuffEvent = { 
		BuffTargetType = "Self", 
		Watch = "HEALDEBUFF", 
		Parameter = ""
	}, 
	Actions = {
		TargetWindow = "",
		Visibility = { enabled = true,},
		Color = { enabled = false, r = 255, g = 255, b = 255 },
	}
}

function Addon.Indicator:new (name)
	return Addon.Indicator:newFrom (name, Addon.DefaultIndicator)
end

function Addon.Indicator:newFrom (name, indicator)
	if (nil ~= Addon.CurrentConfiguration[name]) then
		EA_ChatWindow.Print(L"Cannot create a new indicator for one that exists")
		return nil 
	end
	local self = {}

	setmetatable(self, Addon.Indicator) -- setup prototye

	self.Name = name
	
	self.BuffEvent = {}
	self.BuffEvent.BuffTargetType = indicator.BuffEvent.BuffTargetType
	self.BuffEvent.Watch = indicator.BuffEvent.Watch
	self.BuffEvent.Parameter = indicator.BuffEvent.Parameter
	
	self.Actions = {}
	self.Actions.TargetWindow = indicator.Actions.TargetWindow
	self.Actions.Visibility = {}
	self.Actions.Visibility.enabled = indicator.Actions.Visibility.enabled
	self.Actions.Color = {}
	self.Actions.Color.enabled = indicator.Actions.Color.enabled
	self.Actions.Color.r = indicator.Actions.Color.r
	self.Actions.Color.g = indicator.Actions.Color.g
	self.Actions.Color.b = indicator.Actions.Color.b
	
	Addon.CurrentConfiguration[name] = self

	return self
end

--------------------------------------------------------------
-- var DefaultConfiguration
-- Description: default module configuration
--------------------------------------------------------------
Addon.DefaultConfiguration	= Addon.GetFactoryPresets()


--------------------------------------------------------------
-- var CurrentConfiguration
-- Description: current module configuration
--------------------------------------------------------------
Addon.CurrentConfiguration =
{
	-- should stay empty, will load in the InitializeConfiguration() function
}

--------------------------------------------------------------
-- function Initialize()
-- Description:
--------------------------------------------------------------
function Addon.Initialize()

	-- First step: load configuration
	Addon.InitializeConfiguration()

	-- Second step: define event handlers
	RegisterEventHandler(SystemData.Events.ALL_MODULES_INITIALIZED, Addon.Name..".OnAllModulesInitialized")
	RegisterEventHandler(SystemData.Events.LOADING_END, Addon.Name..".OnLoad")
	RegisterEventHandler(SystemData.Events.RELOAD_INTERFACE, Addon.Name..".OnLoad")
end

--------------------------------------------------------------
-- function OnRVManagerCallback
-- Description:
--------------------------------------------------------------
function Addon.OnRVManagerCallback(Self, Event, EventData)

	if		Event == RVMOD_Manager.Events.NAME_REQUESTED then

		return RVName

	elseif	Event == RVMOD_Manager.Events.CREDITS_REQUESTED then

		return RVCredits

	elseif	Event == RVMOD_Manager.Events.LICENSE_REQUESTED then

		return RVLicense

	elseif	Event == RVMOD_Manager.Events.PROJECT_URL_REQUESTED then

		return RVProjectURL

	elseif	Event == RVMOD_Manager.Events.RECENT_UPDATES_REQUESTED then

		return RVRecentUpdates

	elseif	Event == RVMOD_Manager.Events.PARENT_WINDOW_UPDATED then

		if not DoesWindowExist(WindowSettings) then
			Addon.InitializeSettingsWindow()
		end

		WindowSetParent(WindowSettings, EventData.ParentWindow)
		WindowClearAnchors(WindowSettings)
		WindowAddAnchor(WindowSettings, "topleft", EventData.ParentWindow, "topleft", 0, 0)
		WindowAddAnchor(WindowSettings, "bottomright", EventData.ParentWindow, "bottomright", 0, 0)

		Addon.UpdateSettingsWindow()

		return true

	end
end

--------------------------------------------------------------
-- function OnAllModulesInitialized()
-- Description: event ALL_MODULES_INITIALIZED
-- We can start working with the RVAPI just then we sure they are all initialized
-- and ready to provide their services
--------------------------------------------------------------
function Addon.OnAllModulesInitialized()

		-- Final step: register in the RV Mods Manager
	-- Please note the folowing:
	-- 1. always do this ON SystemData.Events.ALL_MODULES_INITIALIZED event
	-- 2. you don't need to add RVMOD_Manager to the dependency list
	-- 3. the registration code should be same as below, with your own function parameters
	-- 4. for more information please follow by http://war.curse.com/downloads/war-addons/details/rv_mods.aspx
	if RVMOD_Manager then
		RVMOD_Manager.API_RegisterAddon(Addon.Name, Addon, Addon.OnRVManagerCallback)
	end

end

function Addon.OnLoad()		-- Only called once to delay registering to when GameData is available
	Addon.RegisterBuffs()
end
--------------------------------------------------------------
-- function Shutdown()
-- Description:
--------------------------------------------------------------
function Addon.Shutdown()
	-- First step: destroy settings window
	if DoesWindowExist(WindowSettings) then
		DestroyWindow(WindowSettings)
	end

	-- Second step: unregister events
	Addon.UnregisterBuffs()
	UnregisterEventHandler(SystemData.Events.ALL_MODULES_INITIALIZED, Addon.Name..".OnAllModulesInitialized")
	UnregisterEventHandler(SystemData.Events.LOADING_END, Addon.Name..".OnLoad")
	UnregisterEventHandler(SystemData.Events.RELOAD_INTERFACE, Addon.Name..".OnLoad")
end

--------------------------------------------------------------
-- function InitializeConfiguration()
-- Description: loads current configuration
--------------------------------------------------------------
function Addon.InitializeConfiguration()

	-- First step: move default value to the CurrentConfiguration variable
	for k,v in pairs(Addon.DefaultConfiguration) do
		if(Addon.CurrentConfiguration[k]==nil) then
			Addon.CurrentConfiguration[k]=v
		end
	end
end

--------------------------------------------------------------
-- function InitializeSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.InitializeSettingsWindow(ParentWindow)
	-- First step: create main window
	local w = {}
	w = LibGUI("Window", WindowSettings)

	-- Create new Indicator
	w.lCreateInd = w("Label")
	w.lCreateInd:Resize(65)
	w.lCreateInd:AnchorTo(w, "topleft", "topleft", 25, 25)
	w.lCreateInd:Font(Addon.FontText)
	w.lCreateInd:SetText(L"Create:")
	w.lCreateInd:Align("left")
	w.lCreateInd:IgnoreInput()

	w.tCreateInd = w("Textbox")
	w.tCreateInd:Resize(250)
	w.tCreateInd:AnchorTo(w.lCreateInd, "bottomleft", "topleft", 0, 0)
	w.tCreateInd.OnKeyEnter =
		function()
			if (nil ~= w.tCreateInd:GetText()) and (L"" ~= w.tCreateInd:GetText()) then
				Addon.Indicator:new(WStringToString(w.tCreateInd:GetText()))
				w.cEditInd:Add(w.tCreateInd:GetText())
				w.cEditInd:Select(w.tCreateInd:GetText())
				w.tCreateInd:Clear()
				Addon.OnSelChangedEditComboBox()
				Addon.RegisterBuff(Addon.CurrentConfiguration[w.tCreateInd:GetText()])
			end
		end
    w.tCreateInd.OnKeyTab =
		function()
			--EA_ChatWindow.Print(L"Tab")
			Addon.Indicator:new(WStringToString(w.tCreateInd:GetText()))
			w.cEditInd:Add(w.tCreateInd:GetText())
			w.cEditInd:Select(w.tCreateInd:GetText())
			Addon.OnSelChangedEditComboBox()
		end
    w.tCreateInd.OnKeyEscape =
		function()
			--EA_ChatWindow.Print(L"ESCAPE")
			w.tCreateInd:Clear()
		end

	-- edit color
	w.lEditInd = w("Label", WindowSettings.."lEditInd")
	w.lEditInd:Resize(65)
	w.lEditInd:AnchorTo(w.lCreateInd, "right", "left", 200, 0)
	w.lEditInd:Font(Addon.FontText)
	w.lEditInd:SetText(L"Edit:")
	w.lEditInd:Align("left")
	w.lEditInd:IgnoreInput()
	
	w.cEditInd = w("Combobox", WindowSettings.."cEditInd", Addon.Name.."ComboBoxTemplate")
	w.cEditInd:AnchorTo(w.lEditInd, "bottomleft", "topleft", 0, 0)
	w.cEditInd.OnLButtonUp = 
		function()
			LastComboBoxName = w.cEditInd.name
		end

	w.buttonDelete = w("Button", nil, Addon.ButtonInherits)
	w.buttonDelete:Resize(Addon.ButtonWidth)
	w.buttonDelete:SetText(L"Delete")
	w.buttonDelete:AnchorTo(w.cEditInd, "right", "left", 10, 0)
	w.buttonDelete.OnLButtonUp = 
		function()
			if (nil ~= w.cEditInd:Selected()) and (L"" ~= w.cEditInd:Selected()) then
				local name = WStringToString(w.cEditInd:Selected())
				Addon.UnregisterBuff(Addon.CurrentConfiguration[name])
				if Addon.DefaultConfiguration[name] ~= nil then
					Addon.ResetFactoryPreset(name)
					Addon.RegisterBuff(Addon.CurrentConfiguration[name])
					Addon.OnSelChangedEditComboBox()
					Addon.Print("Resetted Factory Preset "..name.." to default values.")
					return
				end
				Addon.CurrentConfiguration[name] = nil
				Addon.PopulateEditCombobox()
				w.cEditInd:Select("default")
				Addon.OnSelChangedEditComboBox("default")
				Addon.Print("Deleted Indicator: "..name)
			end
		end
		
	Addon.W = w
	Addon.PopulateEditCombobox()
	Addon.W:Show()
end

function Addon.PopulateEditCombobox()
	local w = Addon.W
	w.cEditInd:Clear()
	local tt={}
	for k,v in pairs(Addon.CurrentConfiguration) do
		table.insert (tt, k)
	end
	table.sort(tt)
	for k,v in pairs(tt) do w.cEditInd:Add(v) end
end
--------------------------------------------------------------
-- function ShowModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.ShowModuleSettings(ModuleWindow)

	-- First step: check for window
	if not DoesWindowExist(WindowSettings) then
		Addon.InitializeSettingsWindow(ModuleWindow)
	end

	-- Second step: update fields with the current configuration 
	Addon.UpdateSettingsWindow()

	-- Final step: show everything
	WindowSetShowing(WindowSettings, true)
end

--------------------------------------------------------------
-- function HideModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.HideModuleSettings()

	-- Final step: hide window
	WindowSetShowing(WindowSettings, false)
end

--------------------------------------------------------------
-- function GetModuleStatus()
-- Description: returns module status: RV_System.Status
--------------------------------------------------------------
function Addon.GetModuleStatus()

	-- Final step: return status
	-- TODO: (MrAngel) place a status calculation code in here
	return RV_System.Status.MODULE_STATUS_ENABLED
end

--------------------------------------------------------------
-- function UpdateSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.UpdateSettingsWindow()

end

-- LibGUI ComboBox OnSelChanged bad WarAPI Workaround
function Addon.OnSelChanged()
	
	if LastComboBoxName == Addon.W.cEditInd.name then
		local w = Addon.W
		if (nil ~= w.cEditInd:Selected()) and (L"" ~= w.cEditInd:Selected()) then
			local name = WStringToString(w.cEditInd:Selected())
			Addon.EditIndicator(name)
			Addon.C:AnchorTo(Addon.W, "topleft", "topleft", 0, 100)
			Addon.C:AddAnchor(Addon.W, "bottomright", "bottomright", 0, 0)
			Addon.C:Parent(Addon.W)
			if Addon.DefaultConfiguration[name] ~= nil then w.buttonDelete:SetText(L"Reset") else w.buttonDelete:SetText(L"Delete") end
		end
	elseif LastComboBoxName == Addon.C.Color.cColorPresets.name then
		-- on "none"
		local selection = WStringToString(Addon.C.Color.cColorPresets:Selected())
		if selection ~= nil and selection ~= "none" then
			local ColorPreset = RVMOD_GColorPresets.GetColorPreset(selection)
			Addon.C.Color.colorBox:Tint(ColorPreset.r, ColorPreset.g, ColorPreset.b)
		else
			local name = WStringToString(Addon.W.cEditInd:Selected())
			Addon.C.Color.colorBox:Tint(Addon.CurrentConfiguration[name].Actions.Color.r, Addon.CurrentConfiguration[name].Actions.Color.g, Addon.CurrentConfiguration[name].Actions.Color.b)
		end
	end
end


--
-- Getters
function Addon.GetIndicatorPresets()
	return Addon.CurrentConfiguration
end

function Addon.GetIndicatorPreset(presetName)
	return Addon.CurrentConfiguration[presetName]
end

local function CreateColorFrame(settings)
	local w = LibGUI("BlackFrame")
	w:Resize(400, 100)
	w.lColor = w("Label")
	w.lColor:Resize(150)
	w.lColor:Position(10, 10)
	w.lColor:Font(Addon.FontText)
	w.lColor:SetText(L"Color:")
	w.lColor:Align("left")
	w.lColor.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lColor, "Override the color of the Target Window when the event occurs.")
		end
			
	w.checkColor = w("Checkbox")
	w.checkColor:AnchorTo(w.lColor, "right", "left", 10, -5)
	w.checkColor:SetValue(settings.enabled)
		
	w.colorBox = w("Image")
	w.colorBox:Resize(25,25)
	--w.colorBox:Alpha(1)
	--w.colorBox:Tint(settings[n].color.r, settings[n].color.g, settings[n].color.b)
	w.colorBox:AnchorTo(w.checkColor, "right", "left", 10, 0)
	--w.colorBox:CaptureInput()
		
	-- windows and frames registercoreeventhandler does not work for lua as of 1.3.4
	w.colorBoxLabelForEvents = w("Label")
	w.colorBoxLabelForEvents:AnchorTo(w.colorBox, "topleft", "topleft", 0, 0)
	w.colorBoxLabelForEvents:AddAnchor(w.colorBox, "bottomright", "bottomright", 0, 0)
	w.colorBoxLabelForEvents.OnLButtonUp =
		function()
			local selection = WStringToString(w.cColorPresets:Selected())
			if RVMOD_GColorPresets ~= nil and selection ~= nil and selection ~= "" and selection ~= "none" then
				RVMOD_GColorPresets.EditColorPreset(selection)
			else
				local ColorDialogOwner, ColorDialogFunction = RVAPI_ColorDialog.API_GetLink()
				if ColorDialogOwner ~= Addon or ColorDialogFunction ~= Addon.OnColorDialogCallback then
					-- Third step: open color dialog
					RVAPI_ColorDialog.API_OpenDialog(Addon, Addon.OnColorDialogCallback, true, settings.r, settings.g, settings.b, 1, Window.Layers.SECONDARY)
				else
					-- Fourth step: close color dialog
					RVAPI_ColorDialog.API_CloseDialog(true)
				end
			end
		end
		
	if RVMOD_GColorPresets ~= nil then
		w.lColorPresets = w("Label")
		w.lColorPresets:Resize(70)
		w.lColorPresets:AnchorTo(w.lColor, "bottomleft", "topleft", 5, 10)
		w.lColorPresets:Font(Addon.FontText)
		w.lColorPresets:SetText(L"Preset:")
		w.lColorPresets:Align("left")
		w.lColorPresets.OnMouseOver = 
			function() 
				Addon.SetToolTip(w.lColorPresets, "Chose a preset or define a custom color.")
			end
		w.cColorPresets = w("combobox", w.name.."cColorPresets", Addon.Name.."ComboBoxTemplate")
		w.cColorPresets:AnchorTo(w.lColorPresets, "right", "left", 0, -5)
		w.cColorPresets.OnLButtonUp = 
			function()
				LastComboBoxName = w.cColorPresets.name
			end
		local colorPresets = RVMOD_GColorPresets.GetColorPresets()
		w.cColorPresets:Clear()
		w.cColorPresets:Add("none")
		for k,_ in pairs(colorPresets) do
			w.cColorPresets:Add(k)
		end
		if settings.ColorPreset ~= nil and settings.ColorPreset ~= "" and settings.ColorPreset ~= "none" then
			w.cColorPresets:Select(settings.ColorPreset)
			local ColorPreset = RVMOD_GColorPresets.GetColorPreset(settings.ColorPreset)
			w.colorBox:Tint(ColorPreset.r, ColorPreset.g, ColorPreset.b)
		else
			w.cColorPresets:Select("none")
		end
		-- reanchor colorBox
		w.colorBox:AnchorTo(w.cColorPresets, "right", "left", 10, 0)
	end



	return w
end

function Addon.EditIndicator(presetName)
	if (nil ~= Addon.C) then
		Addon.C:Destroy()
	end
	local w = {}
	w = LibGUI("Blackframe", WindowSettings.."wEdit")

	--Filter
	w.lBTT = w("Label")
	w.lBTT:Resize(150)
	w.lBTT:Position(25, 25)
	w.lBTT:Font(Addon.FontText)
	w.lBTT:SetText(L"Buff Target Type:")
	w.lBTT:Align("left")
	w.lBTT.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lBTT, "Only apply this rule to the selected filter matches")
		end
	w.cBTT = w("smallcombobox")
	w.cBTT:AnchorTo(w.lBTT, "right", "left", 10, -5)
	w.cBTT:Clear()
	-- buff target types
	w.cBTT:Add("Self")
	w.cBTT:Add("Friendly")
	w.cBTT:Add("Hostile")
	w.cBTT:Add("Party1")
	w.cBTT:Add("Party2")
	w.cBTT:Add("Party3")
	w.cBTT:Add("Party4")
	w.cBTT:Add("Party5")
		
	w.lWatch = w("Label")
	w.lWatch:Resize(150)
	w.lWatch:AnchorTo(w.lBTT, "bottomleft", "topleft", 0, 10)
	w.lWatch:Font(Addon.FontText)
	w.lWatch:SetText(L"Watch for:")
	w.lWatch:Align("left")
	w.lWatch.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lWatch, "Watch for bufftype, abilityId, Buffname, dispellable or healdebuff.")
		end
	w.cWatch = w("Combobox")
	w.cWatch:AnchorTo(w.lWatch, "right", "left", 10, -5)
	w.cWatch:Clear()
	-- buff target types
	w.cWatch:Add("BUFFTYPE")
	w.cWatch:Add("ABILITYID")
	w.cWatch:Add("BUFFNAME")
	w.cWatch:Add("DISPELLABLE")
	w.cWatch:Add("HEALDEBUFF")
	w.cWatch:Add("HOT")
	
	w.lParameter = w("Label")
	w.lParameter:Resize(150)
	w.lParameter:AnchorTo(w.lWatch, "bottomleft", "topleft", 0, 10)
	w.lParameter:Font(Addon.FontText)
	w.lParameter:SetText(L"Parameter:")
	w.lParameter:Align("left")
	w.lParameter.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lParameter, "Parameters", "BUFFTYPE: curses, ailments, hexes, debuffs, healings, buffs, defensives, damagings, offensives, passives, granteds, selfcasts, cripples, bolsters, augmentations, statsBuffs, enchantments, blessings", "ABILITYID: Number, BUFFNAME: Name", "DISPELLABLE: NONE", "HEALDEBUFF: 25, 50, out", "HOT: [(optional)shm, zel, dok, am, rp, wp][15,5,ExtraHot,Shield,Extra]")
		end
	w.tParameter = w("Textbox")
	w.tParameter:Resize(250)
	w.tParameter:AnchorTo(w.lParameter, "right", "left", 10, -5)
	
	w.lSelfcast = w("Label")
	w.lSelfcast:Resize(75)
	w.lSelfcast:AnchorTo(w.lParameter, "bottomleft", "topleft", 0, 10)
	w.lSelfcast:Font(Addon.FontText)
	w.lSelfcast:SetText(L"Selfcast:")
	w.lSelfcast:Align("left")
	w.lSelfcast.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lSelfcast, "Only spells cast by the player.")
		end		
	w.cSelfcast = w("tinycombobox")
	w.cSelfcast:AnchorTo(w.lSelfcast, "right", "left", 0, -5)
	w.cSelfcast:Add("--")
	w.cSelfcast:Add("no")
	w.cSelfcast:Add("yes")
	
	-- Actions
	w.lAction = w("Label")
	w.lAction:Resize(150)
	w.lAction:AnchorTo(w.lSelfcast, "bottomleft", "topleft", 0, 10)
	w.lAction:Font(Addon.FontHeadline)
	w.lAction:SetText(L"Actions:")
	w.lAction:Align("left")
	w.lAction.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lAction, "The action to be applied to the window")
		end

	-- TargetWindow
	w.lTargetWindow = w("Label")
	w.lTargetWindow:Resize(150)
	w.lTargetWindow:AnchorTo(w.lAction, "bottomleft", "topleft", 0, 10)
	w.lTargetWindow:Font(Addon.FontText)
	w.lTargetWindow:SetText(L"Target Window:")
	w.lTargetWindow:Align("left")
	w.lTargetWindow.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lTargetWindow, "The window on which the action shall be applied to")
		end
			
	w.tTargetWindow = w("Textbox")
	w.tTargetWindow:Resize(250)
	w.tTargetWindow:AnchorTo(w.lTargetWindow, "right", "left", 10, -5)
	
	--[[w.bTargetWindow = w("Button", nil, Addon.ButtonInherits)
	w.bTargetWindow:Resize(Addon.ButtonWidth)
	w.bTargetWindow:SetText(L"Capture...")
	w.bTargetWindow:AnchorTo(w.tTargetWindow, "right", "left", 10, 0)]]--
	
	w.lVisibility = w("Label")
	w.lVisibility:Resize(150)
	w.lVisibility:AnchorTo(w.lTargetWindow, "bottomleft", "topleft", 0, 10)
	w.lVisibility:Font(Addon.FontText)
	w.lVisibility:SetText(L"Visibility:")
	w.lVisibility:Align("left")
	w.lVisibility.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.lVisibility, "Show or Hide the Target Window when the event occurs.")
		end
			
	w.checkVisibility = w("Checkbox")
	w.checkVisibility:AnchorTo(w.lVisibility, "right", "left", 10, -5)
	w.checkVisibility:SetValue(Addon.CurrentConfiguration[presetName].Actions.Visibility.enabled)
		
	w.Color = CreateColorFrame(Addon.CurrentConfiguration[presetName].Actions.Color)
	w.Color:Parent(w)
	w.Color:AnchorTo(w.lVisibility, "bottomleft", "topleft", 0, 0)
	--w.Color:AddAnchor(w, "center", "bottomleft", 0, -40)
		
	-- Apply
	w.bApply = w("Button", nil, Addon.ButtonInherits)
	w.bApply:Resize(Addon.ButtonWidth)
	w.bApply:SetText(L"Apply")
	w.bApply:AnchorTo(w, "bottomright", "bottomright", -20, -20)
	w.bApply.OnLButtonUp = 
		function()
			--Addon.UnregisterBuff(Addon.CurrentConfiguration[presetName])
			
			Addon.CurrentConfiguration[presetName].BuffEvent.BuffTargetType = WStringToString(w.cBTT:Selected())
			Addon.CurrentConfiguration[presetName].BuffEvent.Watch = WStringToString(w.cWatch:Selected())	
			Addon.CurrentConfiguration[presetName].BuffEvent.Parameter = WStringToString(w.tParameter:GetText())
			Addon.CurrentConfiguration[presetName].BuffEvent.SelfCast = WStringToString(w.cSelfcast:Selected())
			
			Addon.CurrentConfiguration[presetName].Actions.TargetWindow = WStringToString(w.tTargetWindow:GetText())
			Addon.CurrentConfiguration[presetName].Actions.Visibility.enabled = w.checkVisibility:GetValue()
			Addon.CurrentConfiguration[presetName].Actions.Color.enabled = w.Color.checkColor:GetValue()
			if w.Color.cColorPresets ~= nil then
				Addon.CurrentConfiguration[presetName].Actions.Color.ColorPreset = WStringToString(w.Color.cColorPresets:Selected())
			end
			Addon.CurrentConfiguration[presetName].Actions.Color.r, Addon.CurrentConfiguration[presetName].Actions.Color.g, Addon.CurrentConfiguration[presetName].Actions.Color.b = WindowGetTintColor(w.Color.colorBox.name)
			
			--Addon.RegisterBuff(Addon.CurrentConfiguration[presetName])
			w:Hide()
		end


	w.cBTT:Select(Addon.CurrentConfiguration[presetName].BuffEvent.BuffTargetType)
	w.cWatch:Select(Addon.CurrentConfiguration[presetName].BuffEvent.Watch)
	w.cSelfcast:Select(Addon.CurrentConfiguration[presetName].BuffEvent.SelfCast)
	w.tParameter:SetText(Addon.CurrentConfiguration[presetName].BuffEvent.Parameter)
	
	w.tTargetWindow:SetText(Addon.CurrentConfiguration[presetName].Actions.TargetWindow)
	w.checkVisibility:SetValue(Addon.CurrentConfiguration[presetName].Actions.Visibility.enabled)
	w.Color.checkColor:SetValue(Addon.CurrentConfiguration[presetName].Actions.Color.enabled)
	if w.Color.cColorPresets ~= nil then
		w.Color.cColorPresets:Select(Addon.CurrentConfiguration[presetName].Actions.Color.ColorPreset)
	end
	WindowSetTintColor(w.Color.colorBox.name, Addon.CurrentConfiguration[presetName].Actions.Color.r, Addon.CurrentConfiguration[presetName].Actions.Color.g, Addon.CurrentConfiguration[presetName].Actions.Color.b)
	--w.cbNegate:SetValue(Addon.CurrentConfiguration[presetName].Negate)
	
	Addon.C = w
	Addon.C:Show()
end

--
-- ColorDialog Callback
function Addon.OnColorDialogCallback(Object, Event, EventData)
	-- Hint: COLOR_EVENT_UPDATED sends the old value again if cancel ist clicked
	-- First step: check for the right event
	if Event == RVAPI_ColorDialog.Events.COLOR_EVENT_UPDATED then
		Addon.C.Color.colorBox:Tint(math.floor(EventData.Red + 0.5), math.floor(EventData.Green + 0.5), math.floor(EventData.Blue + 0.5)) 
	end
end

--
-- Interface to LibBuffEvents

local function btt_string_to_number(btt_string)
	if btt_string == "Self" then
		return GameData.BuffTargetType.SELF
	elseif btt_string == "Friendly" then
		return GameData.BuffTargetType.TARGET_FRIENDLY
	elseif btt_string == "Hostile" then
		return GameData.BuffTargetType.TARGET_HOSTILE
	elseif btt_string == "Party1" then
		return GameData.BuffTargetType.GROUP_MEMBER_START
	elseif btt_string == "Party2" then
		return GameData.BuffTargetType.GROUP_MEMBER_START+1
	elseif btt_string == "Party3" then
		return GameData.BuffTargetType.GROUP_MEMBER_START+2
	elseif btt_string == "Party4" then
		return GameData.BuffTargetType.GROUP_MEMBER_START+3
	elseif btt_string == "Party5" then
		return GameData.BuffTargetType.GROUP_MEMBER_START+4
	end
	return nil
end

local function string_split (str, separator, skipEmptyEntries)
	
	local res = {}
	
	if (str == nil or str == L"")
	then
		return res
	end
	
	if (separator == nil or separator == L"")
	then
		table.insert (res, str)
		return res
	end
	
	local str = str
	local pos = 1
	local len = str:len ()
	local endpos
	
	while (pos <= len)
	do
		endpos = str:find (separator, pos, true)
		if (endpos == nil) then endpos = len + 1 end
		
		local s = str:sub (pos, endpos - 1)
		if (s ~= L"" or not skipEmptyEntries)
		then
			table.insert (res, s)
		end
		
		pos = endpos + 1
	end
	
	return res
end

function Addon.RegisterBuff(settings)
	local btt = btt_string_to_number(settings.BuffEvent.BuffTargetType)
	--DEBUG(towstring(btt))
	if btt == nil then return end
	local condition = string_split(settings.BuffEvent.Parameter, "[^,%s]+", true)
	condition.type = settings.BuffEvent.Watch
	if settings.BuffEvent.SelfCast == "yes" then
		condition.selfcast = true
	elseif settings.BuffEvent.SelfCast == "no" then
		condition.selfcast = false
	else	-- use nil as third value for boolean; I wonder if that works...
		condition.selfcast = nil
	end
	
	if condition.type == "ABILITYID" then
		for i,v in ipairs(condition) do
			condition[i] = tonumber(v)
		end
	end
	LibBuffEvents.RegisterEventHandler({btt, condition }, settings.Name, Addon.BuffHandler)
	--LibBuffEvents.RegisterEventHandler({btt, {settings.BuffEvent.Parameter, type = settings.BuffEvent.Watch} }, settings.Name, Addon.BuffHandler)
end

function Addon.UnregisterBuff(settings)
	local btt = btt_string_to_number(settings.BuffEvent.BuffTargetType)
	if btt == nil then return end
	local condition = string_split(settings.BuffEvent.Parameter, "[^,%s]+")
	condition.type = settings.BuffEvent.Watch
	LibBuffEvents.UnregisterEventHandler({btt, condition }, settings.Name, Addon.BuffHandler)
	--LibBuffEvents.UnregisterEventHandler({btt, {settings.BuffEvent.Parameter, type = settings.BuffEvent.Watch} }, settings.Name, Addon.BuffHandler)
end

function Addon.RegisterBuffs()
	for _,settings in pairs(Addon.CurrentConfiguration) do
		Addon.RegisterBuff(settings)
	end
end

function Addon.UnregisterBuffs()
	for _,settings in pairs(Addon.CurrentConfiguration) do
		Addon.UnregisterBuff(settings)
	end
end

--ToDo: Cache the original TargetWindows on apply for performance?
local originalTargetWindows = {}
function Addon.BuffHandler(Name, EventData)
-- EventData.Event, EventData.Result

	if Addon.CurrentConfiguration[Name] == nil then
		DEBUG(L"Settings == nil")
		return
	end
	local actions = Addon.CurrentConfiguration[Name].Actions
	if actions == nil then
		DEBUG(L"Actions == nil")
		return
	end
	
	if actions.TargetWindow == nil or actions.TargetWindow == "" then
		DEBUG(L"TargetWindow == nil or empty")
		return
	end
	if not DoesWindowExist(actions.TargetWindow) then
		DEBUG(L"TargetWindow == nil or empty")
		return
	end
	
	if not originalTargetWindows[actions.TargetWindow] then originalTargetWindows[actions.TargetWindow] = {} end
	local origWindow = originalTargetWindows[actions.TargetWindow]
	
	if actions.Visibility.enabled then
		--[[if (actions.TargetWindow) then
			DEBUG(L"TargetWindow: "..towstring(actions.TargetWindow))
		else
			DEBUG(L"TargetWindow: nil")
		end
		if EventData.Result == nil then
			DEBUG(L"Result: nil")
		elseif EventData.Result == true then
			DEBUG(L"Result: true")
		elseif EventData.Result == false then
			DEBUG(L"Result: false")
		end
		]]--	
		WindowSetShowing(actions.TargetWindow, EventData.Result)
	end
	if actions.Color.enabled then
		if EventData.Result == true then
			if not origWindow.Color then origWindow.Color = {} end
			origWindow.r, origWindow.g, origWindow.b = WindowGetTintColor(actions.TargetWindow)
			WindowSetTintColor(actions.TargetWindow, actions.Color.r, actions.Color.g, actions.Color.b)
		else
			-- reconstruct the original window settings
			WindowSetTintColor(actions.TargetWindow, origWindow.r, origWindow.g, origWindow.b)
		end
	end
	--[[
	if Name == "default" then return end
	if EventData.Result == true then
		EA_ChatWindow.Print(towstring(Name)..L": "..towstring(EventData.Event[1])..L": true")
		DEBUG(towstring(Name)..L": "..towstring(EventData.Event[1])..L": true")
	else
		EA_ChatWindow.Print(towstring(Name)..L": "..towstring(EventData.Event[1])..L": false")
		DEBUG(towstring(Name)..L": "..towstring(EventData.Event[1])..L": false")
	end
	if Name == "Player-Dispellable" then
		WindowSetShowing("PlayerHPImageIndicator1", EventData.Result)
	end
	]]--
end
