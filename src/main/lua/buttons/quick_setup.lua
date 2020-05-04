local player_count = 2

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
  self.setPositionSmooth({
    self.getPosition().x,
    0.9,
    self.getPosition().z,
  }, false, true)
  Wait.frames(function ()
    self.setPositionSmooth({
      self.getPosition().x,
      1.05,
      self.getPosition().z,
    }, false, true)
  end, 20)
  Global.call("quickSetup", player_count)
end
