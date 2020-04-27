local color = "red"
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
end

function onClick()
  getObjectFromGUID(start_button_guid).call("addPlayer", color)
  self.setState(2)
end
