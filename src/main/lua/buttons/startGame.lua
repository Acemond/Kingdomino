local kingTargetPositions = {
  { 0.00, 1.92, -1.00 },
  { 0.00, 1.92, -3.00 },
  { 0.00, 1.92, -5.00 },
  { 0.00, 1.92, -7.00 },
  { 0.00, 1.92, -9.00 }
}

local hidden_boards = {}
local player_pieces_guids = {
  orange = {
    hand_zone = "96929a",
    castle_tile = "9ab771",
    castle = "768b9c",
    kings = { "4d2d92", "5e6289" }
  },
  purple = {
    hand_zone = "6ea086",
    castle_tile = "7db35a",
    castle = "a1e204",
    kings = { "7dd59a", "e44a70" }
  },
  red = {
    hand_zone = "31279b",
    castle_tile = "f6948c",
    castle = "ae130d",
    kings = { "24345c", "2837e9" }
  },
  white = {
    hand_zone = "f85ea1",
    castle_tile = "537260",
    castle = "fd4160",
    kings = { "86f4c2", "61259d" }
  },
  green = {
    hand_zone = "352048",
    castle_tile = "8c9612",
    castle = "b5c1bc",
    kings = { "526c31", "f2cd83" }
  },
  pink = {
    hand_zone = "49989f",
    castle_tile = "a5aad1",
    castle = "a407fb",
    kings = { "9dc643", "0dba70" }
  }
}

local right_boards_infos = {
  nil,
  nil,
  { guid = "e5b23a", position = { 5.50, 1.06, -3.01 } },
  { guid = "7a72d1", position = { 5.50, 1.06, -4.21 } },
  { guid = "174390", position = { 5.50, 1.06, -5.50 } }
}

local left_boards_infos = {
  nil,  -- size 1
  nil,  -- size 2
  { guid = "ae485e", position = { -5.50, 1.06, -3.01 } },  -- size 3
  { guid = "bd95f5", position = { -5.50, 1.06, -3.01 } },  -- size 4
  { guid = "8c018b", position = { -5.50, 1.06, -5.50 } }  -- size 5
}

local zone_coordinates_modifiers = {
  nil,
  nil,
  { zPos = -3, zScale = 8.25 },
  { zPos = -4.25, zScale = 10.5 },
  { zPos = -5.5, zScale = 13.5 },
}

local left_control_zone_guid = "38ed1c"
local right_control_zone_guid = "358f4e"
local game_buttons_guid = {
  age_of_giants = { "df1760", "6a25ff" },
  two_players_advanced = { "823bca", "02322f" }
}
local game_dependencies = {
  kingdomino = { "two_players_advanced", "age_of_giants" }
}
local quests_deck_guid = "fd8a62"
local game_objects_guid = {
  kingdomino = {
    deck = "b972db"
  },
  two_players_advanced = {},
  queendomino = {
    deck = "b12f86",
    buildings = "04de04",
    left_building_board = "a77d62",
    right_building_board = "a066dc",
    coin1_bag = "38e164",
    coin3_bag = "8468e9",
    coin9_bag = "4638c0",
    knight_bag = "fe4062",
    tower_bag = "45152b",
    queen = "401270",
    dragon = "447c40"
  },
  age_of_giants = {
    deck = "d36a20",
    giants_bag = "da9688"
  },
  the_court = {
    buildings = "e0b7ee",
    building_board = "d19b4c",
    wheat_bag = "68a4e4",
    sheep_bag = "98f12a",
    wood_bag = "443d34",
    fish_bag = "3725a9"
  }
}
local kings_bag_guid = "1403b9"
local buttons_to_remove = {
  removeRed = "dfeee5",
  addRed = "a1ef12",
  removeOrange = "fa1b7c",
  addOrange = "8d17b0",
  removeWhite = "74e8b0",
  addWhite = "f60fe5",
  removePurple = "1bbcb3",
  addPurple = "1b4b1a",
  removeGreen = "8fedd0",
  addGreen = "fbeaba",
  removePink = "668a0a",
  addPink = "6987e6",
  quickSetup = "31971b",
  quickSetup2p = "46971b",
  quickSetup3p = "4f4db6",
  quickSetup4p = "8dfa00",
  quickSetup5p = "1765aa",
  quickSetup6p = "6c37eb",
  laCourEnable = "6ff70f",
  laCourDisable = "2c22ed",
  kingdominoEnable = "9f4a39",
  kingdominoDisable = "697d5b",
  queendominoEnable = "69cbda",
  queendominoDisable = "d64709",
  age_of_giantsEnable = "df1760",
  age_of_giantsDisable = "6a25ff",
  two_players_advancedEnable = "823bca",
  two_players_advancedDisable = "02322f",
  randomn_quests_enable = "75dcb1",
  randomn_quests_disable = "edb838",
  kingdomino_xl_enable = "42f5a4",
  kingdomino_xl_disable = "92f52d",
  teamdomino_enable = "83af19",
  teamdomino_disable = "355eca",
}
local objects_to_lock = {
  game_objects_guid.kingdomino.deck,
  game_objects_guid.queendomino.deck,
  game_objects_guid.queendomino.buildings,
  game_objects_guid.queendomino.left_building_board,
  game_objects_guid.queendomino.right_building_board,
  game_objects_guid.queendomino.coin1_bag,
  game_objects_guid.queendomino.coin3_bag,
  game_objects_guid.queendomino.coin9_bag,
  game_objects_guid.queendomino.knight_bag,
  game_objects_guid.queendomino.tower_bag,
  game_objects_guid.the_court.building_board,
  game_objects_guid.the_court.wheat_bag,
  game_objects_guid.the_court.sheep_bag,
  game_objects_guid.the_court.wood_bag,
  game_objects_guid.the_court.fish_bag
}
local deck_size_modifiers = {
  two_players_basic = 0.5,
  three_players_classic = 0.75
}

local decks_positions = {
  main_deck = {
    { { 0.00, 1.24, -23.00 } },
    { { -3.00, 1.24, -23.00 }, { 3.00, 1.24, -23.00 } }
  },
  buildings = {
    queendomino = { -5.88, 1.25, 4.05 },
    the_court = { -3.67, 1.21, 8.04 }
  }
}

local questPositions = {
  { -3.00, 1.03, -20.00 },
  { 3.00, 1.03, -20.00 }
}
local default_quests_guid = { "e29f53", "e865f4" }

local game_settings = {
  players = {
    white = false,
    orange = false,
    purple = false,
    red = false,
    green = false,
    pink = false
  },
  modes = {
    kingdomino = true,
    queendomino = false,
    age_of_giants = false,
    the_court = false
  },
  variants = {
    two_players_advanced = false,
    three_players_variant = true,
    random_quests = false
  }
}
local next_turn_button_guid = "4a6126"

function onLoad()
  self.createButton({
    click_function = "startGame",
    function_owner = self,
    label = "",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600
  })
end

function quickSetup(target_player_count)
  if getPlayerCount() ~= target_player_count then
    if target_player_count == 2 then
      setPlayers({ "white", "orange" }, { "purple", "red", "green", "pink" })
    elseif target_player_count == 3 then
      setPlayers({ "white", "orange", "purple" }, { "red", "green", "pink" })
    elseif target_player_count == 4 then
      setPlayers({ "red", "orange", "purple", "white" }, { "green", "pink" })
    else
      setPlayers({ "red", "orange", "purple", "white", "green" }, { "pink" })
    end
  end

  startGame()
end

function isGameReady()
  if getPlayerCount() < 2 then
    return false, "There should be at least two players to start a game"
  elseif not game_settings.modes.kingdomino and not game_settings.modes.queendomino then
    return false, "You should pick at least a deck to play"
  elseif getPlayerCount() == 5 and not (
      game_settings.modes.age_of_giants
      or (game_settings.modes.queendomino and game_settings.modes.kingdomino)
  ) then
    return false, "You need to enable Age of Giants or both Kingdomino and Queendomino to play with 5 players"
  elseif getPlayerCount() > 5 and not (game_settings.variants.teamdomino or (game_settings.modes.queendomino and game_settings.modes.kingdomino)) then
    return false, "You need to enable either Teamdomino or both Kingdomino and Queendomino to play with " .. tostring(getPlayerCount()) .. " players"
  end
  return true
end

function addPlayer(playerColor)
  showCastle(playerColor)
  game_settings.players[playerColor] = true
  updateTileBoards()
end

function removePlayer(playerColor)
  hideCastle(playerColor)
  game_settings.players[playerColor] = false
  updateTileBoards()
end

function hideCastle(playerColor)
  local castle = getObjectFromGUID(player_pieces_guids[playerColor].castle)
  local castle_tile = getObjectFromGUID(player_pieces_guids[playerColor].castle_tile)
  castle.setPositionSmooth({ castle_tile.getPosition().x, -1.5, castle_tile.getPosition().z }, false)
  castle.lock()
end

function showCastle(playerColor)
  local castle = getObjectFromGUID(player_pieces_guids[playerColor].castle)
  local castle_tile = getObjectFromGUID(player_pieces_guids[playerColor].castle_tile)
  castle.setPositionSmooth({ castle_tile.getPosition().x, 1.16, castle_tile.getPosition().z }, false)
end

function enableDeck(gameName)
  game_settings.modes[gameName] = true
  showObjects(game_objects_guid[gameName])

  if game_dependencies[gameName] then
    enableDependenciesButtons(game_dependencies[gameName])
  end

  updateTileBoards()
end

function enableDependenciesButtons(dependencies_name)
  for _, dependencyName in pairs(dependencies_name) do
    showObjects(game_buttons_guid[dependencyName])
    for _, guid in pairs(game_buttons_guid[dependencyName]) do
      local button = getObjectFromGUID(guid)
      if button ~= nil then
        button.setPosition({ button.getPosition().x, 1.06, button.getPosition().z })
        button.lock()
        if button.getStateId() == 2 then
          button.setState(1)
        end
      end
    end
  end
end

function setVariant(parameters)
  game_settings.variants[parameters.variant_name] = parameters.value
end

function disableDeck(gameName)
  game_settings.modes[gameName] = false
  hideObjects(game_objects_guid[gameName])

  if game_dependencies[gameName] then
    for _, dependencyName in pairs(game_dependencies[gameName]) do
      disableDeck(dependencyName)
      hideObjects(game_buttons_guid[dependencyName])
    end
  end
  updateTileBoards()
end

function getBoardSize()
  if game_settings.modes.age_of_giants then
    return 5
  elseif getPlayerCount() == 3
      and not game_settings.modes.queendomino
      and not game_settings.variants.three_players_variant then
    return 3
  elseif getPlayerCount() == 5 then
    return 5
  else
    return 4
  end
end

function hideTileBoards(board_size)
  table.insert(hidden_boards, left_boards_infos[board_size].guid)
  table.insert(hidden_boards, right_boards_infos[board_size].guid)
  local leftBoard = getObjectFromGUID(left_boards_infos[board_size].guid)
  local rightBoard = getObjectFromGUID(right_boards_infos[board_size].guid)

  leftBoard.setPositionSmooth({ leftBoard.getPosition().x, 0, leftBoard.getPosition().z }, false, true)
  rightBoard.setPositionSmooth({ rightBoard.getPosition().x, 0, rightBoard.getPosition().z }, false, true)
end

function showTilesBoard(board_size)
  local leftBoard = getObjectFromGUID(left_boards_infos[board_size].guid)
  local rightBoard = getObjectFromGUID(right_boards_infos[board_size].guid)

  leftBoard.setPositionSmooth({ leftBoard.getPosition().x, 1.06, leftBoard.getPosition().z }, false, true)
  rightBoard.setPositionSmooth({ rightBoard.getPosition().x, 1.06, rightBoard.getPosition().z }, false, true)
end

function updateTileBoards()
  local target_size = getBoardSize()
  showTilesBoard(target_size)
  hidden_boards = {}
  for size, _ in pairs(right_boards_infos) do
    if size ~= target_size then
      hideTileBoards(size)
    end
  end
  resizeControlZones(target_size)
end

function setPlayers(playing, not_playing)
  for _, color in pairs(playing) do
    addPlayer(color)
  end
  for _, color in pairs(not_playing) do
    removePlayer(color)
  end
end

function getPlayerCount()
  local count = 0
  for _, playing in pairs(game_settings.players) do
    if playing then
      count = count + 1
    end
  end
  return count
end

function destroyObjectsIfExists(guids)
  for _, guid in pairs(guids) do
    destroyObjectIfExists(guid)
  end
end

function destroyObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object ~= nil then
    object.destroy()
  end
end

function getPlayingColors()
  local playingColors = {}
  for color, playing in pairs(game_settings.players) do
    if playing then
      table.insert(playingColors, color)
    end
  end
  return playingColors
end

function startGame()
  is_ready, message = isGameReady()
  if not is_ready then
    broadcastToAll(message, { r = 1, g = 0, b = 0 })
    return
  end

  placeKings()

  if game_settings.variants.random_quests then
    dealRandomQuests()
  else
    dealDefaultQuests()
  end

  local decks = prepareMainDecks()
  local buildings = prepareBuildingsDecks()

  if game_settings.modes.queendomino then
    for _, color in pairs(getPlayingColors()) do
      takeCoins(color)
    end
  end

  self.setState(2)
  destroyObjectsIfExists(buttons_to_remove)
  destroyObjectsIfExists(hidden_boards)
  destroyUnusedPieces()

  lockExistingObjects()

  local new_game = {
    decks = decks,
    board_size = getBoardSize(),
    buildings = buildings,
    settings = game_settings,
    player_count = getPlayerCount()
  }
  Global.setTable("game", new_game)
  getObjectFromGUID(next_turn_button_guid).call("firstTurn", new_game)
end

function dealDefaultQuests()
  dealQuests(default_quests_guid)
end

function dealRandomQuests()
  dealQuests({ nil, nil })
end

function dealQuests(quest_guids)
  local quest_deck = getObjectFromGUID(quests_deck_guid)
  quest_deck.shuffle()
  for i = 1, 2, 1 do
    quest_deck.takeObject({
      guid = quest_guids[i],
      position = questPositions[i],
      callback_function = function(obj)
        obj.lock()
      end })
  end
  quest_deck.destroy()
end

function lockExistingObjects()
  for _, guid in pairs(objects_to_lock) do
    local obj = getObjectFromGUID(guid)
    if obj ~= nil then
      obj.lock()
    end
  end
end

function takeCoins(playerColor)
  local handPosition = getObjectFromGUID(player_pieces_guids[playerColor].hand_zone).getPosition()
  local coin1Bag = getObjectFromGUID(game_objects_guid.queendomino.coin1_bag)
  local coin3Bag = getObjectFromGUID(game_objects_guid.queendomino.coin3_bag)
  local knightBag = getObjectFromGUID(game_objects_guid.queendomino.knight_bag)
  coin1Bag.takeObject({ smooth = false, position = { handPosition.x + 2, handPosition.y, handPosition.z } })
  coin3Bag.takeObject({ smooth = false, position = { handPosition.x + 1, handPosition.y, handPosition.z } })
  coin3Bag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z } })
  knightBag.takeObject({ smooth = false, position = { handPosition.x - 2, handPosition.y, handPosition.z } })
end

function destroyUnusedPieces()
  for mode, enabled in pairs(game_settings.modes) do
    if not enabled then
      for _, guid in pairs(game_objects_guid[mode]) do
        destroyObjectIfExists(guid)
      end
    end
  end
end

function setupRoyalWedding(decksPositions)
  setupKingdomino(decksPositions[1])
  setupQueendomino(decksPositions[2])
  Global.setTable("decks", {
    getObjectFromGUID(game_objects_guid.kingdomino.deck),
    getObjectFromGUID(game_objects_guid.queendomino.deck)
  })
end

function placeKings()
  local kingsBag = getObjectFromGUID(kings_bag_guid)

  destroyNonPlayingKings(kingsBag)
  takeKings(kingsBag)
end

function takeKings(kingsBag)
  kingsBag.shuffle()
  local playingColors = getPlayingColors()

  if #playingColors == 2 then
    math.randomseed(os.time())
    local firstPlayerIndex = math.random(2)
    local firstPlayer = player_pieces_guids[playingColors[firstPlayerIndex]]
    local otherPlayer = player_pieces_guids[playingColors[3 - firstPlayerIndex]]

    kingsBag.takeObject({ guid = firstPlayer.kings[1], position = kingTargetPositions[1], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = otherPlayer.kings[1], position = kingTargetPositions[2], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = otherPlayer.kings[2], position = kingTargetPositions[3], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = firstPlayer.kings[2], position = kingTargetPositions[4], rotation = { 0, 180, 0 } })
  else
    for i = 1, #playingColors, 1 do
      kingsBag.takeObject({ position = kingTargetPositions[i], rotation = { 0, 180, 0 } })
    end
  end

  destroyObject(kingsBag)
end

function destroyNonPlayingKings(kingsBag)
  for color, playing in pairs(game_settings.players) do
    if not playing then
      destroyObjectInBag(kingsBag, player_pieces_guids[color].kings[1])
      destroyObjectInBag(kingsBag, player_pieces_guids[color].kings[2])
      destroyObject(getObjectFromGUID(player_pieces_guids[color].castle))
      destroyObject(getObjectFromGUID(player_pieces_guids[color].castle_tile))
    elseif getPlayerCount() > 2 then
      destroyObjectInBag(kingsBag, player_pieces_guids[color].kings[1])
    end
  end
end

function destroyObjectInBag(bag, guid)
  bag.takeObject({
    guid = guid,
    smooth = false,
    callback_function = function(obj)
      destroyObject(obj)
    end
  })
end

function showObjects(object_guids)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      showObject(object)
      showObjectsButton(object)
    end
  end
end

function hideObjects(object_guids)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      hideObject(object)
      hideObjectsButton(object)
    end
  end
end

function hideObjectsButton(object)
  local buttons = object.getButtons()
  if buttons ~= nil then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 0, 0, 0 } })
    end
  end
end

function showObjectsButton(object)
  local buttons = object.getButtons()
  if buttons ~= nil then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 1, 1, 1 } })
    end
  end
end

function showObject(object)
  object.setPosition({ object.getPosition().x, 3, object.getPosition().z })
  object.unlock()
end

function hideObject(object)
  object.setPositionSmooth({ object.getPosition().x, -2.5, object.getPosition().z })
  object.lock()
end

function resizeControlZones(slots)
  resizeControlZone(getObjectFromGUID(right_control_zone_guid), slots)
  resizeControlZone(getObjectFromGUID(left_control_zone_guid), slots)
end

function resizeControlZone(zone, slots)
  zone.setScale({ zone.getScale().x, zone.getScale().y, zone_coordinates_modifiers[slots].zScale })
  zone.setPosition({ zone.getPosition().x, zone.getPosition().y, zone_coordinates_modifiers[slots].zPos })
end

function prepareMainDecks()
  local decks = getMainDecks()
  local positions = getMainDecksPosition(decks)
  readyDecks(decks, positions)

  local indexedDeck = {}
  for _, deck in pairs(decks) do
    table.insert(indexedDeck, deck)
  end
  return indexedDeck
end

function prepareBuildingsDecks()
  local decks = getBuildingsDecks()
  local positions = getBuildingsDecksPosition(decks)
  readyDecks(decks, positions)

  return decks
end

function readyDecks(decks, positions)
  for name, deck in pairs(decks) do
    deck.setPositionSmooth(positions[name])
    deck.shuffle()
  end
end

function getMainDecks()
  local decks = {}
  for mode, enabled in pairs(game_settings.modes) do
    if enabled and mode == "age_of_giants" then
      local age_of_giants_deck = getObjectFromGUID(game_objects_guid[mode].deck)
      local kingdomino_deck = getObjectFromGUID(game_objects_guid["kingdomino"].deck)
      kingdomino_deck.call("mergeDeck", age_of_giants_deck)
    elseif enabled and game_objects_guid[mode].deck then
      local deck = getObjectFromGUID(game_objects_guid[mode].deck)
      decks[mode] = deck
    end
  end
  return decks
end

function getBuildingsDecks()
  local buildings_deck = {}
  for mode, enabled in pairs(game_settings.modes) do
    if enabled and game_objects_guid[mode].buildings then
      buildings_deck[mode] = getObjectFromGUID(game_objects_guid[mode].buildings)
    end
  end
  return buildings_deck
end

function getBuildingsDecksPosition(buildings)
  local decks_target_position = {}
  for mode, _ in pairs(buildings) do
    decks_target_position[mode] = decks_positions.buildings[mode]
  end
  return decks_target_position
end

function getMainDecksPosition(decks)
  local decks_target_position = {}
  local size = getSize(decks)
  local i = 1
  for mode, _ in pairs(decks) do
    decks_target_position[mode] = decks_positions.main_deck[size][i]
    i = i + 1
  end
  return decks_target_position
end

function resizeDecks(decks)
  if isOnlyKingdomino(game_settings.modes) then
    if not game_settings.variants.two_players_advanced then
      cutDeck(decks.kingdomino, deck_size_modifiers.two_players_basic)
    end
    if not game_settings.variants.three_players_variant then
      cutDeck(decks.kingdomino, deck_size_modifiers.three_players_classic)
    end
  end
  return decks
end

function isOnlyKingdomino(selected_modes)
  for mode, activated in pairs(selected_modes) do
    if activated and mode ~= "kingdomino" then
      return false
    end
  end
  return true
end

function cutDeck(deck, size_modifier)
  deck.cut(#deck.getObjects() * size_modifier)[2].destroy()
end

function getSize(t)
  size = 0
  for _, _ in pairs(t) do
    size = size + 1
  end
  return size
end
