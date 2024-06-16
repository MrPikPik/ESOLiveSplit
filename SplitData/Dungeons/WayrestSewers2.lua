local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 16528,
			y = 2297,
			z = 71126,
			r = 6,
		}
	},
	[2] = {
		name = "Malubeth The Scourger",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 16509,
			y = 1402,
			z = 59679,
			r = 6,
		},
	},
	[3] = {
		name = "Uulgarg The Risen",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 23154,
			y = 2297,
			z = 58125,
			r = 6,
		}
	},
	[4] = {
		name = "Garron The Returned",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 26300,
			y = 1467,
			z = 52456,
			r = 6,
		}
	},
	[5] = {
		name = "The Forgotten One",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 31030,
			y = 2297,
			z = 55381,
			r = 6,
		}
	},
	[6] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "Pellingare Twins",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(933, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_WayrestSewers2",
	catName = "Wayrest Sewers II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(933, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_WayrestSewers2",
	catName = "Wayrest Sewers II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})