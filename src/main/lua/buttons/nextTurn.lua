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
    local save = JSON.decode(save_state)

    local decks = {}
    for _, guid in ipairs(save.deck_guids) do
      table.insert(decks, getObjectFromGUID(guid))
    end
    local buildings = {}
    for _, guid in ipairs(save.building_guids) do
      table.insert(buildings, getObjectFromGUID(guid))
    end

    local game_settings = {
      decks = save.decks_settings,
      variants = save.variants_settings,
      player_count = save.player_count,
      seated_players = save.seated_players_settings,
      tile_deal_count = save.tile_deal_count_settings
    }

    game = {
      turn = save.turn,
      decks = decks,
      board_size = save.board_size,
      buildings = buildings,
      settings = game_settings,
      player_count = save.player_count
    }
  end
end

function onSave()
  local deck_guids = {}
  if game.decks then
    for _, deck in ipairs(game.decks) do
      table.insert(deck_guids, deck.guid)
    end
  end

  local building_guids = {}
  if game.buildings then
    for _, deck in pairs(game.buildings) do
      table.insert(building_guids, deck.guid)
    end
  end

  --return JSON.encode({
  --  turn = turn,
  --  deck_guids = deck_guids,
  --  board_size = game.game_settings.tile_deal_count,
  --  building_guids = building_guids,
  --  decks_settings = game.game_settings.decks,
  --  variants_settings = game.game_settings.variants,
  --  seated_players_settings = game.game_settings.seated_players,
  --  tile_deal_count_settings = game.game_settings.tile_deal_count,
  --  player_count = game.game_settings.player_count
  --})
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

  for _, manager in pairs(game.buildings) do
    manager.call("dealBuildings")
  end

  if turn ~= 1 then
    moveZoneContents()
  end

  local deck = game.decks[(turn - 1) % #game.decks + 1]
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
  if game.player_count == 2 then
    return 4
  else
    return game.player_count
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
