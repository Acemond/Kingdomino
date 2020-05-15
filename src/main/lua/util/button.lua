Button = {}
Button.__index = Button

local shown_y_position = 1.05
local hidden_y_position = 0.5

function Button:new(guid, x, z, tts_properties)
  local button = {}
  setmetatable(button, Button)
  button.guid = guid
  button.target_position = { x, shown_y_position, z }
  button.createButton(tts_properties)
end

function Button:move()
  error("Not implemented!")
end

function Button:show()
  local button = getObjectFromGUID(self.guid)
  button.editButton({ index = 0, scale = { 1, 1, 1 } })
  button.setPosition({ self.target_position.x, 0.86, self.target_position.z })
  button.setPositionSmooth({ self.target_position.x, shown_y_position, self.target_position.z }, false, true)
end

function Button:hide()
  local button = getObjectFromGUID(self.guid)
  button.editButton({ index = 0, scale = { 0, 0, 0 } })
  button.setPositionSmooth({ button.getPosition().x, hidden_y_position, button.getPosition().z }, false, true)
end
