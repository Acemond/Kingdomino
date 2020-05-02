local button_config = {
  counter = {
    width = 600, height = 550,
    font = 450,
    scale = { 0.15, 0.15, 0.15 }
  },
  plus_minus = {
    width = 300, height = 300,
    font = 400,
    scale = { 0.17, 0.17, 0.17 }
  }
}
local plus_minus_spacing = 0.16
local total_label_prefix = "Total Score: "

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
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },
  { columns = 3, subcolumns = 2, default_values = { 0, 0 } },

  { columns = 1, subcolumns = 1, default_values = { 0 } },

  { columns = 1, subcolumns = 2, default_values = { 0, 1 } },
  { columns = 1, subcolumns = 2, default_values = { 0, 1 } },

  { columns = 1, subcolumns = 1, default_values = { 0 } },
  { columns = 1, subcolumns = 1, default_values = { 0 } },
  { columns = 1, subcolumns = 1, default_values = { 0 } },
  { columns = 1, subcolumns = 1, default_values = { 0 } }
}
local total_position = {
  row = 15,
  column = 1
}

function onLoad(save_state)
  if save_state ~= "" then
    counters = JSON.decode(save_state).counters
    total_counter_count = JSON.decode(save_state).total_counter_count
    buttons_count = JSON.decode(save_state).buttons_count
    total_counter = JSON.decode(save_state).total_counter
  else
    initButtons()
  end
end

function onSave()
  return JSON.encode({
    counters = counters,
    total_counter_count = total_counter_count,
    buttons_count = buttons_count,
    total_counter = total_counter
  })
end

function getCounterCoordinates(row, sheet_column, subcolumn)
  return {
    x = getUiXPos(sheet_column, subcolumn),
    y = ui_y_position,
    z = ui_z_first_pos + vertical_spacing * (row - 1)
  }
end

function generateCounters()
  for row, row_configuration in pairs(counters_configuration) do
    generateRow(row, row_configuration)
  end
end

function generateRow(row, row_configuration)
  for col = 1, row_configuration.columns, 1 do
    generateSubcolumns(row, col, row_configuration)
  end
end

-- A set is all contained on the same line
function generateSubcolumns(row, col, row_configuration)
  for subcol = 1, row_configuration.subcolumns, 1 do
    setupCounter(getCounterCoordinates(row, col, subcol), row_configuration.default_values[subcol])
  end
end

function initButtons()
  generateCounters()
  setupTotal(getCounterCoordinates(total_position.row, total_position.column, 1.5))
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
    color = { 0.5, 0.5, 0.5, 0 },
    font_color = { 0, 0, 0, 100 },
    alignment = 3, -- Center
    validation = 2, -- 1: None, 2: Integer
    tab = 2  -- Select next input
  }

  self.setVar(input_function_name,
      function(_, _, input_value, _)
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
      function(_, _, alt_click)
        incrementCounter(counter, alt_click, 1)
      end)

  self.createButton({
    index = buttons_count,
    click_function = click_function_name,
    function_owner = self,
    label = "+",
    position = { position.x + plus_minus_spacing, position.y, position.z - 0.03 },
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
      function(_, _, alt_click)
        incrementCounter(counter, alt_click, -1)
      end)

  self.createButton({
    index = buttons_count,
    click_function = click_function_name,
    function_owner = self,
    label = "-",
    position = { position.x - plus_minus_spacing, position.y, position.z - 0.03 },
    scale = button_config["plus_minus"].scale,
    width = button_config["plus_minus"].width,
    height = button_config["plus_minus"].height,
    font_size = button_config["plus_minus"].font,
  })
  buttons_count = buttons_count + 1
end

function doNothing()
end

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
    color = { 1, 1, 1, 0 },
    font_color = { 0, 0, 0, 100 },
    alignment = 3, -- Center
    tooltip = total_label_prefix .. "0"
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
    if counters[i + 1].value then
      result = result + counters[i + 1].value
    end
  end
  return result
end

function getValueOrElse(value, else_value)
  if value then
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
    for _ = 1, config.columns, 1 do
      total = total + multiplyCells(counter_index, config.subcolumns, config.default_values)
      counter_index = counter_index + config.subcolumns
    end
  end

  total_counter.label = tostring(total)
  total_counter.tooltip = total_label_prefix .. tostring(total)
  self.editButton(total_counter)
end
