local color = "White"
local flag = {}

local ready_tooltip = "Ready"
local cancel_tooltip = "Cancel"

local flag_guids = {
  White = "e0aed1",
  Orange = "6cfdbd",
  Pink = "43d6e5",
  Red = "d99107",
  Purple = "137a90",
  Green = "37748e",
}

local is_ready = false

local flag_shown_y = 3.5
local flag_hidden_y = 0.5

local next_turn_button_guid = "4a6126"
local next_turn_button = {}

local ready_text_color = { r = 0, g = 0.75, b = 0 }
local unready_text_color = { r = 0.8, g = 0.8, b = 0.8 }

function onLoad()
  if Global.get("game") then
    reset()
  end
  flag = getObjectFromGUID(flag_guids[color])
  next_turn_button = getObjectFromGUID(next_turn_button_guid)
  hideFlag(true)
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
      tooltip = ready_tooltip,
      height = 1300
    })
  end
  hideFlag()
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
    showFlag()
  else
    is_ready = false
    broadcastToAll(color .. " player is reconsidering...", unready_text_color)
    hideFlag()
  end
  next_turn_button.call("setPlayerReady", { player_color = color, is_ready = is_ready })
end

function showFlag()
  flag.setPositionSmooth({
    self.getPosition().x,
    flag_shown_y,
    self.getPosition().z,
  })
  Wait.frames(function()
    flag.setRotationSmooth({ 90, 180, 0 })
  end, 10)
  if self.getButtons() and #self.getButtons() > 0 then
    self.editButton({ index = 0, tooltip = cancel_tooltip })
  end
end

function hideFlag(hide_instantaniously)
  if hide_instantaniously then
    flag.setPosition({
      self.getPosition().x,
      flag_hidden_y,
      self.getPosition().z,
    })
    flag.setRotation({ 90, 0, 0 })
  else
    flag.setPositionSmooth({
      self.getPosition().x,
      flag_hidden_y,
      self.getPosition().z,
    })
    flag.setRotationSmooth({ 90, 0, 0 })
  end
  if self.getButtons() and #self.getButtons() > 0 then
    self.editButton({ index = 0, tooltip = ready_tooltip })
  end
end

function temporarilyDisable()
  if self.getButtons() and #self.getButtons() > 0 then
    self.editButton({ index = 0, scale = { 0, 0, 0 } })
    Wait.frames(function()
      self.editButton({ index = 0, scale = { 1, 1, 1 } })
    end, 120)
  end
end
