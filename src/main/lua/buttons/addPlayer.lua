local color = "Green"
local start_button_guid = "af7bb2"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600,
  })

  if isSeatTaken() then
    addPlayer()
  end
end

function onPlayerChangeColor()
  if isSeatTaken() then
    addPlayer()
  end
end

function onPlayerConnect()
  if isSeatTaken() then
    addPlayer()
  end
end

function onClick(_, player_color)
  addPlayer(player_color)
  Player[player_color].changeColor(color)
end

function addPlayer()
  getObjectFromGUID(start_button_guid).call("removePlayer", color:lower())
  getObjectFromGUID(start_button_guid).call("addPlayer", color:lower())
  self.setState(2)
end

function isSeatTaken()
  for _, player in pairs(Player.getPlayers()) do
    if player.color == color then
      return true
    end
  end
end
