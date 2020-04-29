local variant_name = "random_quests"
local quests_deck_guid = ""

local game_manager_guid = ""
local game_manager = {}

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

  game_manager = getObjectFromGUID(game_manager_guid)
end

function onClick()
  game_manager.call("setVariant", {variant_name = variant_name, enable = true})
  local quests = getObjectFromGUID(quests_deck_guid)
  quests.shuffle()
  self.setState(2)
end
