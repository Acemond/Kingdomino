local color = "Red"
local game_master_color = "Black"
local start_button_guid = "af7bb2"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600
  })
  if not isSeatTaken() then
    removePlayer(color)
  end
end

function onPlayerChangeColor()
  if not isSeatTaken() then
    removePlayer(color)
  end
end

function onPlayerDisconnect()
  if isSeatTaken() then
    addPlayer()
  end
end

function onClick()
  removePlayer()
  Player[color].changeColor(game_master_color)
end

function removePlayer()
  getObjectFromGUID(start_button_guid).call("removePlayer", color:lower())
  self.setState(1)
end

function isSeatTaken()
  for _, player in pairs(Player.getPlayers()) do
    if player.color == color then
      return true
    end
  end
end
