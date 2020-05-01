local variant_name = "random_quests"
local quests_deck_guid = "fd8a62"

local variant_manager_guid = "2c055b"
local variant_manager = {}

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
  variant_manager = getObjectFromGUID(variant_manager_guid)
end

function onClick()
  variant_manager.call("setVariantEnabled", { variant_name = variant_name, is_enabled = true })
  local quests = getObjectFromGUID(quests_deck_guid)
  quests.shuffle()
  self.setState(2)
end
