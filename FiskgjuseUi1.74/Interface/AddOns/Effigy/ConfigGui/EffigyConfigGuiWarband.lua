if not Effigy then Effigy = {} end
local CoreAddon = Effigy
if not EffigyConfigGui then EffigyConfigGui = {} end
local Addon = EffigyConfigGui

Addon.WarbandSettings = {}
function Addon.WarbandSettings.Create()
	local w, bar = Addon.CreateEditSettingsStart()
	
	w:Resize(320, 590)

	w.lhead = w("Label")
	w.lhead:Resize(200)
	
	w.lhead:Font(Addon.FontBold)
	w.lhead:SetText(L"Warband")
	w.lhead:Align("left")
	w.lhead:Position(25,20)


	w.ldisable = w("Label")
	w.ldisable:Resize(140)
	w.ldisable:AnchorTo(w.lhead, "bottomleft", "topleft", 20, 0)
	w.ldisable:Font(Addon.FontText)
	w.ldisable:SetText(L"Disable:")
	w.ldisable:Align("left")
	w.ldisable.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.ldisable, "Disable Warband Party Display")
		end

	w.k7 = w("Checkbox")
	w.k7:AnchorTo(w.ldisable, "right", "left", 0, 0)
	w.k7.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].disabled = w.k7:GetValue()
			CoreAddon.HideSCNubs()
		end
	if (nil ~= CoreAddon.WindowSettings["WB"].disabled)and
		 (true == CoreAddon.WindowSettings["WB"].disabled) then
		w.k7:Check()
	end
	
	w.l10 = w("Label")
	w.l10:Resize(140)
	w.l10:AnchorTo(w.ldisable, "bottomleft", "topleft", 0, 0)
	w.l10:Font(Addon.FontText)
	w.l10:SetText(L"Show group:")
	w.l10:Align("left")
	

	w.k8 = w("Checkbox")
	w.k8:AnchorTo(w.l10, "right", "left", 0, 0)
	w.k8.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].showgroup = w.k8:GetValue()
		end
	if (nil ~= CoreAddon.WindowSettings["WB"].showgroup)and
		 (true == CoreAddon.WindowSettings["WB"].showgroup) then
		w.k8:Check()
	end
	
	w.l11 = w("Label")
	w.l11:Resize(140)
	w.l11:AnchorTo(w.l10, "bottomleft", "topleft", 0, 0)
	w.l11:Font(Addon.FontText)
	w.l11:SetText(L"Hide label:")
	w.l11:Align("left")
	w.l11.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l11, "Hide the group or archetype label")
		end

	w.k9 = w("Checkbox")
	w.k9:AnchorTo(w.l11, "right", "left", 0, 0)
	w.k9.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].hide_label = w.k9:GetValue()
			CoreAddon.DestroySCNubs()
			CoreAddon.SCNubs(CoreAddon.WindowSettings.WBSortType or 2)
		end
	if (nil ~= CoreAddon.WindowSettings["WB"].hide_label)and
		 (true == CoreAddon.WindowSettings["WB"].hide_label) then
		w.k9:Check()
	end

	w.l1 = w("Label")
	w.l1:Resize(175)
	w.l1:AnchorTo(w.l11, "bottomleft", "topleft", -20, 0)
	w.l1:Font(Addon.FontBold)
	w.l1:SetText(L"Grow Direction:")
	w.l1:Align("left")
	w.l1.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l1, "Direction to grow on each Nub")
		end

	w.l2 = w("Label")
	w.l2:Resize(80)
	w.l2:AnchorTo(w.l1, "bottomleft", "topleft", 20, 0)
	w.l2:Font(Addon.FontText)
	w.l2:SetText(L"Down:")
	w.l2:Align("left")
	w.l2.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l2, "Grow the groups down")
		end


	w.k1 = w("Checkbox")
	w.k1:AnchorTo(w.l2, "right", "left", 20, 0)
	w.k1.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].Direction = 1
			w.k2:Clear()
			w.k3:Clear()
			w.k4:Clear()
			CoreAddon.FixAllNubs()
		end
	if (1 == CoreAddon.WindowSettings["WB"].Direction) then
		w.k1:Check()
	end

	w.l3 = w("Label")
	w.l3:Resize(80)
	w.l3:AnchorTo(w.l2, "bottomleft", "topleft", 0, 0)
	w.l3:Font(Addon.FontText)
	w.l3:SetText(L"Right:")
	w.l3:Align("left")
	w.l3.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l3, "Grow the groups right")
		end

	w.k2 = w("Checkbox")
	w.k2:AnchorTo(w.l3, "right", "left", 20, 0)
	w.k2.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].Direction = 2
			w.k1:Clear()
			w.k3:Clear()
			w.k4:Clear()
			CoreAddon.FixAllNubs()
		end
	if (2 == CoreAddon.WindowSettings["WB"].Direction) then
		w.k2:Check()
	end

	w.l4 = w("Label")
	w.l4:Resize(80)
	w.l4:AnchorTo(w.l3, "bottomleft", "topleft", 0, 0)
	w.l4:Font(Addon.FontText)
	w.l4:SetText(L"Up:")
	w.l4:Align("left")
	w.l4.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l4, "Grow the groups up")
		end

	w.k3 = w("Checkbox")
	w.k3:AnchorTo(w.l4, "right", "left", 20, 0)
	w.k3.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].Direction = 3
			w.k2:Clear()
			w.k1:Clear()
			w.k4:Clear()
			CoreAddon.FixAllNubs()
		end
	if (3 == CoreAddon.WindowSettings["WB"].Direction) then
		w.k3:Check()
	end

	w.l5 = w("Label")
	w.l5:Resize(80)
	w.l5:AnchorTo(w.l4, "bottomleft", "topleft", 0, 0)
	w.l5:Font(Addon.FontText)
	w.l5:SetText(L"Left:")
	w.l5:Align("left")
	w.l5.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l5, "Grow the groups left")
		end

	w.k4 = w("Checkbox")
	w.k4:AnchorTo(w.l5, "right", "left", 20, 0)
	w.k4.OnLButtonUp =
		function()
			CoreAddon.WindowSettings["WB"].Direction = 4
			w.k2:Clear()
			w.k1:Clear()
			w.k3:Clear()
			CoreAddon.FixAllNubs()
		end
	if (4 == CoreAddon.WindowSettings["WB"].Direction) then
		w.k4:Check()
	end

	w.loffset = w("Label")
	w.loffset:Resize(250)
	w.loffset:AnchorTo(w.l5, "bottomleft", "topleft", -20, 0)
	w.loffset:Font(Addon.FontBold)
	w.loffset:SetText(L"Axis offset:")
	w.loffset:Align("left")
	w.loffset.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.loffset, "Axis offset")
		end
		
	w.loffsetx = w("Label")
	w.loffsetx:Resize(80)
	w.loffsetx:AnchorTo(w.loffset, "bottomleft", "topleft", 20, 0)
	w.loffsetx:Font(Addon.FontText)
	w.loffsetx:SetText(L"X Axis:")
	w.loffsetx:Align("left")
	w.loffsetx.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.loffset, "X Axis offset")
		end	
		
	w.btx = w("Textbox")
	w.btx:Resize(60)
	w.btx:AnchorTo(w.loffsetx, "right", "left", 10, 0)
	if (CoreAddon.WindowSettings["WB"].x_off == nil) 
	then 
			w.btx:SetText(0)
	else
		w.btx:SetText(CoreAddon.WindowSettings["WB"].x_off)
	end
		
	w.loffsety = w("Label")
	w.loffsety:Resize(80)
	w.loffsety:AnchorTo(w.loffsetx, "bottomleft", "topleft", 0, 0)
	w.loffsety:Font(Addon.FontText)
	w.loffsety:SetText(L"Y Axis:")
	w.loffsety:Align("left")
	w.loffsety.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.loffsety, "Y Axis offset")
		end	
	
	w.bty = w("Textbox")
	w.bty:Resize(60)
	w.bty:AnchorTo(w.loffsety, "right", "left", 10, 0)
	if (CoreAddon.WindowSettings["WB"].y_off == nil) 
	then 
			w.bty:SetText(0)
	else
		w.bty:SetText(CoreAddon.WindowSettings["WB"].y_off)
	end		

	w.l6 = w("Label")
	w.l6:Resize(175)
	w.l6:AnchorTo(w.loffsety, "bottomleft", "topleft", -20, 0)
	w.l6:Font(Addon.FontBold)
	w.l6:SetText(L"Sort By:")
	w.l6:Align("left")
	w.l6.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l6, "Sort bars")
		end

	w.l7 = w("Label")
	w.l7:Resize(80)
	w.l7:AnchorTo(w.l6, "bottomleft", "topleft", 20, 0)
	w.l7:Font(Addon.FontText)
	w.l7:SetText(L"Group:")
	w.l7:Align("left")
	w.l7.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l7, "Sort bars by Group")
		end

	w.k5 = w("Checkbox")
	w.k5:AnchorTo(w.l7, "right", "left", 20, 0)
	w.k5.OnLButtonUp =
		function()
			w.k6:Clear()
			CoreAddon.WBNubs(1)
		end
	if (1 == CoreAddon.WindowSettings.WBSortType) then
		w.k5:Check()
	end

	w.l8 = w("Label")
	w.l8:Resize(100)
	w.l8:AnchorTo(w.l7, "bottomleft", "topleft", 0, 0)
	w.l8:Font(Addon.FontText)
	w.l8:SetText(L"Class Type:")
	w.l8:Align("left")
	w.l8.OnMouseOver = 
		function() 
			Addon.SetToolTip(w.l8, "Sort bars by Class Type (MDPS, RDPS, Tank, Healer)")
		end

	w.k6 = w("Checkbox")
	w.k6:AnchorTo(w.l8, "right", "left", 0, 0)
	w.k6.OnLButtonUp =
		function()
			w.k5:Clear()
			CoreAddon.WBNubs(2)
		end
	if (2 == CoreAddon.WindowSettings.WBSortType) then
		w.k6:Check()
	end

	
	
	

	w.b1 = w("Button", nil, Addon.ButtonInherits)
	w.b1:Resize(250)
	w.b1:SetText(L"Edit Template")
	w.b1:AnchorTo(w.l8, "bottomleft", "topleft", -20, 0)
	w.b1.OnMouseOver = 
		function()
			Addon.SetToolTip(w.b1, "Edit the Template used for Warband")
		end
	w.b1.OnLButtonUp = 
		function()
			Addon.EditBarPanel.Create("WBTemplate")
		end
		
	w.ab1 = w("Button", nil, Addon.ButtonInherits)
	w.ab1:Resize(Addon.ButtonWidth)
	w.ab1:SetText(L"Apply")
	w.ab1:AnchorTo(w, "bottomright", "bottomright", -17, -20)
	w.ab1.OnLButtonUp = 
		function()
					
			local pos_x = WStringToString(w.btx:GetText())
			pos_x = tonumber(pos_x)
			if (nil == pos_x) then width = 0 end

			local pos_y = WStringToString(w.bty:GetText())
			pos_y = tonumber(pos_y)
			if (nil == pos_y) then pos_y = 0 end
			
			CoreAddon.WindowSettings["WB"].x_off = pos_x
			CoreAddon.WindowSettings["WB"].y_off = pos_y

			CoreAddon.FixAllNubs()
			--bar:setup()
			--bar:render()
		end

	Addon.CreateEditSettingsEnd(w)
end

