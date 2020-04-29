local castle_positions = {
  White = { position = { -21.00, 1.16, -11.00 }, yaw = 0 },
  Orange = { position = { 21.00, 1.16, -11.00 }, yaw = 0 },
  Purple = { position = { -21.00, 1.16, 11.00 }, yaw = 180 },
  Red = { position = { 21.00, 1.16, 11.00 }, yaw = 180 },
  Green = { position = { -31.00, 1.16, 1.00 }, yaw = 90 },
  Pink = { position = { 31.00, 1.16, -1.00 }, yaw = 270 }
}

function onLoad()
  Player.getPlayers()[1].lookAt({
    position = { x = 0, y = 0, z = -28 },
    pitch = 55,
    yaw = 0,
    distance = 30,
  })

  broadcastToAll("Welcome to Kingdomino!", { r = 1, g = 1, b = 1 })
  Wait.frames(function()
    broadcastToAll("Please add players and press Start Game", { r = 1, g = 1, b = 1 })
  end, 60)
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
