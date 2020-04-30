local deck_button_accessible = {
  kingdomino = true,
  queendomino = true,
  age_of_giants = true,
  the_court = true,
}
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
local deck_visible = {
  kingdomino = true,
  queendomino = false,
  age_of_giants = true,
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
  age_of_giants = { dependency = "kingdomino", incompatibility = nil },
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

function onUpdate()
  checkInteractions()
  updateDeckVisible()
  updateButtonVisible()
  updateButtonsState()
end

function onLoad(save_state)
  --if save_state ~= "" then
  --  deck_button_visible = JSON.decode(save_state).decks_visible
  --  deck_enabled = JSON.decode(save_state).deck_enabled
  --end
  self.setTable("deck_enabled", deck_enabled)
end

function onSave()
  return JSON.encode({
    deck_button_accessible = deck_button_accessible,
    deck_button_visible = deck_button_visible,
    deck_enabled = deck_enabled,
    deck_visible = deck_visible
  })
end

function setDeckEnabled(parameters)
  deck_enabled[parameters.deck_name] = parameters.is_enabled
  self.setTable("deck_enabled", deck_enabled)
end

function checkInteractions()
  for deck_name, interaction in pairs(deck_interaction) do
    if checkDependency(interaction) and checkIncompatibility(interaction) then
      deck_button_accessible[deck_name] = true
    else
      -- FIXME: dirty fix to wait for state switch
      --Wait.frames(function() deck_button_accessible[deck_name] = false end, 1)
      deck_button_accessible[deck_name] = false
      if deck_enabled[deck_name] then
        setDeckEnabled({ deck_name = deck_name, is_enabled = false })
      end
    end
  end
end

function checkIncompatibility(interaction)
  for other_deck, is_enabled in pairs(deck_enabled) do
    if other_deck == interaction.incompatibility and is_enabled then
      return false
    end
  end
  return true
end

function checkDependency(interaction)
  for other_deck, is_enabled in pairs(deck_enabled) do
    if other_deck == interaction.dependency and not is_enabled then
      return false
    end
  end
  return true
end

function isOtherDeckConflicting(deck_name, other_deck, other_deck_enabled)
  return other_deck == deck_interaction[deck_name].incompatibility and other_deck_enabled
      or other_deck == deck_interaction[deck_name].dependency and not other_deck_enabled
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
  object.lock()
  object.setPositionSmooth({ object.getPosition().x, -2.5, object.getPosition().z })
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

function updateButtonVisible()
  for deck_name, should_be_accessible in pairs(deck_button_accessible) do
    if should_be_accessible and not deck_button_visible[deck_name] then
      showButtonIfExists(deck_buttons_guids.enable[deck_name])
      showButtonIfExists(deck_buttons_guids.disable[deck_name])
      deck_button_visible[deck_name] = true
    elseif not should_be_accessible and deck_button_visible[deck_name] then
      hideObjectIfExists(deck_buttons_guids.enable[deck_name])
      hideObjectIfExists(deck_buttons_guids.disable[deck_name])
      deck_button_visible[deck_name] = false
    end
  end
end

function updateDeckVisible()
  for deck_name, should_be_visible in pairs(deck_enabled) do
    if should_be_visible and not deck_visible[deck_name] then
      deck_visible[deck_name] = true
      showDeck(deck_name)
    elseif not should_be_visible and deck_visible[deck_name] then
      deck_visible[deck_name] = false
      hideDeck(deck_name)
    end
  end
end

function updateButtonsState()
  for deck_name, should_be_accessible in pairs(deck_button_accessible) do
    if should_be_accessible then
      if deck_enabled[deck_name] then
        local button_enable = getObjectFromGUID(deck_buttons_guids.enable[deck_name])
        if button_enable ~= nil and button_enable.getStateId() == 1 then
          button_enable.setState(2)
        end
      else
        local button_disable = getObjectFromGUID(deck_buttons_guids.disable[deck_name])
        if button_disable ~= nil and button_disable.getStateId() == 2 then
          button_disable.setState(1)
        end
      end
    end
  end
end
