local variants_visible = {
  two_players_advanced = true,
  three_players_variant = true,
  random_quests = true,
  kingdomino_xl = true,
  teamdomino = true,
}

local variant_buttons_guids = {
  enable = {
    two_players_advanced = "823bca",
    three_players_variant = "",
    randomn_quests = "75dcb1",
    kingdomino_xl = "42f5a4",
    teamdomino = "83af19"
  },
  disable = {
    two_players_advanced = "02322f",
    three_players_variant = "",
    randomn_quests = "edb838",
    kingdomino_xl = "92f52d",
    teamdomino = "355eca"
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
  if save_state ~= "" then
    variants_visible = JSON.decode(save_state).variants_visible
  end
  deck_manager = getObjectFromGUID(deck_manager_guid)
end

function onSave()
  return JSON.encode({ variants_visible = variants_visible })
end

function checkInteractions(decks_enabled)
  local variants_to_hide = shouldHide(decks_enabled, variant_interaction)
  local variants_to_show = shouldShow(decks_enabled, variant_interaction)

  for variant_name, _ in pairs(variants_to_show) do
    if not isInKeys(variant_name, variants_to_hide) then
      variants_visible[variant_name] = true
      showButtonIfExists(variant_buttons_guids.enable[variant_name])
      showButtonIfExists(variant_buttons_guids.disable[variant_name])
    end
  end
  for variant_name, _ in pairs(variants_to_hide) do
    variants_visible[variant_name] = false
    hideObjectIfExists(variant_buttons_guids.enable[variant_name])
    hideObjectIfExists(variant_buttons_guids.disable[variant_name])
    Global.call("setVariantEnabled", { variant_name = variant_name, is_enabled = false })
  end
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

function showButtonIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object == nil then
    return false
  end
  object.setPosition({ object.getPosition().x, 1.06, object.getPosition().z })
  if object.getButtons() then
    for _, button in pairs(object.getButtons()) do
      object.editButton({ index = button.index, scale = { 1, 1, 1 } })
    end
  end
  return true
end

function hideObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object == nil then
    return false
  end
  object.setPositionSmooth({ object.getPosition().x, -2.5, object.getPosition().z })
  object.lock()
  if object.getButtons() then
    for _, button in pairs(object.getButtons()) do
      object.editButton({ index = button.index, scale = { 0, 0, 0 } })
    end
  end
  return true
end

function isInKeys(key_to_test, list)
  for key, _ in pairs(list) do
    if key == key_to_test then
      return true
    end
  end
  return false
end
