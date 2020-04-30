local deck_button_visible = {
  kingdomino = true,
  queendomino = true,
  age_of_giants = true,
  the_court = true,
}
local deck_enabled = {
  kingdomino = true,
  queendomino = false,
  age_of_giants = false,
  the_court = false,
}

local deck_buttons_guids = {
  enable = {
    kingdomino = "9f4a39",
    queendomino = "69cbda",
    age_of_giants = "df1760",
    the_court = "6ff70f"
  },
  disable = {
    kingdomino = "697d5b",
    queendomino = "d64709",
    age_of_giants = "6a25ff",
    the_court = "2c22ed"
  }
}

local deck_interaction = {
  age_of_giants = { dependency = "kingdomino", incompatibilities = nil },
}

local deck_objects_guid = {
  kingdomino = {
    deck = "b972db"
  },
  queendomino = {
    deck = "b12f86",
    buildings = "04de04",
    building_board = "a066dc",
    right_building_board = "a77d62",
    coin1_bag = "38e164",
    coin3_bag = "8468e9",
    coin9_bag = "4638c0",
    knight_bag = "fe4062",
    tower_bag = "45152b",
    queen = "401270",
    dragon = "447c40"
  },
  age_of_giants = {
    deck = "d36a20",
    giants_bag = "da9688"
  },
  the_court = {
    buildings = "e0b7ee",
    building_board = "d19b4c",
    wheat_bag = "68a4e4",
    sheep_bag = "98f12a",
    wood_bag = "443d34",
    fish_bag = "3725a9"
  }
}

function onLoad(save_state)
  --if save_state ~= "" then
  --  deck_button_visible = JSON.decode(save_state).decks_visible
  --  deck_enabled = JSON.decode(save_state).deck_enabled
  --end
  self.setTable("deck_enabled", deck_enabled)
end

function onSave()
  return JSON.encode({
    decks_visible = deck_button_visible,
    deck_enabled = deck_enabled
  })
end

function setDeckEnabled(parameters)
  deck_enabled[parameters.deck_name] = parameters.is_enabled
  self.setTable("deck_enabled", deck_enabled)
  if parameters.is_enabled then
    showDeck(parameters.deck_name)
  else
    hideDeck(parameters.deck_name)
  end
  checkInteractions()
end

function checkInteractions()
  local buttons_to_hide = shouldHideDeckButton()
  local buttons_to_show = shouldShowButtons()

  for deck_name, _ in pairs(buttons_to_show) do
    if not isInKeys(deck_name, buttons_to_hide) then
      deck_button_visible[deck_name] = true
      showButtonIfExists(deck_buttons_guids.enable[deck_name])
      showButtonIfExists(deck_buttons_guids.disable[deck_name])
    end
  end
  for deck_name, _ in pairs(buttons_to_hide) do
    deck_button_visible[deck_name] = false
    hideObjectIfExists(deck_buttons_guids.enable[deck_name])
    hideObjectIfExists(deck_buttons_guids.disable[deck_name])
    if deck_enabled[deck_name] then
      --Global.call("setDeckEnabled", { deck_name = deck_name, is_enabled = false })
    end
  end
end

function shouldHideDeckButton()
  local to_hide = {}
  for game_name, interactions in pairs(deck_interaction) do
    for mode, enabled in pairs(deck_enabled) do
      if mode == interactions.incompatibilities and enabled
          or mode == interactions.dependency and not enabled then
        to_hide[game_name] = true
      end
    end
  end

  return to_hide
end

function shouldShowButtons()
  local to_show = {}
  for game_name, interactions in pairs(deck_interaction) do
    if not deck_button_visible[game_name] then
      for mode, enabled in pairs(deck_enabled) do
        if mode == interactions.dependency and enabled
            or mode == interactions.incompatibilities and not enabled then
          to_show[game_name] = true
        end
      end
    end
  end

  return to_show
end

function hideDeck(deck_name)
  for _, guid in pairs(deck_objects_guid[deck_name]) do
    hideObjectIfExists(guid)
  end
end

function showDeck(deck_name)
  for _, guid in pairs(deck_objects_guid[deck_name]) do
    showObjectIfExists(guid)
  end
end

function showButtonIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object == nil then
    return
  end
  object.setPosition({ object.getPosition().x, 1.06, object.getPosition().z })
  if object.getButtons() then
    for _, button in pairs(object.getButtons()) do
      object.editButton({ index = button.index, scale = { 1, 1, 1 } })
    end
  end
end

function showObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object == nil then
    return
  end
  object.setPosition({ object.getPosition().x, 3, object.getPosition().z })
  object.unlock()
end

function hideObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object == nil then
    return
  end
  object.setPositionSmooth({ object.getPosition().x, -2.5, object.getPosition().z })
  object.lock()
  if object.getButtons() then
    for _, button in pairs(object.getButtons()) do
      object.editButton({ index = button.index, scale = { 0, 0, 0 } })
    end
  end
end

function isInKeys(key_to_test, list)
  for key, _ in pairs(list) do
    if key == key_to_test then
      return true
    end
  end
  return false
end
