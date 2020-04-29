local left_control_zone_guid = "38ed1c"
local right_control_zone_guid = "358f4e"

local board_visible_y_position = 1.06
local board_hidden_y_position = 0

local right_boards_infos = {
  nil, -- size 1
  nil, -- size 2
  { guid = "e5b23a", position = { 5.50, 1.06, -3.01 } }, -- size 3
  { guid = "7a72d1", position = { 5.50, 1.06, -4.21 } }, -- size 4
  { guid = "174390", position = { 5.50, 1.06, -5.50 } }, -- size 5
  nil, -- size 6
  nil, -- size 7
  { guid = "722967", position = { 5.50, 1.06, -9 } } -- size 8
}

local left_boards_infos = {
  nil, -- size 1
  nil, -- size 2
  { guid = "ae485e", position = { -5.50, 1.06, -3.01 } }, -- size 3
  { guid = "bd95f5", position = { -5.50, 1.06, -4.21 } }, -- size 4
  { guid = "8c018b", position = { -5.50, 1.06, -5.50 } }, -- size 5
  nil, -- size 6
  nil, -- size 7
  { guid = "a391ea", position = { -5.50, 1.06, -9 } }, -- size 8
}

local zone_coordinates_modifiers = {
  nil, -- size 1
  nil, -- size 2
  { zPos = -3, zScale = 8.25 }, -- size 3
  { zPos = -4.25, zScale = 10.5 }, -- size 4
  { zPos = -5.5, zScale = 13.5 }, -- size 5
  nil,
  nil,
  { zPos = -9, zScale = 20 },
}

function updateTileBoards(board_size)
  setBoardYPosition(board_size, board_visible_y_position)

  for size, _ in pairs(right_boards_infos) do
    if size ~= board_size then
      setBoardYPosition(size, board_hidden_y_position)
    end
  end
  resizeControlZones(board_size)
end


function setBoardYPosition(board_size, y_position)
  local leftBoard = getObjectFromGUID(left_boards_infos[board_size].guid)
  local rightBoard = getObjectFromGUID(right_boards_infos[board_size].guid)

  leftBoard.setPositionSmooth({ leftBoard.getPosition().x, y_position, leftBoard.getPosition().z }, false, true)
  rightBoard.setPositionSmooth({ rightBoard.getPosition().x, y_position, rightBoard.getPosition().z }, false, true)
end


function resizeControlZones(slots)
  resizeControlZone(getObjectFromGUID(right_control_zone_guid), slots)
  resizeControlZone(getObjectFromGUID(left_control_zone_guid), slots)
end


function resizeControlZone(zone, slots)
  zone.setScale({ zone.getScale().x, zone.getScale().y, zone_coordinates_modifiers[slots].zScale })
  zone.setPosition({ zone.getPosition().x, zone.getPosition().y, zone_coordinates_modifiers[slots].zPos })
end

