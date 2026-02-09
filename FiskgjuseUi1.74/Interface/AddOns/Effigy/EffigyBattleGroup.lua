-- vim: sw=2 ts=2
if not Effigy then Effigy = {} end
local Addon = Effigy

function Addon.AddWBState(state)
	local bar = Addon.GetBar(state.name)

	if (nil == bar) then
		--[[if (nil == Addon.WindowSettings.WBTemplate) then
			Addon.WindowSettings.WBTemplate = "WBTemplate"
		end]]--
		--bar = Addon.CreateBarFromTemplate(state.name, "WBTemplate")
		bar = Addon.CreateBar(state.name, "WBTemplate")
		bar.show = true		-- kind of
		bar.hidden = true	-- a joke?
		bar.block_layout_editor = true
		bar:useState(state.name)
	end
	if (nil ~= state.extra_info.career)and(nil ~= state.extra_info.group) then
		local nub_name = ""
		if (1 == Addon.WindowSettings.WBSortType) then
			nub_name = "WBNubGroup"..state.extra_info.group
		else
			nub_name = "WBNub"..Addon.CareerResourceSettings[state.extra_info.career].ctype
		end
		Addon.NubAddBar(nub_name, bar.name)
	end
end

function Addon.RemoveWBState(state)
	if (nil == state) then return end
	-- Remove the bar
	for _,b in ipairs(state.bars) do
		local bar = Addon.Bars[b]
		if (nil ~= bar) then
			Addon.NubRemoveBar(bar.name)
			bar:destroy()
		end
	end
end

function Addon.WBNubs(sort)
	if (nil ~= Addon.WindowSettings.WBNubs) then
		Addon.DestroyWBNubs()
	end

	Addon.WindowSettings.WBNubs = {}

	if (1 == sort) then -- Create Nubs for Group
		Addon.WindowSettings.WBSortType = sort

		for i=1,4 do
			Addon.WindowSettings.WBNubs[i] = {}
			Addon.WindowSettings.WBNubs[i].name = Addon.CreateNub("WB", "Group "..i)
			Addon.WindowSettings.WBNubs[i].pre = "WB"
			WindowClearAnchors(Addon.WindowSettings.WBNubs[i].name)
			WindowAddAnchor(Addon.WindowSettings.WBNubs[i].name, "topleft", "Root", "topleft", (i-1)*200, 40)
			if (nil ~= Addon.WindowSettings["WBNubPos"]) then
					WindowSetScale(Addon.WindowSettings.WBNubs[i].name, 
						Addon.WindowSettings["WBNubPos"][i].scale) 
					WindowClearAnchors(Addon.WindowSettings.WBNubs[i].name)
					WindowAddAnchor(Addon.WindowSettings.WBNubs[i].name, 
						Addon.WindowSettings["WBNubPos"][i].my_anchor,
						Addon.WindowSettings["WBNubPos"][i].relwin,
						Addon.WindowSettings["WBNubPos"][i].to_anchor,
						Addon.WindowSettings["WBNubPos"][i].x,
						Addon.WindowSettings["WBNubPos"][i].y)
			end
		end
	end
	-- this may come later..
	--[[
	if (2 == sort) then -- Create Nubs for Class Type
		Addon.WindowSettings.WBSortType = sort

		local temp = { "Heal", "Tank", "MDPS", "RDPS" }
		for i,k in ipairs(temp) do
			--d("test "..i.." | "..k)
			Addon.WindowSettings.WBNubs[i] = {}
			Addon.WindowSettings.WBNubs[i].name = Addon.CreateNub("WB", k)
			Addon.WindowSettings.WBNubs[i].pre = "WB"
			WindowClearAnchors(Addon.WindowSettings.WBNubs[i].name)
			WindowAddAnchor(Addon.WindowSettings.WBNubs[i].name, "topleft", "Root", "topleft", (i-1)*200, 40)
			if ((nil ~= Addon.WindowSettings["WBNubPos"])and
					(nil ~= Addon.WindowSettings["WBNubPos"][i])) then
					WindowSetScale(Addon.WindowSettings.WBNubs[i].name, 
						Addon.WindowSettings["WBNubPos"][i].scale) 
					WindowClearAnchors(Addon.WindowSettings.WBNubs[i].name)
					WindowAddAnchor(Addon.WindowSettings.WBNubs[i].name, 
						Addon.WindowSettings["WBNubPos"][i].my_anchor,
						Addon.WindowSettings["WBNubPos"][i].relwin,
						Addon.WindowSettings["WBNubPos"][i].to_anchor,
						Addon.WindowSettings["WBNubPos"][i].x,
						Addon.WindowSettings["WBNubPos"][i].y)
			end
		end
	end

	if (3 == sort) then -- Create Nubs for Class
	end
	]]--

	Addon.FixAllNubs()
end

function Addon.DestroyWBNubs()
	for _, n in pairs(Addon.WindowSettings.WBNubs) do
		Addon.DestroyNub(n)
	end
end

function Addon.DestroySCNubs()
	for _, n in pairs(Addon.WindowSettings.SCNubs) do
		Addon.DestroyNub(n)
	end
end

function Addon.HideWBNubs()
	for _, n in pairs(Addon.WindowSettings.WBNubs) do
		if (n.name) then WindowSetShowing(n.name, false) end
	end
end

function Addon.ShowWBNubs()
	for _, n in pairs(Addon.WindowSettings.WBNubs) do
		if (n.name) then WindowSetShowing(n.name, true) end
	end
end

function Addon.HideSCNubs()
	for _, n in pairs(Addon.WindowSettings.SCNubs) do
		if (n.name) then WindowSetShowing(n.name, false) end
	end
end

function Addon.ShowSCNubs()
	for _, n in pairs(Addon.WindowSettings.SCNubs) do
		if (n.name) then WindowSetShowing(n.name, true) end
	end
end


function Addon.AddSCState(state)
	-- Add Template Bar
	local bar = Addon.GetBar(state.name)
	if (nil == bar) then
		if (nil == Addon.WindowSettings["SC"].Template) then
			Addon.WindowSettings["SC"].Template = "SCTemplate"
		end
		--bar = Addon.CreateBarFromTemplate(state.name, Addon.WindowSettings["SC"].Template)
		bar = Addon.CreateBar(state.name, Addon.WindowSettings["SC"].Template)
		bar.show = true
		bar.hidden = true
		bar.block_layout_editor = true
		bar:useState(state.name)
	end
	if (nil ~= state.extra_info.career)and(nil ~= state.extra_info.group) then
		local nub_name = ""
		if (1 == Addon.WindowSettings.SCSortType) then
			nub_name = "SCGroup "..state.extra_info.group.."Nub"
		else
			nub_name = "SC"..Addon.CareerResourceSettings[state.extra_info.career].ctype.."Nub"
		end
		Addon.NubAddBar(nub_name, bar.name)
	end
end

function Addon.RemoveSCState(state)
	-- Remove the bar
	for _,b in ipairs(state.bars) do
		local bar = Addon.Bars[b]
		if (nil ~= bar) then
			Addon.NubRemoveBar(bar.name)
			bar:destroy()
		end
	end
end

function Addon.SCNubs(sort)
	if (nil ~= Addon.WindowSettings.SCNubs) then
		Addon.DestroySCNubs()
	end

	Addon.WindowSettings.SCNubs = {}

	if (1 == sort) then -- Create Nubs for Group
		Addon.WindowSettings.SCSortType = sort

		for i=1,4 do
			Addon.WindowSettings.SCNubs[i] = {}
			Addon.WindowSettings.SCNubs[i].name = Addon.CreateNub("SC", "Group "..i)
			Addon.WindowSettings.SCNubs[i].pre = "SC"
			WindowClearAnchors(Addon.WindowSettings.SCNubs[i].name)
			WindowAddAnchor(Addon.WindowSettings.SCNubs[i].name, "topleft", "Root", "topleft", (i-1)*200, 40)
			if (nil ~= Addon.WindowSettings["SCNubPos"]) then
					WindowSetScale(Addon.WindowSettings.SCNubs[i].name, 
						Addon.WindowSettings["SCNubPos"][i].scale) 
					WindowClearAnchors(Addon.WindowSettings.SCNubs[i].name)
					WindowAddAnchor(Addon.WindowSettings.SCNubs[i].name, 
						Addon.WindowSettings["SCNubPos"][i].my_anchor,
						Addon.WindowSettings["SCNubPos"][i].relwin,
						Addon.WindowSettings["SCNubPos"][i].to_anchor,
						Addon.WindowSettings["SCNubPos"][i].x,
						Addon.WindowSettings["SCNubPos"][i].y)
			end
		end
	end
	--may come later...
	--[[
	if (2 == sort) then -- Create Nubs for Class Type
		Addon.WindowSettings.SCSortType = sort

		local temp = { "Heal", "Tank", "MDPS", "RDPS" }
		for i,k in ipairs(temp) do
			--d("test "..i.." | "..k)
			Addon.WindowSettings.SCNubs[i] = {}
			Addon.WindowSettings.SCNubs[i].name = Addon.CreateNub("SC", k)
			Addon.WindowSettings.SCNubs[i].pre = "SC"
			WindowClearAnchors(Addon.WindowSettings.SCNubs[i].name)
			WindowAddAnchor(Addon.WindowSettings.SCNubs[i].name, "topleft", "Root", "topleft", (i-1)*200, 40)
			if ((nil ~= Addon.WindowSettings["SCNubPos"])and
					(nil ~= Addon.WindowSettings["SCNubPos"][i])) then
					WindowSetScale(Addon.WindowSettings.SCNubs[i].name, 
						Addon.WindowSettings["SCNubPos"][i].scale) 
					WindowClearAnchors(Addon.WindowSettings.SCNubs[i].name)
					WindowAddAnchor(Addon.WindowSettings.SCNubs[i].name, 
						Addon.WindowSettings["SCNubPos"][i].my_anchor,
						Addon.WindowSettings["SCNubPos"][i].relwin,
						Addon.WindowSettings["SCNubPos"][i].to_anchor,
						Addon.WindowSettings["SCNubPos"][i].x,
						Addon.WindowSettings["SCNubPos"][i].y)
			end
		end
	end

	if (3 == sort) then -- Create Nubs for Class
	end
	]]--
	Addon.FixAllNubs()
end

--[[
HUDUFSC = {}
HUDUFSC.TemplateBar = "grp1hp"
function Addon.SCFactory(state)
	if (1 == state.valid) then
		if (0 == #state.bars) then
			-- Add Template Bar
			--local bar = Addon.CreateBarFromTemplate(WStringToString(state.word), HUDUFSC.TemplateBar)
			local bar = Addon.CreateBar(WStringToString(state.word), HUDUFSC.TemplateBar)
			bar:useState(state.name)
			local nub_name = "Group "..state.extra_info.group.."Nub"
			Addon.NubAddBar(nub_name, bar.name)
		end
	else
		-- Remove the bar
		for _,b in ipairs(state.bars) do
			local bar = Addon.Bars[b]
			if (nil ~= bar) then
				Addon.NubRemoveBar(bar.name)
				bar:destroy()
			end
		end
	end
end ]]

function Addon.NubAddBar(nub_name, bar_name)
	local nub = nil
	local found = false

	for _, n in pairs(Addon.WindowSettings.SCNubs) do
		if (nub_name == n.name) then
			nub = n
		end
	end
	for _, n in pairs(Addon.WindowSettings.WBNubs) do
		if (nub_name == n.name) then
			nub = n
		end
	end

	if (nil == nub) then return end

	if (nil == nub.bars) then
		nub.bars = {}
	end

	--d("test"..nub_name.." | "..bar_name)
	for _,n in ipairs(nub.bars) do
		if (n == bar_name) then
			found = true
		end
	end

	if (false == found) then
		table.insert(nub.bars, bar_name)
	end

	--WindowSetParent(bar_name, nub_name)

	Addon.NubFixBars(nub)
end

function Addon.NubRemoveBar(bar_name)
	--d("nub remove bar "..bar_name)
	for _, n in pairs(Addon.WindowSettings.SCNubs) do
		if (nil ~= n.bars) then 
			for k,v in ipairs(n.bars) do
				if (v == bar_name) then
					table.remove(n.bars, k)
				end
			end
			Addon.NubFixBars(n)
		end
	end
	for _, n in ipairs(Addon.WindowSettings.WBNubs) do
		if (nil ~= n.bars) then 
			for k,v in ipairs(n.bars) do
				if (v == bar_name) then
					table.remove(n.bars, k)
				end
			end
			Addon.NubFixBars(n)
		end
	end
end

function Addon.FixAllNubs()
	if (nil ~= Addon.WindowSettings.SCNubs) then
		for _, n in pairs(Addon.WindowSettings.SCNubs) do
			Addon.NubFixBars(n)
		end
	end
	if (nil ~= Addon.WindowSettings.WBNubs) then
		for _, n in pairs(Addon.WindowSettings.WBNubs) do
			Addon.NubFixBars(n)
		end
	end
end

function Addon.NubFixBars(nub)
	local bar
	if (nil == nub.bars) then return end
	local pre = nub.pre
	if (nil == Addon.WindowSettings[pre].Direction) then
		Addon.WindowSettings[pre].Direction = 1
	end
	local dir = Addon.WindowSettings[pre].Direction
	for i,b in ipairs(nub.bars) do
		bar = Addon.Bars[b]
		if (nil ~= bar) then
			if (1 == dir) then -- down
				bar.to_anchor = "topleft"
				bar.my_anchor = "bottomleft"
			elseif (2 == dir) then --right
				bar.to_anchor = "topleft"
				bar.my_anchor = "topright"
			elseif (3 == dir) then --up
				bar.to_anchor = "bottomleft"
				bar.my_anchor = "topleft"
			elseif (4 == dir) then --left
				bar.to_anchor = "topright"
				bar.my_anchor = "topleft"	
			end
			bar.x = 0
			bar.y = 0
				
			bar.x = tonumber(Addon.WindowSettings[pre].x_off)
			if (not bar.x) then bar.x = 0 end
				
			bar.y = tonumber(Addon.WindowSettings[pre].y_off)
			if (not bar.y) then bar.y = 0 end
				
			if (1 == i) then
				bar.relwin = nub.name
				bar.my_anchor = "left"
			else
				bar.relwin = nub.bars[i-1]
			end
			--d("fixing "..bar.name.." | "..bar.relwin)

			bar:setup()
			bar:render()
		end
	end
end


function Addon.CreateWindowSettings(pre)
	if (not Addon.WindowSettings) then
			Addon.WindowSettings = 
				{
					--SCSortType = 1,
					--SCTemplate = "SCTemplate",
					--WBSortType = 1,
					--WBTemplate = "WBTemplate",
				}
	end
	if (pre == "WB") then
		if (not Addon.WindowSettings.WB) then
			--Addon.WindowSettings.WBSortType = 1
			--Addon.WindowSettings.WBTemplate = "WBTemplate"
		
			Addon.WindowSettings.WB = 
				{
					showgroup = true,
					disabled = false,
					--hide_label = false,
					--Template = "WBTemplate",
					SortType = 1,
					Direction = 2,
				}
			Addon.WindowSettings.WBNubPos  = 
				{
					
					{	y = 100,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 160,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 220,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 290,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
				}
			Addon.WindowSettings.WBNubs = 
				{
					{	name = "WBNubGroup1",	pre = "WB",	},
					{	name = "WBNubGroup2",	pre = "WB",	},
					{	name = "WBNubGroup3",	pre = "WB",	},
					{	name = "WBNubGroup4",	pre = "WB",	},
				}
		end
	end
	if (pre == "SC") then
		if (not Addon.WindowSettings.SC) then
			--Addon.WindowSettings.SCSortType = 1
			--Addon.WindowSettings.SCTemplate = "SCTemplate"	
		
			Addon.WindowSettings.SC = 
				{
					showgroup = true,
					disabled = false,
					--hide_label = false,
					Template = "SCTemplate",
					SortType = 1,
					Direction = 2,
				}
			Addon.WindowSettings.SCNubPos  = 
				{
					
					{	y = 100,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 160,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 220,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
					{	y = 290,x = 0,relwin = "Root",to_anchor = "topleft",	scale = 0.75,my_anchor = "topleft",	},
				}
			Addon.WindowSettings.SCNubs = 
				{
					{	name = "SCNubGroup1",	pre = "SC",	},
					{	name = "SCNubGroup2",	pre = "SC",	},
					{	name = "SCNubGroup3",	pre = "SC",	},
					{	name = "SCNubGroup4",	pre = "SC",	},
				}
		end
	end

end

function Addon.CreateNub(pre, name)
	--d("Creating Nub: "..pre..name.."Nub")
	--CreateWindowFromTemplate(pre.."Nub"..name, "HUDUFNub", "Root")
	CreateWindowFromTemplate(pre.."Nub"..name, "HUDUFBarTemplate", "Root")
	-- register it
	LayoutEditor.RegisterWindow(pre.."Nub"..name, 
				L"HUDUF "..towstring(pre)..L"Nub"..towstring(name), 
				L"HUD Unit Frames", 
				false, false, 
				false, nil)
	
	if (not Addon.WindowSettings[pre]) then
		Addon.CreateWindowSettings(pre)
	end

	if ((Addon.WindowSettings[pre].hide_label == nil) 
			or (Addon.WindowSettings[pre].hide_label == false))
	then
		LabelSetText(pre.."Nub"..name.."Name", towstring(name))
	else
		LabelSetText(pre.."Nub"..name.."Name",L"")
	end


	if (nil == Addon.WindowSettings[pre]) then
		Addon.WindowSettings[pre] = {}
	end

	if (nil == Addon.WindowSettings[pre].Template) then
		Addon.WindowSettings[pre].Template = pre.."Template"
	end

	if (nil ~= Addon.Bars[Addon.WindowSettings[pre].Template]) then
		local bar = Addon.Bars[Addon.WindowSettings[pre].Template]
		if (nil ~= bar) then
			WindowSetDimensions(pre.."Nub"..name, bar.width, 25)
		end
	end


	return pre.."Nub"..name
end

function Addon.DestroyNub(nub)
	if (nil ~= nub.bars) then
		for i,b in ipairs(nub.bars) do
			if (nil ~= Addon.Bars[b]) then
				local state = Addon.Bars[b].state
				Addon.DestroyBar(b)
				if (nil ~= state) then
					Addon.States[state].valid = 0
				end
			end
		end
	end

	if (true == DoesWindowExist(nub.name)) then
		DestroyWindow(nub.name)
		LayoutEditor.UnregisterWindow(nub.name)
	end
end
