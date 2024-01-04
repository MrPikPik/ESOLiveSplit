local startData = {
	x = 22357,
	y = 51445,
	z = 84636,
	r = 35,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mathgamain",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Caillaoife",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Stoneheart",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Galchobhar",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Gherig Bullblood",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "The Earthgore Amalgam",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(973, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "Bloodroot Forge",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(973, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "Bloodroot Forge",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1200000,
	wrPlayer = "Zenimax",
	splits = splits
})