local kingTargetPositions = {
  { 0.00, 1.92, -1.00 },
  { 0.00, 1.92, -3.00 },
  { 0.00, 1.92, -5.00 },
  { 0.00, 1.92, -7.00 },
  { 0.00, 1.92, -9.00 },
  { 0.00, 1.92, -11.00 }
}

local player_pieces_guids = {
  Orange = {
    castle_tile = "9ab771",
    castle = "768b9c",
    kings = { "4d2d92", "5e6289" }
  },
  Purple = {
    castle_tile = "7db35a",
    castle = "a1e204",
    kings = { "7dd59a", "e44a70" }
  },
  Red = {
    castle_tile = "f6948c",
    castle = "ae130d",
    kings = { "24345c", "2837e9" }
  },
  White = {
    castle_tile = "537260",
    castle = "fd4160",
    kings = { "86f4c2", "61259d" }
  },
  Green = {
    castle_tile = "8c9612",
    castle = "b5c1bc",
    kings = { "526c31", "f2cd83" }
  },
  Pink = {
    castle_tile = "a5aad1",
    castle = "a407fb",
    kings = { "9dc643", "0dba70" }
  }
}


function placeKings(game_settings)
  destroyNonPlayingKings(game_settings)
  takeKings(game_settings)
end

function takeKings(game_settings)
  self.shuffle()

  if game_settings.player_count == 2 then
    math.randomseed(os.time())
    local firstPlayerIndex = math.random(2)
    local colors = getTableKeys(game_settings.seated_players)
    local firstPlayer = player_pieces_guids[colors[firstPlayerIndex]]
    local otherPlayer = player_pieces_guids[colors[3 - firstPlayerIndex]]

    self.takeObject({ guid = firstPlayer.kings[1], position = kingTargetPositions[1], rotation = { 0, 180, 0 } })
    self.takeObject({ guid = otherPlayer.kings[1], position = kingTargetPositions[2], rotation = { 0, 180, 0 } })
    self.takeObject({ guid = otherPlayer.kings[2], position = kingTargetPositions[3], rotation = { 0, 180, 0 } })
    self.takeObject({ guid = firstPlayer.kings[2], position = kingTargetPositions[4], rotation = { 0, 180, 0 } })
  else
    for i = 1, game_settings.player_count, 1 do
      self.takeObject({ position = kingTargetPositions[i], rotation = { 0, 180, 0 } })
    end
  end

  self.destroy()
end

function getTableKeys(seated_players)
  local colors = {}
  for color, is_seated in pairs(seated_players) do
    if is_seated then
      table.insert(colors, color)
    end
  end
  return colors
end

function destroyNonPlayingKings(game_settings)
  for color, playing in pairs(game_settings.seated_players) do
    if not playing then
      destroyObjectInBag(self, player_pieces_guids[color].kings[1])
      destroyObjectInBag(self, player_pieces_guids[color].kings[2])
      getObjectFromGUID(player_pieces_guids[color].castle).destroy()
      getObjectFromGUID(player_pieces_guids[color].castle_tile).destroy()
    elseif game_settings.player_count > 2 then
      destroyObjectInBag(self, player_pieces_guids[color].kings[1])
    end
  end
end

function destroyObjectInBag(bag, guid)
  bag.takeObject({
    guid = guid,
    smooth = false,
    callback_function = function(obj)
      obj.destroy()
    end
  })
end