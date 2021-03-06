function table.contains(tbl, value)
  for _, table_value in pairs(tbl) do
    if table_value == value then
      return true
    end
  end
  return false
end

function table.map(tbl, map_function)
  local new_table = {}
  for key, tbl_value in pairs(tbl) do
    new_table[key] = map_function(tbl_value)
  end
  return new_table
end

function table.size(tbl)
  local size = 0
  for _, _ in pairs(tbl) do
    size = size + 1
  end
  return size
end

function table.collectValues(tbl)
  local result = {}
  for _, value in pairs(tbl) do
    table.insert(result, value)
  end
  return result
end

function table.containsAll(tbl, other)
  for _, obj in pairs(other) do
    if not table.contains(tbl, obj) then
      return false
    end
  end
  return true
end

function table.containsOnly(tbl, other)
  return table.containsAll(tbl, other) and table.containsAll(other, tbl)
end

function table.indexOf(tbl, value)
  for i, tbl_value in pairs(tbl) do
    if tbl_value == value then
      return i
    end
  end
end

function table.containsOne(tbl, other)
  for _, obj in pairs(other) do
    if table.contains(tbl, obj) then
      return true
    end
  end
  return false
end

function table.equal(tbl, other)
  for key, value in pairs(tbl) do
    if other[key] ~= value then
      return false
    end
  end
  return true
end

function table.log(tbl)
  log(table.tostring(tbl))
end

function table.tostring(tbl)
  if type(tbl) == "table" then
    local result = "{ "
    for key, value in pairs(tbl) do
      if result ~= "{ " then
        result = result .. ", "
      end
      result = result .. tostring(key) .. ": " .. table.tostring(value)
    end
    return result .. " }"
  else
    return tostring(tbl)
  end
end
