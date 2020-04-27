-- useless hidden objects used to keep button textures in memory
local decoyButtons = { "9bb39a", "3416fc", "2a0d3f", "25ef05", "d78ce4", "25bfc4", "29ae89", "6ce2c6", "31bd66",
                       "5740ca", "180cbc", "2c055b", "28fcc5" }

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
  start_button_guid, "4a6126", "46971b", "4f4db6", "8dfa00", -- game buttons
  "7a72d1", "bd95f5", "174390", "8c018b", "e5b23a", "ae485e", -- tile boards
  "1403b9"  -- kings bag
}

function onLoad()
  self.interactable = false
  freezeNonInteractables(decoyButtons)
  freezeNonInteractables(non_interactable_guids)
end

function freezeNonInteractables(guids)
  for _, guid in pairs(guids) do
    obj = getObjectFromGUID(guid)
    if obj ~= nil then
      obj.interactable = false
    end
  end
end
