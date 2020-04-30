local castles = {
  Orange = "768b9c",
  Purple = "a1e204",
  Red = "ae130d",
  White = "fd4160",
  Green = "b5c1bc",
  Pink = "a407fb"
}
local castle_tile_positions = {
  White = { x = -21.00, z = -11.00 },
  Orange = { x = 21.00, z = -11.00 },
  Purple = { x = -21.00, z = 11.00 },
  Red = { x = 21.00, z = 11.00 },
  Green = { x = -31.00, z = 1.00 },
  Pink = { x = 31.00, z = -1.00 },
}
local castle_y_position = 1.16

local castle_animations = {}
function showCastle(seat_color)
  if castle_animations[seat_color] ~= nil then
    stopCastleAnimation(seat_color)
  end

  castleAnimationShow(seat_color)
end

function hideCastle(seat_color)
  if castle_animations[seat_color] ~= nil then
    stopCastleAnimation(seat_color)
  end

  castleAnimationHide(seat_color)
end

function stopCastleAnimation(seat_color)
  Wait.stop(castle_animations[seat_color])
  castle_animations[seat_color] = nil
end

function castleAnimationShow(seat_color)
  local castle = getObjectFromGUID(castles[seat_color])
  castle_animations[seat_color] = Wait.frames(function()
    castle.setPositionSmooth({
      castle_tile_positions[seat_color].x,
      castle_y_position,
      castle_tile_positions[seat_color].z
    })
    castle_animations[seat_color] = nil
  end, 25)
end

function castleAnimationHide(seat_color)
  local castle = getObjectFromGUID(castles[seat_color])
  castle.lock()
  castle.setPositionSmooth({ castle_tile_positions[seat_color].x, -0.8, castle_tile_positions[seat_color].z })
end
