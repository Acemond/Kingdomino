function onLoad()
  displayWelcomeMessage()
end

function displayWelcomeMessage()
  broadcastToAll("Welcome to Kingdomino!", { r = 1, g = 1, b = 1 })
  Wait.frames(function()
    broadcastToAll("Please add players and press Start Game", { r = 1, g = 1, b = 1 })
  end, 60)
end
