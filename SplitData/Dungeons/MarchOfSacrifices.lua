local startData = {
	x = 45989,
	y = 51789,
	z = 113216,
	r = 50,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "The Wyrd Sisters",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Aghaedh of the Solstice",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Dagrund The Bully",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Tarcyr",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Barlorgh",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1055, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_MarchOfSacrifices",
	catName = "March of Sacrifices",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1055, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_MarchOfSacrifices",
	catName = "March of Sacrifices",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})