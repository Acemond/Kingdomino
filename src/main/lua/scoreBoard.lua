local button_config = {
  counter = {
    width = 0, height = 0,
    font = 800,
    scale = {0.1,0.1,0.1}
  },
  plus_minus = {
    width = 300, height = 300,
    font = 560,
    scale = {0.1,0.1,0.1}
  }
}
local plus_minus_spacing = 0.08

local counters = {}

function onLoad()
  initButtons()
end

function initButtons()
  setupCounter("testCounter", {10, 0.1, 10})
end

function setupCounter(name, position)
  local input_function_name = "onInput" .. name
  Global.setVar(input_function_name,
    function(obj, player_clicker_color, input_value, selected) changeCounterValue(name, tonumber(input_value)) end)

  local parameters = {
    index = #counters
    input_function = input_function_name,
    function_owner = self,
    label = "0",
    position = position,
    scale = button_config["counter"].scale,
    width = button_config["counter"].width,
    height = button_config["counter"].height,
    font_size = button_config["counter"].font,
    color = {1, 1, 1},
    validation = 2,  -- Integer
    tab = 2  -- Select next input
  }
  self.createInput(parameters)
  counters[name] = parameters

  createPlusButton(name, position)
  createMinusButton(name, position)
end

function createPlusButton(parentName, position)
  local click_function_name = "onClickPlus" .. parentName
  Global.setVar(click_function_name,
    function(obj, player_clicker_color, alt_click) incrementCounter(parentName, alt_click, 1) end)

  self.createButton({
    click_function = click_function_name,
    function_owner = self,
    label = "+",
    position = {position.x + plus_minus_spacing, position.y, position.z}
    scale = button_config["plusMinus"].scale,
    width = button_config["plusMinus"].width,
    height = button_config["plusMinus"].height,
    font_size = button_config["plusMinus"].font,
    click_function = "onClickPlus"
  })
end

function createMinusButtons(parentIndex, position)
  local click_function_name = "onClickMinus" .. parentName
  Global.setVar(click_function_name,
    function(obj, player_clicker_color, alt_click) changeCounter(parentName, alt_click, -1) end)

  self.createButton({
    click_function = click_function_name,
    function_owner = self,
    label = "-",
    position = {position.x - plus_minus_spacing, position.y, position.z}
    scale = button_config["plusMinus"].scale,
    width = button_config["plusMinus"].width,
    height = button_config["plusMinus"].height,
    font_size = button_config["plusMinus"].font,
    click_function = "onClickPlus"
  })
end

function changeCounterValue(counterName, input_value)
  local amount = tonumber(input_value)
  counters[counterName].label = tostring(tonumber(counters[counterName].label) + amount)
  editInput(counters[counterName])
end

function incrementCounter(counterName, alt_click, amount)
  if alt_click then amount = amount * 10 end
  counters[counterName].label = tostring(tonumber(counters[counterName].label) + amount)
  editInput(counters[counterName])
end
