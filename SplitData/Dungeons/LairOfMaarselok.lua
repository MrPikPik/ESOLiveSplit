local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Selene",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 129167,
			y = 59154,
			z = 44831,
			r = 1,
		},
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Maarselok I",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 134373,
			y = 57602,
			z = 65581,
			r = 1,
		},
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "The Azureblight Cancroid",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Maarselok II",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 97301,
			y = 56063,
			z = 144602,
			r = 1,
		},
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Maarselok III",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1123, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Lair of Maarselok",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1123, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Lair of Maarselok",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})