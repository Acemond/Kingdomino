local tiles_value

function onLoad(save_state)
  if save_state ~= "" then
    tiles_value = JSON.decode(save_state).tiles_value
  else
    tiles_value = assignTilesValue()
  end
  self.setTable("tiles_value", tiles_value)
end

function onSave()
  return JSON.encode({ tiles_value = tiles_value })
end

function assignTilesValue()
  local values = {}
  local tiles = self.getObjects()
  startValue = -6
  for i = 1, 6, 1 do
    values[tiles[i].guid] = startValue
    startValue = startValue + 1
  end

  startValue = 49
  for i = 7, #tiles, 1 do
    values[tiles[i].guid] = startValue
    startValue = startValue + 1
  end
  return values
end
