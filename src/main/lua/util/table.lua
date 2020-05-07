function table.contains(table, value)
  for _, table_value in pairs(table) do
    if table_value == value then
      return true
    end
  end
  return false
end
