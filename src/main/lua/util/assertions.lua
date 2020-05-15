require("util/table")

function assertEquals(actual, expected)
  if (type(expected) == "table") then
    return assertTableEquals(actual, expected)
  end

  assert(actual == expected, "Assertion failed: got [" .. actual .. "], expected [" .. expected .. "]")
end

function assertTableEquals(actual, expected)
  assert(type(actual) == "table", "Assertion failed: actual value was not a Lua table")
  assert(table.equal(actual, expected), "Assertion failed: got " .. table.tostring(actual) .. ", expected " .. table.tostring(expected))
end
