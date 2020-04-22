local tileValues = {}

function onLoad()
  tileValues = assignTilesValue()

  if not Global.get('gameMode').ageOfGiants then
    self.setPosition({self.getPosition().x, 0.5, self.getPosition().z})
  end
end

function assignTilesValue()
  local values = {}
  local tiles = self.getObjects()
  startValue = -6
  for i = 1, 6, 1 do
    values[tiles[i].guid] = startValue
    startValue = startValue + 1
  end

  startValue = 49
  for i = 7, #tiles, 1 do
    values[tiles[i].guid] = startValue
    startValue = startValue + 1
  end
  return values
end

function mergeValuesTableWith(deck)
  deck.call("addTilesValues", tileValues)
end
