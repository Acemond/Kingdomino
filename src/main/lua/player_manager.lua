local seated_players = {
  White = false,
  Orange = false,
  Purple = false,
  Red = false,
  Green = false,
  Pink = false
}
local local_players_button_guid = {
  enable = "4f044d",
  disable = "d1e47c"
}
local player_buttons_guids = {
  add = {
    White = "f60fe5",
    Orange = "8d17b0",
    Purple = "1b4b1a",
    Red = "a1ef12",
    Green = "fbeaba",
    Pink = "6987e6"
  },
  remove = {
    White = "74e8b0",
    Orange = "fa1b7c",
    Purple = "1bbcb3",
    Red = "dfeee5",
    Green = "8fedd0",
    Pink = "668a0a"
  }
}
local game_master_color = "Black"
local spectator_color = "Grey"

local castle_positions = {
  White = { position = { -21.00, 1.16, -11.00 }, yaw = 0 },
  Orange = { position = { 21.00, 1.16, -11.00 }, yaw = 0 },
  Purple = { position = { -21.00, 1.16, 11.00 }, yaw = 180 },
  Red = { position = { 21.00, 1.16, 11.00 }, yaw = 180 },
  Green = { position = { -31.00, 1.16, 1.00 }, yaw = 90 },
  Pink = { position = { 31.00, 1.16, -1.00 }, yaw = 270 }
}

local local_players_enabled = false  -- Set this with setLocalPlayersEnabled only

local tile_board_manager_guid = "3853c3"
local tile_board_manager = {}

function onLoad(save_state)
  if save_state ~= "" then
    loadSaveState(save_state)
  end
  Player.getPlayers()[1].lookAt({
    position = { x = 0, y = 0, z = -28 },
    pitch = 55,
    yaw = 0,
    distance = 30,
  })
  tile_board_manager = getObjectFromGUID(tile_board_manager_guid)
end

function loadSaveState(save_state)
  seated_players = JSON.decode(save_state).seated_players
  local_players_enabled = JSON.decode(save_state).local_players_enabled
end

function onSave()
  --return JSON.encode({
  --  seated_players = seated_players,
  --  local_players_enabled = local_players_enabled,
  --})
end

function onUpdate()
  updatePlayerButtons()
  updateLocalPlayerButton()
end

function initialize(save_state)
  if save_state ~= "" then
    seated_players = JSON.decode(save_state).seated_players
    local_players_enabled = JSON.decode(save_state).local_players_enabled
  end
end

function setLocalPlayersEnabled(is_enabled)
  local_players_enabled = is_enabled
  if not local_players_enabled then
    removeAllLocalPlayers()
  end
end

function sitPlayer(parameters)
  seated_players[parameters.seat_color] = true
  if not local_players_enabled then
    Player[parameters.player_color].changeColor(parameters.seat_color)
  end
end

function kickPlayer(seat_color)
  seated_players[seat_color] = false
  if not local_players_enabled then
    removePlayerColor(Player[seat_color])
  end
end

function removePlayerColor(player)
  local target_color = game_master_color
  if Player[game_master_color].seated then
    target_color = spectator_color
  end
  player.changeColor(game_master_color)
end

function setPlayerCount(target_player_count)
  while getPlayerCount() < target_player_count do
    addNextPlayer()
  end
end

function addNextPlayer()
  for color, enabled in pairs(seated_players) do
    if not enabled then
      local player = getPlayerNotSeated()
      if player ~= nil then
        Global.call("addPlayer", { player_color = player.color, seat_color = color })
        return
      else
        setLocalPlayersEnabled(true)
        Global.call("addPlayer", { seat_color = color })
        return
      end
    end
  end
end

function getPlayerNotSeated()
  for _, player in ipairs(Player.getPlayers()) do
    if not seated_players[player.color] then
      return player
    end
  end
end

function removeAllLocalPlayers()
  for color, enabled in pairs(seated_players) do
    if not Player[color].seated and enabled then
      Global.call("removePlayer", color)
    end
  end
end

function onPlayerChangeColor(player_color)
  makePlayerLookAtCastle(player_color)
  if not local_players_enabled and player_color ~= spectator_color and player_color ~= game_master_color then
    if seated_players[player_color] and not Player[player_color].seated then
      Global.call("removePlayer", player_color)
    elseif not seated_players[player_color] and Player[player_color].seated then
      Global.call("addPlayer", { player_color = player_color, seat_color = player_color })
    end
  end
end

function makePlayerLookAtCastle(player_color)
  if castle_positions[player_color] then
    Player[player_color].lookAt({
      position = castle_positions[player_color].position,
      pitch = 55,
      yaw = castle_positions[player_color].yaw,
      distance = 20,
    })
  end
end

function getSeatedPlayers()
  return seated_players
end

function getPlayerCount()
  local count = 0
  for _, seated in pairs(seated_players) do
    if seated then
      count = count + 1
    end
  end
  return count
end

function onPlayerConnect(person)
  if not local_players_enabled and not seated_players[person.color] then
    addPlayer({ player_color = person.color, seat_color = person.color })
  end
end

function onPlayerDisconnect(person)
  if not local_players_enabled and seated_players[person.color] then
    removePlayer(person.color)
  end
end

function updatePlayerButtons()
  for color, seated in pairs(seated_players) do
    local add_button = getObjectFromGUID(player_buttons_guids.add[color])
    local remove_button = getObjectFromGUID(player_buttons_guids.remove[color])

    if seated and add_button ~= nil and add_button.getStateId() == 1 then
      add_button.setState(2)
    elseif not seated and remove_button ~= nil and remove_button.getStateId() == 2 then
      remove_button.setState(1)
    end
  end
end

function updateLocalPlayerButton()
  if local_players_enabled then
    local enable_button = getObjectFromGUID(local_players_button_guid.enable)
    if enable_button and enable_button.getStateId() == 1 then
      enable_button.setState(2)
    end
  else
    local disable_button = getObjectFromGUID(local_players_button_guid.disable)
    if disable_button and disable_button.getStateId() == 2 then
      disable_button.setState(1)
    end
  end
end
