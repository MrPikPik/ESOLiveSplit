local startData = {
	x = 78704,
	y = 61555,
	z = 100019,
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
		name = "Saint Olms The Just",
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
		data = {
			filterMatch = "Olms",
		},
	},
	[4] = {
		name = "Saint Olms The Just",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits_plus2 = {
	[1] = {
		name = "Running",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = "Olms",
		},
	},
	[2] = {
		name = "Saint Olms The Just",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nAS+0",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nAS+1",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})
SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nAS+2",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})
SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vAS+0",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vAS+1",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})
SPLIT_MANAGER:RegisterSplit(1000, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vAS+2",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})