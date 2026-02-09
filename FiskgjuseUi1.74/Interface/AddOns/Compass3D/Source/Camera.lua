Compass3D = Compass3D or {}
Compass3D.Camera = {}

local pivot_zone_id = 0

local pivot_zone_x = nil
local pivot_zone_y = nil
-- The Z position is the same for region and zone coordinates.
local pivot_world_z = nil

-- Player data stored seperately from pivot point data, as the player position
-- might change before the new pivot data (specifically, pivot_zone_position_z)
-- is calculated. This ensures the current pivot data stays synced with itself.

local player_zone_id = 0

local player_zone_x = nil
local player_zone_y = nil

local function CalculatePivotPoisition ()

  -- Cache these function for performance.
  local math_abs = math.abs
  local WorldToScreen = WorldToScreen

  -- We can't do anything if we do not know where the player is.
  if (player_zone_x == nil)
  then
    pivot_zone_id = player_zone_id
    pivot_zone_x = nil
    pivot_zone_y = nil
    pivot_world_z = nil
    return
  end

  -- We are aiming to find a Z value that results in WorldToScreen putting the
  -- screen-space Y value in the middle of the screen.
  local mid_screen_y = SystemData.screenResolution.y / 2

  -- Shortest pixel distance to mid_screen_y found so far. Initialised with a
  -- stupidly large value to ensure the first on-screen Z value becomes the
  -- best.
  local best_distance_screen_y = 100000

  --[[
  ----------------------------------------------------------------------------    
  -- "HISTORIC" SEARCH PHASE
  ----------------------------------------------------------------------------

  See if the previous Z value gives us a point on screen. If so then we can skip
  the "coarse" search phase and use the old Z as a starting point for the "fine"
  search phase.

  TODO: to make this more robust, this should be used to feed into the coarse
  search phase rather than skip it completely in case the player height changed
  by more than 50 inches in a frame (frame drops?)

  ]]

  local historic_pivot_screen_y = nil
  local historic_pivot_world_z = nil

  if (pivot_world_z ~= nil)
  then
    local screen_visible, screen_x, screen_y = WorldToScreen (player_zone_x, player_zone_y, pivot_world_z)

    if (screen_visible == true)
    then
      best_distance_screen_y = math_abs (mid_screen_y - screen_y)

      historic_pivot_screen_y = screen_y
      historic_pivot_world_z = pivot_world_z
    end
  end

  --[[
  ----------------------------------------------------------------------------
  -- "COARSE" SEARCH PHASE
  ----------------------------------------------------------------------------

  Start scanning from the bottom of the map (0) to the top of the map (-65535)
  in steps of -50 inches. This is the "coarse" phase where we are looking for
  the Z coordinate (in multiples of 50 inches) that results in a Y screen
  position closest to `mid_screen_y`.

  This stage is skipped completely if the "historic" search phase found an Z
  value on screen.

  ]]

  local coarse_pivot_screen_y = nil
  local coarse_pivot_world_z = nil

  if (historic_pivot_world_z == nil)
  then

    -- Scan from the bottom of the map to the top in increments of 50 inches.
    for test_world_z = 0, -65535, -50
    do

      local screen_visible, screen_x, screen_y = WorldToScreen (player_zone_x, player_zone_y, test_world_z)

      -- The point is on screen.
      if (screen_visible == true)
      then

        local distance_screen_y = math_abs (mid_screen_y - screen_y)

        -- Check if it's the closest point to mid_screen_y so far.
        if (distance_screen_y < best_distance_screen_y)
        then
          best_distance_screen_y = distance_screen_y

          coarse_pivot_screen_y = screen_y
          coarse_pivot_world_z = test_world_z
        end

        -- If screen_y is above the line then we don't need to check any more Z
        -- values as the rest of the points will be further away.
        if (screen_y <= mid_screen_y)
        then
          break
        end

      end

    end

    -- If we couldn't find any on-screen Z values then we can't calculate the
    -- camera's pivot position. Likely only happens if the player is zoomed in
    -- too close to the pivot position.
    if (coarse_pivot_world_z == nil)
    then
      pivot_zone_id = player_zone_id
      pivot_zone_x = nil
      pivot_zone_y = nil
      pivot_world_z = nil
      return
    end

  else

    coarse_pivot_screen_y = historic_pivot_screen_y
    coarse_pivot_world_z = historic_pivot_world_z

  end

  -- We already have the best possible Z value so stop searching.
  if (best_distance_screen_y == 0)
  then
    pivot_zone_id = player_zone_id
    pivot_zone_x = player_zone_x
    pivot_zone_y = player_zone_y
    pivot_world_z = coarse_pivot_world_z
    return
  end

  --[[
  ----------------------------------------------------------------------------
  -- "FINE" SEARCH PHASE
  ----------------------------------------------------------------------------

  Previously we have either found that the previous Z value was still on screen
  ("historic" search) or we have scanned the Z values in blocks of 50 inches and
  recorded the details of the Z value closest to the middle of the screen on the
  Y axis ("coarse" search).

  Now, we refine that search by making up to 49 additional checks, one per inch,
  to find a Z value even closer to the middle of the screen's Y axis. If the
  "historic" search was carried out then there is a tiny chance that the "fine"
  search won't find the optimal value. This only happens if the player's Z
  coordinate changed by more than 50 inches in a single frame. If that happens
  then the Z value found by the "fine" search will still be better than the one
  originally found by the "historic" search, and it will be further refined on
  later frames if needed.

  Regardless of how it was found, if the Z found prior to starting the "fine"
  search was in the top-half of the screen (`coarse_pivot_screen_y` <
  `mid_screen_y`) then then this means we overshot the Z values and need to
  start scanning towards the bottom of the world. If not then we need to start
  scanning towards the top of the world.

  Because WAR is weird, the "bottom/floor" Z is 0, and the "top/sky" Z is
  -65535. This means that to go down we need to increase the Z value and to go
  up we need to decrease it.

  ]]

  -- Default: search upwards (decrease Z).
  local fine_direction_z = -1
  local fine_pivot_world_z = coarse_pivot_world_z

  -- If the current screen Y cordinate is in the top-half of the screen then
  -- search downwards (increase Z) instead. Screen coordinates are 0 at the
  -- top and SystemData.screenResolution.y at the bottom (standard screen
  -- space coordinates).
  if (coarse_pivot_screen_y < mid_screen_y)
  then
    fine_direction_z = 1
  end

  -- Now check up to 49 inches to try and get as close to mid_screen_y as
  -- possible. Multiplying by `direction` is used to control whether we search
  -- towards the top or bottom of the map.
  for test_world_z = (coarse_pivot_world_z + fine_direction_z), (coarse_pivot_world_z + (49 * fine_direction_z)), (1 * fine_direction_z)
  do

    local screen_visible, screen_x, screen_y = WorldToScreen (player_zone_x, player_zone_y, test_world_z)

    -- If we can't see this point, we can't see any others after.
    if (screen_visible == false)
    then
      break
    end

    local distance_screen_y = math_abs (mid_screen_y - screen_y)

    if (distance_screen_y < best_distance_screen_y)
    then
      best_distance_screen_y = distance_screen_y
      fine_pivot_world_z = test_world_z
    else
      -- Current and all subsequent points will be further away.
      break
    end

  end

  pivot_zone_id = player_zone_id
  pivot_zone_x = player_zone_x
  pivot_zone_y = player_zone_y
  pivot_world_z = fine_pivot_world_z

end



function Compass3D.Camera.GetPivotZonePosition ()

  CalculatePivotPoisition ()

  return pivot_zone_x, pivot_zone_y, pivot_world_z, pivot_zone_id

end

function Compass3D.Camera.OnInitialize ()

  RegisterEventHandler (SystemData.Events.PLAYER_POSITION_UPDATED, "Compass3D.Camera.OnPlayerPositionUpdated")

end

function Compass3D.Camera.OnPlayerPositionUpdated (player_region_position_x, player_region_position_y)

  -- Due to what I assume are bugs with the client, this event only gets called
  -- reliably when walking forwards or pure strafing. Walking backwards or
  -- back-strafing do not cause the events to be generated regularly, and being
  -- in the air is a huge mess.

  -- x and y are in region coordinates (regions hold multiple zones) and not
  -- zone coordinates (which WorldToScreen uses), so we need to convert between
  -- the two. There is no client-provided way to do this so Compass3D.ZoneData
  -- was added and filled with data pulled out of the client's internal
  -- "figleaf.db" file.

  player_zone_id = GameData.Player.zone

  local current_zone_data = Compass3D.ZoneData[player_zone_id]

  -- If this happens then we've ended up in a brand new zone that the addon
  -- knows nothing about. Nothing we can do.
  if (current_zone_data == nil)
  then
      player_zone_x = nil
      player_zone_y = nil
      return
  end

  -- Convert from region to zone coordinates and save.
  player_zone_x = player_region_position_x - current_zone_data.region_offset_x
  player_zone_y = player_region_position_y - current_zone_data.region_offset_y

end

function Compass3D.Camera.OnShutdown ()

  UnregisterEventHandler (SystemData.Events.PLAYER_POSITION_UPDATED, "Compass3D.Camera.OnPlayerPositionUpdated")

end
