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
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Foundation Stone Atronach",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Varlariel",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "The Celestial Mage",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_AetherianArchive",
	catName = "nAA",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_AetherianArchive",
	catName = "vAA",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})

SPLIT_MANAGER:RegisterSplit(638, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_AetherianArchive_HM",
	catName = "vAA HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_33_MINUTES,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})