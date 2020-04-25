local kingTargetPositions = {
  {0.00, 1.92, -1.00},
  {0.00, 1.92, -3.00},
  {0.00, 1.92, -5.00},
  {0.00, 1.92, -7.00}
}
local queendominoDeckButtonGuid = "69cbda"
local kingdominoDeckButtonGuid = "9f4a39"
local queendominoDeckGuid = "b12f86"
local kingdominoDeckGuid = "b972db"
local laCourDeckGuid = "e0b7ee"
local laCourBoardGuid = "d19b4c"
local ageOfGiantsDeckGuid = "d36a20"
local questsDeckGuid = "01da2c"

local queenGuid = "401270"
local buildingsBoardGuids = {"a77d62", "a066dc"}
local buildingsDeckGuid = "04de04"
local dragonGuid = "447c40"
local bagsGuid = {
  kings = "1403b9",
  coin1 = "38e164",
  coin3 = "8468e9",
  coin9 = "4638c0",
  knight = "fe4062",
  tower = "45152b",

  giants = "da9688",

  wheat = "68a4e4",
  sheep = "98f12a",
  wood = "443d34",
  fish = "3725a9"
}
local buttonsToRemove = {
  removeRed = "dfeee5",
  addRed = "a1ef12",
  removeOrange = "fa1b7c",
  addOrange = "8d17b0",
  removeWhite = "74e8b0",
  addWhite = "f60fe5",
  removePurple = "1bbcb3",
  addPurple = "1b4b1a",
  quickGame2p = "46971b",
  quickGame3p = "4f4db6",
  quickGame4p = "8dfa00",
  laCourEnable = "6ff70f",
  laCourDisable = "2c22ed",
  kingdominoEnable = "9f4a39",
  kingdominoDisable = "697d5b",
  queendominoEnable = "69cbda",
  queendominoDisable = "d64709",
  ageOfGiantsEnable = "df1760",
  ageOfGiantsDisable = "6a25ff",
  twoPlayersAdvancedEnable = "823bca",
  twoPlayersAdvancedDisable = "02322f"
}
local trashbagGuid = "32278a"
local objectsToLock = {
  queendominoDeckGuid, kingdominoDeckGuid, buildingsDeckGuid,
  buildingsBoardGuids[1], buildingsBoardGuids[2], laCourBoardGuid,
  bagsGuid.coin1, bagsGuid.coin3, bagsGuid.coin9, bagsGuid.knight, bagsGuid.tower,
  bagsGuid.wheat, bagsGuid.sheep, bagsGuid.wood, bagsGuid.fish
}

local mainDeckPosition = {0.00, 1.24, -23.00}
local twoDecksPositions = {{-3.00, 1.24, -23.00}, {3.00, 1.24, -23.00}}
local buildingsDeckPosition = {-5.88, 1.25, 4.05}
local laCourDeckPosition = {-3.67, 1.22, 8.04}
local questPositions = {
  {-3.00, 1.03, -20.00},
  {3.00, 1.03, -20.00}
}
local defaultQuests = {"e29f53", "e865f4"}

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
  elseif not Global.get("gameMode").kingdomino and not Global.get("gameMode").queendomino then
    broadcastToAll("You should pick at least a deck to play", {r=1, g=0, b=0})
  else
    startGame()
  end
end

function destroyObjectsIfExists(guids)
  for _, guid in pairs(guids) do
    destroyObjectIfExists(guid)
  end
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
  self.setState(2)
  destroyObjectsIfExists(buttonsToRemove)
  destroyObjectsIfExists(Global.get("hiddenBoards"))
  placeKings()
  
  local gameMode = Global.get("gameMode")
  dealQuests(gameMode)
  if gameMode.ageOfGiants then
    setupAgeOfGiants()
  end
  if gameMode.laCour then
    setupLaCour()
  end

  if gameMode.queendomino and gameMode.kingdomino then
    setupRoyalWedding(twoDecksPositions)
    getObjectFromGUID(queendominoDeckGuid).call("dealTiles")
  elseif gameMode.queendomino then
    setupQueendomino(mainDeckPosition)
    getObjectFromGUID(queendominoDeckGuid).call("dealTiles")
  elseif gameMode.kingdomino then
    setupKingdomino(mainDeckPosition)
    getObjectFromGUID(kingdominoDeckGuid).call("dealTiles")
  end

  for gameName, state in pairs(gameMode) do
    if not state then
      destroyGamePieces(gameName)
    end
  end

  lockExistingObjects(objectsToLock)
end

function dealQuests(gameMode)
  local questsDeck = getObjectFromGUID(questsDeckGuid)
  if gameMode.ageOfGiants then
    questsDeck.shuffle()
    questsDeck.takeObject({position = questPositions[1], callback_function = function(obj) obj.lock() end})
    questsDeck.takeObject({position = questPositions[2], callback_function = function(obj) obj.lock() end})
  else
    questsDeck.takeObject({guid = defaultQuests[1], position = questPositions[1], callback_function = function(obj) obj.lock() end})
    questsDeck.takeObject({guid = defaultQuests[2], position = questPositions[2], callback_function = function(obj) obj.lock() end})
  end
  
  questsDeck.destroy()
end

function lockExistingObjects(objectGuids)
  for _, guid in pairs(objectGuids) do
    local obj = getObjectFromGUID(guid)
    if obj ~= nil then
      obj.lock()
    end
  end
end

function setupQueendomino(deckPosition)
  for _, color in pairs(getPlayingColors()) do
    takeCoins(color)
  end

  local queendominoDeck = getObjectFromGUID(queendominoDeckGuid)
  queendominoDeck.setPositionSmooth(deckPosition)
  queendominoDeck.shuffle()
  Global.setTable("decks", {queendominoDeck})

  local buildingsDeck = getObjectFromGUID(buildingsDeckGuid)
  buildingsDeck.setPositionSmooth(buildingsDeckPosition)
  buildingsDeck.shuffle()
  buildingsDeck.interactable = true
  buildingsDeck.call("dealBuildings")
end

function takeCoins(playerColor)
  local handPosition = getObjectFromGUID(Global.get("playerPieces")[playerColor].handZone).getPosition()
  local coin1Bag = getObjectFromGUID(bagsGuid.coin1)
  local coin3Bag = getObjectFromGUID(bagsGuid.coin3)
  local knightBag = getObjectFromGUID(bagsGuid.knight)
  coin1Bag.takeObject({smooth = false, position = {handPosition.x + 2, handPosition.y, handPosition.z}})
  coin3Bag.takeObject({smooth = false, position = {handPosition.x + 1, handPosition.y, handPosition.z}})
  coin3Bag.takeObject({smooth = false, position = {handPosition.x, handPosition.y, handPosition.z}})
  knightBag.takeObject({smooth = false, position = {handPosition.x - 2, handPosition.y, handPosition.z}})
end

function setupLaCour()
  laCourDeck = getObjectFromGUID(laCourDeckGuid)
  laCourDeck.setPositionSmooth(laCourDeckPosition)
  laCourDeck.shuffle()
  laCourDeck.interactable = true
  laCourDeck.tooltip = true
  laCourDeck.call("dealBuildings")
end

function setupAgeOfGiants()
  kingdominoDeck = getObjectFromGUID(kingdominoDeckGuid)
  ageOfGiantsDeck = getObjectFromGUID(ageOfGiantsDeckGuid)
  ageOfGiantsDeck.call("mergeValuesTableWith", kingdominoDeck)
  ageOfGiantsDeck.setInvisibleTo({"Black", "Red", "Orange", "Purple", "White"})
  kingdominoDeck.putObject(ageOfGiantsDeck)
end

function setupKingdomino(deckPosition)
  kingdominoDeck = getObjectFromGUID(kingdominoDeckGuid)
  kingdominoDeck.setPositionSmooth(deckPosition)
  kingdominoDeck.shuffle()
  kingdominoDeck.call("limitSize")
  Global.setTable("decks", {kingdominoDeck})
end

function destroyGamePieces(gameName)
  local gameObjects = Global.get("gameObjects")

  for _, guid in pairs(gameObjects[gameName]) do
    destroyObject(getObjectFromGUID(guid))
  end
end

function setupRoyalWedding(decksPositions)
  setupKingdomino(decksPositions[1])
  setupQueendomino(decksPositions[2])
  Global.setTable("decks", {
    getObjectFromGUID(kingdominoDeckGuid),
    getObjectFromGUID(queendominoDeckGuid)
  })
end

function placeKings()
  local kingsBag = getObjectFromGUID(bagsGuid.kings)

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
