local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Akash gra-Mal",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Chokethorn",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Nensh gro-Mal & Leefseether",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 28611,
			y = 7513,
			z = 26555,
			r = 6.5,
		},
	},
	[7] = {
		name = "Canonreeve Oraneth",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(126, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_EldenHollow1",
	catName = "Elden Hollow I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(126, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_EldenHollow1",
	catName = "Elden Hollow I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})