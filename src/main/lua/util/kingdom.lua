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
  end
  return kingdom
end

function Kingdom:addDomino(domino)
  self:addNormalizedDomino(domino, self:getDominoLine(domino), self:getDominoColumn(domino))
end

function Kingdom:addNormalizedDomino(domino, line, column)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local orientation = DominoUtils.getOrientation(domino.getRotation().y - zone.getRotation().y)

  local squares = getDominoContent(domino.guid)
  if orientation == DominoUtils.orientations.x and self.map[line] then
    self.map[line][column - 0.5] = squares[1]
    self.map[line][column + 0.5] = squares[2]
  elseif orientation == DominoUtils.orientations.x_reverse and self.map[line] then
    self.map[line][column - 0.5] = squares[2]
    self.map[line][column + 0.5] = squares[1]
  elseif orientation == DominoUtils.orientations.z and self.map[line + 0.5] and self.map[line - 0.5] then
    self.map[line - 0.5][column] = squares[2]
    self.map[line + 0.5][column] = squares[1]
  elseif orientation == DominoUtils.orientations.z_reverse and self.map[line + 0.5] and self.map[line - 0.5] then
    self.map[line - 0.5][column] = squares[1]
    self.map[line + 0.5][column] = squares[2]
  end
end

function Kingdom:getScore()
  local total = 0
  local counted_squares = initializeCountedArray(self.map)
  for row, column in pairs(self.map) do
    for col_number, _ in pairs(column) do
      local accumulator = { counted_squares = counted_squares, type = nil, size = 0, crowns = 0 }

      local territory = countTerritory(self.map, { row, col_number }, accumulator)
      total = total + territory.size * territory.crowns
    end
  end

  return total
end

function Kingdom:getDominoLine(domino)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = math.floor(zone.positionToLocal(domino.getPosition()).z * (1 / grid) + 0.5) / (1 / grid)

  return self.size - local_position * 5 - (self.size - 1) / 2
end

function Kingdom:getDominoColumn(domino)
  local zone = getObjectFromGUID(Guids.player_pieces[self.color].kingdom_zone)
  local local_position = math.floor(zone.positionToLocal(domino.getPosition()).x * (1 / grid) + 0.5) / (1 / grid)

  return local_position * 5 + (self.size - 1) / 2 + 1
end
