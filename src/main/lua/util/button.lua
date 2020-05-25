Button = {}
Button.__index = Button

local shown_y_position = 1.05
local low_y_position = 0.9
local hidden_y_position = 0.5

function Button:new(guid, x, z, tts_properties)
  local button = {}
  setmetatable(button, Button)
  button.guid = guid
  button.target_position = { x = x, y = shown_y_position, z = z }
  getObjectFromGUID(guid).createButton(tts_properties)
  getObjectFromGUID(guid).setPosition({ x, low_y_position, z })
  return button
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

function Button:getLabel()
  return getObjectFromGUID(self.guid).getButtons()[1].label
end

function Button:setLabel(label)
  getObjectFromGUID(self.guid).editButton({ index = 0, label = label })
end

function Button:setTooltip(tooltip)
  getObjectFromGUID(self.guid).editButton({ index = 0, tooltip = tooltip })
end

function Button:setPositionLow()
  local button = getObjectFromGUID(self.guid)
  button.setPositionSmooth({ button.getPosition().x, low_y_position, button.getPosition().z }, false, true)
end

function Button:hide()
  local button = getObjectFromGUID(self.guid)
  button.editButton({ index = 0, scale = { 0, 0, 0 } })
  button.setPositionSmooth({ button.getPosition().x, hidden_y_position, button.getPosition().z }, false, true)
end
