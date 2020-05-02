local castles = {
  Orange = "768b9c",
  Purple = "a1e204",
  Red = "ae130d",
  White = "fd4160",
  Green = "b5c1bc",
  Pink = "a407fb"
}

local castle_positions = {
  White = {
    position = { x = -21.00, y = 1.16, z = -11.00 },
    yaw = 0 },
  Orange = {
    position = { x = 21.00, y = 1.16, z = -11.00 },
    yaw = 0 },
  Purple = {
    position = { x = -21.00, y = 1.16, z = 11.00 },
    yaw = 180 },
  Red = {
    position = { x = 21.00, y = 1.16, z = 11.00 },
    yaw = 180 },
  Green = {
    position = { x = -31.00, y = 1.16, z = 1.00 },
    yaw = 90 },
  Pink = {
    position = { x = 31.00, y = 1.16, z = -1.00 },
    yaw = 270 }
}

local y_position = 1.16
local hidden_y_position = -0.8

local castle_animations = {}

function onPlayerChangeColor(player_color)
  if castle_positions[player_color] and not Global.getVar("quick_setup") then
    Player[player_color].lookAt({
      position = castle_positions[player_color].position,
      pitch = 45,
      yaw = castle_positions[player_color].yaw,
      distance = 30,
    })
  end
end

function showCastle(seat_color)
  local position = {
    castle_positions[seat_color].position.x,
    y_position,
    castle_positions[seat_color].position.z
  }
  animateCastle(seat_color, position, 25)
end

function hideCastle(seat_color)
  local position = {
    castle_positions[seat_color].position.x,
    hidden_y_position,
    castle_positions[seat_color].position.z
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
