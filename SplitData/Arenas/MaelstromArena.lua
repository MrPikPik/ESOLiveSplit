local startData = {
    x = 172224,
    y = 51693,
    z = 172064,
    r = 1,
}

local splits = {
    [1] = {
        name = "Vale of the Surreal",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 34938,
            y = 47583,
            z = 33137,
            r= 1,
        },
    },
    [2] = {
        name = "Seht's Balcony",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 37676,
            y = 49926,
            z = 99408,
            r = 1,
        },
    },
    [3] = {
        name = "Drome of Toxic Shock",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 99830,
            y = 50978,
            z = 27364,
            r = 1,
        },
    },
    [4] = {
        name = "Seht's Flywheel",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 163620,
            y = 50002,
            z = 102404,
            r = 1,
        },
    },
    [5] = {
        name = "Rink if Frozen Blood",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 165822,
            y = 49999,
            z = 34794,
            r = 1,
        },
    },
    [6] = {
        name = "Spiral Shadows",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 126284,
            y = 49806,
            z = 176381,
            r = 1,
        },
    },
    [7] = {
        name = "Vault of Umbrage",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 86137,
            y = 50053,
            z = 178896,
            r = 1,
        },
    },
    [8] = {
        name = "Igneous Cistern",
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 34286,
            y = 50133,
            z = 170711,
            r = 1,
        },
    },
    [9] = {
        name = "Theater of Despair",
        splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
        data = {
            filter = "Voriak Solkyn",
        }
    },
}

SPLIT_MANAGER:RegisterSplit(677, DUNGEON_DIFFICULTY_NORMAL, {
    id = "ESOLS_MaelstromArena",
	catName = "Maelstrom Arena",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(677, DUNGEON_DIFFICULTY_VETERAN, {
    id = "ESOLS_MaelstromArena",
	catName = "Maelstrom Arena",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits
})