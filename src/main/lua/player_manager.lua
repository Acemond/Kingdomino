local seated_players = {
  White = false,
  Orange = false,
  Purple = false,
  Red = false,
  Green = false,
  Pink = false
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

local local_players_enabled = false

local castle_manager_guid = ""
local castle_manager = {}

function onLoad(save_state)
  seated_players = JSON.decode(save_state).seated_players
  Player.getPlayers()[1].lookAt({
    position = { x = 0, y = 0, z = -28 },
    pitch = 55,
    yaw = 0,
    distance = 30,
  })
  castle_manager = getObjectFromGUID(castle_manager_guid)
end

function onSave()
  return JSON.encode({seated_players = seated_players})
end

function setLocalPlayersEnabled(is_enabled)
  local_players_enabled = is_enabled
  if not local_players_enabled then
    removeAllLocalPlayers()
  end
end

function addPlayer(parameters)
  seated_players[parameters.seat_color] = true
  castle_manager.call("showCastle", parameters.seat_color)
  tile_board_manager.call("updateTileBoards", getBoardSize())
  if not local_players_enabled then
    Player[parameters.player_color].changeColor(parameters.seat_color)
  end
end

function removePlayer(seat_color)
  player_manager.call("kickPlayer", seat_color)
  game_settings.player_count = player_manager.call("getPlayerCount")
  tile_board_manager.call("updateTileBoards", getBoardSize())
end

function kickPlayer(seat_color)
  seated_players[seat_color] = false
  castle_manager.call("hideCastle", seat_color)
  removePlayerColor(Player[seat_color])
end

function removePlayerColor(player_color)
  local target_color = game_master_color
  if Player[game_master_color].seated then
    target_color = spectator_color
  end
  Player[player_color].changeColor(game_master_color)
end

function setPlayerCount(target_player_count)
  while getPlayerCount() < target_player_count do
    for color, enabled in pairs(seated_players) do
      if not enabled then
        local player = getPlayerNotSeated()
        if player ~= nil then
          addPlayer({player_color = player.color, seat_color = color})
        else
          setLocalPlayersEnabled(true)
          addPlayer({seat_color = color})
        end
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
      removePlayer(color)
    end
  end
end

function onPlayerChangeColor(player_color)
  if castle_positions[player_color] and not Global.getVar("local_players") then
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
