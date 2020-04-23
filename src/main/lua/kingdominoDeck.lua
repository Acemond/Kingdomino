local tileValues = {}
local targetDealingPositions = {
  {5.49, 1.83, -0.59},
  {5.50, 1.83, -3.06},
  {5.49, 1.83, -5.52},
  {5.47, 1.83, -7.98},
  {5.49, 1.83, -10.44}
}
local trashBagGuid = "32278a"

function onLoad()
  tileValues = assignTilesValue()
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

  if playerCount == 2 and not gameMode.twoPlayersAdvanced then
    cutDeck(deckSize / 2)
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

function trashTile(tileGuid, position)
  self.takeObject({
    guid = tileGuid,
    position = position,
    rotation = {0, 180, 0},
    callback_function = moveToTrash
  })
end

function moveToTrash(tile)
  local trashBag = getObjectFromGUID(trashBagGuid)
  trashBag.putObject(tile)
end

function dealTile(tileGuid, position)
  if #self.getObjects() ~= 0 then
    self.takeObject({
      guid = tileGuid,
      position = position,
      rotation = {0, 180, 0}
    })
  else
    Wait.frames(function() 
      getObjectFromGUID(tileGuid).setPositionSmooth(position, false)
      getObjectFromGUID(tileGuid).setRotationSmooth({0, 180, 0}, false)
    end, 1)
  end
end

function dealTiles()
  local gameMode = Global.get("gameMode")
  local playerCount = Global.get("playerCount")

  for index, guid in pairs(getSortedTilesValue()) do
    if gameMode.ageOfGiants then
      if playerCount == 3 and (index == 2 or index == 4) then
        trashTile(guid, targetDealingPositions[index])
      elseif gameMode.ageOfGiants and (playerCount == 2 or playerCount > 3) and index == 3 then
        trashTile(guid, targetDealingPositions[index])
      else
        dealTile(guid, targetDealingPositions[index])
      end
    else
      dealTile(guid, targetDealingPositions[index])
    end
  end
end

function getSortedTilesValue()
  local guids = getObjectsGuids()
  table.sort(guids, function(a, b) return tileValues[a] < tileValues[b] end)
  return guids
end

function getObjectsGuids()
  local tiles = self.getObjects()
  local guids = {}
  for i = 1, Global.get("holderSize"), 1 do
    guids[i] = tiles[i].guid
  end
  return guids
end
