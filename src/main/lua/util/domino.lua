require("constants/guids")

DominoUtils = {}
DominoUtils.__index = DominoUtils

DominoUtils.orientations = {
  x = "x",
  x_reverse = "-x",
  z = "z",
  z_reverse = "-z",
}

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
  return table.contains(Guids.dominoes.kingdomino, object.guid)
      or table.contains(Guids.dominoes.queendomino, object.guid)
      or table.contains(Guids.dominoes.age_of_giants, object.guid)
end
