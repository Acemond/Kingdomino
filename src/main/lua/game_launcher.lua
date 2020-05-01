local player_pieces_guids = {
  Orange = {
    hand_zone = "96929a",
    castle_tile = "9ab771",
    castle = "768b9c",
    kings = { "4d2d92", "5e6289" }
  },
  Purple = {
    hand_zone = "6ea086",
    castle_tile = "7db35a",
    castle = "a1e204",
    kings = { "7dd59a", "e44a70" }
  },
  Red = {
    hand_zone = "31279b",
    castle_tile = "f6948c",
    castle = "ae130d",
    kings = { "24345c", "2837e9" }
  },
  White = {
    hand_zone = "f85ea1",
    castle_tile = "537260",
    castle = "fd4160",
    kings = { "86f4c2", "61259d" }
  },
  Green = {
    hand_zone = "352048",
    castle_tile = "8c9612",
    castle = "b5c1bc",
    kings = { "526c31", "f2cd83" }
  },
  Pink = {
    hand_zone = "49989f",
    castle_tile = "a5aad1",
    castle = "a407fb",
    kings = { "9dc643", "0dba70" }
  }
}

local start_button_guid = "af7bb2"

local kings_bag_guid = "1403b9"
local kings_bag = {}
local game_table_guid = "0f8757"
local game_table = {}
local castle_manager_guid = "9bb39a"
local castle_manager = {}

local quests_deck_guid = "fd8a62"
local game_objects_guid = {
  kingdomino = {
    deck = "b972db"
  },
  queendomino = {
    deck = "b12f86",
    buildings = "04de04",
    building_board = "a066dc",
    right_building_board = "a77d62",
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
local deck_size_modifiers = {
  two_players_basic = 0.5,
  three_players_classic = 0.75
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
  }
}

local next_turn_position = { 0.00, 1.05, -13.00 }
local next_turn_position_5p = { 0.00, 1.05, -21.00 }

local quests_positions = {
  { -3.00, 1.03, -21.00 },
  { 3.00, 1.03, -21.00 }
}
local quests_positions_5p = {
  { -3.00, 1.03, -29.00 },
  { 3.00, 1.03, -29.00 }
}

local default_quests_guid = { "e29f53", "e865f4" }

local game_settings = {}

local next_turn_button_guid = "4a6126"

function onLoad()
  game_table = getObjectFromGUID(game_table_guid)
  kings_bag = getObjectFromGUID(kings_bag_guid)
  castle_manager = getObjectFromGUID(castle_manager_guid)
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

function launchGame(new_game_settings)
  game_settings = new_game_settings
  kings_bag.call("placeKings", game_settings)

  if game_settings.variants.random_quests then
    dealRandomQuests()
  else
    dealDefaultQuests()
  end

  local decks = prepareMainDecks()
  local buildings = prepareBuildings()

  if game_settings.seated_players.Green or game_settings.seated_players.Pink
      or game_settings.variants.kingdomino_xl then
    spaceOutPlayers()
  end
  if game_settings.decks.queendomino then
    for color, seated in pairs(game_settings.seated_players) do
      if seated then
        takeCoins(color)
      end
    end
  end

  destroyUnusedPieces()
  game_table.call("prepareTableForGame")

  local next_turn_button = getObjectFromGUID(next_turn_button_guid)
  setNextTurnPosition(next_turn_button)

  local new_game = {
    decks = decks,
    buildings = buildings,
    settings = game_settings,
  }
  Global.setTable("game", new_game)
  next_turn_button.call("firstTurn", new_game)

  getObjectFromGUID(start_button_guid).destroy()
end

function setNextTurnPosition(button)
  local position = next_turn_position
  if game_settings.player_count > 4 then
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
  if game_settings.player_count > 4 then
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

function takeCoins(playerColor)
  local handPosition = getObjectFromGUID(player_pieces_guids[playerColor].hand_zone).getPosition()
  local coin1Bag = getObjectFromGUID(game_objects_guid.queendomino.coin1_bag)
  local coin3Bag = getObjectFromGUID(game_objects_guid.queendomino.coin3_bag)
  local knightBag = getObjectFromGUID(game_objects_guid.queendomino.knight_bag)
  if playerColor == "Green" or playerColor == "Pink" then
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
  for mode, enabled in pairs(game_settings.decks) do
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

function getBuildingsManagers()
  local building_managers = {}
  for mode, enabled in pairs(game_settings.decks) do
    if enabled and game_objects_guid[mode].building_board then
      building_managers[mode] = getObjectFromGUID(game_objects_guid[mode].building_board)
    end
  end
  return building_managers
end

function prepareBuildings()
  local building_managers = getBuildingsManagers()

  for _, manager in pairs(building_managers) do
    manager.call("placeDeck")
  end

  return building_managers
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
  for mode, enabled in pairs(game_settings.decks) do
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

function getMainDecksPosition(decks)
  local decks_target_position = {}
  local size = getSize(decks)
  local i = 1

  local actual_decks_positions = decks_positions.main_deck
  if game_settings.player_count > 4 then
    actual_decks_positions = decks_positions.main_deck_5p
  end

  for mode, _ in pairs(decks) do
    if game_settings.player_count < 5 then
      decks_target_position[mode] = actual_decks_positions[size][i]
    else
      decks_target_position[mode] = actual_decks_positions[size][i]
    end
    i = i + 1
  end
  return decks_target_position
end

function resizeDecks(decks)
  if game_settings.decks.kingdomino and not game_settings.decks.queendomino then
    if game_settings.player_count == 2 and not game_settings.variants.two_players_advanced then
      decks.kingdomino.shuffle()
      cutDeck(decks.kingdomino, deck_size_modifiers.two_players_basic)
    end
    if game_settings.player_count == 3 and not game_settings.variants.three_players_variant then
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

local castle_tile_positions = {
  White = { x = -21.00, z = -11.00 },
  Orange = { x = 21.00, z = -11.00 },
  Purple = { x = -21.00, z = 11.00 },
  Red = { x = 21.00, z = 11.00 },
  Green = { x = -31.00, z = 1.00 },
  Pink = { x = 31.00, z = -1.00 },
}

function movePlayerPieces(color, offset_vector)
  local castle_tile = getObjectFromGUID(player_pieces_guids[color].castle_tile)
  local hand_zone = getObjectFromGUID(player_pieces_guids[color].hand_zone)

  hand_zone.setPosition({
    hand_zone.getPosition().x + offset_vector[1],
    hand_zone.getPosition().y + offset_vector[2],
    hand_zone.getPosition().z + offset_vector[3],
  })
  castle_manager.call("moveCastle", {
    seat_color = color,
    position = {
      castle_tile_positions[color].x + offset_vector[1],
      castle_y + offset_vector[2],
      castle_tile_positions[color].z + offset_vector[3]
    }
  })
  castle_tile.setPositionSmooth({
    castle_tile_positions[color].x + offset_vector[1],
    castle_tile_y + offset_vector[2],
    castle_tile_positions[color].z + offset_vector[3]
  })
end

function spaceOutPlayers()
  if game_settings.seated_players.White then
    movePlayerPieces("White", { 0, 0, -8 })
  end
  if game_settings.seated_players.Orange then
    movePlayerPieces("Orange", { 0, 0, -8 })
  end
  if game_settings.seated_players.Purple then
    movePlayerPieces("Purple", { 0, 0, 8 })
  end
  if game_settings.seated_players.Red then
    movePlayerPieces("Red", { 0, 0, 8 })
  end
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
