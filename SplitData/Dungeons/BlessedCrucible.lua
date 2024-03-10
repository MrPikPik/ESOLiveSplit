local startData = {
	x = 122917,
	y = 11293,
	z = 13466,
	r = 24.4,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Grunt The Clever",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "The Pack",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[4] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[5] = {
		name = "Teranya The Faceless",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[6] = {
		name = "Arena",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "Stinger",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[8] = {
		name = "The Troll King",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Captain Thoran",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Running...",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[12] = {
		name = "The Lava Queen",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(64, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_BlessedCrucible",
	catName = "Blessed Crucible",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(64, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_BlessedCrucible",
	catName = "Blessed Crucible",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})