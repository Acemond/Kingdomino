local kingTargetPositions = {
  { 0.00, 1.92, -1.00 },
  { 0.00, 1.92, -3.00 },
  { 0.00, 1.92, -5.00 },
  { 0.00, 1.92, -7.00 },
  { 0.00, 1.92, -9.00 },
  { 0.00, 1.92, -11.00 }
}
local table_guid = "0f8757"

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
  nil, -- size 1
  nil, -- size 2
  { guid = "e5b23a", position = { 5.50, 1.06, -3.01 } }, -- size 3
  { guid = "7a72d1", position = { 5.50, 1.06, -4.21 } }, -- size 4
  { guid = "174390", position = { 5.50, 1.06, -5.50 } }, -- size 5
  nil, -- size 6
  nil, -- size 7
  { guid = "722967", position = { 5.50, 1.06, -9 } } -- size 8
}

local left_boards_infos = {
  nil, -- size 1
  nil, -- size 2
  { guid = "ae485e", position = { -5.50, 1.06, -3.01 } }, -- size 3
  { guid = "bd95f5", position = { -5.50, 1.06, -4.21 } }, -- size 4
  { guid = "8c018b", position = { -5.50, 1.06, -5.50 } }, -- size 5
  nil, -- size 6
  nil, -- size 7
  { guid = "a391ea", position = { -5.50, 1.06, -9 } }, -- size 8
}

local zone_coordinates_modifiers = {
  nil, -- size 1
  nil, -- size 2
  { zPos = -3, zScale = 8.25 }, -- size 3
  { zPos = -4.25, zScale = 10.5 }, -- size 4
  { zPos = -5.5, zScale = 13.5 }, -- size 5
  nil,
  nil,
  { zPos = -9, zScale = 20 },
}
local player_add_buttons = {
  red = "a1ef12",
  orange = "8d17b0",
  white = "f60fe5",
  purple = "1b4b1a",
  green = "fbeaba",
  pink = "6987e6"
}
local player_remove_buttons = {
  red = "dfeee5",
  orange = "fa1b7c",
  white = "74e8b0",
  purple = "1bbcb3",
  green = "8fedd0",
  pink = "668a0a"
}
local buttons_to_remove = {
  player_remove_buttons.red,
  player_add_buttons.red,
  player_remove_buttons.orange,
  player_add_buttons.orange,
  player_remove_buttons.white,
  player_add_buttons.white,
  player_remove_buttons.purple,
  player_add_buttons.purple,
  player_remove_buttons.green,
  player_add_buttons.green,
  player_remove_buttons.pink,
  player_add_buttons.pink,
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
  age_of_giants_enable = "df1760",
  age_of_giants_disable = "6a25ff",
  two_players_advanced_enable = "823bca",
  two_players_advanced_disable = "02322f",
  randomn_quests_enable = "75dcb1",
  randomn_quests_disable = "edb838",
  kingdomino_xl_enable = "42f5a4",
  kingdomino_xl_disable = "92f52d",
  teamdomino_enable = "83af19",
  teamdomino_disable = "355eca",
}

local left_control_zone_guid = "38ed1c"
local right_control_zone_guid = "358f4e"
local game_buttons_guid = {
  age_of_giants = { buttons_to_remove.age_of_giants_enable, buttons_to_remove.age_of_giants_disable },
  two_players_advanced = { buttons_to_remove.two_players_advanced_enable, buttons_to_remove.two_players_advanced_disable },
  kingdomino_xl = { buttons_to_remove.kingdomino_xl_enable, buttons_to_remove.kingdomino_xl_disable },
  teamdomino = { buttons_to_remove.teamdomino_enable, buttons_to_remove.teamdomino_disable }
}

local deck_interaction = {
  age_of_giants = { dependency = "kingdomino", incompatibilities = nil },
}

local variant_interaction = {
  kingdomino_xl = { dependency = "kingdomino", incompatibilities = "queendomino" },
  teamdomino = { dependency = "kingdomino", incompatibilities = "queendomino" },
  two_players_advanced = { dependency = "kingdomino", incompatibilities = "queendomino" }
}

local quests_deck_guid = "fd8a62"
local game_objects_guid = {
  kingdomino = {
    deck = "b972db"
  },
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

local castle_tile_positions = {
  white = { x = -21.00, z = -11.00 },
  orange = { x = 21.00, z = -11.00 },
  purple = { x = -21.00, z = 11.00 },
  red = { x = 21.00, z = 11.00 },
  green = { x = -31.00, z = 1.00 },
  pink = { x = 31.00, z = -1.00 },
}
local castle_tile_y = 0.95
local castle_y = 1.16

local decks_positions = {
  main_deck = {
    { { 0.00, 1.24, -24.00 } },
    { { -3.00, 1.24, -24.00 }, { 3.00, 1.24, -24.00 } }
  },
  main_deck_5p = {
    { { 0.00, 1.24, -32.00 } },
    { { -3.00, 1.24, -32.00 }, { 3.00, 1.24, -32.00 } }
  },
  buildings = {
    queendomino = { -5.88, 1.25, 4.05 },
    the_court = { -3.67, 1.21, 8.04 }
  }
}

local next_turn_position = { 0.00, 1.05, -13.00 }
local next_turn_position_5p = {0.00, 1.05, -21.00}

local quests_positions = {
  { -3.00, 1.03, -21.00 },
  { 3.00, 1.03, -21.00 }
}
local quests_positions_5p = {
  { -3.00, 1.03, -29.00 },
  { 3.00, 1.03, -29.00 }
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
    random_quests = false,
    kingdomino_xl = false,
    teamdomino = false
  }
}
local object_visible = {
  kingdomino = true,
  queendomino = true,
  age_of_giants = true,
  the_court = true,
  two_players_advanced = true,
  three_players_variant = true,
  random_quests = true,
  kingdomino_xl = true,
  teamdomino = true,
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
    elseif target_player_count == 5 then
      setPlayers({ "red", "orange", "purple", "white", "green" }, { "pink" })
    elseif target_player_count == 6 then
      if not game_settings.modes.queendomino then
        enableDeck("queendomino")
      end
      if not game_settings.modes.kingdomino then
        enableDeck("kingdomino")
      end
      setPlayers({ "red", "orange", "purple", "white", "green", "pink" }, {})
    end
  end

  startGame()
end

function isGameReady()
  if getPlayerCount() < 2 then
    return false, "There should be at least two players to start a game"
  elseif game_settings.variants.kingdomino_xl and (getPlayerCount() == 2 or getPlayerCount() > 4) then
    return false, "Kingdomino XL is for 3 to 4 players only"
  elseif not game_settings.modes.kingdomino and not game_settings.modes.queendomino then
    return false, "You should pick at least a deck to play"
  elseif getPlayerCount() == 5 and not (
      game_settings.modes.age_of_giants
          or (game_settings.modes.queendomino and game_settings.modes.kingdomino)) then
    return false, "You need to enable Age of Giants or both Kingdomino and Queendomino to play with 5 players"
  elseif getPlayerCount() == 5 and game_settings.modes.age_of_giants
      and game_settings.modes.queendomino
      and game_settings.modes.kingdomino then
    return false, "Royal Wedding not yet implemented for Age of Giants with 5 players"
  elseif getPlayerCount() > 5 and not (game_settings.variants.teamdomino or (game_settings.modes.queendomino and game_settings.modes.kingdomino)) then
    return false, "You need to enable both Kingdomino and Queendomino to play with " .. tostring(getPlayerCount()) .. " players"
  elseif getPlayerCount() > 5 and game_settings.modes.age_of_giants then
    return false, "Age of Giants is for 5 players or less"
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
  castle.setPositionSmooth({ castle_tile_positions[playerColor].x, -1.5, castle_tile_positions[playerColor].z })
  castle.lock()
end

function showCastle(playerColor)
  local castle = getObjectFromGUID(player_pieces_guids[playerColor].castle)
  castle.setPositionSmooth({ castle_tile_positions[playerColor].x, castle_y, castle_tile_positions[playerColor].z })
end

function enableDeck(gameName)
  game_settings.modes[gameName] = true
  showObjects(game_objects_guid[gameName])

  checkInteractions()
  updateTileBoards()
end

function disableDeck(gameName)
  game_settings.modes[gameName] = false
  hideObjects(game_objects_guid[gameName])

  checkInteractions()
  updateTileBoards()
end

function showVariant(variant_name)
  showObjects(game_buttons_guid[variant_name], true)
end

function OrganizeQuests()
  local quests = getObjectFromGUID(quests_deck_guid)
  quests.takeObject({
    guid = default_quests_guid[2],
    position = { quests.getPosition().x, quests.getPosition().y + 0.15, quests.getPosition().z },
    smooth = false
  })
end

function setVariant(parameters)
  game_settings.variants[parameters.variant_name] = parameters.value
  if parameters.variant_name == "random_quests" and parameters.value then
    getObjectFromGUID(quests_deck_guid).shuffle()
  elseif parameters.variant_name == "random_quests" then
    OrganizeQuests()
  end
end

function checkInteractions()
  local decks_to_hide = shouldHide(deck_interaction)
  local decks_to_show = shouldShow(deck_interaction)
  local variants_to_hide = shouldHide(variant_interaction)
  local variants_to_show = shouldShow(variant_interaction)

  for deck_name, _ in pairs(decks_to_hide) do
    if object_visible[deck_name] then
      object_visible[deck_name] = false
      disableDeck(deck_name)
      hideObjects(game_buttons_guid[deck_name])
    end
  end

  for deck_name, _ in pairs(decks_to_show) do
    if not object_visible[deck_name] then
      object_visible[deck_name] = true
      showObjects(game_buttons_guid[deck_name], true)
    end
  end
  for variant_name, _ in pairs(variants_to_show) do
    if not isInKeys(variant_name, variants_to_hide) then
      object_visible[variant_name] = true
      showObjects(game_buttons_guid[variant_name], true)
    end
  end
  for variant_name, _ in pairs(variants_to_hide) do
    object_visible[variant_name] = false
    hideObjects(game_buttons_guid[variant_name])
  end
end

function shouldHide(interaction_table)
  local to_hide = {}
  for game_name, interactions in pairs(interaction_table) do
    for mode, enabled in pairs(game_settings.modes) do
      if mode == interactions.incompatibilities and enabled
          or mode == interactions.dependency and not enabled then
        to_hide[game_name] = true
      end
    end
  end

  return to_hide
end

function shouldShow(interaction_table)
  local to_show = {}
  for game_name, interactions in pairs(interaction_table) do
    if not object_visible[game_name] then
      for mode, enabled in pairs(game_settings.modes) do
        if mode == interactions.dependency and enabled
            or mode == interactions.incompatibilities and not enabled then
          to_show[game_name] = true
        end
      end
    end
  end

  return to_show
end

function getBoardSize()
  local size = 4
  if getPlayerCount() == 3
      and not game_settings.modes.queendomino
      and not game_settings.variants.three_players_variant then
    size = 3
  elseif game_settings.modes.queendomino and game_settings.modes.kingdomino
      and (getPlayerCount() == 5 or getPlayerCount() == 6) then
    size = 8
  end

  if game_settings.modes.age_of_giants then
    size = size + 1
  end

  -- FIXME: Quickfix until other board sizes gets added
  if size ~= 3 and size ~= 4 and size ~= 5 and size ~= 8 then
    return 4
  end

  return size
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
    local player_button = getObjectFromGUID(player_add_buttons[color])
    if player_button then
      player_button.setState(2)
    end
  end
  for _, color in pairs(not_playing) do
    removePlayer(color)
    local player_button = getObjectFromGUID(player_remove_buttons[color])
    if player_button then
      player_button.setState(1)
    end
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
  if object then
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
      Wait.frames(function()
        takeCoins(color)
      end, 1)
    end
  end

  Wait.frames(function()
    destroyObjectsIfExists(buttons_to_remove)
  end, 1)
  destroyObjectsIfExists(hidden_boards)
  destroyUnusedPieces()

  getObjectFromGUID(table_guid).call("unfreezeTemp")
  Wait.frames(function()
    lockExistingObjects()
  end, 60)

  if getPlayerCount() > 4 then
    spaceOutPlayers()
  end

  local new_game = {
    decks = decks,
    board_size = getBoardSize(),
    buildings = buildings,
    settings = game_settings,
    player_count = getPlayerCount()
  }
  Global.setTable("game", new_game)
  local next_turn_button = getObjectFromGUID(next_turn_button_guid)
  setNextTurnPosition(next_turn_button)
  next_turn_button.call("firstTurn", new_game)
  self.destroy()
end

function setNextTurnPosition(button)
  local position = next_turn_position
  if getPlayerCount() > 4 then
    position = next_turn_position_5p
  end

  button.setPosition({ position[1], -2.5, position[3] })
  Wait.frames(function()
    button.setPositionSmooth(position)
  end, 30)
  button.setRotation({ 0, 180, 0 })
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

  local actual_quests_positions = quests_positions
  if getPlayerCount() > 4 then
    actual_quests_positions = quests_positions_5p
  end

  for i = 1, 2, 1 do
    quest_deck.takeObject({
      guid = quest_guids[i],
      position = actual_quests_positions[i],
      callback_function = function(obj)
        obj.lock()
      end })
  end
  quest_deck.destroy()
end

function lockExistingObjects()
  for _, guid in pairs(objects_to_lock) do
    local obj = getObjectFromGUID(guid)
    if obj then
      obj.lock()
    end
  end
end

function takeCoins(playerColor)
  local handPosition = getObjectFromGUID(player_pieces_guids[playerColor].hand_zone).getPosition()
  local coin1Bag = getObjectFromGUID(game_objects_guid.queendomino.coin1_bag)
  local coin3Bag = getObjectFromGUID(game_objects_guid.queendomino.coin3_bag)
  local knightBag = getObjectFromGUID(game_objects_guid.queendomino.knight_bag)
  if playerColor == "green" or playerColor == "pink" then
    coin1Bag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z + 2 } })
    coin3Bag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z + 1 } })
    coin3Bag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z } })
    knightBag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z - 2 } })
  else
    coin1Bag.takeObject({ smooth = false, position = { handPosition.x + 2, handPosition.y, handPosition.z } })
    coin3Bag.takeObject({ smooth = false, position = { handPosition.x + 1, handPosition.y, handPosition.z } })
    coin3Bag.takeObject({ smooth = false, position = { handPosition.x, handPosition.y, handPosition.z } })
    knightBag.takeObject({ smooth = false, position = { handPosition.x - 2, handPosition.y, handPosition.z } })
  end
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

  if getPlayerCount() == 2 then
    math.randomseed(os.time())
    local firstPlayerIndex = math.random(2)
    local firstPlayer = player_pieces_guids[getPlayingColors()[firstPlayerIndex]]
    local otherPlayer = player_pieces_guids[getPlayingColors()[3 - firstPlayerIndex]]

    kingsBag.takeObject({ guid = firstPlayer.kings[1], position = kingTargetPositions[1], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = otherPlayer.kings[1], position = kingTargetPositions[2], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = otherPlayer.kings[2], position = kingTargetPositions[3], rotation = { 0, 180, 0 } })
    kingsBag.takeObject({ guid = firstPlayer.kings[2], position = kingTargetPositions[4], rotation = { 0, 180, 0 } })
  else
    for i = 1, getPlayerCount(), 1 do
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

function showObjects(object_guids, is_button)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object and is_button then
      showButton(object)
      showObjectsButton(object)
    elseif object then
      showObject(object)
    end
  end
end

function hideObjects(object_guids)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object then
      hideObject(object)
      hideObjectsButton(object)
    end
  end
end

function hideObjectsButton(object)
  local buttons = object.getButtons()
  if buttons then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 0, 0, 0 } })
    end
  end
end

function showObjectsButton(object)
  local buttons = object.getButtons()
  if buttons then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 1, 1, 1 } })
    end
  end
end

function showObject(object)
  object.setPosition({ object.getPosition().x, 3, object.getPosition().z })
  object.unlock()
end

function showButton(object)
  object.setPosition({ object.getPosition().x, 1.06, object.getPosition().z })
  if object.getStateId() == 2 then
    object.setState(1)
  end
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
  resizeDecks(decks)
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

function mergeAgeOfGiants(decks)
  local merged_decks = {}
  for name, deck in pairs(decks) do
    if name == "age_of_giants" then
      if game_settings.variants.kingdomino_xl then
        local age_of_giants_clone = deck.clone({ position = { deck.getPosition().x, -2.5, deck.getPosition().z } })
        Wait.frames(function()
          decks["kingdomino_xl"].call("mergeDeck", age_of_giants_clone)
        end, 1)
      end
      decks["kingdomino"].call("mergeDeck", deck)
    else
      merged_decks[name] = deck
    end
  end

  return merged_decks
end

function getMainDecks()
  local decks = {}
  for mode, enabled in pairs(game_settings.modes) do
    if enabled and game_objects_guid[mode].deck then
      local deck = getObjectFromGUID(game_objects_guid[mode].deck)
      decks[mode] = deck
      if game_settings.variants.kingdomino_xl and mode == "kingdomino" then
        local kingdomino_xl_deck = deck.clone({ position = { deck.getPosition().x, -2.5, deck.getPosition().z } })
        decks["kingdomino_xl"] = kingdomino_xl_deck
      end
    end
  end
  return mergeAgeOfGiants(decks)
end

function getBuildingsDecks()
  local buildings_decks = {}
  for mode, enabled in pairs(game_settings.modes) do
    if enabled and game_objects_guid[mode].buildings then
      buildings_decks[mode] = getObjectFromGUID(game_objects_guid[mode].buildings)
    end
  end
  return buildings_decks
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

  local actual_decks_positions = decks_positions.main_deck
  if getPlayerCount() > 4 then
    actual_decks_positions = decks_positions.main_deck_5p
  end

  for mode, _ in pairs(decks) do
    if getPlayerCount() < 5 then
      decks_target_position[mode] = actual_decks_positions[size][i]
    else
      decks_target_position[mode] = actual_decks_positions[size][i]
    end
    i = i + 1
  end
  return decks_target_position
end

function resizeDecks(decks)
  if game_settings.modes.kingdomino and not game_settings.modes.queendomino then
    if getPlayerCount() == 2 and not game_settings.variants.two_players_advanced then
      decks.kingdomino.shuffle()
      cutDeck(decks.kingdomino, deck_size_modifiers.two_players_basic)
    end
    if getPlayerCount() == 3 and not game_settings.variants.three_players_variant then
      decks.kingdomino.shuffle()
      cutDeck(decks.kingdomino, deck_size_modifiers.three_players_classic)
    end
  end
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

function movePlayerPieces(color, offset_vector)
  local castle = getObjectFromGUID(player_pieces_guids[color].castle)
  local castle_tile = getObjectFromGUID(player_pieces_guids[color].castle_tile)
  local hand_zone = getObjectFromGUID(player_pieces_guids[color].hand_zone)

  hand_zone.setPosition({
    hand_zone.getPosition().x + offset_vector[1],
    hand_zone.getPosition().y + offset_vector[2],
    hand_zone.getPosition().z + offset_vector[3],
  })
  castle.setPositionSmooth({
    castle_tile_positions[color].x + offset_vector[1],
    castle_y + offset_vector[2],
    castle_tile_positions[color].z + offset_vector[3]
  })
  castle_tile.setPositionSmooth({
    castle_tile_positions[color].x + offset_vector[1],
    castle_tile_y + offset_vector[2],
    castle_tile_positions[color].z + offset_vector[3]
  })
end

function spaceOutPlayers()
  movePlayerPieces("white", { 0, 0, -8 })
  movePlayerPieces("orange", { 0, 0, -8 })
  movePlayerPieces("purple", { 0, 0, 8 })
  movePlayerPieces("red", { 0, 0, 8 })
end

-- Utility functions
function isInValues(value_to_test, list)
  for _, value in pairs(list) do
    if value == value_to_test then
      return true
    end
  end
  return false
end

function isInKeys(key_to_test, list)
  for key, _ in pairs(list) do
    if key == key_to_test then
      return true
    end
  end
  return false
end

function printTable(table_to_print)
  for key, value in pairs(table_to_print) do
    print("[" .. tostring(key) .. " -> " .. tostring(value) .. "]")
  end
end
