local leftZoneGuid = "38ed1c"
local rightZoneGuid = "358f4e"
local rightBoardsGuids = { "e5b23a", "7a72d1", "174390" }
local tileCheckZones = {
  "8fd451", "7e8397", "d0b593", "f25b1c", "234056"
}
local unpickedTilesBagGuid = "32278a"
local turn = 0
local tableGuid = "0f8757"

local kingsGuid = {
  "4d2d92", "5e6289", "7dd59a", "e44a70", "24345c", "2837e9", "86f4c2", "61259d"
}
local game = {}

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600
  })
end

function onClick()
  nextTurn()
end

function firstTurn(new_game)
  game = new_game
  nextTurn()
end

function nextTurn()
  if not pcall(checkZones) then
    return
  end

  turn = turn + 1
  removedUnpickedTiles()

  for _, deck in pairs (game.buildings) do
    deck.call("dealBuildings")
  end

  moveZoneContents()

  print(turn)
  print((turn - 1) % 2 + 1)
  local deck = game.decks[(turn - 1) % 2 + 1]
  print(game.decks)
  print(deck)
  if deck ~= nil then
    deck.shuffle()
    deck.call("dealTiles")
  else
    broadcastToAll("Last turn! Score sheets are on the compass.", { r = 1, g = 1, b = 1 })
    Player.getPlayers()[1].pingTable({ 36.99, 3, -28.38 })
    self.destroy()
  end
end

function removedUnpickedTiles()
  for _, zoneGuid in pairs(tileCheckZones) do
    local zone = getObjectFromGUID(zoneGuid)
    if #zone.getObjects() == 3 then
      trashTile(zone)
    end
  end
end

function trashTile(zone)
  for _, object in pairs(zone.getObjects()) do
    local unpickedTilesBag = getObjectFromGUID(unpickedTilesBagGuid)
    if not isObjectIn(object.guid, rightBoardsGuids) and object.guid ~= tableGuid then
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

function getExpectedKings()
  if turn == 0 then
    return 0
  elseif game.player_count == 3 then
    return 3
  else
    return 4
  end
end

function checkRightZone()
  if getKingCount() ~= getExpectedKings() then
    broadcastToAll("Pick dominos before clicking Next Turn", { r = 1, g = 0, b = 0 })
    error()
  end
  for _, zoneGuid in pairs(tileCheckZones) do
    checkTileZone(getObjectFromGUID(zoneGuid))
  end
end

function getKingCount()
  local count = 0
  for _, object in pairs(getObjectFromGUID(rightZoneGuid).getObjects()) do
    if isObjectIn(object.guid, kingsGuid) then
      count = count + 1
    end
  end
  return count
end

function checkTileZone(zone)
  local kingCount = getKingCount()
  local tileCount = 0
  for _, object in pairs(zone.getObjects()) do
    if not isObjectIn(object.guid, rightBoardsGuids) and object.guid ~= tableGuid and not isObjectIn(object.guid, kingsGuid) then
      tileCount = tileCount + 1
    end
  end
  if kingCount > 0 and tileCount == 0 then
    broadcastToAll("Place your king on a domino", { r = 1, g = 0, b = 0 })
    error()
  end
  return kingCount
end

function checkLeftZone()
  if #getObjectFromGUID(leftZoneGuid).getObjects() > 2 then
    broadcastToAll("Clear left dominos before clicking Next Turn", { r = 1, g = 0, b = 0 })
    error()
  end
end

function moveZoneContents()
  local rightZone = getObjectFromGUID(rightZoneGuid)
  for _, obj in ipairs(rightZone.getObjects()) do
    if not isObjectIn(obj.guid, rightBoardsGuids) and obj.guid ~= tableGuid then
      obj.unlock()
      obj.setPositionSmooth({
        obj.getPosition().x - 11,
        obj.getPosition().y + 2,
        obj.getPosition().z
      }, false)
    end
  end
end

function isObjectIn(objectGuid, list)
  for _, guid in pairs(list) do
    if objectGuid == guid then
      return true
    end
  end
  return false
end
