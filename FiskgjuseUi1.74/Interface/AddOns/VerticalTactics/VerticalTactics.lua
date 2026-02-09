
VerticalTactics = {}
VerticalTactics.reverse = false

function VerticalTactics.Initialize()
	local modules = ModulesGetData()
	for k,v in ipairs(modules) do
		if v.name == "EA_TacticsWindow_WifNamez" then
			if v.isEnabled and not v.isLoaded then
				ModuleInitialize("EA_TacticsWindow_WifNamez");
			end
			break
		end
	end

	local hookCreateBar = TacticsEditor.CreateBar
	TacticsEditor.CreateBar = function(...)
		hookCreateBar(...)
		VerticalTactics.AnchorTacticButtons()
	end
	local hookUpdateTactics = TacticsEditor.UpdateTactics
	TacticsEditor.UpdateTactics = function()
		hookUpdateTactics()
		VerticalTactics.AnchorTacticButtons()
	end

	local hookTacticShutdown = TacticsEditor.Shutdown
	TacticsEditor.Shutdown = function()
		VerticalTactics.Shutdown()
		hookTacticShutdown()
	end
	if LibSlash then
		LibSlash.RegisterSlashCmd("verticaltactics", function(args)
			if args:match("^reverse (.+)$") then
				local n = args:match("^reverse (.+)$")
				if n == "true" then
					VerticalTactics.reverse = true
					VerticalTactics.AnchorTacticButtons()
				elseif n == "false" then
					VerticalTactics.reverse = false
					VerticalTactics.AnchorTacticButtons()
				end
			else
				EA_ChatWindow.Print(L"[VerticalTactics]: Valid options are:\n reverse [true|false]: enable/disable reverse mode")
			end
		end)
	end
end

function VerticalTactics.Shutdown()
	if DoesWindowExist("EA_TacticsEditor") then
		local x, y = WindowGetDimensions("EA_TacticsEditor")
		if y > x then
			WindowSetDimensions("EA_TacticsEditor", y, x)
		end
	end
end

function VerticalTactics.AnchorTacticButtons()
	if not DoesWindowExist("EA_TacticsEditor") then
		return
	end
	local dimX, dimY = WindowGetDimensions("EA_TacticsEditor")
	if dimX > dimY then
		WindowSetDimensions("EA_TacticsEditor", dimY, dimX)
	end
	
	WindowClearAnchors("EA_TacticsEditorContentsSetMenu")
	if VerticalTactics.reverse then
		WindowAddAnchor("EA_TacticsEditorContentsSetMenu", "bottomleft", "EA_TacticsEditor", "bottomleft", 0, 0)
	else
		WindowAddAnchor("EA_TacticsEditorContentsSetMenu", "topleft", "EA_TacticsEditor", "topleft", 0, 0)
	end
	
	local scale = WindowGetScale("EA_TacticsEditor")

	local anchorToWindow    = "EA_TacticsEditor";
	local offsetX           = 1;
	local offsetY           = 47;
	local relativePoint     = "topleft";
	local point             = "topleft";
	if VerticalTactics.reverse then
		offsetY           = -47;
		relativePoint     = "bottomleft";
		point             = "bottomleft";
	end

	local windowName, previousButtonId
	for buttonId = 1, GameData.MAX_TACTICS_SLOTS do
		windowName = "TacticButton"..buttonId
		if not DoesWindowExist(windowName) then
			break
		end
		previousButtonId = buttonId - 1
	
		if (previousButtonId > 0) then
			anchorToWindow  = "TacticButton"..previousButtonId;
			offsetX         = 0;
			if VerticalTactics.reverse then
				offsetY         = -2;
				point           = "topleft";
			else
				offsetY         = 2;
				point           = "bottomleft";
			end
		end

		WindowClearAnchors (windowName);
		WindowSetScale(windowName, scale)
		WindowAddAnchor (windowName, point, anchorToWindow, relativePoint, offsetX, offsetY);
	end
	for slotType = GameData.TacticType.FIRST, GameData.TacticType.NUM_TYPES do
		windowName = "Spacer"..slotType
		if DoesWindowExist(windowName) then
			WindowSetShowing(windowName, false)
		end
	end
end
