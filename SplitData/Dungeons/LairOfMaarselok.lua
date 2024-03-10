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
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 139017,
			y = 57787,
			z = 60665,
			r = 1,
		},
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
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 75385,
			y = 54001,
			z = 105186,
			r = 1,
		},
	},
	[6] = {
		name = "The Azureblight Cancroid",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 88989,
			y = 56114,
			z = 148241,
			r = 1,
		},
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
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 128964,
			y = 69198,
			z = 138195,
			r = 4.8,
		},
	},
	[10] = {
		name = "Maarselok III",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1123, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_LairOfMaarselok",
	catName = "Lair of Maarselok",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_35_MINUTES,
	wr = 2100000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1123, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_LairOfMaarselok",
	catName = "Lair of Maarselok",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_35_MINUTES,
	wr = 2100000,
	wrPlayer = "Zenimax",
	splits = splits
})