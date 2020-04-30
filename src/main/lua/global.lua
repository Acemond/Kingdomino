local game_settings = {
  player_count = 0,
  seated_players = {
    White = false,
    Orange = false,
    Purple = false,
    Red = false,
    Green = false,
    Pink = false
  },
  decks = {
    kingdomino = true,
    queendomino = false,
    age_of_giants = false,
    the_court = false
  },
  variants = {
    two_players_advanced = false, -- TODO: rename in the_mighty duel
    three_players_variant = true,
    random_quests = false,
    kingdomino_xl = false,
    teamdomino = false
  }
}

local deck_manager_guid = "180cbc"
local deck_manager = {}
local variant_manager_guid = "2c055b"
local variant_manager = {}
local tile_board_manager_guid = "3853c3"
local tile_board_manager = {}
local player_manager_guid = "31971b"
local player_manager = {}
local game_launcher_guid = "bb8090"
local game_launcher = {}
local configuration_validator_guid = "2a0d3f"
local configuration_validator = {}
local castle_manager_guid = "9bb39a"
local castle_manager = {}

function onLoad(save_state)
  --loadSaveState(save_state)
  player_manager = getObjectFromGUID(player_manager_guid)
  deck_manager = getObjectFromGUID(deck_manager_guid)
  variant_manager = getObjectFromGUID(variant_manager_guid)
  tile_board_manager = getObjectFromGUID(tile_board_manager_guid)
  game_launcher = getObjectFromGUID(game_launcher_guid)
  configuration_validator = getObjectFromGUID(configuration_validator_guid)
  castle_manager = getObjectFromGUID(castle_manager_guid)
  displayWelcomeMessage()
end

function displayWelcomeMessage()
  broadcastToAll("Welcome to Kingdomino!", { r = 1, g = 1, b = 1 })
  Wait.frames(function()
    broadcastToAll("Please add players and press Start Game", { r = 1, g = 1, b = 1 })
  end, 60)
end

function loadSaveState(save_state)
  if save_state ~= "" then
    game_settings = {
      player_count = JSON.decode(save_state).player_count,
      decks = JSON.decode(save_state).decks,
      variants = JSON.decode(save_state).variants
    }
  end
end

function onSave()
  --return JSON.encode({
  --  player_count = game_settings.player_count,
  --  decks = game_settings.decks,
  --  variants = game_settings.variants
  --})
end

function quickSetup(target_player_count)
  player_manager.call("setPlayerCount", target_player_count)
  game_settings.seated_players = player_manager.getTable("seated_players")
  resolveForPlayerCount(target_player_count)
end

function startGame()
  if configuration_validator.call("validate", game_settings) then
    game_launcher.call("launchGame", game_settings)
  end
end

function addPlayer(parameters)
  player_manager.call("sitPlayer", { player_color = parameters.player_color, seat_color = parameters.seat_color })
  game_settings.player_count = player_manager.call("getPlayerCount")
  game_settings.seated_players = player_manager.getTable("seated_players")
  castle_manager.call("showCastle", parameters.seat_color)
  log(getBoardSize())
  log(tile_board_manager)
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function removePlayer(seat_color)
  player_manager.call("kickPlayer", seat_color)
  game_settings.player_count = player_manager.call("getPlayerCount")
  game_settings.seated_players = player_manager.getTable("seated_players")
  castle_manager.call("hideCastle", seat_color)
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function setDeckEnabled(parameters)
  deck_manager.call("setDeckEnabled", { deck_name = parameters.deck_name, is_enabled = parameters.is_enabled })
  game_settings.decks = deck_manager.getTable("deck_enabled")
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function setVariantEnabled(parameters)
  variant_manager.call("setVariantEnabled", { variant_name = parameters.variant_name, is_enabled = parameters.is_enabled })
  game_settings.variants = variant_manager.getTable("variant_enabled")
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function getBoardSize()
  local size = 4
  if game_settings.player_count == 3
      and not game_settings.decks.queendomino
      and not game_settings.variants.three_players_variant then
    size = 3
  elseif game_settings.decks.queendomino and game_settings.decks.kingdomino
      and (game_settings.player_count == 5 or game_settings.player_count == 6) then
    size = 8
  end

  if game_settings.decks.age_of_giants then
    size = size + 1
  end

  -- FIXME: Quickfix until other board sizes gets added
  if size ~= 3 and size ~= 4 and size ~= 5 and size ~= 8 then
    return 4
  end

  return size
end

function resolveForPlayerCount(target_player_count)
  if target_player_count == 5 then
    game_settings.variants.kingdomino_xl = false
    game_settings.variants.teamdomino = false
    game_settings.variants.two_players_advanced = false
  elseif target_player_count == 6 then
    game_settings.decks.kingdomino = true
    game_settings.decks.queendomino = true
    game_settings.decks.age_of_giants = false
    game_settings.variants.kingdomino_xl = false
    game_settings.variants.two_players_advanced = false
  end
end
