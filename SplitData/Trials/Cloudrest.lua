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
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Mini 2",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Running 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Mini 3",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Running 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Z'Maja",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
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
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Mini 2",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Running 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filter = {
				[1] = "Z'Maja",
			},
		},
	},
	[6] = {
		name = "Z'Maja + 1",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
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
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Running 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filter = {
				[1] = "Z'Maja",
			},
		},
	},
	[4] = {
		name = "Z'Maja + 2",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splits_plus3 = {
	[1] = {
		name = "Running",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filter = {
				[1] = "Z'Maja",
			},
		},
	},
	[2] = {
		name = "Z'Maja + 3",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

-- +3
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_Cloudrest_3",
	catName = "vCR+3",
	menuName = "Official +3",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus3,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_Cloudrest_3",
	catName = "nCR+3",
	menuName = "Official +3",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus3,
})

-- +2
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_Cloudrest_2",
	catName = "vCR+2",
	menuName = "Official +2",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_Cloudrest_2",
	catName = "nCR+2",
	menuName = "Official + 2",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus2,
})

-- +1
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_Cloudrest_1",
	catName = "vCR+1",
	menuName = "Official +1",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_Cloudrest_1",
	catName = "nCR+1",
	menuName = "Official +1",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits_plus1,
})

-- +0
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_Cloudrest_0",
	catName = "vCR+0",
	menuName = "Official +0",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1051, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_Cloudrest_0",
	catName = "nCR+0",
	menuName = "Official +0",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits,
})