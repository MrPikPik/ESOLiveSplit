local startData = {
	x = 26733,
	y = 37723,
	z = 168255,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Lylanar & Turlassil",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Miniboss 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Miniboss 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Reef Guardian",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Taleria",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1344, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_DreadSailReef",
	catName = "nDSR",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1344, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_DreadSailReef",
	catName = "vDSR",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1344, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_DreadSailReef_HM",
	catName = "vDSR HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})