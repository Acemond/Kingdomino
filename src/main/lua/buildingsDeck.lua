local buildingZones = {"b6d71a", "3b40dd", "51e2bf", "58ae27", "091f68", "372846"}
local leftBuildingsBoardGuid = "a066dc"
local rightBuildingsBoardGuid = "a77d62"

function dealBuildings()
  sendDragonBack()
  local zones = {}
  for _, zoneGuid in pairs(buildingZones) do
    table.insert(zones, getObjectFromGUID(zoneGuid))
  end

  for i = 1, #zones, 1 do
    if not buildingPresent(zones[i]) then
      local sourceIndex = getNextDealtBuilding(zones, i, #zones)
      if not sourceIndex then
        dealBuilding(zones[i])
      else
        moveBuilding(zones[sourceIndex], zones[i])
      end
    end
  end
end

function sendDragonBack()
  getObjectFromGUID("447c40").setPositionSmooth({-8.28, 1.23, 4.10})
  getObjectFromGUID("447c40").setRotationSmooth({0, 0, 0})
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

function getNextDealtBuilding(zones, cursor, max)
  if buildingPresent(zones[cursor]) then
    return cursor
  elseif cursor == max then
    return false
  else
    return getNextDealtBuilding(zones, cursor + 1, max)
  end
end

function dealBuilding(zone)
  self.takeObject({position = zone.getPosition()})
end

function moveBuilding(sourceZone, destinationZone)
  for _,obj in ipairs(sourceZone.getObjects()) do
    if obj.guid ~= leftBuildingsBoardGuid and obj.guid ~= rightBuildingsBoardGuid then
      obj.setPositionSmooth(destinationZone.getPosition(), false)
    end
  end
end
