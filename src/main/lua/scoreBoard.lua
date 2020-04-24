local button_config = {
  counter = {
    width = 1200, height = 1000,
    font = 750,
    scale = {0.15, 0.15, 0.15}
  },
  plus_minus = {
    width = 375, height = 400,
    font = 600,
    scale = {0.2, 0.2, 0.2}
  }
}
local board_thickness = 0.1
local plus_minus_spacing = 0.25

local total_counter_count = 0
local counters = {}
local counter_counts = {
  coins = 1,
  lands = 7,
  objectives = 5
}

local buttons_count = 0

local total_counter = {}

function onLoad()
  initButtons()
end

function initButtons()
  local vertical_spacing = 0.39
  local first_counter_z_pos = -2.3
  local left_counter_x_pos = -0.01
  local right_counter_x_pos = 0.79

  local v_index = 0
  -- Coins counter
  for i = v_index, counter_counts.coins - 1, 1 do
    setupCounter({x = left_counter_x_pos, y = board_thickness, z = first_counter_z_pos})
  end
  v_index = v_index + counter_counts.coins

  -- Land counters
  for i = v_index, v_index + counter_counts.lands - 1, 1 do
    local z_pos = first_counter_z_pos + i * vertical_spacing
    setupCounter({x = left_counter_x_pos, y = board_thickness, z = z_pos})
    setupCounter({x = right_counter_x_pos, y = board_thickness, z = z_pos})
  end
  v_index = v_index + counter_counts.lands

  -- Other objectives counters
  for i = v_index, v_index + counter_counts.objectives - 1, 1 do
    local z_pos = first_counter_z_pos + i * vertical_spacing
    setupCounter({x = left_counter_x_pos, y = board_thickness, z = z_pos})
  end
  v_index = v_index + counter_counts.objectives

  local z_pos = first_counter_z_pos + (counter_counts.coins + counter_counts.lands + counter_counts.objectives) * vertical_spacing - 0.03
  setupTotal({x = left_counter_x_pos, y = board_thickness, z = z_pos})
end

function setupCounter(position)
  local counter_index = total_counter_count
  local input_function_name = "onInput_" .. tostring(total_counter_count)

  local parameters = {
    index = counter_index,
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

  self.setVar(input_function_name,
    function (obj, player_clicker_color, input_value, selected)
      changeCounterValue(parameters, tonumber(input_value))
    end)
  self.createInput(parameters)
  table.insert(counters, parameters)
  total_counter_count = total_counter_count + 1

  createPlusButton(parameters, position)
  createMinusButton(parameters, position)
end

function createPlusButton(counter, position)
  local click_function_name = "plus_function_" .. tostring(counter)
  self.setVar(click_function_name,
    function (obj, player_clicker_color, alt_click)
      incrementCounter(counter, alt_click, 1)
    end)

  self.createButton({
    index = buttons_count,
    click_function = click_function_name,
    function_owner = self,
    label = "+",
    position = {position.x + plus_minus_spacing, position.y, position.z - 0.04},
    scale = button_config["plus_minus"].scale,
    width = button_config["plus_minus"].width,
    height = button_config["plus_minus"].height,
    font_size = button_config["plus_minus"].font,
  })
  buttons_count = buttons_count + 1
end

function createMinusButton(counter, position)
  local click_function_name = "minus_function_" .. tostring(counter)
  self.setVar(click_function_name,
    function (obj, player_clicker_color, alt_click)
      incrementCounter(counter, alt_click, -1)
    end)

  self.createButton({
    index = buttons_count,
    click_function = click_function_name,
    function_owner = self,
    label = "-",
    position = {position.x - plus_minus_spacing, position.y, position.z - 0.04},
    scale = button_config["plus_minus"].scale,
    width = button_config["plus_minus"].width,
    height = button_config["plus_minus"].height,
    font_size = button_config["plus_minus"].font,
  })
  buttons_count = buttons_count + 1
end

function doNothing() end

function setupTotal(position)
  local parameters = {
    index = buttons_count,
    click_function = "doNothing",
    function_owner = self,
    label = "0",
    position = position,
    scale = button_config["counter"].scale,
    width = button_config["counter"].width,
    height = button_config["counter"].height,
    font_size = button_config["counter"].font,
    color = {1, 1, 1, 0},
    font_color = {0, 0, 0, 100},
    alignment = 3  -- Center
  }
  buttons_count = buttons_count + 1
  self.createButton(parameters)
  total_counter = parameters
end

function changeCounterValue(counter, value)
  counter.value = value
  self.editInput(counter)
  updateTotal()
end

function incrementCounter(counter, alt_click, amount)
  if alt_click then
    amount = amount * 10
  end
  if not counter.value then
    counter.value = 0
  end
  counter.value = tonumber(counter.value) + amount
  if counter.value == 0 then
    counter.value = nil
  end
  self.editInput(counter)
  updateTotal()
end

function sumSimpleCounters(cursor, counter_count)
  local result = 0
  for i = cursor, cursor + counter_count - 1, 1 do
    if counters[i + 1].value ~= nil then
      result = result + counters[i + 1].value
    end
  end
  return result
end

function sumSquareCounters(cursor, counter_count)
  local result = 0
  for i = cursor, cursor + counter_count - 1, 2 do
    if counters[i + 1].value ~= nil and counters[i + 2].value ~= nil then
      result = result + (counters[i + 1].value * counters[i + 2].value)
    end
  end
  return result
end

function updateTotal()
  local total = sumSimpleCounters(0, counter_counts.coins)
  total = total + sumSquareCounters(counter_counts.coins, counter_counts.lands * 2)
  total = total + sumSimpleCounters(counter_counts.coins + counter_counts.lands * 2, counter_counts.objectives)

  total_counter.label = tostring(total)
  self.editButton(total_counter)
end
