-- useless hidden objects used to keep button textures in memory
local decoyButtons = { "9bb39a", "3416fc", "2a0d3f", "25ef05", "d78ce4", "25bfc4", "29ae89", "6ce2c6", "31bd66",
                       "5740ca", "180cbc", "2c055b", "28fcc5", "5aebb9", "536275", "eb1dfc", "3853c3", "bb8090",
                       "59253d", "02c925", "093a20" }

-- Decks
local kingdomino_deck_guid = "b972db"
local queendomino_deck_guid = "b12f86"
local age_of_giants_deck_guid = "d36a20"
local quests_deck_guid = "fd8a62"
local buildingsDeckGuid = "04de04"

local start_button_guid = "af7bb2"

local the_court_deck_guid = "e0b7ee"
local non_interactable_guids = {
  quests_deck_guid,
  "6a25ff", "df1760", age_of_giants_deck_guid, -- age of giants buttons and deck
  buildingsDeckGuid, queendomino_deck_guid, "d64709", "69cbda", "a77d62", "a066dc", -- queen
  kingdomino_deck_guid, "697d5b", "9f4a39", "823bca", "02322f", -- king
  the_court_deck_guid, "2c22ed", "6ff70f", "d19b4c", -- the court
  start_button_guid, "31971b", "4a6126", "46971b", "4f4db6", "8dfa00", "1765aa", "6c37eb", -- game buttons
  "7a72d1", "bd95f5", "174390", "8c018b", "e5b23a", "ae485e", "a391ea", "722967", -- tile boards
  "1403b9", -- kings bag
  "75dcb1", "edb838", "42f5a4", "92f52d" --[[, "83af19", "355eca"]] -- variants buttons
}
local temporarily_frozen = {
  "b972db", -- king
  "b12f86", "04de04", "38e164", "8468e9", "4638c0", "fe4062", "45152b", "401270", "447c40", -- queen
  "da9688", -- aog
  "e0b7ee", "68a4e4", "98f12a", "443d34", "3725a9"  -- the_court
}

local buttons_to_remove = {
  player_add_red = "a1ef12",
  player_add_orange = "8d17b0",
  player_add_white = "f60fe5",
  player_add_purple = "1b4b1a",
  player_add_green = "fbeaba",
  player_add_pink = "6987e6",
  player_remove_red = "dfeee5",
  player_remove_orange = "fa1b7c",
  player_remove_white = "74e8b0",
  player_remove_purple = "1bbcb3",
  player_remove_green = "8fedd0",
  player_remove_pink = "668a0a",
  quick_setup = "31971b",
  quick_setup_2p = "46971b",
  quick_setup_3p = "4f4db6",
  quick_setup_4p = "8dfa00",
  quick_setup_5p = "1765aa",
  quick_setup_6p = "6c37eb",
  the_court_enable = "6ff70f",
  the_court_disable = "2c22ed",
  kingdomino_enable = "9f4a39",
  kingdomino_disable = "697d5b",
  queendomino_enable = "69cbda",
  queendomino_disable = "d64709",
  age_of_giants_enable = "df1760",
  age_of_giants_disable = "6a25ff",
  two_players_advanced_enable = "823bca",
  two_players_advanced_disable = "02322f",
  randomn_quests_enable = "75dcb1",
  randomn_quests_disable = "edb838",
  kingdomino_xl_enable = "42f5a4",
  kingdomino_xl_disable = "92f52d",
  teamdomino_enable = "83af19",
  teamdomino_disable = "355eca",
  local_players_enable = "4f044d",
  local_players_disable = "d1e47c"
}

local objects_to_lock = {
  kingdomino_deck = "b972db",
  queendomino_deck = "b12f86",
  queendomino_buildings = "04de04",
  queendomino_building_board = "a066dc",
  queendomino_right_building_board = "a77d62",
  queendomino_coin1_bag = "38e164",
  queendomino_coin3_bag = "8468e9",
  queendomino_coin9_bag = "4638c0",
  queendomino_knight_bag = "fe4062",
  queendomino_tower_bag = "45152b",
  the_court_building_board = "d19b4c",
  the_court_wheat_bag = "68a4e4",
  the_court_sheep_bag = "98f12a",
  the_court_wood_bag = "443d34",
  the_court_fish_bag = "3725a9"
}

local frozen = true

function onLoad(save_state)
  if save_state ~= "" then
    frozen = JSON.decode(save_state).frozen
  else
    frozen = false
  end

  self.interactable = false
  updateFreezeState(decoyButtons, frozen)
  updateFreezeState(non_interactable_guids, frozen)
  updateFreezeState(temporarily_frozen, frozen)
end

function onSave()
  --return JSON.encode({ frozen = frozen })
end

function updateFreezeState(guids)
  for _, guid in pairs(guids) do
    obj = getObjectFromGUID(guid)
    if obj then
      obj.interactable = not frozen
    end
  end
end

function prepareTableForGame()
  frozen = false
  updateFreezeState(temporarily_frozen)
  Wait.frames(function()
    destroyObjectsIfExists(buttons_to_remove)
  end, 1)
  Wait.frames(function()
    lockObjectsIfExists(objects_to_lock)
  end, 60)
end

function destroyObjectsIfExists(guids)
  for _, guid in pairs(guids) do
    destroyObjectIfExists(guid)
  end
end

function destroyObjectIfExists(guid)
  local object = getObjectFromGUID(guid)
  if object then
    object.destroy()
  end
end

function lockObjectsIfExists(guids)
  for _, guid in pairs(guids) do
    local obj = getObjectFromGUID(guid)
    if obj then
      obj.lock()
    end
  end
end
