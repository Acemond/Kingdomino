--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]
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
  queendomino = true,
  ageOfGiants = false,
  laCour = false
}
local kingdominoDeckGuid = "bb9861"
local queendominoDeckGuid = "fadfa0"
local ageOfGiantsDeckGuid = "fa3eea"
local questsDeckGuid = "13e2e1"
decks = {}

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
  queendomino = {
    queendominoDeckGuid,
    bagsGuid.coin1, bagsGuid.coin3, bagsGuid.coin9, bagsGuid.knight, bagsGuid.tower,
    buildingsDeckGuid, buildingsBoardGuids[1], buildingsBoardGuids[2],
    queenGuid, dragonGuid
  },
  ageOfGiants = {ageOfGiantsDeckGuid, questsDeckGuid, bagsGuid.giants},
  laCour = {laCourDeckGuid, laCourBoardGuid, bagsGuid.wheat, bagsGuid.sheep, bagsGuid.wood, bagsGuid.fish}
}
local gameDependency = {
  kingdomino = "ageOfGiants"
}
local gameButtons = {
  ageOfGiants = {"df1760", "6a25ff"}
}

--[[ The Update function. This is called once per frame. --]]
function update()
end

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onLoad()
  Global.set('currentyPlayingColors', currentyPlayingColors)
  Global.set('gameMode', gameMode)
  Global.set('buildingsDeck', getObjectFromGUID(buildingsDeckGuid))
  Global.set('laCourDeck', getObjectFromGUID(laCourDeckGuid))
  Global.set('playerPieces', playerPieces)
  Global.set('playerColors', playerColors)
  Global.set('gameObjects', gameObjects)
  Global.set('holderSize', holderSize)
  Global.set('hiddenBoards', hiddenBoards)

  decks["queendomino"] = getObjectFromGUID(queendominoDeckGuid)
  decks["kingdomino"] = getObjectFromGUID(kingdominoDeckGuid)
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
  elseif gameMode.kingdomino and gameMode.queendomino then
    broadcastToAll("Royal Wedding not implemented yet!", {r=1, g=0, b=0})
    return
  end

  if playerCount ~= targetPlayerCount then
    if targetPlayerCount == 2 then
      setPlayers({"red", "orange"}, {"purple", "white"})
    elseif targetPlayerCount == 3 then
      setPlayers({"red", "orange", "purple"}, {"white"})
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
  if gameDependency[gameName] then
    local dependencyName = gameDependency[gameName]
    showObjects(gameButtons[dependencyName])
    for _, guid in pairs(gameButtons[dependencyName]) do
      local button = getObjectFromGUID(guid)
      if button ~= nil then
        button.setPosition({button.getPosition().x, 1.06, button.getPosition().z})
        button.lock()
      end
    end
  end
  setTileBoards()
end

function showGameButton(gameName)
  for _, guid in pairs(gameButtons[gameName]) do
    local button = getObjectFromGUID(guid)
    obj.setPositionSmooth({obj.getPosition().x, -2.5, obj.getPosition().z})
  end
end

function disableDeck(gameName)
  gameMode[gameName] = false
  Global.set("gameMode", gameMode)
  hideObjects(gameObjects[gameName])
  if gameDependency[gameName] then
    local dependencyName = gameDependency[gameName]
    disableDeck(dependencyName)
    hideObjects(gameButtons[dependencyName])
  end
  setTileBoards()
end

function showObject(object)
  object.setPosition({object.getPosition().x, 3, object.getPosition().z})
  object.unlock()
end

function showObjects(objectGuids)
  for _, guid in pairs(objectGuids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      showObject(getObjectFromGUID(guid))
    end
  end
end

function hideObject(object)
  object.setPositionSmooth({object.getPosition().x, -2.5, object.getPosition().z})
  object.lock()
end

function hideObjects(objectGuids)
  for _, guid in pairs(objectGuids) do
    local object = getObjectFromGUID(guid)
    if object ~= nil then
      hideObject(getObjectFromGUID(guid))
    end
  end
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
  if playerCount == 2 and gameMode.ageOfGiants then
    return 5
  elseif playerCount == 2 then
    return 4
  elseif playerCount == 3 and not gameMode.queendomino and not gameMode.ageOfGiants then
    return 3
  elseif playerCount == 3 and not gameMode.ageOfGiants then
    return 4
  elseif playerCount == 3 then
    return 5
  elseif (playerCount == 4 or playerCount == 0) and not gameMode.ageOfGiants then
    return 4
  elseif (playerCount < 2 or allGameModesDisabled(gameMode)) then return 4
  else return 5 end
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
