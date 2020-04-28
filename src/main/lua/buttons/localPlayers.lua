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
  Global.setVar("local_players", true)
  self.setState(2)
end
