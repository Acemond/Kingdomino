local button_config = {
  counter = {
    width = 600, height = 550,
    font = 450,
    scale = {0.15, 0.15, 0.15}
  },
  plus_minus = {
    width = 300, height = 300,
    font = 400,
    scale = {0.17, 0.17, 0.17}
  }
}
local plus_minus_spacing = 0.16

local total_counter_count = 0
local counters = {}

local vertical_spacing = 0.245
ui_x_first_pos = -1.03
ui_x_spacing = 0.51
function getUiXPos(sheet_col, subcolumn)
  return ui_x_first_pos + ui_x_spacing * (2 * sheet_col + subcolumn - 3)
end

local ui_y_position = 0.1
local ui_z_first_pos = -1.56

local buttons_count = 0

local total_counter = {}

local counters_configuration = {
  {amount = 7, sheet_col = 1, columns = 2, first_row = 1, default_values = {0, 0}},
  {amount = 1, sheet_col = 1, columns = 1, first_row = 8, default_values = {0}},
  {amount = 2, sheet_col = 1, columns = 2, first_row = 9, default_values = {0, 1}},
  {amount = 4, sheet_col = 1, columns = 1, first_row = 11, default_values = {0}},

  {amount = 7, sheet_col = 2, columns = 2, first_row = 1, default_values = {0, 0}},
  {amount = 7, sheet_col = 3, columns = 2, first_row = 1, default_values = {0, 0}}
}
local total_position = {
  sheet_col = 1,
  row = 15
}

function onLoad()
  initButtons()
end

function getCounterCoordinates(sheet_column, subcolumn, row)
  return {
    x = getUiXPos(sheet_column, subcolumn),
    y = ui_y_position,
    z = ui_z_first_pos + vertical_spacing * (row - 1)
  }
end

function generateCounters(counters_table)
  for _, counter_details in pairs(counters_table) do
    for i = 1, counter_details.amount, 1 do
      local current_row = counter_details.first_row + i - 1
      generateSetOfCounters(counter_details, current_row)
    end
  end
end

-- A set is all contained on the same line
function generateSetOfCounters(counter_details, current_row)
  for col = 1, counter_details.columns, 1 do
    setupCounter(getCounterCoordinates(counter_details.sheet_col, col, current_row), counter_details.default_values[col])
  end
end

function initButtons()
  generateCounters(counters_configuration)
  setupTotal(getCounterCoordinates(total_position.sheet_col, 1.5, total_position.row))
end

function setupCounter(position, default_value)
  local counter_index = total_counter_count
  local input_function_name = "onInput_" .. tostring(total_counter_count)

  local parameters = {
    index = counter_index,
    input_function = input_function_name,
    function_owner = self,
    label = tostring(default_value),
    position = position,
    scale = button_config["counter"].scale,
    width = button_config["counter"].width,
    height = button_config["counter"].height,
    font_size = button_config["counter"].font,
    color = {0.5, 0.5, 0.5, 0},
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
    position = {position.x + plus_minus_spacing, position.y, position.z - 0.03},
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
    position = {position.x - plus_minus_spacing, position.y, position.z - 0.03},
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
    amount = amount * 5
  end
  if not counter.value then
    counter.value = tonumber(counter.label)
  end
  counter.value = counter.value + amount
  if counter.value == tonumber(counter.label) then
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

function getValueOrElse(value, else_value)
  if value ~= nil then
    return value
  else
    return else_value
  end
end

function multiplyCells(start_index, size, else_values)
  result = getValueOrElse(counters[start_index].value, else_values[1])
  for i = 1, size - 1, 1 do
    result = result * getValueOrElse(counters[start_index + i].value, else_values[i + 1])
  end
  return result
end

function updateTotal()
  local counter_index = 1
  local total = 0
  for _, config in pairs(counters_configuration) do
    for i = 1, config.amount, 1 do
      total = total + multiplyCells(counter_index, config.columns, config.default_values)
      counter_index = counter_index + config.columns
    end
  end

  total_counter.label = tostring(total)
  self.editButton(total_counter)
end
