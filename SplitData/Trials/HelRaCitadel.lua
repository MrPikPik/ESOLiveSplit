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
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Yokeda Rok'dun & Kai",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "The Warrior",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nHRC- Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vHRC - Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(636, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vHRC HM - Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})