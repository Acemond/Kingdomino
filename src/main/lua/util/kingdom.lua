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
  kingdom.map = {}
end

function Kingdom:addDomino(domino)
  addNormalizedDomino(domino, getDominoLine(domino), getDominoColumn(domino))
end

function addNormalizedDomino(domino, line, column)
  local zone = Guids.player_pieces[color].kingdom_zone
  local orientation = DominoUtils.getOrientation(domino.getRotation().y - zone.getRotation().y)

  if orientation == DominoUtils.orientations.x then
    self.map[line][column - 0.5] = domino[1]
    self.map[line][column + 0.5] = domino[2]
  elseif orientation == DominoUtils.orientations.x_reverse then
    self.map[line][column - 0.5] = domino[2]
    self.map[line][column + 0.5] = domino[1]
  elseif orientation == DominoUtils.orientations.z then
    self.map[line - 0.5][column] = domino[1]
    self.map[line + 0.5][column] = domino[2]
  else
    self.map[line - 0.5][column] = domino[2]
    self.map[line + 0.5][column] = domino[1]
  end
end

function Kingdom:getScore()
  computeScore(self.map)
end

function getDominoLine(domino)
  local zone = Guids.player_pieces[color].kingdom_zone
  return zone.positionToLocal(domino.getPosition()).x * 5 + (self.size - 1) / 2 + 1
end

function getDominoColumn(domino)
  local zone = Guids.player_pieces[color].kingdom_zone
  return self.size - zone.positionToLocal(domino.getPosition()).z * 5 + (self.size - 1) / 2
end
