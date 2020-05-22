SnapPointsManager = {}
SnapPointsManager.__index = SnapPointsManager

local static_snap_points = {}
local held_objects_snap_points = {}

local displayed_snap_points = {}

function SnapPointsManager.setStaticSnapPoints(snap_points)
  static_snap_points = {}
  for _, snap in pairs(snap_points) do
    table.insert(static_snap_points, { snap.position.x, snap.position.z })
  end
end

function SnapPointsManager.setGlobalSnapPoints()
  if not table.containsOnly(displayed_snap_points, held_objects_snap_points) then
    displayed_snap_points = held_objects_snap_points
    Global.setSnapPoints(displayed_snap_points)
  end
end

function setHeldObjectsSnapPoint(snap_points)
  held_objects_snap_points = snap_points
end