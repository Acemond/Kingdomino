local color = "Green"

local player_manager_guid = "31971b"

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
end

function onClick(_, player_color)
  getObjectFromGUID(player_manager_guid).call("addPlayer", { player_color = player_color, seat_color = color })
end
