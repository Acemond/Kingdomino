local rightPositions = {
  {5.02, 3, -0.73},
  {5.02, 3, -0.73 - 2.18},
  {5.02, 3, -0.73 - 2.18 * 2},
  {5.02, 3, -0.73 - 2.18 * 3}
}
local rightZoneGuid = "358f4e"
local leftZoneGuid = "38ed1c"
local rightBoardGuid = "d3be34"
local leftBuildingsBoardGuid = "a066dc"
local rightBuildingsBoardGuid = "a77d62"

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
  nextTurn()
end

function nextTurn()
  local deck = Global.get("deck")

  if pcall(checkZones) then
    sendDragonBack()
    shiftBuildingsStack()
    moveZoneContents()

    if deck ~= nil then
      takeNextTurnTiles(deck)
    end
  end
end

function sendDragonBack()
  getObjectFromGUID("447c40").setPositionSmooth({-8.28, 1.23, 4.10})
  getObjectFromGUID("447c40").setRotationSmooth({0, 0, 0})
end

function shiftBuildingsStack()
  local buildingZones = Global.get("buildingZones")
  local zones = {}
  for _, zoneGuid in pairs(buildingZones) do
    table.insert(zones, getObjectFromGUID(zoneGuid))
  end

  for i = 1, #zones, 1 do
    if not buildingPresent(zones[i]) then
      local sourceIndex = getNextBuilding(zones, i, #zones)
      if not sourceIndex then
        drawBuilding(zones[i])
      else
        moveBuilding(zones[sourceIndex], zones[i])
      end
    end
  end
end

function drawBuilding(zone)
  local buildingsDeck = getObjectFromGUID(Global.get("buildingsDeckGuid"))
  buildingsDeck.takeObject({position = zone.getPosition()})
end

function buildingPresent(zone)
  local count = 0
  for _, obj in pairs(zone.getObjects()) do
    if not obj.isSmoothMoving() then
      count = count + 1
    end
  end
  return count > 1
end

function getNextBuilding(zones, cursor, max)
  if buildingPresent(zones[cursor]) then
    return cursor
  elseif cursor == max then
    return false
  else
    return getNextBuilding(zones, cursor + 1, max)
  end
end

function moveBuilding(sourceZone, destinationZone)
  for _,obj in ipairs(sourceZone.getObjects()) do
    if obj.guid ~= leftBuildingsBoardGuid and obj.guid ~= rightBuildingsBoardGuid then
      obj.setPositionSmooth(destinationZone.getPosition(), false)
    end
  end
end

function checkZones()
  checkRightZone()
  checkLeftZone()
end

function checkRightZone()
  local gameMode = Global.get("gameMode")

  local expectedObjectsCount = 0
  if gameMode.kingdomino and not gameMode.queendomino then
    if #getPlayingColors() == 2 and not gameMode.advanced2p then
      expectedObjectsCount = 5
    elseif #getPlayingColors() == 3 then
      expectedObjectsCount = 7
    else
      expectedObjectsCount = 9
    end
  elseif #getPlayingColors() == 2 then
    expectedObjectsCount = 7
  elseif #getPlayingColors() == 3 then
    expectedObjectsCount = 8
  elseif #getPlayingColors() == 4 then
    expectedObjectsCount = 9
  end

  if #getObjectFromGUID(rightZoneGuid).getObjects() < expectedObjectsCount then
    broadcastToAll("Pick dominos before clicking Next Turn", {r=1, g=0, b=0})
    error()
  end
end

function checkLeftZone()
  local gameMode = Global.get("gameMode")

  local expectedObjects = 1
  if gameMode.queendomino and #getPlayingColors() == 3 then
    expectedObjectsCount = 2
  end

  if #getObjectFromGUID(leftZoneGuid).getObjects() > expectedObjects then
    broadcastToAll("Clear left dominos before clicking Next Turn", {r=1, g=0, b=0})
    error()
  end
end

function moveZoneContents()
  local rightZone = getObjectFromGUID(rightZoneGuid)
  for _,obj in ipairs(rightZone.getObjects()) do
    if obj.guid ~= rightBoardGuid then
      current_position = obj.getPosition()
      obj.setPositionSmooth({
        current_position.x - 10,
        current_position.y + 2,
        current_position.z
      }, false)
    end
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

function takeNextTurnTiles(deck)
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
end

function takeTiles(deck, count)
  local tiles = deck.getObjects()
  local guids = {}
  for i = 1, count, 1 do
    guids[i] = tiles[i].guid
  end

  local positions = getTilesPosition(guids)
  for guid, position in pairs(positions) do
    if #deck.getObjects() ~= 0 then
      deck.takeObject({
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
  for i, obj in ipairs(tileValues) do
    result[tilesByValue[obj]] = rightPositions[i]
  end
  return result
end
