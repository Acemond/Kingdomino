local color = "Red"
local non_playing_color = "Grey"
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
    removePlayer()
  end
end

function onPlayerChangeColor()
  if not isSeatTaken() then
    removePlayer()
  end
end

function onPlayerDisconnect()
  if not isSeatTaken() then
    addPlayer()
  end
end

function onClick()
  removePlayer()
  Player[color].changeColor(non_playing_color)
end

function removePlayer()
  getObjectFromGUID(start_button_guid).call("removePlayer", color:lower())
  if self.getStateId() == 2 then
    self.setState(1)
  end
end

function isSeatTaken()
  for _, player in pairs(Player.getPlayers()) do
    if player.color == color then
      return true
    end
  end
end
