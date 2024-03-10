local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mephala's Fang",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Gamyne Bandu",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Ciirenas The Shepard",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Spawn of Mephala",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 16574,
			y = 13844,
			z = 27520,
			r = 3,
		},
	},
	[9] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Reggr Dark-Dawn",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 20116,
			y = 12453,
			z = 42577,
			r = 32,
		},
	},
	[12] = {
		name = "Vila Theran",
		splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
		data = {
			message = {
				[1] = "It is done.",
			},
		},
	},
}

SPLIT_MANAGER:RegisterSplit(934, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_FungalGrotto2_NoSkip",
	catName = "Fungal Grotto II - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(934, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_FungalGrotto2_NoSkip",
	catName = "Fungal Grotto II - NoSkip",
	menuName = "Official - NoSkip",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})