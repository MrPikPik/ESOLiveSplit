local startData = {
	x = 126370,
	y = 25037,
	z = 112082,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Yandir",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Vrol",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Falgravn",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1196, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_KynesAegis",
	catName = "nKA",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_35_MINUTES,
	wr = 2100000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1196, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_KynesAegis",
	catName = "vKA",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_35_MINUTES,
	wr = 2100000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1196, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_KynesAegis_HM",
	catName = "vKA HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_35_MINUTES,
	wr = 2100000,
	wrPlayer = "Zenimax",
	splits = splits,
})