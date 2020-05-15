require("decks/territories")
require("util/assertions")

local tests = {
  shouldComputeScore = function()
    local kingdom = {
      { squares.fields_0, squares.fields_1, squares.prairies_0 },
      { squares.fields_0, squares.castle, squares.prairies_2 },
      { squares.fields_0, squares.forest_0, squares.forest_1 },
    }
    assertEquals(computeScore(kingdom), 10)
  end,

  shouldComputeEmptyKingdom = function()
    local kingdom = {
      { squares.castle },
    }
    assertEquals(computeScore(kingdom), 0)
  end,

  shouldComputeNilKingdom = function()
    local kingdom = {
      { nil, nil, nil },
      { nil, nil, nil },
      { nil, nil, nil },
    }
    assertEquals(computeScore(kingdom), 0)
  end,

  shouldComputeScoreWithNils = function()
    local kingdom = {
      { nil, squares.fields_1, squares.prairies_0 },
      { squares.fields_0, squares.castle, nil },
      { squares.fields_0, squares.forest_0, squares.forest_1 },
    }
    assertEquals(computeScore(kingdom), 3)
  end,

  shouldComputeSize7Kingdom = function()
    local kingdom = {
      { squares.fields_0, squares.fields_1, squares.prairies_0, squares.prairies_2, squares.prairies_0, squares.prairies_1, squares.prairies_0 },
      { squares.fields_0, squares.castle, squares.prairies_2, squares.prairies_0, squares.prairies_1, squares.town, squares.town },
      { squares.fields_1, squares.forest_0, squares.forest_1, squares.lake_1, squares.lake_0, squares.lake_1, squares.town },
      { squares.fields_0, squares.forest_0, squares.forest_1, squares.lake_1, squares.lake_0, squares.lake_1, squares.town },
      { squares.fields_0, squares.forest_0, squares.forest_1, squares.lake_1, squares.lake_0, squares.lake_1, squares.town },
      { squares.fields_0, squares.forest_0, squares.forest_1, squares.lake_1, squares.lake_0, squares.lake_1, squares.town },
    }
    assertEquals(computeScore(kingdom), 190)
  end,
}
for test_name, test in pairs(tests) do
  local state, message = pcall(test)
  if state then
    print(test_name .. ": OK")
  else
    print(test_name .. ": " ..message)
  end
end

