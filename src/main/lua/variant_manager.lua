local variants_visible = {
  two_players_advanced = true,
  three_players_variant = true,
  random_quests = true,
  kingdomino_xl = true,
  teamdomino = true,
}

local game_buttons_guid = {
  two_players_advanced = {
    enable = "823bca",
    disable = "02322f"
  },
  kingdomino_xl = {
    enable = "42f5a4",
    disable = "92f52d"
  },
  teamdomino = {
    enable = "83af19",
    disable = "355eca"
  }
}

local variant_interaction = {
  kingdomino_xl = { dependency = "kingdomino", incompatibilities = "queendomino" },
  teamdomino = { dependency = "kingdomino", incompatibilities = "queendomino" },
  two_players_advanced = { dependency = "kingdomino", incompatibilities = "queendomino" }
}

local deck_manager_guid = ""
local deck_manager = {}

function onLoad(save_state)
  deck_manager = getObjectFromGUID(deck_manager_guid)
  decks_visible = JSON.decode(save_state).variants_visible
end

function onSave()
  return JSON.encode({ variants_visible = variants_visible })
end

function checkInteractions(game_settings)
  local variants_to_hide = shouldHide(game_settings.decks, variant_interaction)
  local variants_to_show = shouldShow(game_settings.decks, variant_interaction)

  for variant_name, _ in pairs(variants_to_show) do
    if not isInKeys(variant_name, variants_to_hide) then
      variants_visible[variant_name] = true
      showObjects(game_buttons_guid[variant_name], true)
    end
  end
  for variant_name, _ in pairs(variants_to_hide) do
    variants_visible[variant_name] = false
    hideObjects(game_buttons_guid[variant_name])
  end
end

function showVariant(variant_name)
  showObjects(game_buttons_guid[variant_name], true)
end

function shouldHide(decks_enabled, interaction_table)
  local to_hide = {}
  for game_name, interactions in pairs(interaction_table) do
    for mode, enabled in pairs(decks_enabled) do
      if mode == interactions.incompatibilities and enabled
          or mode == interactions.dependency and not enabled then
        to_hide[game_name] = true
      end
    end
  end

  return to_hide
end

function shouldShow(decks_enabled, interaction_table)
  local to_show = {}
  for game_name, interactions in pairs(interaction_table) do
    if not variants_visible[game_name] then
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
