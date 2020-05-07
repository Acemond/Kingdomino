function table.contains(tbl, value)
  for _, table_value in pairs(tbl) do
    if table_value == value then
      return true
    end
  end
  return false
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
