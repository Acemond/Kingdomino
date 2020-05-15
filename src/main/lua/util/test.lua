function test(test_functions)
  for test_name, test in pairs(test_functions) do
    local state, message = pcall(test)
    if state then
      print(test_name .. ": OK")
    else
      print(test_name .. ": " .. message)
    end
  end
end