local color = "Red"
local game_master_color = "Black"
local spectator_color = "Grey"
local start_button_guid = "af7bb2"
local local_players_var = "local_players"

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
  if not Player[color].seated and not Global.getVar(local_players_var) then
    removePlayer()
  end
end

function onPlayerChangeColor()
  if not Player[color].seated and not Global.getVar(local_players_var) then
    removePlayer()
  end
end

function onPlayerDisconnect()
  if not Player[color].seated and not Global.getVar(local_players_var) then
    addPlayer()
  end
end

function onClick()
  removePlayer()
  if not Global.getVar(local_players_var) then
    if not Player[game_master_color].seated then
      Player[color].changeColor(game_master_color)
    else
      Player[color].changeColor(spectator_color)
    end
  end
end

function removePlayer()
  getObjectFromGUID(start_button_guid).call("removePlayer", color:lower())
  if self.getStateId() == 2 then
    self.setState(1)
  end
end
