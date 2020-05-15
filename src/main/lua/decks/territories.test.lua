require("decks/territories")
require("util/assertions")
require("util/test")

test({
  ["should compute score"] = function()
    local kingdom = {
      { squares.fields_0, squares.fields_1, squares.prairies_0 },
      { squares.fields_0, squares.castle, squares.prairies_2 },
      { squares.fields_0, squares.forest_0, squares.forest_1 },
    }
    assertEquals(computeScore(kingdom), 10)
  end,

  ["should compute empty kingdom"] = function()
    local kingdom = {
      { squares.castle },
    }
    assertEquals(computeScore(kingdom), 0)
  end,

  ["should compute nil kingdom"] = function()
    local kingdom = {
      { nil, nil, nil },
      { nil, nil, nil },
      { nil, nil, nil },
    }
    assertEquals(computeScore(kingdom), 0)
  end,

  ["should compute score with nils"] = function()
    local kingdom = {
      { nil, squares.fields_1, squares.prairies_0 },
      { squares.fields_0, squares.castle, nil },
      { squares.fields_0, squares.forest_0, squares.forest_1 },
    }
    assertEquals(computeScore(kingdom), 3)
  end,

  ["should compute size 7 kingdom"] = function()
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

  ["should compare tables"] = function()
    assertEquals({ 1, 2 }, { 1, 2 })
  end
})

