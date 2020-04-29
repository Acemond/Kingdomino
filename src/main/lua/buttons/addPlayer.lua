local color = "Green"
local start_button_guid = "af7bb2"
local local_players_enabled = "local_players"

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
  if Player[color].seated
      and not Global.getVar(local_players_enabled) then
    addPlayer()
  end
end

function onPlayerChangeColor(player_color)
  if player_color == color
      and not Global.getVar(local_players_enabled) then
    addPlayer()
  end
end

function onPlayerConnect(person)
  if person.color == color
      and not Global.getVar(local_players_enabled) then
    addPlayer()
  end
end

function onClick(_, player_color)
  addPlayer()
  if not Global.getVar(local_players_enabled) then
    Player[player_color].changeColor(color)
  end
end

function addPlayer()
  getObjectFromGUID(start_button_guid).call("addPlayer", color:lower())
  if self.getStateId() == 1 then
    self.setState(2)
  end
end
