local variant_name = "random_quests"
local quests_deck_guid = "fd8a62"
local default_quests_guid = { "e29f53", "e865f4" }

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
end

function onClick()
  Global.call("setVariantEnabled", { variant_name = variant_name, is_enabled = false })
  organizeQuests()
  self.setState(1)
end

function organizeQuests()
  local quests = getObjectFromGUID(quests_deck_guid)
  quests.takeObject({
    guid = default_quests_guid[2],
    position = { quests.getPosition().x, quests.getPosition().y + 0.15, quests.getPosition().z },
    smooth = false
  })
end