-- useless hidden objects used to keep button textures in memory
local decoyButtons = { "9bb39a", "3416fc", "2a0d3f", "25ef05", "d78ce4", "25bfc4", "29ae89", "6ce2c6", "31bd66",
                       "5740ca", "180cbc", "2c055b", "28fcc5", "5aebb9", "536275", "eb1dfc", "3853c3", "bb8090", "59253d" }

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
  "1403b9",  -- kings bag
  "75dcb1", "edb838", "42f5a4", "92f52d" --[[, "83af19", "355eca"]] -- variants buttons
}
local temporarily_frozen = {
  "b972db", -- king
  "b12f86", "04de04", "38e164", "8468e9", "4638c0", "fe4062", "45152b", "401270", "447c40",  -- queen
  "da9688",  -- aog
  "e0b7ee", "68a4e4", "98f12a", "443d34", "3725a9"  -- the_court
}

function onLoad()
  self.interactable = false
  chageFreezeState(decoyButtons, true)
  chageFreezeState(non_interactable_guids, true)
  chageFreezeState(temporarily_frozen, true)
end

function unfreezeTemp()
  chageFreezeState(temporarily_frozen, false)
end

function chageFreezeState(guids, frozen)
  for _, guid in pairs(guids) do
    obj = getObjectFromGUID(guid)
    if obj then
      obj.interactable = not frozen
    end
  end
end
