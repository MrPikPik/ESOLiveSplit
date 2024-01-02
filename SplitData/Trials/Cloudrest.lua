local startData = {
	x = 153662,
	y = 30570,
	z = 73882,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Running 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mini 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Mini 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Running 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Mini 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Running 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Z'Maja",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits_plus1 = {
	[1] = {
		name = "Running 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mini 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Mini 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Running 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Z'Maja + 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits_plus2 = {
	[1] = {
		name = "Running 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mini 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Z'Maja + 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits_plus3 = {
	[1] = {
		name = "Running 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Z'Maja + 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nCR+0",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nCR+1",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nCR+2",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nCR+3",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus3,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vCR+0",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vCR+1",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vCR+2",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vCR+3",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus3,
})