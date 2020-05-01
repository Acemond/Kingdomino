local player_manager_guid = "31971b"
local player_manager = {}
local game_launcher_guid = "bb8090"
local game_launcher = {}
local configuration_validator_guid = "2a0d3f"
local configuration_validator = {}

function onLoad(save_state)
  if save_state == "" then
    displayWelcomeMessage()
  end
  player_manager = getObjectFromGUID(player_manager_guid)
  game_launcher = getObjectFromGUID(game_launcher_guid)
  configuration_validator = getObjectFromGUID(configuration_validator_guid)
end

function displayWelcomeMessage()
  broadcastToAll("Welcome to Kingdomino!", { r = 1, g = 1, b = 1 })
  Wait.frames(function()
    broadcastToAll("Please add players and press Start Game", { r = 1, g = 1, b = 1 })
  end, 60)
end

function quickSetup(target_player_count)
  player_manager.call("setPlayerCount", target_player_count)
  startWithSettings(resolveForPlayerCount(target_player_count))
end

function startGame()
  startWithSettings(getGameSettings())
end

function startWithSettings(game_settings)
  if configuration_validator.call("validate", game_settings) then
    game_launcher.call("launchGame", game_settings)
  end
end

function getGameSettings()
  return {
    decks = Global.getTable("deck_enabled"),
    variants = Global.getTable("variant_enabled"),
    player_count = Global.getVar("player_count"),
    seated_players = Global.getTable("seated_players"),
    tile_deal_count = Global.getVar("board_size")
  }
end

function resolveForPlayerCount(target_player_count)
  local game_settings = getGameSettings()
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
  Global.setTable("deck_enabled", game_settings.decks)
  Global.setTable("variant_enabled", game_settings.variants)
  return game_settings
end
