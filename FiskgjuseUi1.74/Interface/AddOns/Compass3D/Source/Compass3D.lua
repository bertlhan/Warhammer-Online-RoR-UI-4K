--------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------

-- Customise the appearance of each point and even add more.
local compass_windows =
{
    { name = "Compass3D_PointN", icon = 20078, direction_x =  0, direction_y = -1, red = 255, green = 70, blue = 70, alpha = 0.85, scale = 0.75 },
    { name = "Compass3D_PointS", icon = 20083, direction_x =  0, direction_y =  1, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.75 },
    { name = "Compass3D_PointE", icon = 20069, direction_x =  1, direction_y =  0, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.75 },
    { name = "Compass3D_PointW", icon = 20087, direction_x = -1, direction_y =  0, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.75 },
    { name = "Compass3D_PointNE", icon = 22718, direction_x =  0.707, direction_y = -0.707, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_PointNW", icon = 22718, direction_x =  -0.707, direction_y =  -0.707, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_PointSE", icon = 22718, direction_x =  0.707, direction_y =  0.707, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_PointSW", icon = 22718, direction_x = -0.707, direction_y =  0.707, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point01", icon = 22718, direction_x =  0.259, direction_y = 0.966, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point02", icon = 22718, direction_x =  0.259, direction_y = -0.966, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
	{ name = "Compass3D_Point03", icon = 22718, direction_x =  -0.259, direction_y = 0.966, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point04", icon = 22718, direction_x =  -0.259, direction_y = -0.966, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point05", icon = 22718, direction_x =  0.5, direction_y = 0.866, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point06", icon = 22718, direction_x =  0.5, direction_y = -0.866, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point07", icon = 22718, direction_x =  -0.5, direction_y = 0.866, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point08", icon = 22718, direction_x =  -0.5, direction_y = -0.866, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point09", icon = 22718, direction_x =  0.866, direction_y = 0.5, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point10", icon = 22718, direction_x =  0.866, direction_y = -0.5, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point11", icon = 22718, direction_x =  -0.866, direction_y = 0.5, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point12", icon = 22718, direction_x =  -0.866, direction_y = -0.5, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point13", icon = 22718, direction_x =  0.966, direction_y = 0.259, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point14", icon = 22718, direction_x =  0.966, direction_y = -0.259, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point15", icon = 22718, direction_x =  -0.966, direction_y = 0.259, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
    { name = "Compass3D_Point16", icon = 22718, direction_x =  -0.966, direction_y = -0.259, red = 255, green = 255, blue = 255, alpha = 0.85, scale = 0.4 },
}

-- How far to lower the compass. If zero then it means to centre the compass on
-- the camera's pivot point which is the top of the player's head. 6ft works for
-- most human characters.
local compass_offset_feet = 6

-- How far each point is from the centre of your character.
local compass_radius_feet = 37

--------------------------------------------------------------------------------
-- DON'T TOUCH UNLESS YOU KNOW WHAT YOU'RE DOING
--------------------------------------------------------------------------------

-- Internally the client uses inches
local compass_radius_inches = compass_radius_feet * 12
local compass_offset_inches = compass_offset_feet * 12

local WINDOW_NAME_TEMPLATE = "T_Compass3D_Point"

Compass3D = Compass3D or {}

function Compass3D.OnInitialize ()

  Compass3D.Camera.OnInitialize ()

  -- Create the 4 windows, one for each cardinal direction.
  for _, window in pairs (compass_windows)
  do
      CreateWindowFromTemplate (window.name, WINDOW_NAME_TEMPLATE, "Root")
      WindowSetShowing (window.name, true)
      WindowSetScale (window.name, window.scale)
      WindowSetTintColor (window.name, window.red, window.green, window.blue)

      local texture_name, texture_x, texture_y = GetIconData (window.icon)
      DynamicImageSetTexture (window.name .. "_Icon", texture_name, texture_x, texture_y)
  end

end

function Compass3D.OnShutdown ()

  Compass3D.Camera.OnShutdown ()

end

function Compass3D.OnUpdate (time_delta_s)

  local camera_pivot_x, camera_pivot_y, camera_pivot_z, camera_pivot_zone_id = Compass3D.Camera.GetPivotZonePosition ()

  -- We can't work out the camera pivot point so just hide the compass windows.
  if (camera_pivot_x == nil)
  then
    for _, point in pairs (compass_windows)
    do
      WindowSetAlpha (point.name, 0.0)
    end

    return
  end

  local unscale_multiplier = 1.0 / 0.9  -- TOOD: replace 0.9 with actual scaling multiplier.

  for _, window in pairs (compass_windows)
  do

    local point_zone_x = camera_pivot_x + (window.direction_x * compass_radius_inches)
    local point_zone_y = camera_pivot_y + (window.direction_y * compass_radius_inches)
    local point_zone_z = camera_pivot_z + compass_offset_inches

    local screen_visible, screen_x, screen_y = WorldToScreen (point_zone_x, point_zone_y, point_zone_z)

    local window_name = window.name

    if (screen_visible == true)
    then
      WindowClearAnchors (window_name)
      WindowAddAnchor (window_name, "topleft", "Root", "center", (screen_x) * unscale_multiplier, (screen_y) * unscale_multiplier)

      WindowSetAlpha (window_name, window.alpha)
    else
      WindowSetAlpha (window_name, 0.0)
    end
  end


end

