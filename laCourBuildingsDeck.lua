local buildingZones = {"e03e9a", "72e2ec", "d91132"}
local buildingsBoardGuid = "d19b4c"

function onLoad()
  if not Global.get('gameMode').laCour then
    self.setPosition({self.getPosition().x, 0.5, self.getPosition().z})
  end
end

function dealBuildings()
  print("Dealing la cour buildings")
  for _, zoneGuid in pairs(buildingZones) do
    local zone = getObjectFromGUID(zoneGuid)
    if not buildingPresent(zone) then
      dealBuilding(zone)
    end
  end
end

function buildingPresent(zone)
  local count = 0
  for _, obj in pairs(zone.getObjects()) do
    if not obj.isSmoothMoving() then
      count = count + 1
    end
  end
  return count > 1
end

function dealBuilding(zone)
  self.takeObject({position = zone.getPosition(), rotation = {0, 180, 0}})
end
