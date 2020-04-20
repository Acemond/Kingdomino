local rightPositions = {
  {5.02, 3, -0.73},
  {5.02, 3, -0.73 - 2.18},
  {5.02, 3, -0.73 - 2.18 * 2},
  {5.02, 3, -0.73 - 2.18 * 3}
}
local rightZoneGuid = "358f4e"
local leftZoneGuid = "38ed1c"
local rightBoardGuid = "d3be34"

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
  local deck = Global.getVar("deck")

  if pcall(checkZones) then
    moveZoneContents()
    deck.shuffle()
    takeTiles(deck, 4)
  end
end

function checkZones()
  if #getObjectFromGUID(rightZoneGuid).getObjects() <= 8 then
    broadcastToAll("Pick dominos before clicking Next Turn", {r=1, g=0, b=0})
    error()
  end
  if #getObjectFromGUID(leftZoneGuid).getObjects() > 1 then
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
