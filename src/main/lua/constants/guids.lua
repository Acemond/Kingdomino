Guids = {}
Guids.__index = Guids

Guids.managers = {
  player = "31971b"
}

Guids.score_counter = "3416fc"

Guids.player_pieces = {
  Orange = {
    kingdom_zone = "f9209b",
    hand_zone = "96929a",
    castle_tile = "9ab771",
    castle = "768b9c",
    flag = "6cfdbd",
    kings = { "4d2d92", "5e6289" },
    lock_kingdom = "7fba99",
    unlock_kingdom = "174baf",
    add_player = "8d17b0",
    remove_player = "fa1b7c",
    score = "fb3aef",
    left = "930bfd",
    right = "c42b3a",
    up = "bdcd6e",
    down = "f7ecfc"
  },
  Purple = {
    kingdom_zone = "54b528",
    hand_zone = "6ea086",
    castle_tile = "7db35a",
    castle = "a1e204",
    flag = "137a90",
    kings = { "7dd59a", "e44a70" },
    lock_kingdom = "65631a",
    unlock_kingdom = "bb6a8f",
    add_player = "1b4b1a",
    remove_player = "1bbcb3",
    score = "a0c171",
    left = "0aeb33",
    right = "bbd180",
    up = "6e634c",
    down = "898c80"
  },
  Red = {
    kingdom_zone = "f1bc94",
    hand_zone = "31279b",
    castle_tile = "f6948c",
    castle = "ae130d",
    flag = "d99107",
    kings = { "24345c", "2837e9" },
    lock_kingdom = "c423f5",
    unlock_kingdom = "8ea950",
    add_player = "a1ef12",
    remove_player = "dfeee5",
    score = "5f029e",
    left = "a60174",
    right = "2284ad",
    up = "b7ed5b",
    down = "10eb8f"
  },
  White = {
    kingdom_zone = "57d93f",
    hand_zone = "f85ea1",
    castle_tile = "537260",
    castle = "fd4160",
    flag = "e0aed1",
    kings = { "86f4c2", "61259d" },
    lock_kingdom = "9328d8",
    unlock_kingdom = "78c148",
    add_player = "f60fe5",
    remove_player = "74e8b0",
    score = "6d61c5",
    left = "75497b",
    right = "5ab6ce",
    up = "672025",
    down = "16b5f1"
  },
  Green = {
    kingdom_zone = "e491d2",
    hand_zone = "352048",
    castle_tile = "8c9612",
    castle = "b5c1bc",
    flag = "37748e",
    kings = { "526c31", "f2cd83" },
    lock_kingdom = "220125",
    unlock_kingdom = "4d9e38",
    add_player = "fbeaba",
    remove_player = "8fedd0",
    score = "43b47b",
    left = "c34f25",
    right = "6c0fdf",
    up = "ed1972",
    down = "3af1e7"
  },
  Pink = {
    kingdom_zone = "921b32",
    hand_zone = "49989f",
    castle_tile = "a5aad1",
    castle = "a407fb",
    flag = "43d6e5",
    kings = { "9dc643", "0dba70" },
    lock_kingdom = "fb8289",
    unlock_kingdom = "f26133",
    add_player = "6987e6",
    remove_player = "668a0a",
    score = "e9f7d0",
    left = "97a9e5",
    right = "4071a5",
    up = "6eaf33",
    down = "1b567d"
  }
}

Guids.castle_tiles = {
  Orange = "9ab771",
  Purple = "7db35a",
  Red = "f6948c",
  White = "537260",
  Green = "8c9612",
  Pink = "a5aad1"
}

Guids.walls_guids = {
  [5] = {
    Orange = "5a6899",
    Purple = "5907ab",
    Red = "81b26a",
    White = "81e993",
    Green = "92a671",
    Pink = "41845a"
  },
  [7] = {
    Orange = "3e4ffe",
    Purple = "7ee381",
    Red = "31a320",
    White = "5dd07b",
    Green = "e3c516",
    Pink = "82e2c3"
  }
}

-- FIXME: not reliable because of deck cloning for XL games.
-- TODO: remove
Guids.dominoes = {
  kingdomino = {
    "65c7b4",
    "efc3a8",
    "d7bb36",
    "74fd29",
    "7508a5",
    "afcd54",
    "6f3cbe",
    "d08c6a",
    "d092b3",
    "afb8c2",
    "6ec55a",
    "db41aa",
    "275e67",
    "4edbd6",
    "f81c15",
    "d565ea",
    "784f13",
    "7f4702",
    "172f81",
    "82ed99",
    "b7b1f5",
    "37508d",
    "32a4a2",
    "f30ad4",
    "cb862f",
    "d68a28",
    "7995b5",
    "c7af30",
    "8b3161",
    "4c2771",
    "9d404c",
    "df01de",
    "6c3bfb",
    "8e7cba",
    "b9f2e4",
    "ae0007",
    "33d0ab",
    "411bad",
    "e664fd",
    "2de119",
    "f8932a",
    "49ad83",
    "969040",
    "5aa79c",
    "17f66a",
    "23b84f",
    "575931",
    "8cb621"
  },
  queendomino = {
    "2e8be9",
    "fe6c64",
    "66d0d8",
    "1b7eee",
    "fbd1c1",
    "5c026e",
    "8287de",
    "fb6cc8",
    "3687b0",
    "857c78",
    "d58039",
    "403cd7",
    "c08da2",
    "044714",
    "a63359",
    "4b696c",
    "cb6acc",
    "aa273a",
    "1586c9",
    "26e5ad",
    "b31949",
    "8186ba",
    "52066e",
    "58f60f",
    "09e788",
    "2b913b",
    "268a77",
    "582068",
    "a4247d",
    "5e2fdc",
    "4c4939",
    "27c560",
    "413c0f",
    "16a313",
    "4aea98",
    "59754c",
    "0f3f56",
    "5bb02c",
    "27ac38",
    "7dd7b6",
    "cde02f",
    "c69447",
    "c23e9c",
    "c3fa42",
    "b9e1da",
    "7ddf55",
    "25a7dd",
    "3e28d0"
  },
  age_of_giants = {
    [-6] = "5539f9",
    [-5] = "7d77a2",
    [-4] = "9b1a43",
    [-3] = "bb4c79",
    [-2] = "087d50",
    [-1] = "b274c0",
    [49] = "00c0d7",
    [50] = "c1149b",
    [51] = "1a54d9",
    [52] = "261de8",
    [53] = "68a08c",
    [54] = "c469c2"
  }
}

Guids.deck_objects = {
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
    Wheat = "68a4e4",
    Sheep = "98f12a",
    Wood = "443d34",
    Fish = "3725a9",
  }
}

Guids.tile_check_zone = {
  "8fd451", "7e8397", "d0b593", "f25b1c", "234056", "e05d05", "094ef7", "568e1c", "778b3f", "ae470a"
}
