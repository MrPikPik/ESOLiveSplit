local startData = {
	x = 82305,
	y = 9472,
	z = 72299,
	r = 0.5,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Lightning Storm Atronach",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Foundation Stone Atronach",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Varlariel",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "The Celestial Mage",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_NORMAL, {
	catName = "nAA- Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vAA - Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_VETERAN, {
	catName = "vAA HM - Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})