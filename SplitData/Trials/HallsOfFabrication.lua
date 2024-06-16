local startData = {
	x = 5743,
	y = 50571,
	z = 32094,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Hunter-Killer Fabricants",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Pinnacle Factotum",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Archcustodian",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 7780,
			y = 55368,
			z = 54610,
			r = 1,
		},
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Reassembly Commitee",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Assembly General",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(975, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_HallsOfFabrication",
	catName = "nHoF",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(975, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_HallsOfFabrication",
	catName = "vHoF",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(975, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_HallsOfFabrication_HM",
	catName = "vHoF HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})