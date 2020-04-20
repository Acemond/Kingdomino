local rightPositions = {
  {5.02, 3, -0.73},
  {5.02, 3, -0.73 - 2.18},
  {5.02, 3, -0.73 - 2.18 * 2},
  {5.02, 3, -0.73 - 2.18 * 3}
}
local buildingsPositions = {
  {-5.94, 1.13, 13.94},
  {-3.73, 1.13, 13.94},
  {-1.52, 1.13, 13.94},
  {1.55, 1.13, 13.94},
  {3.77, 1.13, 13.94},
  {6.00, 1.13, 13.94},
  {8.24, 1.13, 13.94}
}
local buildingsDeckGuid = "04de04"

function onLoad()
  self.createButton({
    click_function = "onClick",
    function_owner = self,
    label          = "",
    position       = {0,0.05,0},
    color          = {0, 0, 0, 0},
    width          = 2400,
    height         = 600
  })
end

function onClick()
  self.clearButtons()
  startGame()
  self.setState(2)
end

function startGame()
  local deck = Global.getVar("deck")
  local buildingsDeck = getObjectFromGUID(buildingsDeckGuid)

  deck.shuffle()
  takeTiles(deck, 4)
  buildingsDeck.shuffle()
  placeBuildings(buildingsDeck)
end

function placeBuildings(buildingsDeck)
  for _, position in pairs(buildingsPositions) do
    buildingsDeck.takeObject({ position = position })
  end
end

function takeTiles(deck, count)
  local tiles = deck.getObjects()
  local guids = {}
  for i = 1, count, 1 do
    guids[i] = tiles[i].guid
  end

  local positions = getTilesPosition(guids)

  for guid, position in pairs(positions) do
    deck.takeObject({
      guid = guid,
      position = position,
      rotation = {0, 180, 180},
      callback_function = function(obj) obj.flip() end
    })
  end

  return guids
end

function getTilesPosition(guids)
  local values = Global.getVar('tileValues')

  local tilesByValue = {}
  local tileValues = {}
  for _, guid in ipairs(guids) do
    tileValue = values[guid]
    if tileValue ~= nil then
      tilesByValue[tileValue] = guid
      table.insert(tileValues, tileValue)
    end
  end
  table.sort(tileValues)

  local result = {}
  for i,obj in ipairs(tileValues) do
    result[tilesByValue[obj]] = rightPositions[i]
  end
  return result
end
