local startData = {
	x = 76380,
	y = 14775,
	z = 38000,
	r = 4,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Cell Haunter",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Shadowrend",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Angata The Clanfear Handler",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Skeletal Destroyer",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "High Kinlord Rilis",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(380, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_BanishedCells1",
	catName = "Banished Cells I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(380, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_BanishedCells1",
	catName = "Banished Cells I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})