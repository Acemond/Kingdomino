local error_color = { r = 1, g = 0, b = 0 }

function validate(game_settings)
  local variants = game_settings.variants
  local decks = game_settings.decks
  local player_count = game_settings.player_count
  if player_count < 2 then
    broadcastToAll("There should be at least two players to start a game", error_color)
    return false
  elseif player_count < 3 and decks.queendomino and decks.kingdomino then
    broadcastToAll("Royal Wedding requires at least 3 players", error_color)
    return false
  elseif variants.kingdomino_xl
      and (player_count == 2 or player_count > 4) then
    broadcastToAll("Kingdomino XL is for 3 to 4 players only", error_color)
    return false
  elseif not decks.kingdomino and not decks.queendomino then
    broadcastToAll("You should pick at least a deck to play", error_color)
    return false
  elseif player_count == 5 and not (
      decks.age_of_giants
          or (decks.queendomino and decks.kingdomino)) then
    broadcastToAll("You need to enable Age of Giants or both Kingdomino and Queendomino to play with 5 players", error_color)
    return false
  elseif player_count == 5 and decks.age_of_giants
      and decks.queendomino
      and decks.kingdomino then
    broadcastToAll("Royal Wedding not yet implemented for Age of Giants with 5 players", error_color)
    return false
  elseif player_count > 5 and not decks.queendomino and decks.kingdomino then
    broadcastToAll("You need to enable both Kingdomino and Queendomino to play with "
        .. tostring(player_count) .. " players", error_color)
    return false
  elseif player_count > 5 and decks.age_of_giants then
    broadcastToAll("Age of Giants is for 5 players or less", error_color)
    return false
  end
  return true
end