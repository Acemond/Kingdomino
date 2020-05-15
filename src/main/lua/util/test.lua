function assertEquals(actual, expected)
  if actual ~= expected then
    error("Assertion failed: got [" .. actual .. "], expected [".. expected .."]")
  end
end
