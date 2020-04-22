local leftZoneGuid = "38ed1c"
local rightZoneGuid = "358f4e"
local rightBoardsGuids = {"e5b23a", "7a72d1", "174390"}
local tileCheckZones = {
  "8fd451", "7e8397", "d0b593", "f25b1c", "234056"
}
local unpickedTilesBagGuid = "32278a"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label          = "",
    position       = {0,0.05,0},
    color          = {0, 0, 0, 0},
    width          = 2400,
    height         = 600
  })
end

function onClick()
  nextTurn()
end

function nextTurn()
  if pcall(checkZones) then
    print("Zones OK")
    removedUnpickedTiles()
    print("Removed tiles")
    local gameMode = Global.get("gameMode")
    if gameMode.queendomino then
      Global.get("buildingsDeck").call("dealBuildings")
    end
    if gameMode.laCour then
      Global.get("laCourDeck").call("dealBuildings")
    end

    moveZoneContents()

    local deck = Global.get("deck")
    if deck ~= nil then
      deck.shuffle()
      deck.call("dealTiles")
    end

    Wait.frames(function()
      if Global.get("deck") == nil then
        destroyObject(self)
      end
    end, 1)
  end
end

function removedUnpickedTiles()
  for _, zoneGuid in pairs(tileCheckZones) do
    local zone = getObjectFromGUID(zoneGuid)
    if #zone.getObjects() == 2 then
      trashTile(zone)
    end
  end
end

function trashTile(zone)
  for _, object in pairs(zone.getObjects()) do
    local unpickedTilesBag = getObjectFromGUID(unpickedTilesBagGuid)
    if object.guid ~= "e5b23a" and object.guid ~= "7a72d1" and object.guid ~= "174390" then
      if unpickedTilesBag ~= nil then
        getObjectFromGUID(unpickedTilesBagGuid).putObject(object)
      else
        destroyObject(object)
      end
    end
  end
end

function checkZones()
  checkRightZone()
  checkLeftZone()
end

function checkRightZone()
  local holderSize = Global.get("holderSize")
  local playerCount = Global.get("playerCount")

  local expectedKings = nil
  if playerCount == 3 then
    expectedKings = 3
  else
    expectedKings = 4
  end
  local expectedCount = holderSize + 1 + expectedKings

  if #getObjectFromGUID(rightZoneGuid).getObjects() < expectedCount then
    broadcastToAll("Pick dominos before clicking Next Turn", {r=1, g=0, b=0})
    error()
  end
end

function checkLeftZone()
  if #getObjectFromGUID(leftZoneGuid).getObjects() > 1 then
    broadcastToAll("Clear left dominos before clicking Next Turn", {r=1, g=0, b=0})
    error()
  end
end

function moveZoneContents()
  local rightZone = getObjectFromGUID(rightZoneGuid)
  for _,obj in ipairs(rightZone.getObjects()) do
    if not isObjectTileBoard(obj.guid) then
      obj.setPositionSmooth({
        obj.getPosition().x - 11,
        obj.getPosition().y + 2,
        obj.getPosition().z
      }, false)
    end
  end
end

function isObjectTileBoard(objectGuid)
  for _, guid in pairs(rightBoardsGuids) do
    if objectGuid == guid then return true end
  end
  return false
end
