local deck_name = "kingdomino"

local deck_manager = {}
local deck_manager_guid = "180cbc"

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
  deck_manager = getObjectFromGUID(deck_manager_guid)
end

function onClick()
  deck_manager.call("setDeckEnabled", {deck_name = deck_name, is_enabled = true})
end
