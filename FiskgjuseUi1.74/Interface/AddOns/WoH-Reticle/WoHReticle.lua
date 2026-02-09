LibConfig = LibStub("LibConfig")

WoHReticle = {}

local print 		= EA_ChatWindow.Print
local HPlerps = {
	{ 35, 	 180, 	75	}, -- green 100-80
	{ 255,	 240,	0	}, -- yellow - 59-40
	{ 240,	 30, 	35	}, -- red 19-0
}

local lerprate = 0.5

DEFAULTSETTINGS = {
	version = 1.2,
	FriendlyReticle = { enabled = true,
						hp = 100,
						scale = 1,
						alpha = 1,
						dx = 0,
						dy = -10,
						lerp = false,
						graphic = "default",
					},
	EnemyReticle =	{ enabled = true,
						hp = 100,
						scale = 1.25,
						alpha = 1,
						dx = 0,
						dy = -10,
						lerp = true,
						graphic = "default",
						},
					}

local cur_eid = nil
local cur_fid = nil
local GUI
local RotateFactor = 25

local function getNeededColors(percent)
	local r, g, b
	if percent >= 100 then
		r, g, b = HPlerps[1]
	elseif percent >= 50 then
		r, g, b = HPlerps[2]
	else
		r, g, b = HPlerps[3]
	end
	return r, g, b
end

local function getMin(hp)
	local min
	if hp >= 100 then
		min = 100
	elseif hp >= 50 then
		min = 50
	else
		min = 0
	end
	return min
end

local function lerp(unit)

	local hp = WoHReticle.Settings[unit].hp 
	local min = getMin(hp) 
	local max = min + 50
	local difference_max = max - min
	local difference_needed = hp - min
	local difference_percentage = difference_needed / difference_max

	if hp >= 50 then
		difference_percentage = 1 - difference_percentage
	end

	xr = getNeededColors(min)
	yr = getNeededColors(max)


	local newr = xr[1] - yr[1]
	local newg = xr[2] - yr[2]
	local newb = xr[3] - yr[3]

	if newr < 0 then
		newr = newr * -1
	end

	if newg < 0 then
		newg = newg * -1
	end

	if newb < 0 then
		newb = newb * -1
	end

	local newr = newr * difference_percentage
	local newg = newg * difference_percentage
	local newb = newb * difference_percentage

	local minr, ming, minb
	if xr[1] < yr[1] then
		minr = xr[1]
	else
		minr = yr[1]
	end

	if xr[2] < yr[2] then
		ming = xr[2]
	else
		ming = yr[2]
	end

	if xr[3] < yr[3] then
		minb = xr[3]
	else
		minb = yr[3]
	end

	local newr = minr + newr
	local newg = ming + newg
	local newb = minb + newb

	WindowSetTintColor(unit, newr, newg, newb)
end

function WoHReticle.OnUpdate(timeElapsed)
	if WoHReticle.RotateTimer <= 360 then
		WoHReticle.RotateTimer = WoHReticle.RotateTimer + (timeElapsed * RotateFactor)
	else
		WoHReticle.RotateTimer = 0
	end

	for unit, _ in pairs(WoHReticle.Settings) do
		if (unit ~= "version") then
			DynamicImageSetRotation(unit, WoHReticle.RotateTimer)
			if WoHReticle.Settings[unit].lerp == true then
				--lerp
				if WindowGetShowing(unit) == true then
					lerp(unit)
				end
			end
		end
	end
end

function WoHReticle.CreateRing(ring)
	--set the graphic here too
	anchor = ring.."Anchor"
	settings = WoHReticle.Settings[ring]

	if (DoesWindowExist(anchor)) then
		DestroyWindow(ring)
	else
		CreateWindowFromTemplate(anchor, "EA_DynamicImage_DefaultSeparatorRight", "Root")
		WindowSetDimensions(anchor, 1, 1)
	end
	
	CreateWindowFromTemplate(ring, "EA_DynamicImage_DefaultSeparatorRight", anchor)
	WindowClearAnchors(ring)
	WindowAddAnchor(ring, "top", anchor, "top", settings.dx, settings.dy)
	DynamicImageSetTexture(ring, settings.graphic, 0, 0)
	DynamicImageSetTextureDimensions(ring, 256, 256)
	WindowSetDimensions(ring,100,100)
	WindowSetScale(ring, settings.scale)
	WindowSetAlpha(ring, settings.alpha)
	WindowSetShowing(ring, false)
end

function WoHReticle.Recreate()
	for unit, _ in pairs(WoHReticle.Settings) do
		if (unit ~= "version") then
			WoHReticle.CreateRing(unit)
		end
	end 
end

function WoHReticle.Initialize()

	RegisterEventHandler(SystemData.Events.PLAYER_TARGET_UPDATED, "WoHReticle.UpdateTargets")
	
	LibSlash.RegisterSlashCmd("wohreticle",function(msg) WoHReticle.Slash(msg) end)
	LibSlash.RegisterSlashCmd("reticle",function(msg) WoHReticle.Slash(msg) end)
	LibSlash.RegisterSlashCmd("ret",function(msg) WoHReticle.Slash(msg) end)
	LibSlash.RegisterSlashCmd("woh",function(msg) WoHReticle.Slash(msg) end)
	
	if (not WoHReticle.Settings) then
		WoHReticle.Settings = DEFAULTSETTINGS
	elseif (WoHReticle.Settings.version ~= DEFAULTSETTINGS.version) then
		WoHReticle.Settings = DEFAULTSETTINGS
	end
	
	print(L"<icon26> /woh for more woh-reticle settings")
	WoHReticle.RotateTimer = 0
	WoHReticle.Recreate()
end

function WoHReticle.Slash(msg)
	if (not GUI) then
		GUI = LibConfig("WoHReticle Settings", WoHReticle.Settings, true, WoHReticle.Recreate)

		for unit, _ in pairs(WoHReticle.Settings) do
			if (unit ~= "version") then
				GUI:AddTab(unit)
				GUI("checkbox", "enabled", {unit, "enabled"})
				GUI("checkbox", "lerp", {unit, "lerp"})
				GUI("textbox", "scale", {unit, "scale"}, function(i) return math.max(math.min(i, 10), 0.1) end)
				GUI("label", "")
				local comboBox = GUI("combobox", "reticle:", {unit, "graphic"}).combo
					comboBox:Add("default")
					comboBox:Add("crosshair1")
					comboBox:Add("crosshair2")
					comboBox:Add("crosshair3")
					comboBox:Add("crosshair4")
					comboBox:Add("crosshair5")
					comboBox:Add("crosshair6")
					comboBox:Add("crosshair7")
					comboBox:Add("crosshair8")
					comboBox:Add("crosshair9")
					comboBox:Add("1")
					comboBox:Add("2")
					comboBox:Add("3")

				GUI("textbox", "alpha", {unit, "alpha"})
				GUI("label", "")
				GUI("textbox", "x offset", {unit, "dx"})
				GUI("label", "")
				GUI("textbox", "y offset", {unit, "dy"})
			end
		end
	end
	
	GUI:Show()
end

function WoHReticle.UpdateTargets()
	TargetInfo:UpdateFromClient()
	local fid = TargetInfo:UnitEntityId("selffriendlytarget")
	local fhp
	local fcolor = TargetInfo:UnitRelationshipColor("selffriendlytarget")
	if WoHReticle.Settings.FriendlyReticle.lerp == true then
		fhp = TargetInfo:UnitHealth("selffriendlytarget")
		WoHReticle.Settings.FriendlyReticle.hp = fhp
	end
	if (fid ~= cur_fid) then
		if (cur_fid) then
			DetachWindowFromWorldObject("FriendlyReticleAnchor", cur_fid)
		end
		WindowSetShowing("FriendlyReticle", false)
		if (fid > 0 and fid ~= GameData.Player.worldObjNum) then
			MoveWindowToWorldObject("FriendlyReticleAnchor",fid,1)
			AttachWindowToWorldObject("FriendlyReticleAnchor",fid)
			if (WoHReticle.Settings.FriendlyReticle.enabled) then
				if WoHReticle.Settings.FriendlyReticle.lerp == true then
					--WindowSetTintColor("FriendlyReticle", getNeededColors(fhp))
				else
					WindowSetTintColor("FriendlyReticle", fcolor.r, fcolor.g, fcolor.b)
				end
				WindowSetShowing("FriendlyReticle", true)
			else
				WindowSetShowing("FriendlyReticle", false)
			end
		end
		cur_fid = fid
	end

	local eid = TargetInfo:UnitEntityId("selfhostiletarget")
	local ehp
	local ecolor = TargetInfo:UnitRelationshipColor("selfhostiletarget")
	if WoHReticle.Settings.EnemyReticle.lerp == true then
		ehp = TargetInfo:UnitHealth("selfhostiletarget")
		WoHReticle.Settings.EnemyReticle.hp = ehp
	end
	if (eid ~= cur_eid) then
		if (cur_eid) then
			DetachWindowFromWorldObject("EnemyReticleAnchor", cur_eid)
		end
		WindowSetShowing("EnemyReticle", false)
		if (eid > 0) then
			MoveWindowToWorldObject("EnemyReticleAnchor",eid,1)
			AttachWindowToWorldObject("EnemyReticleAnchor",eid)
			if (WoHReticle.Settings.EnemyReticle.enabled) then
				if WoHReticle.Settings.EnemyReticle.lerp == true then
					--WindowSetTintColor("EnemyReticle", getNeededColors(ehp))
				else
					WindowSetTintColor("EnemyReticle", ecolor.r, ecolor.g, ecolor.b)
				end
				WindowSetShowing("EnemyReticle", true)
			else
				WindowSetShowing("EnemyReticle", false)
			end
		end
		cur_eid = eid
	end

end

local function adjustMax(min, max)
	local max = max / max * 100
	local min = min - min
end