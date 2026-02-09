if not Effigy then Effigy = {} end
local CoreAddon = Effigy
if not EffigyConfigGui then EffigyConfigGui = {} end
local Addon = EffigyConfigGui
if (nil == Addon.Name) then Addon.Name = "EffigyConfigGui" end

local LibGUI = LibStub("LibGUI")

Addon.Settings = {}
Addon.Settings.W = nil

function Addon.Settings.Create()
	local w = {}
	
	if (nil ~= Addon.Settings.W) then
		Addon.Settings.Destroy()
	end
	
	w = LibGUI("Blackframe")
	
	w.bCloseButton = w("Closebutton")
	w.bCloseButton.OnLButtonUp =
	function()
		Addon.Settings.Destroy()
	end
	
	w:MakeMovable()
	w:Resize(320, 590)
	w:AnchorTo(Addon.Name.."SettingsWindow", "center", "center", 0, 0)
	
	w.lhead = w("Label")
	w.lhead:Resize(200)
	
	w.lhead:Font("font_clear_medium_bold")
	w.lhead:SetText(L"State Settings")
	w.lhead:Align("left")
	w.lhead:Position(25,20)

	w.l0 = w("Label")
	w.l0:Resize(175)
	w.l0:AnchorTo(w.lhead, "bottomleft", "topleft",0, 20)
	w.l0:Font("font_clear_medium_bold")
	w.l0:SetText(L"Group Bars")
	w.l0:Align("left")

	w.ldisable = w("Label")
	w.ldisable:Resize(200)
	w.ldisable:AnchorTo(w.l0, "bottomleft", "topleft", 20, 0)
	w.ldisable:Font("font_clear_medium")
	w.ldisable:SetText(L"Show group in WB:")
	w.ldisable:Align("left")
	w.ldisable.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.ldisable, "Disable group health bars while in a warband.")
		end

	w.k7 = w("Checkbox")
	w.k7:AnchorTo(w.ldisable, "right", "left", 0, 0)
	w.k7.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].showgroup = w.k7:GetValue()
		end
	if (nil ~= CoreAddon.WindowSettings["WB"].showgroup)and
		 (true == CoreAddon.WindowSettings["WB"].showgroup) then
		w.k7:Check()
	end
	
	
	w.l10 = w("Label")
	w.l10:Resize(200)
	w.l10:AnchorTo(w.ldisable, "bottomleft", "topleft", 0, 0)
	w.l10:Font("font_clear_medium")
	w.l10:SetText(L"Show group in SC:")
	w.l10:Align("left")
	w.l10.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l10, "Disable group health bars while in a scenario.")
		end
	

	w.k8 = w("Checkbox")
	w.k8:AnchorTo(w.l10, "right", "left", 0, 0)
	w.k8.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["SC"].showgroup = w.k8:GetValue()
		end
	if (nil ~= CoreAddon.WindowSettings["SC"].showgroup)and
		 (true == CoreAddon.WindowSettings["SC"].showgroup) then
		w.k8:Check()
	end
	


	w.l1 = w("Label")
	w.l1:Resize(175)
	w.l1:AnchorTo(w.l10, "bottomleft", "topleft", -20, 20)
	w.l1:Font("font_clear_medium_bold")
	w.l1:SetText(L"Castbar")
	w.l1:Align("left")


	w.l11 = w("Label")
	w.l11:Resize(140)
	w.l11:AnchorTo(w.l1, "bottomleft", "topleft", 20, 0)
	w.l11:Font("font_clear_medium")
	w.l11:SetText(L"Show GCD:")
	w.l11:Align("left")
	w.l11.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l11, "Show GCD when using instant spells.")
		end

	w.k9 = w("Checkbox")
	w.k9:AnchorTo(w.l11, "right", "left", 0, 0)
	w.k9.OnLButtonUp =
		function()
			CoreAddon.WindowSettings.castbar_show_gcd = w.k9:GetValue()
		end
	if (nil ~= CoreAddon.WindowSettings.castbar_show_gcd)and
		 (true == CoreAddon.WindowSettings.castbar_show_gcd) then
		w.k9:Check()
	end
	
	w.l12 = w("Label")
	w.l12:Resize(140)
	w.l12:AnchorTo(w.l11, "bottomleft", "topleft", 00, 0)
	w.l12:Font("font_clear_medium")
	w.l12:SetText(L"Incl latency:")
	w.l12:Align("left")
	w.l12.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l12, "WAR provides the avarage latency that is expeced when casting. If you check this options the latency will be included in the cast time thus showing the expected cast time rather than the tooltip one.")
		end

	w.k10 = w("Checkbox")
	w.k10:AnchorTo(w.l12, "right", "left", 0, 0)
	w.k10.OnLButtonUp =
		function()
				CoreAddon.WindowSettings.castbar_incl_latency = w.k10:GetValue()
		end
	if (nil ~= CoreAddon.WindowSettings.castbar_incl_latency)and
		 (true == CoreAddon.WindowSettings.castbar_incl_latency) then
		w.k10:Check()
	end
		
	w.ab1 = w("Button")
	w.ab1:Resize(250)
	w.ab1:SetText(L"Apply")
	w.ab1:AnchorTo(w.l12, "bottomleft", "topleft", 0, 10)
	w.ab1.OnLButtonUp = 
		function()
					
		
		end
		
	Addon.Settings.W = w
	Addon.Settings.W:Show()
	--Addon.CreateEditSettingsEnd(w)
end

function Addon.Settings.Destroy()
	Addon.Settings.W:Destroy()
end




local SettingsWindow = Addon.Name.."SettingsWindowSettings"
--------------------------------------------------------------
-- function InitializeSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.Settings.InitializeSettingsWindow(ParentWindow)

	-- First step: create window from template
	CreateWindowFromTemplate(SettingsWindow, Addon.Name.."SettingsTemplate", "Root")
	LabelSetText(SettingsWindow.."TitleBarText", L"State Settings")
	ButtonSetText(SettingsWindow.."ButtonOK", L"OK")

	-- Second step: set additional controls
	--				Lets show some additional controls as an example

	local showGroupWindow = Addon.GetShowGroupWindow()
	showGroupWindow:AnchorTo(SettingsWindow, "top", "topright", -10, 50)
	showGroupWindow:Parent(SettingsWindow)


	--[[ButtonSetPressedFlag(SettingsWindow.."GrpBarsCheckBoxShowGrpInSC", isShowGrpSC)
	LabelSetText(SettingsWindow.."GrpBarsTitle", L"Group Bars")
	LabelSetTextColor(SettingsWindow.."GrpBarsTitle", 255, 255, 255)
	
	LabelSetText(SettingsWindow.."GrpBarsLabelShowGrpInWB", L"Show Group in Warband")
	LabelSetTextColor(SettingsWindow.."GrpBarsLabelShowGrpInWB", 255, 255, 255)
	
	LabelSetText(SettingsWindow.."GrpBarsLabelShowGrpInSC", L"Show Group in Scenario")
	LabelSetTextColor(SettingsWindow.."GrpBarsLabelShowGrpInSC", 255, 255, 255)
	]]--
	
	LabelSetText(SettingsWindow.."CastBarTitle", L"Cast Bar")
	LabelSetTextColor(SettingsWindow.."CastBarTitle", 255, 255, 255)
	
	LabelSetText(SettingsWindow.."CastBarLabelShowGCD", L"Show Global Cooldown")
	LabelSetTextColor(SettingsWindow.."CastBarLabelShowGCD", 255, 255, 255)
	
	LabelSetText(SettingsWindow.."CastBarLabelInclLatency", L"Include Latency")
	LabelSetTextColor(SettingsWindow.."CastBarLabelInclLatency", 255, 255, 255)
	
	--WindowRegisterCoreEventHandler(SettingsWindow.."CheckBoxFakeCombat", "OnLButtonUp", Addon.Name..".Settings.OnClickFakeCombat")
	--[[
	-- First step: create main window
	CreateWindow(SettingsWindow, false)
	WindowSetParent(SettingsWindow, ParentWindow.name)
	WindowClearAnchors(SettingsWindow)
	WindowAddAnchor(SettingsWindow, "topleft", ParentWindow.name, "topleft", 0, 0)
	WindowAddAnchor(SettingsWindow, "bottomright", ParentWindow.name, "bottomright", 0, 0)
	]]--
	
end

--------------------------------------------------------------
-- function ShowModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.Settings.ShowModuleSettings()--ModuleWindow)

	-- First step: check for window
	if not DoesWindowExist(SettingsWindow) then
		Addon.Settings.InitializeSettingsWindow("root")--ModuleWindow)
	end

	-- Second step: update fields with the current configuration 
	Addon.Settings.UpdateSettingsWindow()

	-- Final step: show everything
	WindowSetShowing(SettingsWindow, true)
end

--------------------------------------------------------------
-- function HideModuleSettings()
-- Description:
--------------------------------------------------------------
function Addon.Settings.HideModuleSettings()

	-- Final step: hide window
	WindowSetShowing(SettingsWindow, false)
end

--------------------------------------------------------------
-- function UpdateSettingsWindow()
-- Description:
--------------------------------------------------------------
function Addon.Settings.UpdateSettingsWindow()

	--[[local isShowGrpWB
	if (nil ~= CoreAddon.WindowSettings["WB"].showgroup) and (true == CoreAddon.WindowSettings["WB"].showgroup) then 
		isShowGrpWB = true
	else
		isShowGrpWB = false
	end
	ButtonSetPressedFlag(SettingsWindow.."GrpBarsCheckBoxShowGrpInWB", isShowGrpWB)

	local isShowGrpSC
	if (nil ~= CoreAddon.WindowSettings["SC"].showgroup) and (true == CoreAddon.WindowSettings["SC"].showgroup) then 
		isShowGrpSC = true
	else
		isShowGrpSC = false
	end
	ButtonSetPressedFlag(SettingsWindow.."GrpBarsCheckBoxShowGrpInSC", isShowGrpSC)
	]]--
	
	local isShowGCD
	if (nil ~= CoreAddon.WindowSettings.castbar_show_gcd) and (true == CoreAddon.WindowSettings.castbar_show_gcd) then 
		isShowGCD = true
	else
		isShowGCD = false
	end
	ButtonSetPressedFlag(SettingsWindow.."CastBarCheckBoxShowGCD", isShowGCD)
	
	local isInclLatency
	if (nil ~= CoreAddon.WindowSettings.castbar_incl_latency) and (true == CoreAddon.WindowSettings.castbar_incl_latency) then 
		isInclLatency = true
	else
		isInclLatency = false
	end
	ButtonSetPressedFlag(SettingsWindow.."CastBarCheckBoxInclLatency", isInclLatency)
end


--------------------------------------------------------------
-- CLICK HANDLERS
--------------------------------------------------------------

function Addon.Settings.OnClickCloseSettings()
	Addon.Settings.HideModuleSettings()
end

--[[function Addon.Settings.OnClickShowGrpInWB()
	if (nil ~= CoreAddon.WindowSettings["WB"].showgroup) then
		CoreAddon.WindowSettings["WB"].showgroup = not CoreAddon.WindowSettings["WB"].showgroup
	else
		CoreAddon.WindowSettings["WB"].showgroup = true
	end
	Addon.Settings.UpdateSettingsWindow()
end


function Addon.Settings.OnClickShowGrpInSC()
	if (nil ~= CoreAddon.WindowSettings["SC"].showgroup) then
		CoreAddon.WindowSettings["SC"].showgroup = not CoreAddon.WindowSettings["SC"].showgroup
	else
		CoreAddon.WindowSettings["SC"].showgroup = true
	end
	Addon.Settings.UpdateSettingsWindow()
end
]]--

function Addon.Settings.OnClickShowGCD()
	if (nil ~= CoreAddon.WindowSettings.castbar_show_gcd) then
		CoreAddon.WindowSettings.castbar_show_gcd = not CoreAddon.WindowSettings.castbar_show_gcd
	else
		CoreAddon.WindowSettings.castbar_show_gcd = true
	end
	Addon.Settings.UpdateSettingsWindow()
end

function Addon.Settings.OnClickInclLatency()
	if (nil ~= CoreAddon.WindowSettings.castbar_incl_latency) then
		CoreAddon.WindowSettings.castbar_incl_latency = not CoreAddon.WindowSettings.castbar_incl_latency
	else
		CoreAddon.WindowSettings.castbar_incl_latency = true
	end
	Addon.Settings.UpdateSettingsWindow()
end

--------------------------------------------------------------
-- STUFF ;D
--------------------------------------------------------------

function Addon.GetShowGroupWindow()
	local w = LibGUI("Frame")
	w:Resize(200,160)
	
	w.lShow = w("Label")
	w.lShow:Position(10,10)
	w.lShow:Resize(300)
	w.lShow:Font(Addon.FontHeadline)
	w.lShow:SetText(L"Show:")
	w.lShow:Align("left")
	
	w.lShowGroup = w("Label")
	w.lShowGroup:AnchorTo(w.lShow, "bottomleft", "topleft", 5, 0)
	w.lShowGroup:Resize(65)
	w.lShowGroup:Font(Addon.FontBold)
	w.lShowGroup:SetText(L"Group:")
	w.lShowGroup:Align("left")
	w.ckShowGroup = w("checkbox")
	w.ckShowGroup:AnchorTo(w.lShowGroup, "right", "left", 0, 0)
	w.ckShowGroup.OnLButtonUp =
		function()
			Addon.SetShowGroup(false, w.ckShowGroup:GetValue())
		end
	w.ckShowGroup:SetValue(Addon.GetShowGroup(false)) --worldobj

	w.lShowGroupInWB = w("Label")
	w.lShowGroupInWB:AnchorTo(w.lShowGroup, "bottomleft", "topleft", 20, 0)
	w.lShowGroupInWB:Resize(110)
	w.lShowGroupInWB:Font(Addon.FontText)
	w.lShowGroupInWB:SetText(L"in Warband:")
	w.lShowGroupInWB:Align("left")
	w.ckShowGroupInWB = w("checkbox")
	w.ckShowGroupInWB:AnchorTo(w.lShowGroupInWB, "right", "left", 0, -5)
	w.ckShowGroupInWB.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["SC"].showgroup = w.ckShowGroupInWB:GetValue()
		end
	w.ckShowGroupInWB:SetValue(CoreAddon.WindowSettings["WB"].showgroup)
	
	w.lShowGroupInSC = w("Label")
	w.lShowGroupInSC:AnchorTo(w.lShowGroupInWB, "bottomleft", "topleft", 0, 0)
	w.lShowGroupInSC:Resize(110)
	w.lShowGroupInSC:Font(Addon.FontText)
	w.lShowGroupInSC:SetText(L"in Scenario:")
	w.lShowGroupInSC:Align("left")
	w.ckShowGroupInSC = w("checkbox")
	w.ckShowGroupInSC:AnchorTo(w.lShowGroupInSC, "right", "left", 0, -5)
	w.ckShowGroupInSC.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["SC"].showgroup = w.ckShowGroupInSC:GetValue()
		end
	w.ckShowGroupInSC:SetValue(CoreAddon.WindowSettings["SC"].showgroup)
	
	w.lShowGroupWO = w("Label")
	w.lShowGroupWO:AnchorTo(w.lShowGroupInSC, "bottomleft", "topleft", -10, 0)
	w.lShowGroupWO:Resize(125)
	w.lShowGroupWO:Font(Addon.FontText)
	w.lShowGroupWO:SetText(L"WorldObjects:")
	w.lShowGroupWO:Align("left")
	w.ckShowGroupWO = w("checkbox")
	w.ckShowGroupWO:AnchorTo(w.lShowGroupWO, "right", "left", 0, -5)
	w.ckShowGroupWO.OnLButtonUp =
		function()
			Addon.SetShowGroup(true, w.ckShowGroupWO:GetValue())
		end
	w.ckShowGroupWO:SetValue(Addon.GetShowGroup(true)) --worldobj
	
	return w
end

function Addon.SetShowGroup(worldObj, onoff)
	for barName, settings in pairs(CoreAddon.Bars) do
		if settings.state == "grp1hp" or settings.state == "grp2hp" or settings.state == "grp3hp" or settings.state == "grp4hp" or settings.state == "grp5hp" then
			if worldObj == settings.pos_at_world_object then
				settings.show = onoff or not settings.show
				CoreAddon.Bars[barName]:setup()
				CoreAddon.Bars[barName]:render()
			end
		end
	end
end

function Addon.GetShowGroup(worldObj)
	for barName, settings in pairs(CoreAddon.Bars) do
		if settings.state == "grp1hp" and worldObj == settings.pos_at_world_object then	-- let us assume no one is gonna showing/hiding group bars partly
			return settings.show
		end
	end
end