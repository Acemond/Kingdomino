local color = "White"
local is_ready = false

local next_turn_button_guid = "4a6126"
local next_turn_button = {}

local ready_text_color = { r = 0, g = 0.75, b = 0 }
local unready_text_color = { r = 0.8, g = 0.8, b = 0.8 }

function onLoad()
  if Global.get("game") then
    reset()
  end
  next_turn_button = getObjectFromGUID(next_turn_button_guid)
end

function reset()
  if not self.getButtons() or #self.getButtons() < 1 then
    self.createButton({
      click_function = "toggleReady",
      function_owner = self,
      label = "",
      position = { 0, 0, 0 },
      color = { 0, 0, 0, 0 },
      width = 1300,
      height = 1300
    })
  end
  is_ready = false
end

function removeButton()
  if self.getButtons() and #self.getButtons() > 0 then
    self.removeButton(0)
  end
end

function toggleReady()
  if not is_ready then
    is_ready = true
    broadcastToAll(color .. " player is ready for the next turn", ready_text_color)
  else
    is_ready = false
    broadcastToAll(color .. " player is reconsidering...", unready_text_color)
  end
  next_turn_button.call("setPlayerReady", {player_color = color, is_ready = is_ready})
end

