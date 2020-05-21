terrain_types = {
  castle = "castle",
  prairies = "prairies",
  fields = "fields",
  forest = "forest",
  lake = "lake",
  marsh = "marsh",
  mountain = "mountain",
  town = "town"
}

squares = {
  castle = { type = terrain_types.castle, crowns = 0 },
  prairies_0 = { type = terrain_types.prairies, crowns = 0 },
  prairies_1 = { type = terrain_types.prairies, crowns = 1 },
  prairies_2 = { type = terrain_types.prairies, crowns = 2 },
  fields_0 = { type = terrain_types.fields, crowns = 0 },
  fields_1 = { type = terrain_types.fields, crowns = 1 },
  fields_2 = { type = terrain_types.fields, crowns = 2 },
  forest_0 = { type = terrain_types.forest, crowns = 0 },
  forest_1 = { type = terrain_types.forest, crowns = 1 },
  forest_2 = { type = terrain_types.forest, crowns = 2 },
  lake_0 = { type = terrain_types.lake, crowns = 0 },
  lake_1 = { type = terrain_types.lake, crowns = 1 },
  lake_2 = { type = terrain_types.lake, crowns = 2 },
  marsh_0 = { type = terrain_types.marsh, crowns = 0 },
  marsh_1 = { type = terrain_types.marsh, crowns = 1 },
  marsh_2 = { type = terrain_types.marsh, crowns = 2 },
  mountain_0 = { type = terrain_types.mountain, crowns = 0 },
  mountain_1 = { type = terrain_types.mountain, crowns = 1 },
  mountain_2 = { type = terrain_types.mountain, crowns = 2 },
  mountain_3 = { type = terrain_types.mountain, crowns = 3 },
  town = { type = terrain_types.town, crowns = 0 },
}

resources = {
  Wheat = { type = "wheat", base_points = 0, warrior = false, terrain = terrain_types.fields },
  Wood = { type = "wood", base_points = 0, warrior = false, terrain = terrain_types.forest },
  Fish = { type = "fish", base_points = 0, warrior = false, terrain = terrain_types.lake },
  Sheep = { type = "sheep", base_points = 0, warrior = false, terrain = terrain_types.prairies },
}

giant = { name = "Giant" }
queen = { name = "Queen" }

buildings = {
  ["53a259"] = { type = "building", base_points = 0, crowns = 1 },
  ["55a4a4"] = { type = "building", base_points = 0, crowns = 1 },
  ["241fb0"] = { type = "character", base_points = 3, variable = { condition = "wheat", amount = 3 }, crowns = 0 },
  ["274932"] = { type = "building", base_points = 0, crowns = 1 },
  ["bb359a"] = { type = "character", base_points = 2, variable = { condition = "resource", amount = 2 }, crowns = 0 },
  ["c67301"] = { type = "building", base_points = 0, crowns = 1 },
  ["6d78bd"] = { type = "building", base_points = 0, crowns = 1 },
  ["ff433f"] = { type = "character", base_points = 3, variable = { condition = "wood", amount = 3 }, crowns = 0 },
  ["f3256d"] = { type = "building", base_points = 0, crowns = 1 },
  ["18035c"] = { type = "character", base_points = 4, warrior = true, crowns = 0 },
  ["232195"] = { type = "building", base_points = 0, crowns = 1 },
  ["c8bd41"] = { type = "building", base_points = 0, crowns = 1 },
  ["0beb15"] = { type = "character", base_points = 3, variable = { condition = "fish", amount = 3 }, crowns = 0 },
  ["7ce667"] = { type = "building", base_points = 0, crowns = 1 },
  ["10f247"] = { type = "character", base_points = 4, warrior = true, crowns = 0 },
  ["5a7da2"] = { type = "building", base_points = 0, crowns = 1 },
  ["4c73d8"] = { type = "building", base_points = 0, crowns = 2 },
  ["03f1db"] = { type = "character", base_points = 3, variable = { condition = "sheep", amount = 3 }, crowns = 0 },
  ["88ed47"] = { type = "character", base_points = 1, variable = { condition = "warrior", amount = 3 }, warrior = true, crowns = 0 },
  ["3bd5ba"] = { type = "character", base_points = 3, warrior = true, crowns = 0 },
  ["edfc8d"] = { type = "building", base_points = 0, crowns = 1 },
  ["0255c1"] = { type = "building", base_points = 0, crowns = 2 },
  ["ac0d2f"] = { type = "character", base_points = 0, variable = { condition = "crowns", amount = 1 }, crowns = 0 },
  ["78cc48"] = { type = "character", base_points = 2, variable = { condition = "character", amount = 2 }, crowns = 0 },
  ["55a4a4"] = { type = "character", base_points = 3, warrior = true, crowns = 0 },
  -- Queendomino
  ["d9bf8b"] = { type = "building", base_points = 0, crowns = 1 },
  ["d9eca3"] = { type = "building", base_points = 0, crowns = 1 },
  ["a5d37f"] = { type = "building", base_points = 0, crowns = 1 },
  ["4d0169"] = { type = "building", base_points = 3, crowns = 0 },
  ["27b93b"] = { type = "building", base_points = 2, crowns = 0 },
  ["1a04ee"] = { type = "building", base_points = 3, crowns = 0 },
  ["652cf1"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = "tower", amount = 1 } },
  ["1853da"] = { type = "building", base_points = 5, crowns = 0 },
  ["782aaa"] = { type = "building", base_points = 5, crowns = 0 },
  ["31df24"] = { type = "building", base_points = 5, crowns = 0 },
  ["353102"] = { type = "building", base_points = 3, crowns = 0 },
  ["de4cb6"] = { type = "building", base_points = 3, crowns = 0 },
  ["cde022"] = { type = "building", base_points = 2, crowns = 0 },
  ["89e872"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = "knight", amount = 1 } },
  ["3a9776"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = "knight", amount = 1 } },
  ["81427c"] = { type = "building", base_points = 2, crowns = 0 },
  ["9728da"] = { type = "building", base_points = 2, crowns = 0 },
  ["60be38"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.forest, amount = 2 } },
  ["c42be4"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.forest, amount = 2 } },
  ["5cf294"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.mountain, amount = 2 } },
  ["5f8667"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.mountain, amount = 2 } },
  ["2a33d7"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.marsh, amount = 2 } },
  ["733e96"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.lake, amount = 2 } },
  ["4770ba"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.lake, amount = 2 } },
  ["199581"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.town, amount = 2 } },
  ["5a17db"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.town, amount = 2 } },
  ["0598a2"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.marsh, amount = 2 } },
  ["36774f"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.fields, amount = 2 } },
  ["f4b32f"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.fields, amount = 2 } },
  ["aae8a1"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.prairies, amount = 2 } },
  ["d9eca3"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = terrain_types.prairies, amount = 2 } },
  ["ce08fa"] = { type = "building", base_points = 0, crowns = 0, variable = { condition = "tower", amount = 1 } },
}

local dominoes = {
  kingdomino = {
    { squares.fields_0, squares.fields_0 },
    { squares.fields_0, squares.fields_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.lake_0, squares.lake_0 },
    { squares.lake_0, squares.lake_0 },
    { squares.lake_0, squares.lake_0 },
    { squares.prairies_0, squares.prairies_0 },
    { squares.prairies_0, squares.prairies_0 },
    { squares.marsh_0, squares.marsh_0 },
    { squares.fields_0, squares.forest_0 },
    { squares.fields_0, squares.lake_0 },
    { squares.fields_0, squares.prairies_0 },
    { squares.fields_0, squares.marsh_0 },
    { squares.forest_0, squares.lake_0 },
    { squares.forest_0, squares.prairies_0 },
    { squares.fields_1, squares.forest_0 },
    { squares.fields_1, squares.lake_0 },
    { squares.fields_1, squares.prairies_0 },
    { squares.fields_1, squares.marsh_0 },
    { squares.fields_1, squares.mountain_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.lake_0 },
    { squares.forest_1, squares.prairies_0 },
    { squares.lake_1, squares.fields_0 },
    { squares.lake_1, squares.fields_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.fields_0, squares.prairies_1 },
    { squares.lake_0, squares.prairies_1 },
    { squares.fields_0, squares.marsh_1 },
    { squares.prairies_0, squares.marsh_1 },
    { squares.mountain_1, squares.fields_0 },
    { squares.fields_0, squares.prairies_2 },
    { squares.lake_0, squares.prairies_2 },
    { squares.fields_0, squares.marsh_2 },
    { squares.prairies_0, squares.marsh_2 },
    { squares.mountain_2, squares.fields_0 },
    { squares.marsh_0, squares.mountain_2 },
    { squares.marsh_0, squares.mountain_2 },
    { squares.fields_0, squares.mountain_3 }
  },
  queendomino = {
    { squares.fields_0, squares.fields_0 },
    { squares.fields_0, squares.fields_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.forest_0, squares.forest_0 },
    { squares.fields_1, squares.marsh_0 },
    { squares.fields_1, squares.mountain_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.lake_0, squares.lake_0 },
    { squares.lake_0, squares.lake_0 },
    { squares.prairies_0, squares.prairies_0 },
    { squares.prairies_0, squares.prairies_0 },
    { squares.forest_1, squares.fields_0 },
    { squares.forest_1, squares.lake_0 },
    { squares.forest_1, squares.prairies_0 },
    { squares.lake_1, squares.fields_0 },
    { squares.marsh_0, squares.marsh_0 },
    { squares.fields_1, squares.forest_0 },
    { squares.fields_1, squares.lake_0 },
    { squares.fields_1, squares.prairies_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.lake_1, squares.forest_0 },
    { squares.prairies_1, squares.fields_0 },
    { squares.marsh_1, squares.fields_0 },
    { squares.prairies_2, squares.fields_0 },
    { squares.prairies_2, squares.forest_0 },
    { squares.marsh_2, squares.fields_0 },
    { squares.town, squares.marsh_0 },
    { squares.forest_1, squares.town },
    { squares.lake_1, squares.town },
    { squares.lake_1, squares.town },
    { squares.marsh_2, squares.forest_0 },
    { squares.mountain_2, squares.fields_0 },
    { squares.mountain_2, squares.fields_0 },
    { squares.town, squares.forest_0 },
    { squares.prairies_1, squares.forest_0 },
    { squares.marsh_1, squares.forest_0 },
    { squares.mountain_1, squares.forest_0 },
    { squares.mountain_2, squares.forest_0 },
    { squares.town, squares.lake_0 },
    { squares.town, squares.lake_0 },
    { squares.town, squares.prairies_0 },
    { squares.town, squares.prairies_0 },
    { squares.mountain_3, squares.town },
    { squares.town, squares.town },
    { squares.town, squares.town },
    { squares.town, squares.town },
  },
  age_of_giants = {
    [-6] = { squares.forest_0, squares.fields_0 },
    [-5] = { squares.forest_0, squares.fields_0 },
    [-4] = { squares.lake_0, squares.fields_0 },
    [-3] = { squares.mountain_0, squares.prairies_0 },
    [-2] = { squares.marsh_0, squares.prairies_0 },
    [-1] = { squares.lake_0, squares.prairies_0 },
    [49] = { squares.fields_2, squares.forest_1 },
    [50] = { squares.forest_2, squares.lake_1 },
    [51] = { squares.lake_2, squares.prairies_1 },
    [52] = { squares.prairies_2, squares.marsh_1 },
    [53] = { squares.marsh_2, squares.mountain_1 },
    [54] = { squares.mountain_2, squares.marsh_1 }
  }
}

function getDominoContent(object)
  local domino_index = table.indexOf(Guids.dominoes.kingdomino, object.guid)
  if domino_index ~= nil then
    return dominoes.kingdomino[domino_index]
  end
  domino_index = table.indexOf(Guids.dominoes.queendomino, object.guid)
  if domino_index ~= nil then
    return dominoes.queendomino[domino_index]
  end
  domino_index = table.indexOf(Guids.dominoes.age_of_giants, object.guid)
  if domino_index ~= nil then
    return dominoes.age_of_giants[domino_index]
  end
end

function getResourceType(terrain_type)
  for resource_name, resource in pairs(resources) do
    if terrain_type == resource.terrain then
      return resource_name
    end
  end
end

function getBuildingObject(object)
  if buildings[object.guid] then
    return buildings[object.guid]
  elseif resources[object.getName()] then
    return resources[object.getName()]
  end
end

function getTerritory(map, row, col, accumulator)
  if map[row] and map[row][col] and not accumulator.counted_squares[row][col] then
    local kingdom_square = map[row][col].terrain
    local building = map[row][col].building

    if kingdom_square ~= nil and (not accumulator.type or kingdom_square.type == accumulator.type) then
      accumulator.type = kingdom_square.type
      accumulator.size = accumulator.size + 1

      local square_crowns = 0
      square_crowns = kingdom_square.crowns
      if building and building.crowns then
        square_crowns = square_crowns + building.crowns
      end
      if map[row][col].queen then
        square_crowns = square_crowns + 1
      end
      if map[row][col].giant_count then
        square_crowns = square_crowns - map[row][col].giant_count
      end

      accumulator.crowns = accumulator.crowns or 0
      if square_crowns > 0 then
        accumulator.crowns = accumulator.crowns + square_crowns
      end

      accumulator.counted_squares[row][col] = true
      getTerritory(map, row + 1, col, accumulator)
      getTerritory(map, row - 1, col, accumulator)
      getTerritory(map, row, col + 1, accumulator)
      getTerritory(map, row, col - 1, accumulator)
    end
  end

  return accumulator
end

function initializeCountedArray(kingdom)
  local counted_squares = {}
  for row, column in pairs(kingdom) do
    if not counted_squares[row] then
      counted_squares[row] = {}
    end

    for col_number, square in pairs(column) do
      counted_squares[row][col_number] = square.type == terrain_types.castle
    end
  end

  return counted_squares
end
