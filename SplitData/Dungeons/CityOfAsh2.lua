local startData = {
	x = 94086,
	y = 32269,
	z = 77126,
	r = 1,
}

local splits = {
	[1] = {
		name = "Rukhan",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[2] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[3] = {
		name = "Marruz",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[4] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[5] = {
		name = "Horvantud The Fire Maw",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[6] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "Ash Titan",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[8] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 24475,
			y = 34088,
			z = 159186,
			r = 7,
		},
	},
	[9] = {
		name = "Bridges",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 25213,
			y = 34731,
			z = 167863,
			r = 10,
		},
	},
	[10] = {
		name = "Valkyn Skoria",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(681, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_CityOfAsh2",
	catName = "City of Ash II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(681, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_CityOfAsh2",
	catName = "City of Ash II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})