function onLoad()
  Player["White"].lookAt({
    position = { x = 0, y = 0, z = -28 },
    pitch = 55,
    yaw = 0,
    distance = 30,
  })

  broadcastToAll("Welcome to Kingdomino!", { r = 1, g = 1, b = 1 })
  Wait.frames(function()
    broadcastToAll("Please add players and press Start Game", { r = 1, g = 1, b = 1 })
  end, 1)
end
