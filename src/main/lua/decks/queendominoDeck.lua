local tileValues = {}
local targetDealingPositions = {
  { 5.49, 1.83, -0.59 },
  { 5.50, 1.83, -3.06 },
  { 5.49, 1.83, -5.52 },
  { 5.47, 1.83, -7.98 },
  { 5.49, 1.83, -10.31 },
  { 5.49, 1.83, -12.72 },
  { 5.49, 1.83, -15.13 },
  { 5.49, 1.83, -17.55 }
}

function onLoad(save_state)
  if save_state ~= "" then
    tileValues = JSON.decode(save_state).tileValues
  else
    tileValues = assignTilesValue()
  end
end

function onSave()
  return JSON.encode({ tileValues = tileValues })
end

function assignTilesValue()
  local values = {}
  local tiles = self.getObjects()
  for i = 1, #tiles, 1 do
    values[tiles[i].guid] = i
  end
  return values
end

function dealTile(tileGuid, position)
  local guid = tileGuid
  if #self.getObjects() == 0 then
    guid = nil
  end

  self.takeObject({
    guid = guid,
    position = position,
    rotation = { 0, 180, 180 },
    callback_function = function(obj)
      obj.flip()
      Wait.condition(function()
        obj.lock()
      end, function()
        return obj.getPosition().y < 1.24
      end, 180, function()
        obj.lock()
      end)
    end
  })
end

function dealTiles()
  for guid, position in pairs(getTilesTargetPosition()) do
    dealTile(guid, position)
  end
end

function getTilesTargetPosition()
  local guids = getObjectsGuids()
  table.sort(guids, function(a, b)
    return tileValues[a] < tileValues[b]
  end)

  result = {}
  for i, guid in ipairs(guids) do
    result[guid] = targetDealingPositions[i]
  end
  return result
end

function getObjectsGuids()
  local tiles = self.getObjects()
  local guids = {}
  local tilesDealtPerTurn = 4
  if Global.getVar("board_size") == 8 then
    tilesDealtPerTurn = 8
  end
  for i = 1, tilesDealtPerTurn, 1 do
    guids[i] = tiles[i].guid
  end
  return guids
end
