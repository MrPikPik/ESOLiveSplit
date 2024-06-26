local startData = {
	x = 48886,
	y = 30317,
	z = 123476,
	r = 83.0,
}
local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Iron-Heel",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Atarnus",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "First Mate Wavecutter",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "The Roost Mother",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Hollow Heart",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Running...",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[12] = {
		name = "Captain Blackheart",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(38, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_BlackheartHaven",
	catName = "Blackheart Haven",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION_INV,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(38, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_BlackheartHaven",
	catName = "Blackheart Haven",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION_INV,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})