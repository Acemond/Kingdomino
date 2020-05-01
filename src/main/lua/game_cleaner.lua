
local buttons_to_remove = {
  player_remove_buttons.Red,
  player_add_buttons.Red,
  player_remove_buttons.Orange,
  player_add_buttons.Orange,
  player_remove_buttons.White,
  player_add_buttons.White,
  player_remove_buttons.Purple,
  player_add_buttons.Purple,
  player_remove_buttons.Green,
  player_add_buttons.Green,
  player_remove_buttons.Pink,
  player_add_buttons.Pink,
  quickSetup = "31971b",
  quickSetup2p = "46971b",
  quickSetup3p = "4f4db6",
  quickSetup4p = "8dfa00",
  quickSetup5p = "1765aa",
  quickSetup6p = "6c37eb",
  laCourEnable = "6ff70f",
  laCourDisable = "2c22ed",
  kingdominoEnable = "9f4a39",
  kingdominoDisable = "697d5b",
  queendominoEnable = "69cbda",
  queendominoDisable = "d64709",
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

local game_objects_guid = {
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
    dragon = "447c40",
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
  game_objects_guid.the_court.building_board,
  game_objects_guid.the_court.wheat_bag,
  game_objects_guid.the_court.sheep_bag,
  game_objects_guid.the_court.wood_bag,
  game_objects_guid.the_court.fish_bag
}

function cleanTableForGame()

end
