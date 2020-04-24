--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]
local fourTilesForThreePlayers = true
local playerColors = {"Red", "Orange", "Purple", "White"}
local playerPieces = {
  orange = {
    handZone = "96929a",
    castleTile = "9ab771",
    castle = "768b9c",
    kings = {"4d2d92", "5e6289"}
  },
  purple = {
    handZone = "6ea086",
    castleTile = "7db35a",
    castle = "a1e204",
    kings = {"7dd59a", "e44a70"}
  },
  red = {
    handZone = "31279b",
    castleTile = "f6948c",
    castle = "ae130d",
    kings = {"24345c", "2837e9"}
  },
  white = {
    handZone = "f85ea1",
    castleTile = "537260",
    castle = "fd4160",
    kings = {"86f4c2", "61259d"}
  }
}
local currentyPlayingColors = {
  orange = false,
  purple = false,
  red = false,
  white = false,
}
local playerCount = 0
local gameMode = {
  kingdomino = false,
  twoPlayersAdvanced = false,
  queendomino = true,
  ageOfGiants = false,
  laCour = false
}
local kingdominoDeckGuid = "b972db"
local queendominoDeckGuid = "b12f86"
local ageOfGiantsDeckGuid = "d36a20"
local questsDeckGuid = "01da2c"

local buildingsDeckGuid = "04de04"
local startGameButtonGuid = "af7bb2"

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

local queenGuid = "401270"
local dragonGuid = "447c40"
local buildingsBoardGuids = {"a77d62", "a066dc"}

local laCourBoardGuid = "d19b4c"
local laCourDeckGuid = "e0b7ee"

local rightBoardsInfos = {}
rightBoardsInfos[3] = {guid = "e5b23a", position = {5.50, 1.06, -3.01}}
rightBoardsInfos[4] = {guid = "7a72d1", position = {5.50, 1.06, -4.21}}
rightBoardsInfos[5] = {guid = "174390", position = {5.50, 1.06, -5.50}}

local leftBoardsInfos = {}
leftBoardsInfos[3] = {guid = "ae485e", position = {-5.50, 1.06, -3.01}}
leftBoardsInfos[4] = {guid = "bd95f5", position = {-5.50, 1.06, -3.01}}
leftBoardsInfos[5] = {guid = "8c018b", position = {-5.50, 1.06, -5.50}}
local hiddenBoards = {"e5b23a", "174390", "ae485e", "8c018b"}

local zoneCoordinatesModifiers = {}
zoneCoordinatesModifiers[3] = {zPos = -3, zScale = 8.25}
zoneCoordinatesModifiers[4] = {zPos = -4.25, zScale = 10.5}
zoneCoordinatesModifiers[5] = {zPos = -5.5, zScale = 13.5}

local holderSize = 4
local leftZoneGuid = "38ed1c"
local rightZoneGuid = "358f4e"

local gameObjects = {
  kingdomino = {kingdominoDeckGuid},
  twoPlayersAdvanced = {},
  queendomino = {
    queendominoDeckGuid,
    bagsGuid.coin1, bagsGuid.coin3, bagsGuid.coin9, bagsGuid.knight, bagsGuid.tower,
    buildingsDeckGuid, buildingsBoardGuids[1], buildingsBoardGuids[2],
    queenGuid, dragonGuid
  },
  ageOfGiants = {ageOfGiantsDeckGuid, bagsGuid.giants},
  laCour = {laCourDeckGuid, laCourBoardGuid, bagsGuid.wheat, bagsGuid.sheep, bagsGuid.wood, bagsGuid.fish}
}
local gameDependency = {
  kingdomino = {"twoPlayersAdvanced", "ageOfGiants"}
}
local gameButtons = {
  ageOfGiants = {"df1760", "6a25ff"},
  twoPlayersAdvanced = {"823bca", "02322f"}
}

local tableGuid = "0f8757"
-- useless hidden objects used to keep button textures in memory
local decoyButtons = {"9bb39a", "3416fc", "2a0d3f", "25ef05", "d78ce4", "25bfc4", "29ae89", "6ce2c6", "31bd66", "5740ca", "180cbc", "2c055b", "28fcc5"}
local notInteractableObjects = {
  questsDeckGuid,
  "6a25ff", "df1760", ageOfGiantsDeckGuid,  -- age of giants buttons and deck
  "04de04", queendominoDeckGuid, "d64709", "69cbda", "a77d62", "a066dc",  -- queen
  kingdominoDeckGuid, "697d5b", "9f4a39", "823bca", "02322f",  -- king
  laCourDeckGuid, "2c22ed", "6ff70f", "d19b4c",  -- the court
  "af7bb2", "4a6126", "46971b", "4f4db6", "8dfa00", -- game buttons
  "7a72d1", "bd95f5", "174390", "8c018b", "e5b23a", "ae485e", -- tile boards
  "1403b9"  -- kings bag
}

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onLoad()
  Player["White"].lookAt({
      position = {x=0,y=0,z=-18},
      pitch    = 55,
      yaw      = 0,
      distance = 30,
  })

  Global.set('currentyPlayingColors', currentyPlayingColors)
  Global.set('gameMode', gameMode)
  Global.set('buildingsDeck', getObjectFromGUID(buildingsDeckGuid))
  Global.set('laCourDeck', getObjectFromGUID(laCourDeckGuid))
  Global.set('playerPieces', playerPieces)
  Global.set('playerColors', playerColors)
  Global.set('gameObjects', gameObjects)
  Global.set('holderSize', holderSize)
  Global.set('hiddenBoards', hiddenBoards)

  broadcastToAll("Please add players and press Start Game", {r=1, g=1, b=1})
  broadcastToAll("Welcome to Kingdomino!", {r=1, g=1, b=1})

  getObjectFromGUID(tableGuid).interactable = false
  freezeNonInteractables(decoyButtons)
  freezeNonInteractables(notInteractableObjects)
  Wait.frames(function () hideObjectsButton(getObjectFromGUID(gameButtons.ageOfGiants[1])) end, 1)
  Wait.frames(function () hideObjectsButton(getObjectFromGUID(gameButtons.twoPlayersAdvanced[1])) end, 1)
end

function freezeNonInteractables(guids)
  for _, guid in pairs(guids) do
    obj = getObjectFromGUID(guid)
    if obj ~= nil then
       obj.interactable = false
       obj.tooltip = false
    end
  end
end

function addPlayer(playerColor)
  buildCastle(playerColor)

  currentyPlayingColors[playerColor] = true
  playerCount = getPlayerCount()

  Global.set("playerCount", playerCount)
  Global.set("currentyPlayingColors", currentyPlayingColors)
  setTileBoards()
end

function getPlayerCount()
  count = 0
  for color, value in pairs(currentyPlayingColors) do
    if value then count = count + 1 end
  end
  return count
end

function buildCastle(playerColor)
  local castle = getObjectFromGUID(playerPieces[playerColor].castle)
  local castleTile = getObjectFromGUID(playerPieces[playerColor].castleTile)
  castle.setPositionSmooth({castleTile.getPosition().x, 1.16, castleTile.getPosition().z}, false)
  castle.lock()
end

function removePlayer(playerColor)
  local playerPieces = playerPieces[playerColor]
  destroyCastle(playerColor)

  currentyPlayingColors[playerColor] = false
  playerCount = getPlayerCount()

  Global.set("playerCount", playerCount)
  Global.set("currentyPlayingColors", currentyPlayingColors)
  setTileBoards()
end

function setPlayers(playerTable, notPlaying)
  for _, color in pairs(playerTable) do
    buildCastle(color)
    currentyPlayingColors[color] = true
  end
  for _, color in pairs(notPlaying) do
    destroyCastle(color)
    currentyPlayingColors[color] = false
  end

  playerCount = getPlayerCount()
  Global.set("playerCount", playerCount)
  Global.set("currentyPlayingColors", currentyPlayingColors)
  setTileBoards()
end

function destroyCastle(playerColor)
  local castle = getObjectFromGUID(playerPieces[playerColor].castle)
  local castleTile = getObjectFromGUID(playerPieces[playerColor].castleTile)
  castle.setPositionSmooth({castleTile.getPosition().x, -1.5, castleTile.getPosition().z}, false)
  castle.lock()
end

function quickSetup(targetPlayerCount)
  if not gameMode.kingdomino and not gameMode.queendomino then
    broadcastToAll("You should pick at least a deck to play", {r=1, g=0, b=0})
    return
  end

  if playerCount ~= targetPlayerCount then
    if targetPlayerCount == 2 then
      setPlayers({"white", "orange"}, {"purple", "red"})
    elseif targetPlayerCount == 3 then
      setPlayers({"white", "orange", "purple"}, {"red"})
    else
      setPlayers({"red", "orange", "purple", "white"}, {})
    end
  end

  getObjectFromGUID(startGameButtonGuid).call("startGame")
end

function enableDeck(gameName)
  gameMode[gameName] = true
  Global.set("gameMode", gameMode)
  showObjects(gameObjects[gameName])
  if gameDependency[gameName] and #gameDependency[gameName] > 0 then
    for _, dependencyName in pairs(gameDependency[gameName]) do
      showObjects(gameButtons[dependencyName])
      for _, guid in pairs(gameButtons[dependencyName]) do
        local button = getObjectFromGUID(guid)
        if button ~= nil then
          button.setPosition({button.getPosition().x, 1.06, button.getPosition().z})
          button.lock()
          if button.getStateId() == 2 then button.setState(1) end
        end
      end
    end
  end
  setTileBoards()
end

function disableDeck(gameName)
  gameMode[gameName] = false
  Global.set("gameMode", gameMode)
  hideObjects(gameObjects[gameName])

  if gameDependency[gameName] then
    for _, dependencyName in pairs(gameDependency[gameName]) do
      disableDeck(dependencyName)
      hideObjects(gameButtons[dependencyName])
    end
  end
  setTileBoards()
end

function showObjects(objectGuids)
  for _, guid in pairs(objectGuids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      showObject(object)
      showObjectsButton(object)
    end
  end
end

function hideObjects(objectGuids)
  for _, guid in pairs(objectGuids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      hideObject(object)
      hideObjectsButton(object)
    end
  end
end

function hideObjectsButton(object)
  local buttons = object.getButtons()
  if buttons ~= nil then
    for _, button in pairs(buttons) do
      object.editButton({index = button.index, scale = {0, 0, 0}})
    end
  end
end

function showObjectsButton(object)
  local buttons = object.getButtons()
  if buttons ~= nil then
    for _, button in pairs(buttons) do
      object.editButton({index = button.index, scale = {1, 1, 1}})
    end
  end
end

function showObject(object)
  object.setPosition({object.getPosition().x, 3, object.getPosition().z})
  object.unlock()
end

function hideObject(object)
  object.setPositionSmooth({object.getPosition().x, -2.5, object.getPosition().z})
  object.lock()
end

function setTileBoards()
  local targetSize = getBoardSize(gameMode, playerCount)
  Global.set("holderSize", targetSize)
  showTilesBoard(targetSize)
  hiddenBoards = {}
  for size, _ in pairs(rightBoardsInfos) do
    if size ~= targetSize then
      hideTilesBoard(size)
    end
  end
  resizeControlZones(targetSize)
  Global.set("hiddenBoards", hiddenBoards)
end

function hideTilesBoard(boardNumber)
  table.insert(hiddenBoards, leftBoardsInfos[boardNumber].guid)
  table.insert(hiddenBoards, rightBoardsInfos[boardNumber].guid)
  local leftBoard = getObjectFromGUID(leftBoardsInfos[boardNumber].guid)
  local rightBoard = getObjectFromGUID(rightBoardsInfos[boardNumber].guid)

  leftBoard.setPositionSmooth({leftBoard.getPosition().x, 0, leftBoard.getPosition().z}, false, true)
  rightBoard.setPositionSmooth({rightBoard.getPosition().x, 0, rightBoard.getPosition().z}, false, true)
end

function showTilesBoard(boardNumber)
  local leftBoard = getObjectFromGUID(leftBoardsInfos[boardNumber].guid)
  local rightBoard = getObjectFromGUID(rightBoardsInfos[boardNumber].guid)

  leftBoard.setPositionSmooth({leftBoard.getPosition().x, 1.06, leftBoard.getPosition().z}, false, true)
  rightBoard.setPositionSmooth({rightBoard.getPosition().x, 1.06, rightBoard.getPosition().z}, false, true)
end

function getBoardSize(gameMode, playerCount)
  if gameMode.ageOfGiants then
    return 5
  elseif playerCount == 3 and not gameMode.queendomino and not fourTilesForThreePlayers then
    return 3
  else
    return 4
  end
end

function allGameModesDisabled(gameMode)
  for _, enabled in pairs(gameMode) do
    if enabled then return false end
  end
  return true
end

function resizeControlZones(slots)
  resizeControlZone(getObjectFromGUID(rightZoneGuid), slots)
  resizeControlZone(getObjectFromGUID(leftZoneGuid), slots)
end

function resizeControlZone(zone, slots)
  zone.setScale({zone.getScale().x, zone.getScale().y, zoneCoordinatesModifiers[slots].zScale})
  zone.setPosition({zone.getPosition().x, zone.getPosition().y, zoneCoordinatesModifiers[slots].zPos})
end
