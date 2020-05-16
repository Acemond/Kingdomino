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

dominoes = {
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

function getDominoContent(guid)
  local domino_index = table.indexOf(Guids.dominoes.kingdomino, guid)
  if domino_index ~= nil then
    return dominoes.kingdomino[domino_index]
  end
end

function countTerritory(kingdom, position, accumulator)
  if kingdom[position[1]] and kingdom[position[1]][position[2]]
      and not accumulator.counted_squares[position[1]][position[2]] then
    local kingdom_square = kingdom[position[1]][position[2]]
    if not accumulator.type or kingdom_square.type == accumulator.type then
      accumulator.type = kingdom_square.type
      accumulator.size = accumulator.size + 1
      accumulator.crowns = accumulator.crowns + kingdom_square.crowns
      accumulator.counted_squares[position[1]][position[2]] = true
      countTerritory(kingdom, { position[1] + 1, position[2] }, accumulator)
      countTerritory(kingdom, { position[1] - 1, position[2] }, accumulator)
      countTerritory(kingdom, { position[1], position[2] + 1 }, accumulator)
      countTerritory(kingdom, { position[1], position[2] - 1 }, accumulator)
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
