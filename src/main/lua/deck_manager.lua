local decks_visible = {
  kingdomino = true,
  queendomino = true,
  age_of_giants = true,
  the_court = true,
}

local game_buttons_guid = {
  age_of_giants = {
    enable = "df1760",
    disable = "df1760"
  }
}

local deck_interaction = {
  age_of_giants = { dependency = "kingdomino", incompatibilities = nil },
}

function onLoad(save_state)
  decks_visible = JSON.decode(save_state).decks_visible
end

function onSave()
  return JSON.encode({ decks_visible = decks_visible })
end

function checkInteractions(decks_enabled)
  local decks_to_hide = shouldHide(decks_enabled, deck_interaction)
  local decks_to_show = shouldShow(decks_enabled, deck_interaction)

  for deck_name, _ in pairs(decks_to_hide) do
    if decks_visible[deck_name] then
      decks_visible[deck_name] = false
      disableDeck(deck_name)
      hideObjects(game_buttons_guid[deck_name])
    end
  end

  for deck_name, _ in pairs(decks_to_show) do
    if not decks_visible[deck_name] then
      decks_visible[deck_name] = true
      showObjects(game_buttons_guid[deck_name], true)
    end
  end
end

function enableDeck(gameName)
  decks_enabled[gameName] = true
  showObjects(game_objects_guid[gameName])

  checkInteractions()
  updateTileBoards()
end

function disableDeck(gameName)
  decks_enabled[gameName] = false
  hideObjects(game_objects_guid[gameName])

  checkInteractions()
  updateTileBoards()
end

function shouldHide(decks_enabled)
  local to_hide = {}
  for game_name, interactions in pairs(deck_interaction) do
    for mode, enabled in pairs(decks_enabled) do
      if mode == interactions.incompatibilities and enabled
          or mode == interactions.dependency and not enabled then
        to_hide[game_name] = true
      end
    end
  end

  return to_hide
end

function shouldShow(decks_enabled)
  local to_show = {}
  for game_name, interactions in pairs(deck_interaction) do
    if not decks_visible[game_name] then
      for mode, enabled in pairs(decks_enabled) do
        if mode == interactions.dependency and enabled
            or mode == interactions.incompatibilities and not enabled then
          to_show[game_name] = true
        end
      end
    end
  end

  return to_show
end

function showObjects(object_guids, is_button)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object and is_button then
      showButton(object)
      showObjectsButton(object)
    elseif object then
      showObject(object)
    end
  end
end

function hideObjects(object_guids)
  for _, guid in pairs(object_guids) do
    local object = getObjectFromGUID(guid)
    if object then
      hideObject(object)
      hideObjectsButton(object)
    end
  end
end

function hideObjectsButton(object)
  local buttons = object.getButtons()
  if buttons then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 0, 0, 0 } })
    end
  end
end

function showObjectsButton(object)
  local buttons = object.getButtons()
  if buttons then
    for _, button in pairs(buttons) do
      object.editButton({ index = button.index, scale = { 1, 1, 1 } })
    end
  end
end

function showObject(object)
  object.setPosition({ object.getPosition().x, 3, object.getPosition().z })
  object.unlock()
end

function showButton(object)
  object.setPosition({ object.getPosition().x, 1.06, object.getPosition().z })
  if object.getStateId() == 2 then
    object.setState(1)
  end
end

function hideObject(object)
  object.setPositionSmooth({ object.getPosition().x, -2.5, object.getPosition().z })
  object.lock()
end
