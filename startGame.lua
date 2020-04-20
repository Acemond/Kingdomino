local rightPositions = {
  {5.02, 3, -0.73},
  {5.02, 3, -0.73 - 2.18},
  {5.02, 3, -0.73 - 2.18 * 2},
  {5.02, 3, -0.73 - 2.18 * 3}
}
local kingTargetPositions = {
  {0.00, 1.92, -1.00},
  {0.00, 1.92, -3.00},
  {0.00, 1.92, -5.00},
  {0.00, 1.92, -7.00}
}

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
  if #getPlayingColors() < 2 then
    broadcastToAll("There should be at least two players to start a game", {r=1, g=0, b=0})
  else
    startGame()
  end
end

function destroyPlayersButtons()
  self.setState(2)
  destroyObjectIfExists("dfeee5")
  destroyObjectIfExists("a1ef12")
  destroyObjectIfExists("8d17b0")
  destroyObjectIfExists("fa1b7c")
  destroyObjectIfExists("f60fe5")
  destroyObjectIfExists("1b4b1a")
  destroyObjectIfExists("74e8b0")
  destroyObjectIfExists("1bbcb3")
  destroyObjectIfExists("46971b")
  destroyObjectIfExists("4f4db6")
  destroyObjectIfExists("8dfa00")
end

function destroyObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object ~= nil then
    destroyObject(object)
  end
end

function getPlayingColors()
  local currentlyPlayingPlayers = Global.get("currentyPlayingColors")

  local playingColors = {}
  for color, playing in pairs(currentlyPlayingPlayers) do
    if playing then table.insert(playingColors, color) end
  end
  return playingColors
end

function startGame()
  destroyPlayersButtons()
  local message = "Starting game with players: "
  for color, playing in pairs(Global.get("currentyPlayingColors")) do
    if playing then message = message .. color .. " " end
  end
  print(message)

  placeKings()
  placeTiles()
end

function placeKings()
  local kingsBag = getObjectFromGUID(Global.get("bagsGuid").kings)

  destroyNonPlayingKings(kingsBag)
  takeKings(kingsBag)
end

function takeKings(kingsBag)
  local playerPieces = Global.get("playerPieces")

  kingsBag.shuffle()
  local playingColors = getPlayingColors()

  if #playingColors == 2 then
    math.randomseed(os.time())
    local firstPlayerIndex = math.random(2)
    local firstPlayer = playerPieces[playingColors[firstPlayerIndex]]
    local otherPlayer = playerPieces[playingColors[3 - firstPlayerIndex]]

    kingsBag.takeObject({guid = firstPlayer.kings[1], position = kingTargetPositions[1], rotation = {0, 180, 0}})
    kingsBag.takeObject({guid = otherPlayer.kings[1], position = kingTargetPositions[2], rotation = {0, 180, 0}})
    kingsBag.takeObject({guid = otherPlayer.kings[2], position = kingTargetPositions[3], rotation = {0, 180, 0}})
    kingsBag.takeObject({guid = firstPlayer.kings[2], position = kingTargetPositions[4], rotation = {0, 180, 0}})
  else
    for i = 1, #playingColors, 1 do
      kingsBag.takeObject({position = kingTargetPositions[i], rotation = {0, 180, 0}})
    end
  end

  destroyObject(kingsBag)
end

function destroyNonPlayingKings(kingsBag)
  local playerColors = Global.get("playerColors")
  local playerPieces = Global.get("playerPieces")

  for _, color in pairs(playerColors) do
    local lowerColor = color:lower()
    if not Global.get("currentyPlayingColors")[lowerColor] then
      destroyObjectInBag(kingsBag, playerPieces[lowerColor].kings[1])
      destroyObjectInBag(kingsBag, playerPieces[lowerColor].kings[2])
      destroyObject(getObjectFromGUID(playerPieces[lowerColor].castle))
      destroyObject(getObjectFromGUID(playerPieces[lowerColor].castleTile))
    elseif #getPlayingColors() > 2 then
      destroyObjectInBag(kingsBag, playerPieces[color:lower()].kings[1])
    end
  end
end

function destroyObjectInBag(bag, guid)
  bag.takeObject({
    guid = guid,
    smooth = false,
    callback_function = function(obj) destroyObject(obj) end
  })
end

function placeTiles()
  local deck = Global.get("deck")
  local buildingsDeck = getObjectFromGUID(Global.get("buildingsDeckGuid"))

  deck.shuffle()

  local gameMode = Global.get("gameMode")
  if gameMode.kingdomino and not gameMode.queendomino then
    if #getPlayingColors() == 2 and not gameMode.advanced2p then
      takeTiles(deck, 2)
    elseif #getPlayingColors() == 3 then
      takeTiles(deck, 3)
    else
      takeTiles(deck, 4)
    end
  else
    takeTiles(deck, 4)
  end

  buildingsDeck.shuffle()
  placeBuildings(buildingsDeck)
end

function placeBuildings(buildingsDeck)
  local buildingZones = Global.get("buildingZones")
  for _, zoneGuid in pairs(buildingZones) do
    buildingsDeck.takeObject({ position = getObjectFromGUID(zoneGuid).getPosition() })
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
  local values = Global.get('tileValues')

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
