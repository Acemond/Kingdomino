local variant_name = "two_players_advanced"
local start_button_guid = "af7bb2"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    tooltip = "7x7 kingdoms for 2 players!",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 2400,
    height = 600
  })
  self.interactable = false
end

function onClick()
  getObjectFromGUID(start_button_guid).call("setVariant", {variant_name = variant_name, value = true})
  self.setState(2)
end
