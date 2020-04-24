local button_config = {
  counter = {
    width = 1200, height = 1000,
    font = 750,
    scale = {0.1, 0.1, 0.1}
  },
  plus_minus = {
    width = 375, height = 400,
    font = 600,
    scale = {0.1, 0.1, 0.1}
  }
}
local board_thickness = 0.1
local plus_minus_spacing = 0.18

local counters = {}

function onLoad()
  initButtons()
end

function initButtons()
  setupCounter("testCounter", {x = -0.87, y = board_thickness, z = -1.12})
end

function setupCounter(name, position)
  local input_function_name = "onInput" .. name
  self.setVar(input_function_name, function (obj, player_clicker_color, input_value, selected) changeCounterValue(name, tonumber(input_value)) end)

  local parameters = {
    index = #counters,
    input_function = input_function_name,
    function_owner = self,
    label = "0",
    position = position,
    scale = button_config["counter"].scale,
    width = button_config["counter"].width,
    height = button_config["counter"].height,
    font_size = button_config["counter"].font,
    color = {1, 1, 1, 0},
    font_color = {0, 0, 0, 100},
    alignment = 3,  -- Center
    validation = 2,  -- 1: None, 2: Integer
    tab = 2  -- Select next input
  }
  self.createInput(parameters)
  counters[name] = parameters

  createPlusButton(name, position)
  createMinusButton(name, position)
end

function createPlusButton(parentName, position)
  local click_function_name = "plus_function_" .. parentName
  print(click_function_name)
  self.setVar(click_function_name, function (obj, player_clicker_color, alt_click) incrementCounter(parentName, alt_click, 1) end)

  self.createButton({
    click_function = click_function_name,
    function_owner = self,
    label = "+",
    position = {position.x + plus_minus_spacing, position.y, position.z - 0.04},
    scale = button_config["plus_minus"].scale,
    width = button_config["plus_minus"].width,
    height = button_config["plus_minus"].height,
    font_size = button_config["plus_minus"].font,
  })
end

function createMinusButton(parentName, position)
  local click_function_name = "minus_function_" .. parentName
  self.setVar(click_function_name, function (obj, player_clicker_color, alt_click) incrementCounter(parentName, alt_click, -1) end)

  self.createButton({
    click_function = click_function_name,
    function_owner = self,
    label = "-",
    position = {position.x - plus_minus_spacing, position.y, position.z - 0.04},
    scale = button_config["plus_minus"].scale,
    width = button_config["plus_minus"].width,
    height = button_config["plus_minus"].height,
    font_size = button_config["plus_minus"].font,
  })
end

function changeCounterValue(counter_name, value)
  counters[counter_name].value = value
end

function incrementCounter(counter_name, alt_click, amount)
  if alt_click then
    amount = amount * 10
  end
  if not counters[counter_name].value then
    counters[counter_name].value = 0
  end
  counters[counter_name].value = tonumber(counters[counter_name].value) + amount
  if counters[counter_name].value == 0 then
    counters[counter_name].value = nil
  end
  self.editInput(counters[counter_name])
end

function updateTotal()

end
