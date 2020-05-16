require("util/domino")
require("decks/territories")
require("constants/guids")

Kingdom = {}
Kingdom.__index = Kingdom

local grid = 0.1

function Kingdom:new(color, size)
  local kingdom = {}
  setmetatable(kingdom, Kingdom)
  kingdom.color = color
  kingdom.size = size
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
    addSquareToMap(self.map, squares[2], line - 0.5, column)
    addSquareToMap(self.map, squares[1], line + 0.5, column)
  elseif orientation == DominoUtils.orientations.z_reverse and self.map[line + 0.5] and self.map[line - 0.5] then
    addSquareToMap(self.map, squares[1], line - 0.5, column)
    addSquareToMap(self.map, squares[2], line + 0.5, column)
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
  return self:countCrownsPoints()
      + self:countTheCourtPoints()
end

function Kingdom:countTheCourtPoints()
  local points = 0
  for row_number, column in pairs(self.map) do
    for col_number, square in pairs(column) do
      if square.building ~= nil and square.building.type == "character" then
        points = points + self:countCharacterPoints(square.building, row_number, col_number)
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

function getVariablePoints(variable, square)
  if variable.condition == "crowns" and square.terrain then
    return square.terrain.crowns * variable.amount
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

function Kingdom:countCrownsPoints()
  local points = 0
  local counted_squares = initializeCountedArray(self.map)
  for row_number, column in pairs(self.map) do
    for col_number, square in pairs(column) do
      if square.terrain ~= nil then
        local accumulator = { counted_squares = counted_squares, type = nil, size = 0, crowns = 0 }
        local territory = countTerritory(self.map, { row_number, col_number }, accumulator)
        points = points + territory.size * territory.crowns
      end
    end
  end
  return points
end

function Kingdom:getTileLine(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = math.floor(zone.positionToLocal(tile.getPosition()).z * (1 / grid) + 0.5) / (1 / grid)

  return self.size - local_position * 5 - (self.size - 1) / 2
end

function Kingdom:getTileColumn(tile)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = math.floor(zone.positionToLocal(tile.getPosition()).x * (1 / grid) + 0.5) / (1 / grid)

  return local_position * 5 + (self.size - 1) / 2 + 1
end
