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
local y_position = 1.16
local hidden_y_position = -0.8

local castle_animations = {}
function showCastle(seat_color)
  local position = {
    castle_tile_positions[seat_color].x,
    y_position,
    castle_tile_positions[seat_color].z
  }
  animateCastle(seat_color, position, 25)
end

function hideCastle(seat_color)
  local position = {
    castle_tile_positions[seat_color].x,
    hidden_y_position,
    castle_tile_positions[seat_color].z
  }

  animateCastle(seat_color, position, 0)
end

function moveCastle(parameters)
  animateCastle(parameters.seat_color, parameters.position)
end

function stopAnimation(seat_color)
  Wait.stop(castle_animations[seat_color])
  castle_animations[seat_color] = nil
end

function animateCastle(seat_color, new_position, delay)
  if castle_animations[seat_color] ~= nil then
    stopAnimation(seat_color)
  end

  local castle = getObjectFromGUID(castles[seat_color])

  if delay == nil or delay == 0 then
    castle.lock()
    castle.setPositionSmooth(new_position)
  else
    castle_animations[seat_color] = Wait.frames(function()
      castle.lock()
      castle.setPositionSmooth(new_position)
      castle_animations[seat_color] = nil
    end, delay)
  end
end
