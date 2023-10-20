local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "The Cursed One",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Ulguna Soul-Reaver",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Death's Head",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Grothdarr",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Achaeraizur",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Trash 6",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[12] = {
		name = "The Ancient One",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[13] = {
		name = "Trash 7",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[14] = {
		name = "Iskra The Omen",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[15] = {
		name = "Trash 8",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[16] = {
		name = "The Mad Architect",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(11, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Vaults Of Madness",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(11, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Vaults Of Madness",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})