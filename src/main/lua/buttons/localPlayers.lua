local start_button_guid = "af7bb2"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    tooltip = "Allow multiple players on the same machine",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600,
  })
end

function onClick()
  Global.setVar("local_players", false)
  getObjectFromGUID(start_button_guid).call("removeLocalPlayers")
  self.setState(1)
end
