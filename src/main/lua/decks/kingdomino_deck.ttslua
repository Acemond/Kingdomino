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
local trashBagGuid = "32278a"

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

function cutDeck(size)
  if size < #self.getObjects() then
    self.cut(#self.getObjects() - size)[2].destroy()
  end
end

function trashTile(tileGuid, position)
  self.takeObject({
    guid = tileGuid,
    position = position,
    rotation = { 0, 180, 180 },
    callback_function = moveToTrash
  })
end

function moveToTrash(tile)
  local trashBag = getObjectFromGUID(trashBagGuid)
  trashBag.putObject(tile)
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
  local game = Global.getTable("game")

  for index, guid in pairs(getSortedTilesValue()) do
    if game.settings.decks.age_of_giants then
      if game.settings.player_count == 3 and (index == 2 or index == 4) then
        trashTile(guid, targetDealingPositions[index])
      elseif game.settings.decks.age_of_giants
          and (game.settings.player_count == 2 or game.settings.player_count == 4) and index == 3 then
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
  table.sort(guids, function(a, b)
    return tileValues[a] < tileValues[b]
  end)
  return guids
end

function getObjectsGuids()
  local tiles = self.getObjects()
  local guids = {}
  for i = 1, Global.getTable("game").settings.tile_deal_count, 1 do
    guids[i] = tiles[i].guid
  end
  return guids
end

function mergeDeck(deck)
  addTilesValues(deck.getTable("tiles_value"))
  deck.setInvisibleTo({ "Black", "Grey", "Red", "Orange", "Purple", "White", "Pink", "Green" })
  self.putObject(deck)
end

function addTilesValues(tileValuesToAdd)
  for guid, value in pairs(tileValuesToAdd) do
    tileValues[guid] = value
  end
end
