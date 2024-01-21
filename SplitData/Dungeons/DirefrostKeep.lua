local startData = {
	x = 21668,
	y = 17466,
	z = 87256,
	r = 7.4,
}

local splitsSkip = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Teethnasher The Frostbound",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Guardian of the Flame",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Drodda's Dreadlord",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Iceheart",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Drodda of Icereach",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splitsNoSkip = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Teethnasher The Frostbound",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Guardian of the Flame",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Drodda's Dreadlord",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Drodda's Apprentice",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Iceheart",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Trash 6",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[12] = {
		name = "Drodda of Icereach",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}



SPLIT_MANAGER:RegisterSplit(449, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_DirefrostKeep_Skip",
	catName = "Direfrost Keep - Skip",
	menuName = "Official - Skip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splitsSkip
})
SPLIT_MANAGER:RegisterSplit(449, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_DirefrostKeep_Skip",
	catName = "Direfrost Keep - Skip",
	menuName = "Official - Skip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splitsSkip
})
SPLIT_MANAGER:RegisterSplit(449, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_DirefrostKeep_NoSkip",
	catName = "Direfrost Keep - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splitsNoSkip
})
SPLIT_MANAGER:RegisterSplit(449, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_DirefrostKeep_NoSkip",
	catName = "Direfrost Keep - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splitsNoSkip
})