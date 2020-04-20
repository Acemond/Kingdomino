--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]
local playerColors = {"Red", "Orange", "Purple", "White"}
local playerPieces = {
  orange = {
    handZone = "96929a",
    castleTile = "9ab771",
    castle = "768b9c",
    kings = {"5ec087", "b28f70"}
  },
  purple = {
    handZone = "6ea086",
    castleTile = "7db35a",
    castle = "a1e204",
    kings = {"b95ebf", "8c2d1c"}
  },
  red = {
    handZone = "31279b",
    castleTile = "f6948c",
    castle = "ae130d",
    kings = {"fa1c74", "59fe79"}
  },
  white = {
    handZone = "f85ea1",
    castleTile = "537260",
    castle = "fd4160",
    kings = {"d2cd4e", "177138"}
  }
}
local buildingZones = {"b6d71a", "3b40dd", "51e2bf", "58ae27", "091f68", "372846"}
local bagsGuid = {
  kings = "1403b9",
  coin1 = "16b5c1",
  coin3 = "b9a9dd",
  coin9 = "9dce24",
  knight = "fe4062",
  tower = "45152b"
}
local currentyPlayingColors = {
  orange = false,
  purple = false,
  red = false,
  white = false,
}
local gameMode = {
  kingdomino = false,
  advanced2p = false,
  queendomino = true
}

local queendominoDeckGuid = "fadfa0"
local kingdominoDeckGuid = "0672d4"
local buildingsDeckGuid = "04de04"

--[[ The Update function. This is called once per frame. --]]
function update()
    --[[ print('Update loop!') --]]
end

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onLoad()
  Global.set('currentyPlayingColors', currentyPlayingColors)
  Global.set('deck', getObjectFromGUID(queendominoDeckGuid))
  Global.set('buildingsDeckGuid', buildingsDeckGuid)
  Global.set('gameMode', gameMode)
  Global.set('playerPieces', playerPieces)
  Global.set('playerColors', playerColors)
  Global.set('buildingZones', buildingZones)
  Global.set('bagsGuid', bagsGuid)
  Global.set('tileValues', assignTilesValue(deck))
end

function assignTilesValue(deck)
  local values = {}
  local tiles = deck.getObjects()
  for i = 1, #tiles, 1 do
    values[tiles[i].guid] = i
  end
  return values
end

function addPlayer(playerColor)
  print("Called addPlayer with")
  print(playerColor)
  buildCastle(playerColor)
  takeCoins(playerColor)

  currentyPlayingColors[playerColor] = true
end

function buildCastle(playerColor)
  local castle = getObjectFromGUID(playerPieces[playerColor].castle)
  local castleTile = getObjectFromGUID(playerPieces[playerColor].castleTile)
  castle.setPositionSmooth({castleTile.getPosition().x, 1.16, castleTile.getPosition().z}, false)
  castle.lock()
end

function takeCoins(playerColor)
  local handPosition = getObjectFromGUID(playerPieces[playerColor].handZone).getPosition()
  local coin1Bag = getObjectFromGUID(bagsGuid.coin1)
  local coin3Bag = getObjectFromGUID(bagsGuid.coin3)
  local knightBag = getObjectFromGUID(bagsGuid.knight)
  coin1Bag.takeObject({smooth = false, position = {handPosition.x + 2, handPosition.y, handPosition.z}})
  coin3Bag.takeObject({smooth = false, position = {handPosition.x + 1, handPosition.y, handPosition.z}})
  coin3Bag.takeObject({smooth = false, position = {handPosition.x, handPosition.y, handPosition.z}})
  knightBag.takeObject({smooth = false, position = {handPosition.x - 2, handPosition.y, handPosition.z}})
end

function removePlayer(playerColor)
  local playerPieces = playerPieces[playerColor]
  destroyCastle(playerColor, playerPieces)
  removeHandObjects(playerColor, playerPieces)

  currentyPlayingColors[playerColor] = false
end

function destroyCastle(playerColor, playerPieces)
  local castle = getObjectFromGUID(playerPieces.castle)
  local castleTile = getObjectFromGUID(playerPieces.castleTile)
  castle.setPositionSmooth({castleTile.getPosition().x, -1.5, castleTile.getPosition().z}, false)
  castle.lock()
end

function removeHandObjects(playerColor, playerPieces)
  local coin1Bag = getObjectFromGUID(bagsGuid.coin1)
  local coin3Bag = getObjectFromGUID(bagsGuid.coin3)
  local knightBag = getObjectFromGUID(bagsGuid.knight)
  local handZone = getObjectFromGUID(playerPieces.handZone)

  for _, obj in pairs(handZone.getObjects()) do
    if obj.getName() == "Coin (1)" then
      obj.setPosition({coin1Bag.getPosition().x, coin1Bag.getPosition().y + 2, coin1Bag.getPosition().z})
      coin1Bag.putObject(obj)
    elseif obj.getName() == "Coin (3)" then
      obj.setPosition({coin3Bag.getPosition().x, coin3Bag.getPosition().y + 2, coin3Bag.getPosition().z})
      coin3Bag.putObject(obj)
    elseif obj.getName() == "Knight" then
      obj.setPosition({knightBag.getPosition().x, knightBag.getPosition().y + 2, knightBag.getPosition().z})
      knightBag.putObject(obj)
    end
  end
end

function quickSetup(playerCount)
  for i = 1, playerCount, 1 do
    addPlayer(playerColors[i]:lower())
  end

  getObjectFromGUID("af7bb2").call("startGame")
end
