local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Scorion Broodlord",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Cyronin Artellian",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "The Magma Incarnate",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1268, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "The Dread Cellar",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1268, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "The Dread Cellar",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})