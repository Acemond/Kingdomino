local playerCount = 2
local game_manager_guid = "af7bb2"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label = "",
    position = { 0, 0.05, 0 },
    color = { 0, 0, 0, 0 },
    width = 800,
    height = 600
  })
end

function onClick()
  getObjectFromGUID(game_manager_guid).call("quickSetup", playerCount)
  getObjectFromGUID(game_manager_guid).call("startGame")
end
