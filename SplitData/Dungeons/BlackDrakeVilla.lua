local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Kinras Ironeye",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Captain Geminus",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Pyroturge Encratis",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1228, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Black Drake Villa",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1228, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Black Drake Villa",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})