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
  addBuildingToMap(self.map, getBuildingObject(tile), self:getTileLine(tile), self:getTileColumn(tile))
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
      + self:countQuestsPoints()
end

function Kingdom:countBuildingsPoints(territories)
  local points = 0
  for row_number, column in pairs(self.map) do
    for col_number, square in pairs(column) do
      if square.building ~= nil and square.building.type == "character" then
        points = points + self:countCharacterPoints(square.building, row_number, col_number)
      elseif square.building ~= nil then
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

function Kingdom:countQuestsPoints()
  local points = 0
  local quests_guids = Global.get("game").quests
  for _, guid in pairs(quests_guids) do
    if guid == "7f87c8" then
      points = points + self:checkHarmonyQuest()
    elseif guid == "ddd8f4" then
      points = points + self:checkMiddleKingdomQuest()
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
      and self.map[middle_square][middle_square].terrain.type == terrain_type.castle then
    return 10
  else
    return 0
  end
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

function getVariablePoints(variable, square)
  if variable.condition == "crowns" and square.terrain then
    local building_crowns = 0
    if square.building and square.building.crowns > 0 then
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
