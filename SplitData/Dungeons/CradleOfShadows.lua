local startData = {
	x = 5202,
	y = 46816,
	z = 16302,
	r = 2.8,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 23783,
			y = 46700,
			z = 42713,
			r = 35,
		},
	},
	[2] = {
		name = "Sithera",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 19312,
			y = 46779,
			z = 42232,
			r = 6,
		},
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Khephidaen the Spiderkith",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "The Votary of Velidreth",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 34887,
			y = 47359,
			z = 7248,
			r = 3,
		},
	},
	[7] = {
		name = "Running",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Dranos Velador",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Velidreth",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(848, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Cradle of Shadows",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(848, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Cradle of Shadows",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})