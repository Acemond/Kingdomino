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

function showCastle(player_color)
  if castle_animations[player_color] ~= nil then
    stopCastleAnimation(player_color)
  end

  castleAnimationShow(player_color)
end

function hideCastle(player_color)
  if castle_animations[player_color] ~= nil then
    stopCastleAnimation(player_color)
  end

  castleAnimationHide(player_color)
end

local castle_animations = {}

function stopCastleAnimation(player_color)
  Wait.stop(castle_animations[player_color])
  castle_animations[player_color] = nil
end

function castleAnimationShow(player_color)
  castle_animations[player_color] = Wait.frames(function()
    castle.setPositionSmooth({
      castle_tile_positions[player_color].x,
      castle_y_position,
      castle_tile_positions[player_color].z
    })
    castle_animations[player_color] = nil
  end, 25)
end

function castleAnimationHide(player_color)
  local castle = getObjectFromGUID(castles[player_color].castle)
  castle.lock()
  castle.setPositionSmooth({ castle_tile_positions[player_color].x, -0.8, castle_tile_positions[player_color].z })
end
