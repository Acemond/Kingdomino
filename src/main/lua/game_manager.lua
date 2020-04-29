local game_settings = {}
local default_game_settings = {
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

local extension_manager_guid = ""
local extension_manager = {}
local deck_manager_guid = ""
local deck_manager = {}
local variant_manager_guid = ""
local variant_manager = {}
local tile_board_manager_guid = ""
local tile_board_manager = {}
local player_manager_guid = ""
local player_manager = {}
local game_launcher_guid = ""
local game_launcher = {}

function onLoad(save_state)
  initialize(save_state)
  player_manager = getObjectFromGUID(player_manager_guid)
  extension_manager = getObjectFromGUID(extension_manager_guid)
  deck_manager = getObjectFromGUID(deck_manager_guid)
  variant_manager = getObjectFromGUID(variant_manager_guid)
  tile_board_manager = getObjectFromGUID(tile_board_manager_guid)
  game_launcher = getObjectFromGUID(game_launcher_guid)
end

function initialize(save_state)
  if save_state ~= "" then
    game_settings = {
      decks = JSON.decode(save_state).decks,
      variants = JSON.decode(save_state).variants
    }
  else
    game_settings = default_game_settings
  end
end

function onSave()
  return JSON.encode({ decks = game_settings.decks, variants = game_settings.variants })
end

function quickSetup(target_player_count)
  player_manager.call("setPlayerCount", target_player_count)
  game_settings = resolveForPlayerCount(target_player_count)
end

function startGame()
  local configuration = {
    game_settings = resolveForPlayerCount(target_player_count),
    seated_players = player_manager.call("getSeatedPlayers")
  }
  --game_configuration_validator.call("validateConfiguration", configuration)
  game_launcher.call("launchGame", configuration)
end

function setDeckEnabled(deck_name, is_enabled)
  game_settings.decks[deck_name] = is_enabled
  deck_manager.call("checkInteractions", game_settings.decks)
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function setVariantEnabled(variant_name, is_enabled)
  game_settings.variants[variant_name] = is_enabled
  variant_manager.call("checkInteractions", game_settings)
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function isGameReady()
  local player_count = player_manager.call("getPlayerCount")
  if player_count < 2 then
    return false, "There should be at least two players to start a game"
  elseif game_settings.variants.kingdomino_xl
      and (player_count == 2 or player_count > 4) then
    return false, "Kingdomino XL is for 3 to 4 players only"
  elseif not game_settings.decks.kingdomino and not game_settings.decks.queendomino then
    return false, "You should pick at least a deck to play"
  elseif player_count == 5 and not (
      game_settings.decks.age_of_giants
          or (game_settings.decks.queendomino and game_settings.decks.kingdomino)) then
    return false, "You need to enable Age of Giants or both Kingdomino and Queendomino to play with 5 players"
  elseif player_count == 5 and game_settings.decks.age_of_giants
      and game_settings.decks.queendomino
      and game_settings.decks.kingdomino then
    return false, "Royal Wedding not yet implemented for Age of Giants with 5 players"
  elseif player_count > 5
      and not (game_settings.variants.teamdomino
      or (game_settings.decks.queendomino and game_settings.decks.kingdomino)) then
    return false, "You need to enable both Kingdomino and Queendomino to play with "
        .. tostring(player_count) .. " players"
  elseif player_count > 5 and game_settings.decks.age_of_giants then
    return false, "Age of Giants is for 5 players or less"
  end
  return true
end

function getBoardSize()
  local player_count = player_manager.call("getPlayerCount")
  local size = 4
  if player_count == 3
      and not game_settings.decks.queendomino
      and not game_settings.variants.three_players_variant then
    size = 3
  elseif game_settings.decks.queendomino and game_settings.decks.kingdomino
      and (player_count == 5 or player_count == 6) then
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
  if target_player_count < 5 then
    return {
      decks = {
        kingdomino = true,
        queendomino = false,
        age_of_giants = false,
        the_court = false
      },
      variants = default_game_settings.variants
    }
  elseif target_player_count == 5 then
    return {
      decks = {
        kingdomino = true,
        queendomino = false,
        age_of_giants = true,
        the_court = false
      },
      variants = default_game_settings.variants
    }
  elseif target_player_count == 6 then
    return {
      decks = {
        kingdomino = true,
        queendomino = true,
        age_of_giants = false,
        the_court = false
      },
      variants = default_game_settings.variants
    }
  end
end
