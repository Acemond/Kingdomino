require("util/table")
require("util/assertions")
require("util/test")

test({
  ["equal should return true"] = function()
    assertEquals(table.equal({ 2, 3, 1 }, { 2, 3, 1 }), true)
  end,
  ["contains should return true"] = function()
    assertEquals(table.contains({ 2, 3, 1 }, 1), true)
  end,

  ["containsOnly should return true"] = function()
    assertEquals(table.containsOnly({}, {}), true)
  end,

  ["containsAll should return true"] = function()
    assertEquals(table.containsOnly({}, {}), true)
  end,

  ["contains should return true"] = function()
    assertEquals(table.contains({ position = {} }, {}), true)
  end,

  ["containsAll should return true"] = function()
    assertEquals(table.containsOnly({ position = {} }, { position = {} }), true)
  end,

  ["containsAll should return false"] = function()
    assertEquals(table.containsOnly({}, { 1 }), false)
  end
})
