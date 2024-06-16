local startData = {
	x = 62461,
	y = 21536,
	z = 39494,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Ra Kotu",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Yokeda Rok'dun & Kai",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION_MULTI,
		data = {
			[1] = {
				x = 79904,
				y = 24656,
				z = 89086,
				r = 4,
			},
			[2] = {
				x = 86323,
				y = 28070,
				z = 96075,
				r = 5,
			},
		},
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 111935,
			y = 35860,
			z = 92562,
			r = 1,
		},
	},
	[6] = {
		name = "Running",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "The Warrior",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_HelRaCitadel",
	catName = "nHRC",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_HelRaCitadel",
	catName = "vHRC",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_HelRaCitadel_HM",
	catName = "vHRC HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})