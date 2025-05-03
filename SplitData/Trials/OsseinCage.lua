local startData = {
	x = 181950,
	y = 35399,
	z = 85491,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Shapers of Flesh",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filter = {
				[1] = "Jynorah",
			},
		},
	},
	[4] = {
		name = "Jynorah & Skorkhif",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filter = {
				[1] = "Kazpian",
			},
		},
	},
	[6] = {
		name = "Overfiend Kazpian",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1548, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_OsseinCage",
	catName = "nOC",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	par = LIVE_SPLIT_TIME_45_MINUTES,
	startData = startData,
	wr = 2700000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1548, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_OsseinCage",
	catName = "vOC",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_45_MINUTES,
	wr = 2700000,
	wrPlayer = "Zenimax",
	splits = splits,
})