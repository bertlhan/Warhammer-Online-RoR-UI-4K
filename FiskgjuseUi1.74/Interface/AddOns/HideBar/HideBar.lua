if not HideBar then HideBar = {} end
if not HideBar.SavedSettings then HideBar.SavedSettings = {} end

local TIME_DELAY = 0.3;

-- Lua locals for performance
local tostring = tostring
local towstring = towstring
local WindowGetScreenPosition = WindowGetScreenPosition
local WindowGetDimensions = WindowGetDimensions
local WindowSetAlpha = WindowSetAlpha
local WindowSetShowing = WindowSetShowing
local DoesWindowExist = DoesWindowExist
local WindowGetScale = WindowGetScale



local HiddenBarNumber;
local HiddenBarWindowName;


function HideBar.Initialize()
	
	if HideBar.SavedSettings.HiddenBarNumber then
		HiddenBarNumber = HideBar.SavedSettings.HiddenBarNumber;
		HiddenBarWindowName = "EA_ActionBar" .. tostring(HiddenBarNumber);
	end

	RegisterEventHandler( SystemData.Events.LOADING_END, "HideBar.unfuckHiddenBar");
    RegisterEventHandler( SystemData.Events.ALL_MODULES_INITIALIZED, "HideBar.unfuckHiddenBar")
	
	LibSlash.RegisterSlashCmd("hidebar", function(input) HideBar.SlashCmd(input) end);

	if HiddenBarNumber then
		EA_ChatWindow.Print( towstring("HideBar loaded, bar " .. tostring(HiddenBarNumber) .. " is hidden."));
	else
		EA_ChatWindow.Print( towstring("HideBar loaded, no bar is hidden."));
	end
	
end

local timeLeft = TIME_DELAY;
function HideBar.OnUpdate(elapsed)

	if not HiddenBarWindowName then return end

	timeLeft = timeLeft - elapsed;
    if (timeLeft > 0) then return; end

	local TempWindowX,TempWindowY = WindowGetScreenPosition(HiddenBarWindowName);
	if (not TempWindowX) or (not TempWindowY) then return; end

	local MousePosX = SystemData.MousePosition.x;
	if (MousePosX > TempWindowX) then
		local TempWindowWidth, TempWindowHeight = WindowGetDimensions(HiddenBarWindowName)
		if (MousePosX < (TempWindowX + (TempWindowWidth * WindowGetScale(HiddenBarWindowName)))) then
			local MousePosY = SystemData.MousePosition.y;
			if (MousePosY > TempWindowY) then
				if (MousePosY < (TempWindowY + (TempWindowHeight*WindowGetScale(HiddenBarWindowName)))) then
					--d("showing")
					WindowSetShowing(HiddenBarWindowName, true);
					timeLeft = TIME_DELAY;
					return;
				end
			end
		end
	end
	
	--d("hiding")
	WindowSetShowing(HiddenBarWindowName,false);
	timeLeft = TIME_DELAY;
	
end

function HideBar.SlashCmd(command)

	if command == "forceoff" then
		HideBar.ForceOff();
		return;
	elseif command == "1" or command == "2" or command == "3" or command == "4" or command == "5" then

		local input = tonumber(command);
	
		-- make the bar that was hidden previously visible again
		if HiddenBarWindowName then
			WindowSetShowing(HiddenBarWindowName,true);
			WindowSetAlpha(HiddenBarWindowName,1);
			WindowSetFontAlpha(HiddenBarWindowName,1);
		end
		
		-- hide the new bar
		HiddenBarWindowName = "EA_ActionBar"..input;
		WindowSetShowing(HiddenBarWindowName,false);
		
		-- remember to hide this bar in the future
		HideBar.SavedSettings.HiddenBarNumber = input;
		
		EA_ChatWindow.Print(L"[HideBar] bar number " .. towstring(input) .. L" is now hidden.");
		
	else
		EA_ChatWindow.Print(L"[HideBar] Use /hidebar n to hide action bar number n or /hidebar forceoff to show all hidden bars.");
	end

end

-- /script HideBar.ForceOff()
function HideBar.ForceOff()
	if not HideBar.SavedSettings or not HideBar.SavedSettings.HiddenBarNumber then return end
	--d("HideBar.ForceOff()");
	HideBar.OnShutdown();
	HideBar.SavedSettings.oldBar = HideBar.SavedSettings.HiddenBarNumber;
	HideBar.SavedSettings.HiddenBarNumber = nil;
end

-- reset visibility of the hidden bar in case user disables/uninstalls the addon on next login
function HideBar.OnShutdown()
	if HiddenBarWindowName then
		WindowSetShowing(HiddenBarWindowName, true);
		WindowSetAlpha(HiddenBarWindowName, 1);
		WindowSetFontAlpha(HiddenBarWindowName, 1);
		HiddenBarNumber = nil;
		HiddenBarWindowName = nil;
	end
	UnregisterEventHandler( SystemData.Events.LOADING_END, "HideBar.unfuckHiddenBar");
    UnregisterEventHandler( SystemData.Events.ALL_MODULES_INITIALIZED, "HideBar.unfuckHiddenBar")
end


function HideBar.unfuckHiddenBar()
	if HideBar.SavedSettings.oldBar then
		local window = "EA_ActionBar" .. tostring(HideBar.SavedSettings.oldBar);
		if DoesWindowExist(window) ~= true then return end
		d("unfucking the hidden bar")
		WindowSetShowing(window, true);
		HideBar.SavedSettings.oldBar = nil;
		return
	end	
end

-- /script d(HideBar.SavedSettings)
-- /script WindowGetShowing("EA_ActionBar3");
-- /script WindowSetShowing("EA_ActionBar3", true)

-- /script HideBar.test()
function HideBar.test()
	d("HideBar.test()")
	d(HiddenBarNumber)
	d(HiddenBarWindowName)
end


