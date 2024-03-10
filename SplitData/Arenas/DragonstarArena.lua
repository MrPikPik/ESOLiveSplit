local splits = {
    [1] = {
        name = {
            en = "Dragonstar Arena",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 72863,
            y = 30240,
            z = 31883,
            r = 1,
        },
    },
    [2] = {
        name = {
            en = "The Frozen Ring",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 122730,
            y = 29941,
            z = 31599,
            r = 1,
        },
    },
    [3] = {
        name = {
            en = "The Marsh",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 172739,
            y = 29897,
            z = 31706,
            r = 1,
        },
    },
    [4] = {
        name = {
            en = "Slavers Pit",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 222664,
            y = 29852,
            z = 31483,
            r = 1,
        },
    },
    [5] = {
        name = {
            en = "The Celestial Ring",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 22690,
            y = 29967,
            z = 82095,
            r = 1,
        },
    },
    [6] = {
        name = {
            en = "The Grove",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 72642,
            y = 30061,
            z = 81649,
            r = 1,
        },
    },
    [7] = {
        name = {
            en = "Circle of Rituals",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 122757,
            y = 29865,
            z = 81802,
            r = 1,
        },
    },
    [8] = {
        name = {
            en = "Steamworks",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 172458,
            y = 30006,
            z = 81602,
            r = 1,
        },
    },
    [9] = {
        name = {
            en = "Crypts of the Lost",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
        data = {
            x = 222684,
            y = 29852,
            z = 82033,
            r = 1,
        },
    },
    [10] = {
        name = {
            en = "The Champion's Arena",
        },
        splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
    },
}

SPLIT_MANAGER:RegisterSplit(635, DUNGEON_DIFFICULTY_NORMAL, {
    id = "ESOLS_DragonstarArena",
	catName = "Dragonstar Arena",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
    par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(365, DUNGEON_DIFFICULTY_VETERAN, {
    id = "ESOLS_DragonstarArena",
	catName = "Dragonstar Arena",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
    par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits
})