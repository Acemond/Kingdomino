local terrain_type = {
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
  castle = { type = terrain_type.castle, crowns = 0 },
  prairies_0 = { type = terrain_type.prairies, crowns = 0 },
  prairies_1 = { type = terrain_type.prairies, crowns = 1 },
  prairies_2 = { type = terrain_type.prairies, crowns = 2 },
  fields_0 = { type = terrain_type.fields, crowns = 0 },
  fields_1 = { type = terrain_type.fields, crowns = 1 },
  fields_2 = { type = terrain_type.fields, crowns = 2 },
  forest_0 = { type = terrain_type.forest, crowns = 0 },
  forest_1 = { type = terrain_type.forest, crowns = 1 },
  forest_2 = { type = terrain_type.forest, crowns = 2 },
  lake_0 = { type = terrain_type.lake, crowns = 0 },
  lake_1 = { type = terrain_type.lake, crowns = 1 },
  marsh_0 = { type = terrain_type.marsh, crowns = 0 },
  marsh_1 = { type = terrain_type.marsh, crowns = 1 },
  marsh_2 = { type = terrain_type.marsh, crowns = 2 },
  mountain_0 = { type = terrain_type.mountain, crowns = 0 },
  mountain_1 = { type = terrain_type.mountain, crowns = 1 },
  mountain_2 = { type = terrain_type.mountain, crowns = 2 },
  mountain_3 = { type = terrain_type.mountain, crowns = 3 },
  town = { type = terrain_type.town, crowns = 0 },
}

resources = {
  Wheat = { type = "wheat", base_points = 0, warrior = false },
  Wood = { type = "wood", base_points = 0, warrior = false },
  Fish = { type = "fish", base_points = 0, warrior = false },
  Sheep = { type = "sheep", base_points = 0, warrior = false },
}

giant = { type = "giant" }

buildings = {
  ["53a259"] = { type = "building", warrior = false, crowns = 1 },
  ["55a4a4"] = { type = "building", warrior = false, crowns = 1 },
  ["241fb0"] = { type = "character", base_points = 3, variable = { condition = "wheat", amount = 3 }, warrior = false, crowns = 0 },
  ["274932"] = { type = "building", warrior = false, crowns = 1 },
  ["bb359a"] = { type = "character", base_points = 2, variable = { condition = "resource", amount = 2 }, warrior = false, crowns = 0 },
  ["c67301"] = { type = "building", warrior = false, crowns = 1 },
  ["6d78bd"] = { type = "building", warrior = false, crowns = 1 },
  ["ff433f"] = { type = "character", base_points = 3, variable = { condition = "wood", amount = 3 }, warrior = false, crowns = 0 },
  ["f3256d"] = { type = "building", warrior = false, crowns = 1 },
  ["18035c"] = { type = "character", base_points = 4, warrior = true, crowns = 0 },
  ["232195"] = { type = "building", warrior = false, crowns = 1 },
  ["c8bd41"] = { type = "building", warrior = false, crowns = 1 },
  ["0beb15"] = { type = "character", base_points = 3, variable = { condition = "fish", amount = 3 }, warrior = false, crowns = 0 },
  ["7ce667"] = { type = "building", warrior = false, crowns = 1 },
  ["10f247"] = { type = "character", base_points = 4, warrior = true, crowns = 0 },
  ["5a7da2"] = { type = "building", warrior = false, crowns = 1 },
  ["4c73d8"] = { type = "building", warrior = false, crowns = 2 },
  ["03f1db"] = { type = "character", base_points = 3, variable = { condition = "sheep", amount = 3 }, warrior = false, crowns = 0 },
  ["88ed47"] = { type = "character", base_points = 1, variable = { condition = "warrior", amount = 3 }, warrior = true, crowns = 0 },
  ["3bd5ba"] = { type = "character", base_points = 3, warrior = true, crowns = 0 },
  ["edfc8d"] = { type = "building", warrior = false, crowns = 1 },
  ["0255c1"] = { type = "building", warrior = false, crowns = 2 },
  ["ac0d2f"] = { type = "character", base_points = 0, variable = { condition = "crowns", amount = 1 }, warrior = false, crowns = 0 },
  ["78cc48"] = { type = "character", base_points = 2, variable = { condition = "character", amount = 2 }, warrior = false, crowns = 0 },
  ["55a4a4"] = { type = "character", base_points = 3, warrior = true, crowns = 0 },
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
end

function getBuildingObject(object)
  if buildings[object.guid] then
    return buildings[object.guid]
  elseif object.getName() == "Giant" then
    return giant
  elseif resources[object.getName()] then
    return resources[object.getName()]
  end
end

function countTerritory(map, position, accumulator)
  if map[position[1]] and map[position[1]][position[2]]
      and not accumulator.counted_squares[position[1]][position[2]] then
    local kingdom_square = map[position[1]][position[2]].terrain
    local building = map[position[1]][position[2]].building
    if kingdom_square ~= nil and (not accumulator.type or kingdom_square.type == accumulator.type) then
      accumulator.type = kingdom_square.type
      accumulator.size = accumulator.size + 1

      if building then
        if not building.type == "giant" and building.crowns then
          accumulator.crowns = accumulator.crowns + kingdom_square.crowns + building.crowns
        end
      else
        accumulator.crowns = accumulator.crowns + kingdom_square.crowns
      end

      accumulator.counted_squares[position[1]][position[2]] = true
      countTerritory(map, { position[1] + 1, position[2] }, accumulator)
      countTerritory(map, { position[1] - 1, position[2] }, accumulator)
      countTerritory(map, { position[1], position[2] + 1 }, accumulator)
      countTerritory(map, { position[1], position[2] - 1 }, accumulator)
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
      counted_squares[row][col_number] = square.type == terrain_type.castle
    end
  end

  return counted_squares
end
