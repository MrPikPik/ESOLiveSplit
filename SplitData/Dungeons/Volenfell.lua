local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "The Desert Lion",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Quintus Verres",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Gargoyle",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[6] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "Boilbite",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[8] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[9] = {
		name = "The Unstable Construct",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[10] = {
		name = "Running",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[11] = {
		name = "Tremorscale",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[12] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[13] = {
		name = "The Guardian Council",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(22, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Volenfell",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(22, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Volenfell",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})