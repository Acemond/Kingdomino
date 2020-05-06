local variant_visible = {
  two_players_advanced = true,
  three_players_variant = false,
  random_quests = true,
  kingdomino_xl = true,
}
local variant_enabled = {
  two_players_advanced = false,
  three_players_variant = true,
  random_quests = false,
  kingdomino_xl = false,
}

local variant_buttons_guids = {
  enable = {
    two_players_advanced = "823bca",
    three_players_variant = "",
    randomn_quests = "75dcb1",
    kingdomino_xl = "42f5a4",
  },
  disable = {
    two_players_advanced = "02322f",
    three_players_variant = "",
    randomn_quests = "edb838",
    kingdomino_xl = "92f52d",
  }
}

local variant_interaction = {
  kingdomino_xl = { dependency = "kingdomino", incompatibility = "queendomino" },
  two_players_advanced = { dependency = "kingdomino", incompatibility = "queendomino" }
}

local deck_manager_guid = "180cbc"
local deck_manager = {}

function onUpdate()
  checkInteractions()
  updateButtonsState()
end

function onLoad(save_state)
  deck_manager = getObjectFromGUID(deck_manager_guid)
  if save_state ~= "" then
    loadSaveState(save_state)
  end
  Global.setTable("variant_enabled", variant_enabled)
end

function loadSaveState(save_state)
  variant_visible = JSON.decode(save_state).variant_visible
  variant_enabled = JSON.decode(save_state).variant_enabled
end

function onSave()
  return JSON.encode({
    variant_visible = variant_visible,
    variant_enabled = variant_enabled
  })
end

function setVariantEnabled(parameters)
  variant_enabled[parameters.variant_name] = parameters.is_enabled
  Global.setTable("variant_enabled", variant_enabled)
end

function checkInteractions()
  for variant_name, interaction in pairs(variant_interaction) do
    if checkDependency(interaction) and checkIncompatibility(interaction) then
      showButtonIfExists(variant_buttons_guids.enable[variant_name])
      showButtonIfExists(variant_buttons_guids.disable[variant_name])
      variant_visible[variant_name] = true
    else
      hideObjectIfExists(variant_buttons_guids.enable[variant_name])
      hideObjectIfExists(variant_buttons_guids.disable[variant_name])
      variant_visible[variant_name] = false
      setVariantEnabled { variant_name = variant_name, is_enabled = false }
    end
  end
end

function checkIncompatibility(interaction)
  local deck_enabled = Global.getTable("deck_enabled")
  for deck, is_enabled in pairs(deck_enabled) do
    if deck == interaction.incompatibility and is_enabled then
      return false
    end
  end
  return true
end

function checkDependency(interaction)
  local deck_enabled = Global.getTable("deck_enabled")
  for deck, is_enabled in pairs(deck_enabled) do
    if deck == interaction.dependency and not is_enabled then
      return false
    end
  end
  return true
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

function updateButtonsState()
  for variant_name, visible in pairs(variant_visible) do
    if visible and variant_enabled[variant_name] then
      local button_enable = getObjectFromGUID(variant_buttons_guids.enable[variant_name])
      if button_enable ~= nil and button_enable.getStateId() == 1 then
        button_enable.setState(2)
      end
    elseif visible and not variant_enabled[variant_name] then
      local button_disable = getObjectFromGUID(variant_buttons_guids.disable[variant_name])
      if button_disable ~= nil and button_disable.getStateId() == 2 then
        button_disable.setState(1)
      end
    end
  end
end
