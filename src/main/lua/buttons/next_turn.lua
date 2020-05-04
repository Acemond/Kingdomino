local leftZoneGuid = "38ed1c"
local rightZoneGuid = "358f4e"
local rightBoardsGuids = { "e5b23a", "7a72d1", "174390", "722967" }
local tileCheckZones = {
  "8fd451", "7e8397", "d0b593", "f25b1c", "234056", "e05d05", "094ef7", "568e1c"
}
local unpickedTilesBagGuid = "32278a"
local turn = 0
local tableGuid = "0f8757"

local kingsGuid = {
  "4d2d92", "5e6289", "7dd59a", "e44a70", "24345c", "2837e9", "86f4c2", "61259d",
  "526c31", "f2cd83", -- Green
  "9dc643", "0dba70", -- Pink
}
local game = {}
local player_ready = {}

function onLoad(save_state)
  initialize(save_state)
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

function initialize(save_state)
  if save_state ~= "" then
    turn = JSON.decode(save_state).turn
    game = JSON.decode(save_state).game
    Global.setTable("game", game)
    if game and game.castles then
      initializeCastles(game.castles)
      resetCastles(game.castles)
    end
  end
end

function onSave()
  return JSON.encode({
    turn = turn,
    game = game
  })
end

function temporarilyDisableButtons()
  local button = self.getButtons()[1]
  self.editButton({ index = button.index, scale = { 0, 0, 0 } })
  Wait.frames(function()
    self.editButton({ index = button.index, scale = { 1, 1, 1 } })
  end, 120)
end

function onClick()
  temporarilyDisableButtons()
  temporarilyDisableCastles()
  nextTurn()
end

function firstTurn(new_game)
  game = new_game
  initializeCastles(game.castles)
  nextTurn()
end

function temporarilyDisableCastles()
  for _, guid in pairs(game.castles) do
    getObjectFromGUID(guid).call("temporarilyDisable")
  end
end

function disableCastles()
  for _, guid in pairs(game.castles) do
    getObjectFromGUID(guid).call("removeReadyButton")
  end
end

function initializeCastles(castle_guids)
  for _, guid in pairs(castle_guids) do
    getObjectFromGUID(guid).call("initialize")
  end
end

function resetCastles(castle_guids)
  for color, guid in pairs(castle_guids) do
    getObjectFromGUID(guid).call("reset")
    player_ready[color] = false
  end
end

function setPlayerReady(parameters)
  player_ready[parameters.player_color] = parameters.is_ready
  if checkAllPlayersReady() then
    temporarilyDisableButtons()
    temporarilyDisableCastles()
    nextTurn()
  end
end

function checkAllPlayersReady()
  for _, is_ready in pairs(player_ready) do
    if not is_ready then
      return false
    end
  end
  return true
end

function nextTurn()
  if not pcall(checkZones) then
    return
  end

  turn = turn + 1
  removedUnpickedTiles()

  for _, manager in pairs(game.buildings) do
    getObjectFromGUID(manager).call("dealBuildings")
  end

  if turn ~= 1 then
    moveZoneContents()
  end

  Wait.frames(function()
    resetCastles(game.castles)
  end, 100)

  local deck = getObjectFromGUID(game.decks[(turn - 1) % #game.decks + 1])
  if deck ~= nil then
    deck.shuffle()
    deck.call("dealTiles")
  else
    disableCastles()
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
      if unpickedTilesBag then
        getObjectFromGUID(unpickedTilesBagGuid).putObject(object)
      else
        destroyObject(object)
      end
    end
  end
end

function checkZones()
  if turn == 0 then
    return
  end
  checkRightZone()
  checkLeftZone()
end

function getExpectedKings()
  if game.settings.player_count == 2 then
    return 4
  else
    return game.settings.player_count
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
  local kingCount = 0
  local tileCount = 0
  for _, object in pairs(zone.getObjects()) do
    if not isObjectIn(object.guid, rightBoardsGuids) and object.guid ~= tableGuid then
      if isObjectIn(object.guid, kingsGuid) then
        kingCount = kingCount + 1
      end
      if not isObjectIn(object.guid, kingsGuid) then
        tileCount = tileCount + 1
      end
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
