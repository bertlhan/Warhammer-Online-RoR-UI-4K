if not Effigy then Effigy = {} end
local CoreAddon = Effigy
if not EffigyConfigGui then EffigyConfigGui = {} end
local Addon = EffigyConfigGui
if (nil == Addon.Name) then Addon.Name = "EffigyConfigGui" end

local LibGUI = LibStub("LibGUI")

Addon.TricksMode = {}
Addon.TricksMode.W = nil

local SettingsWindow = Addon.Name.."SettingsWindowTricks"
--------------------------------------------------------------
-- function InitializeSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.TricksMode.InitializeSettingsWindow(ParentWindow)
	local frameSizeW = 1260
	local frameSizeH = 360
	--
	-- XML Part
	--
	-- First step: create window from template
	CreateWindowFromTemplate(SettingsWindow, Addon.Name.."PopupWindowTemplate","Root")
	WindowRegisterCoreEventHandler(SettingsWindow.."ButtonOK", "OnLButtonUp", Addon.Name..".TricksMode.OnClickCloseSettings")
	WindowRegisterCoreEventHandler(SettingsWindow.."ButtonClose", "OnLButtonUp", Addon.Name..".TricksMode.OnClickCloseSettings")
	WindowSetDimensions(SettingsWindow, frameSizeW, frameSizeH)
	LabelSetText(SettingsWindow.."TitleBarText", L"Tricks")
	ButtonSetText(SettingsWindow.."ButtonOK", L"Close")
	
	--
	-- LibGUI Part
	--	
	local w = {}

	if (nil ~= Addon.TricksMode.W) then
		Addon.TricksMode.Destroy()
	end

	w = LibGUI("Window")
	w:Resize(frameSizeW - 10, frameSizeH - 100)
	w:AnchorTo(SettingsWindow, "top", "top", 0, 30)
	w:Parent(SettingsWindow)
	--[[
	w.bCloseButton = w("Closebutton")
	w.bCloseButton.OnLButtonUp =
	function()
		Addon.TricksMode.Destroy()
	end
	]]--
	--w:MakeMovable()
	
	w.Title = w("Label")
	w.Title:Resize(250)
	w.Title:AnchorTo(w, "topleft", "topleft", 25, 20)
	w.Title:Font(Addon.FontHeadline)
	w.Title:SetText(L"Fake:")
	w.Title:Align("left")
	w.Title:IgnoreInput()
	
	-- Fake Party button
	w.FakePartyButton = w("Button", nil, Addon.ButtonInherits)
	w.FakePartyButton:Resize(Addon.ButtonWidth)
	w.FakePartyButton:SetText(L"Party")
	w.FakePartyButton:Position(25, 60)
	w.FakePartyButton.OnLButtonUp = function() CoreAddon.CreateFakeParty()  end
	w.FakePartyButton.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.FakePartyButton, "Creates a Party with random classes / HPs",
				"A New Party at the Click of a Button! (tm)") 
		end
		
	-- Fake Warband button
--[[	w.FakeWBButton = w("Button", nil, Addon.ButtonInherits)
	w.FakeWBButton:Resize(Addon.ButtonWidth)
	w.FakeWBButton:SetText(L"Warband")
	w.FakeWBButton:AnchorTo(w.FakePartyButton, "right", "left", 20, 0)
	w.FakeWBButton.OnLButtonUp = function() CoreAddon.CreateFakeWarband()  end
	w.FakeWBButton.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.FakeWBButton, "Creates a Warband with random classes / HPs",
				"A new Warband at the Click of a Button! (tm)") 
		end
		
	-- Fake Scenario button
	w.FakeSCButton = w("Button", nil, Addon.ButtonInherits)
	w.FakeSCButton:Resize(Addon.ButtonWidth)
	w.FakeSCButton:SetText(L"Scenario")
	w.FakeSCButton:AnchorTo(w.FakeWBButton, "right", "left", 20, 0)
	w.FakeSCButton.OnLButtonUp = function() CoreAddon.FakeSC()  end
	w.FakeSCButton.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.FakeSCButton, "Creates a Scenario Party with random classes / HPs",
				"A new Party at the Click of a Button! (tm)") 
		end
]]--


	-- Clear Fakes button
	w.ClearFakesButton = w("Button", nil, Addon.ButtonInherits)
	w.ClearFakesButton:Resize(Addon.ButtonWidth)
	w.ClearFakesButton:SetText(L"Clear Fakes")
	w.ClearFakesButton:AnchorTo(SettingsWindow.."ButtonOK", "topright", "bottomright", 0, -20)
	w.ClearFakesButton.OnLButtonUp = function() CoreAddon.FakeParty = false  end
	w.ClearFakesButton.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.ClearFakesButton, "Clear your fake parties",
					"Note: takes a sec")
		end


	-- Fake Combat label
	w.FakeCombatLabel = w("Label")
	w.FakeCombatLabel:Resize(100)
	w.FakeCombatLabel:AnchorTo(w.FakePartyButton, "right", "left", 0, 0)
	w.FakeCombatLabel:Align("leftcenter")
	w.FakeCombatLabel:SetText(L"In-Combat:")
	w.FakeCombatLabel.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.FakeCombatLabel, "Sets your in/out combat state",
				"Allows for testing bar combat alpha changes",
				"Tip: If your bar does not update as you expect make sure it is Watching the Combat State") 
		end

	w.FakeCombat = w("Checkbox")
	w.FakeCombat:AnchorTo(w.FakeCombatLabel, "right", "left", 0, 0)
	w.FakeCombat.OnLButtonUp =
		function()
			if (1 == CoreAddon.States["Combat"].curr) then
				CoreAddon.States["Combat"].curr = 0
			else
				CoreAddon.States["Combat"].curr = 1
			end

			CoreAddon.States["Combat"]:renderElements()
		end


	Addon.TricksMode.W = w
	Addon.TricksMode.W:Show()
end

--------------------------------------------------------------
-- function ShowModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.TricksMode.ShowModuleSettings()--ModuleWindow)

	-- First step: check for window
	if not DoesWindowExist(SettingsWindow) then
		Addon.TricksMode.InitializeSettingsWindow("root")--ModuleWindow)
	end

	-- Second step: update fields with the current configuration 
	Addon.TricksMode.UpdateSettingsWindow()

	-- Final step: show everything
	WindowSetShowing(SettingsWindow, true)
end

--------------------------------------------------------------
-- function HideModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.TricksMode.HideModuleSettings()

	-- Final step: hide window
	WindowSetShowing(SettingsWindow, false)
end

function Addon.TricksMode.Destroy()
	Addon.TricksMode.W:Destroy()
end

--------------------------------------------------------------
-- function UpdateSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.TricksMode.UpdateSettingsWindow()
--[[
	local isCombatCheckBox
	if 1 == CoreAddon.States["Combat"].curr then
		isCombatCheckBox = true
	else
		isCombatCheckBox = false
	end
	ButtonSetPressedFlag(SettingsWindow.."CheckBoxFakeCombat", isCombatCheckBox)
	]]--
end

--------------------------------------------------------------
-- CLICK HANDLERS
--------------------------------------------------------------

function Addon.TricksMode.OnClickCloseSettings()
	Addon.TricksMode.HideModuleSettings()
end

--[[
function Addon.TricksMode.OnClickFakeParty()
	CoreAddon.CreateFakeParty()
end

function Addon.TricksMode.OnClickClearFakes()
	CoreAddon.FakeParty = false
end

function Addon.TricksMode.OnClickFakeCombat()
	if (1 == CoreAddon.States["Combat"].curr) then
		CoreAddon.States["Combat"].curr = 0
	else
		CoreAddon.States["Combat"].curr = 1
	end
	CoreAddon.States["Combat"]:renderElements()
	Addon.TricksMode.UpdateSettingsWindow()
end
]]--
