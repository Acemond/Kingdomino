require("util/domino")
require("decks/territories")
require("constants/guids")

Kingdom = {}
Kingdom.__index = Kingdom

function Kingdom:new(color, size)
  local kingdom = {}
  setmetatable(kingdom, Kingdom)
  kingdom.color = color
  kingdom.size = size
  kingdom.tower_count = 0
  kingdom.knight_count = 0
  kingdom.coins = 0
  kingdom.map = {}
  for i = 1, size, 1 do
    kingdom.map[i] = {}
    for j = 1, size, 1 do
      kingdom.map[i][j] = {}
    end
  end
  return kingdom
end

function Kingdom:addDomino(tile)
  self:addNormalizedDomino(tile, self:getTileLine(tile), self:getTileColumn(tile))
end

function Kingdom:addBuilding(tile)
  addBuildingToMap(self.map, getBuildingObject(tile), self:getBuildingLine(tile), self:getBuildingColumn(tile))
end

function Kingdom:addGiant(tile)
  local line, column = self:getBuildingLine(tile), self:getBuildingColumn(tile)
  if self.map[line] and self.map[column] then
    self.map[line][column].giant_count = (self.map[line][column].giant_count or 0) + 1
  end
end

function Kingdom:addQueen(tile)
  local line, column = self:getBuildingLine(tile), self:getBuildingColumn(tile)
  if self.map[line] and self.map[column] then
    self.map[line][column].queen = true
  end
end

function Kingdom:addCastle(tile)
  addSquareToMap(self.map, squares.castle, self:getTileLine(tile), self:getTileColumn(tile))
end

function Kingdom:addTower()
  self.tower_count = self.tower_count + 1
end

function Kingdom:addKnight()
  self.knight_count = self.knight_count + 1
end

function Kingdom:addCoins(count)
  self.coins = self.coins + count
end

function Kingdom:addNormalizedDomino(tile, line, column)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local orientation = DominoUtils.getOrientation(tile.getRotation().y - zone.getRotation().y)

  local squares = getDominoContent(tile)
  if orientation == DominoUtils.orientations.x then
    addSquareToMap(self.map, squares[1], line, column - 0.5)
    addSquareToMap(self.map, squares[2], line, column + 0.5)
  elseif orientation == DominoUtils.orientations.x_reverse and self.map[line] then
    addSquareToMap(self.map, squares[2], line, column - 0.5)
    addSquareToMap(self.map, squares[1], line, column + 0.5)
  elseif orientation == DominoUtils.orientations.z and self.map[line + 0.5] and self.map[line - 0.5] then
    addSquareToMap(self.map, squares[1], line - 0.5, column)
    addSquareToMap(self.map, squares[2], line + 0.5, column)
  elseif orientation == DominoUtils.orientations.z_reverse and self.map[line + 0.5] and self.map[line - 0.5] then
    addSquareToMap(self.map, squares[2], line - 0.5, column)
    addSquareToMap(self.map, squares[1], line + 0.5, column)
  end
end

function addBuildingToMap(map, building, line, column)
  if map[line] and map[column] then
    map[line][column].building = building
  end
end

function addSquareToMap(map, square, line, column)
  if map[line] and map[column] then
    map[line][column].terrain = square
  end
end

function Kingdom:getScore()
  local territories = self:getTerritories()
  return self:countCrownsPoints(territories)
      + self:countBuildingsPoints(territories)
      + self:countCoinsPoints()
      + self:countQuestsPoints(territories)
end

function Kingdom:countBuildingsPoints(territories)
  local points = 0
  for row_number, column in pairs(self.map) do
    for col_number, square in pairs(column) do
      if square.building ~= nil and square.building.type == "character" then
        points = points + self:countCharacterPoints(square.building, row_number, col_number)
      elseif square.building ~= nil and square.building.type ~= giant.type and square.building.type ~= queen.type then
        points = points + self:countBuildingPoints(square.building, territories)
      end
    end
  end
  return points
end

function Kingdom:countBuildingPoints(building, territories)
  local points = building.base_points

  if building.variable then
    if building.variable.condition == "knight" then
      points = points + building.variable.amount * self.knight_count
    elseif building.variable.condition == "tower" then
      points = points + building.variable.amount * self.tower_count
    else
      for _, territory in pairs(territories) do
        if territory.type == building.variable.condition then
          points = points + building.variable.amount
        end
      end
    end
  end

  return points
end

function Kingdom:countCharacterPoints(character, row, column)
  local points = character.base_points

  if character.variable then
    for i = row - 1, row + 1, 1 do
      for j = column - 1, column + 1, 1 do
        if (i ~= row or j ~= column) and self.map[i] and self.map[i][j] then
          points = points + getVariablePoints(character.variable, self.map[i][j])
        end
      end
    end
  end

  return points
end

function Kingdom:countCoinsPoints()
  return (self.coins - self.coins % 3) / 3
end

local quests = {
  harmony = "7f87c8",
  middle_kingdom = "ddd8f4",
  local_business_prairies = "76e6c0",
  local_business_fields = "714d68",
  local_business_lakes = "5ce5dd",
  local_business_mountains = "03130c",
  local_business_forests = "2dff57",
  local_business_marsh = "8cf132",
  the_four_corners_prairies = "bd5cc2",
  the_four_corners_fields = "e9d955",
  the_four_corners_lakes = "78f5db",
  the_four_corners_mountains = "cb497b",
  the_four_corners_forests = "e448b6",
  the_four_corners_marsh = "9d32aa",
  the_lost_corner = "fceb99",
  the_bleak_king = "e9ea3f",
  la_folie_des_grandeurs = "89dae0",
}

function Kingdom:countQuestsPoints(territories)
  local points = 0
  local quests_guids = Global.get("game").quests
  for _, guid in pairs(quests_guids) do
    if guid == quests.harmony then
      points = points + self:checkHarmonyQuest()
    elseif guid == quests.middle_kingdom then
      points = points + self:checkMiddleKingdomQuest()
    elseif guid == quests.local_business_prairies then
      points = points + self:checkLocalBusinessQuest(terrain_types.prairies)
    elseif guid == quests.local_business_fields then
      points = points + self:checkLocalBusinessQuest(terrain_types.fields)
    elseif guid == quests.local_business_lakes then
      points = points + self:checkLocalBusinessQuest(terrain_types.lakes)
    elseif guid == quests.local_business_mountains then
      points = points + self:checkLocalBusinessQuest(terrain_types.mountain)
    elseif guid == quests.local_business_forests then
      points = points + self:checkLocalBusinessQuest(terrain_types.forest)
    elseif guid == quests.local_business_marsh then
      points = points + self:checkLocalBusinessQuest(terrain_types.marsh)
    elseif guid == quests.the_four_corners_prairies then
      points = points + self:checkTheFourCornersQuest(terrain_types.prairies)
    elseif guid == quests.the_four_corners_fields then
      points = points + self:checkTheFourCornersQuest(terrain_types.fields)
    elseif guid == quests.the_four_corners_lakes then
      points = points + self:checkTheFourCornersQuest(terrain_types.lakes)
    elseif guid == quests.the_four_corners_mountains then
      points = points + self:checkTheFourCornersQuest(terrain_types.mountain)
    elseif guid == quests.the_four_corners_forests then
      points = points + self:checkTheFourCornersQuest(terrain_types.forest)
    elseif guid == quests.the_four_corners_marsh then
      points = points + self:checkTheFourCornersQuest(terrain_types.marsh)
    elseif guid == quests.the_lost_corner then
      points = points + self:checkTheLostCornerQuest()
    elseif guid == quests.the_bleak_king then
      points = points + self:checkTheBleakKingQuest(territories)
    elseif guid == quests.la_folie_des_grandeurs then
      points = points + self:checkLaFolieDesGrandeursQuest()
    else
      error("Quest not yet implemented!")
    end
  end
  return points
end

function Kingdom:checkMiddleKingdomQuest()
  local middle_square = (self.size + 1) / 2
  if self.map[middle_square]
      and self.map[middle_square][middle_square]
      and self.map[middle_square][middle_square].terrain
      and self.map[middle_square][middle_square].terrain.type == terrain_types.castle then
    return 10
  else
    return 0
  end
end

function Kingdom:checkTheBleakKingQuest(territories)
  local points = 0
  for _, territory in pairs(territories) do
    if territory.size > 4
        and territory.crowns == 0
        and table.contains({ terrain_types.forest, terrain_types.fields, terrain_types.prairies, terrain_types.lakes }, territory.type) then
      points = points + 10
    end
  end
  return points
end

function Kingdom:checkLaFolieDesGrandeursQuest()
  --https://boardgamegeek.com/thread/2040636/tic-tac-toe-bonus-challenge-tile-clarification
  local points = 0

  for row, _ in pairs(self.map) do
    local col = 1
    repeat
      if self:checkLaFolieDesGrandeursHorizontally(row, col) then
        points = points + 10
        col = col + 1
      end
      col = col + 1
    until col > self.size
  end

  for col, _ in pairs(self.map) do
    local row = 1
    repeat
      if self:checkLaFolieDesGrandeursVertically(row, col) then
        points = points + 10
        row = row + 1
      end
      row = row + 1
    until row > self.size
  end

  --[[
    Checking:
    0 0 X X X X X
    0 X X X X X 0
    1 1 1 1 1 0 0
    1 1 1 1 0 0 0
    1 1 1 0 0 0 0
    1 1 0 0 0 0 0
    1 0 0 0 0 0 0
  ]]
  for row = 1, self.size - 2, 1 do
    local col = 1
    repeat
      if self:checkLaFolieDesGrandeursDiagonally(col + row - 1, col) then
        points = points + 10
        col = col + 1
      end
      col = col + 1
    until col > self.size - 1 - row
  end

  --[[
    Checking:
    0 0 0 0 0 0 0
    0 0 0 0 0 0 X
    0 0 0 0 0 X X
    0 0 0 0 1 X X
    0 0 0 1 1 X X
    0 0 1 1 1 X 0
    0 1 1 1 1 0 0
  ]]
  for col = 2, self.size - 2, 1 do
    local row = 1
    repeat
      if self:checkLaFolieDesGrandeursDiagonally(row, row + col - 1) then
        points = points + 10
        row = row + 1
      end
      row = row + 1
    until row > self.size - col - 1
  end

  --[[
    Checking:
    1 0 0 0 0 0 0
    1 1 0 0 0 0 0
    1 1 1 0 0 0 0
    1 1 1 1 0 0 0
    1 1 1 1 1 0 0
    0 X X X X X 0
    0 0 X X X X X
  ]]
  for row = self.size, 3, -1 do
    local col = 1
    repeat
      if self:checkLaFolieDesGrandeursDiagonallyDown(row - (col - 1), col) then
        points = points + 10
        col = col + 1
      end
      col = col + 1
    until col > row - 2
  end

  --[[
    Checking:
    0 1 1 1 1 0 0
    0 0 1 1 1 X 0
    0 0 0 1 1 X X
    0 0 0 0 1 X X
    0 0 0 0 0 X X
    0 0 0 0 0 0 X
    0 0 0 0 0 0 0
  ]]
  for col = 2, self.size - 2, 1 do
    local row = self.size
    repeat
      if self:checkLaFolieDesGrandeursDiagonallyDown(row, col + (self.size - row)) then
        points = points + 10
        row = row - 1
      end
      row = row - 1
    until row < col + 2
  end

  return points
end

function Kingdom:squareHasCrowns(row, col)
  return self.map[row] and self.map[row][col]
      and (squareHasBuildingCrowns(self.map[row][col]) or squareHasTerrainCrowns(self.map[row][col]))
end

function squareHasBuildingCrowns(square)
  return square.building and square.building.crowns and square.building.crowns > 0
end

function squareHasTerrainCrowns(square)
  return square.terrain and square.terrain.crowns and square.terrain.crowns > 0
end

function Kingdom:checkLaFolieDesGrandeursHorizontally(row, col)
  return self:squareHasCrowns(row, col)
      and self:squareHasCrowns(row, col + 1)
      and self:squareHasCrowns(row, col + 2)
end

function Kingdom:checkLaFolieDesGrandeursVertically(row, col)
  return self:squareHasCrowns(row, col)
      and self:squareHasCrowns(row + 1, col)
      and self:squareHasCrowns(row + 2, col)
end

function Kingdom:checkLaFolieDesGrandeursDiagonally(row, col)
  return self:squareHasCrowns(row, col)
      and self:squareHasCrowns(row + 1, col + 1)
      and self:squareHasCrowns(row + 2, col + 2)
end

function Kingdom:checkLaFolieDesGrandeursDiagonallyDown(row, col)
  return self:squareHasCrowns(row, col)
      and self:squareHasCrowns(row - 1, col + 1)
      and self:squareHasCrowns(row - 2, col + 2)
end

function Kingdom:checkTheLostCornerQuest()
  for i = 1, self.size, self.size - 1 do
    for j = 1, self.size, self.size - 1 do
      if self.map[i][j] and self.map[i][j].terrain and self.map[i][j].terrain.type == terrain_types.castle then
        return 20
      end
    end
  end
  return 0
end

function Kingdom:checkHarmonyQuest()
  for _, content in pairs(self.map) do
    for _, square in pairs(content) do
      if square.terrain == nil then
        return 0
      end
    end
  end
  return 5
end

function Kingdom:checkLocalBusinessQuest(terrain_type)
  local points = 0
  for row, content in pairs(self.map) do
    for col, square in pairs(content) do
      if square.terrain and square.terrain.type == terrain_types.castle then
        for i = row - 1, row + 1, 1 do
          for j = col - 1, col + 1, 1 do
            if self.map[i] and self.map[i][j] and self.map[i][j].terrain
                and self.map[i][j].terrain.type == terrain_type then
              points = points + 5
            end
          end
        end
      end
    end
  end
  return points
end

function Kingdom:checkTheFourCornersQuest(terrain_type)
  local points = 0
  for i = 1, self.size, self.size - 1 do
    for j = 1, self.size, self.size - 1 do
      if self.map[i][j] and self.map[i][j].terrain and self.map[i][j].terrain.type == terrain_type then
        points = points + 5
      end
    end
  end
  return points
end

function getVariablePoints(variable, square)
  if variable.condition == "crowns" and square.terrain then
    local building_crowns = 0
    if square.building ~= nil and square.building.crowns ~= nil and square.building.crowns > 0 then
      building_crowns = building_crowns + square.building.crowns
    end
    return (square.terrain.crowns + building_crowns) * variable.amount
  elseif variable.condition == "resource" and square.building
      and (square.building.type == "wheat"
      or square.building.type == "wood"
      or square.building.type == "fish"
      or square.building.type == "sheep") then
    return variable.amount
  elseif variable.condition == "warrior" and square.building and square.building.warrior then
    return variable.amount
  elseif square.building and variable.condition == square.building.type then
    return variable.amount
  else
    return 0
  end
end

function Kingdom:getTerritories()
  local territories = {}
  local counted_squares = initializeCountedArray(self.map)

  for row_number, column in pairs(self.map) do
    for col_number, square in pairs(column) do
      if square.terrain ~= nil and not counted_squares[row_number][col_number] then
        local accumulator = { counted_squares = counted_squares, type = nil, size = 0, crowns = 0 }
        local territory = getTerritory(self.map, row_number, col_number, accumulator)
        table.insert(territories, territory)
      end
    end
  end
  return territories
end

function Kingdom:countCrownsPoints(territories)
  local points = 0
  for _, territory in pairs(territories) do
    points = points + territory.size * territory.crowns
  end
  return points
end

function Kingdom:getBuildingLine(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = zone.positionToLocal(tile.getPosition()).z

  local position_to_center = math.floor(local_position * zone.getScale().x / 2 + 0.5)
  return position_to_center + (self.size - 1) / 2 + 1
end

function Kingdom:getBuildingColumn(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = zone.positionToLocal(tile.getPosition()).x

  local position_to_center = math.floor(local_position * zone.getScale().x / 2 + 0.5)
  return position_to_center + (self.size - 1) / 2 + 1
end

function Kingdom:getTileLine(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = zone.positionToLocal(tile.getPosition()).z

  local position_to_center = math.floor(local_position * zone.getScale().x + 0.5) / 2
  return position_to_center + (self.size - 1) / 2 + 1
end

function Kingdom:getTileColumn(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = zone.positionToLocal(tile.getPosition()).x

  local position_to_center = math.floor(local_position * zone.getScale().x + 0.5) / 2
  return position_to_center + (self.size - 1) / 2 + 1
end
