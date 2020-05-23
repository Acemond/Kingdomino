require("constants/guids")

DominoUtils = {}
DominoUtils.__index = DominoUtils

DominoUtils.orientations = {
  x = "x",
  x_reverse = "-x",
  z = "z",
  z_reverse = "-z",
}

local deck_names = {
  kingdomino = "Kingdomino",
  queendomino = "Queendomino",
  age_of_giants = "Age of Giants",
}

function DominoUtils.getDominoName(deck_name, position)
  return deck_names[deck_name] .. ": " .. position
end

function DominoUtils.getOrientation(raw_rotation)
  local rotation = DominoUtils.boundRotation(raw_rotation)

  if rotation >= -45 and rotation < 45 then
    return DominoUtils.orientations.x_reverse
  elseif rotation >= 45 and rotation < 135 then
    return DominoUtils.orientations.z
  elseif (rotation >= 135 and rotation <= 180) or (rotation >= -180 and rotation < -135) then
    return DominoUtils.orientations.x
  else
    return DominoUtils.orientations.z_reverse
  end
end

function DominoUtils.boundRotation(rotation_value)
  local result = rotation_value

  while result > 180 do
    result = result - 360
  end
  while result <= -180 do
    result = result + 360
  end

  return result
end

function DominoUtils.isDomino(object)
  return deck_names[DominoUtils.getDominoDeck(object)] ~= nil
end

function DominoUtils.getDominoDeck(object)
  for deck_name, _ in string.gmatch(object.getName(), "([%w%s*]+): (-?%d+)") do
    return table.indexOf(deck_names, deck_name)
  end
end

function DominoUtils.getDominoValueFromName(name)
  for _, v in string.gmatch(name, "(%w+): (-?%d+)") do
    return tonumber(v)
  end
end
