local tileValues = {}
local targetDealingPositions = {
  {5.49, 1.83, -0.59},
  {5.50, 1.83, -3.06},
  {5.49, 1.83, -5.52},
  {5.47, 1.83, -7.98},
  {5.49, 1.83, -10.44}
}
local advanced2pEnabled = false

function onLoad()
  tileValues = assignTilesValue()

  if not Global.get('gameMode').kingdomino then
    self.setPosition({self.getPosition().x, 0.5, self.getPosition().z})
  end
end

function addTilesValues(tileValuesToAdd)
  for guid, value in pairs(tileValuesToAdd) do
    tileValues[guid] = value
  end
end

function limitSize()
  local playerCount = Global.get("playerCount")
  local gameMode = Global.get("gameMode")

  local deckSize = 48
  if gameMode.ageOfGiants then
    deckSize = deckSize + 12
  end

  if playerCount == 2 and not advanced2pEnabled then
    cutDeck(deckSize / 2)
  elseif playerCount == 3 then
    cutDeck(deckSize * 3 / 4)
  end
end

function cutDeck(size)
  if size < #self.getObjects() then
    self.cut(#self.getObjects() - size)[2].destroy()
  end
end

function assignTilesValue()
  local values = {}
  local tiles = self.getObjects()
  for i = 1, #tiles, 1 do
    values[tiles[i].guid] = i
  end
  return values
end

function dealTiles()
  for guid, position in pairs(getTilesTargetPosition()) do
    if #self.getObjects() ~= 0 then
      self.takeObject({
        guid = guid,
        position = position,
        rotation = {0, 180, 0}
      })
    else
      Wait.frames(function() 
        getObjectFromGUID(guid).setPositionSmooth(position, false)
        getObjectFromGUID(guid).setRotationSmooth({0, 180, 0}, false)
      end, 1)
    end
  end
end

function getTilesTargetPosition()
  local guids = getObjectsGuids()
  table.sort(guids, function(a, b) return tileValues[a] < tileValues[b] end)

  result = {}
  for i, guid in ipairs(guids) do
    result[guid] = targetDealingPositions[i]
  end
  return result
end

function getObjectsGuids()
  local tiles = self.getObjects()
  local guids = {}
  for i = 1, Global.get("holderSize"), 1 do
    guids[i] = tiles[i].guid
  end
  return guids
end
