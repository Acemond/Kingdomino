local buildingZones = { "e03e9a", "72e2ec", "d91132" }

local deck_guid = "e0b7ee"
local deck_position = { -3.67, 1.21, 8.04 }

function dealBuildings()
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
  return count > 2
end

function dealBuilding(zone)
  local deck = getObjectFromGUID(deck_guid)
  if deck ~= nil then
    deck.takeObject({
      position = zone.getPosition(),
      rotation = { 0, 180, 180 },
      callback_function = function(tile)
        tile.flip()
      end
    })
  end
end

function placeDeck()
  local deck = getObjectFromGUID(deck_guid)
  deck.setPositionSmooth(deck_position)
  deck.shuffle()
end