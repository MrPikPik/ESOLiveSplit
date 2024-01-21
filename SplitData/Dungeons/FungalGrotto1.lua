local startData = {
	x = 28147,
	y = 13592,
	z = 39949,
	r = 59.4,
}

local splits_skip = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Tazkad the Packmaster",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "War Chief Ozozai",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Kra'gh the Dreug King",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits =  {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Tazkad the Packmaster",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "War Chief Ozozai",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Broodbirther",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Clatterclaw",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Kra'gh the Dreug King",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(283, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_FungalGrotto1_NoSkip",
	catName = "Fungal Grotto I - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(283, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_FungalGrotto1_NoSkip",
	catName = "Fungal Grotto I - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(283, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_FungalGrotto1_Skip",
	catName = "Fungal Grotto I - Skip",
	menuName = "Official - Skip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_skip
})
SPLIT_MANAGER:RegisterSplit(283, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_FungalGrotto1_Skip",
	catName = "Fungal Grotto I - Skip",
	menuName = "Official - Skip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_skip
})