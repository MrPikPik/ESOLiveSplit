local startData = {
	x = 108558,
	y = 43471,
	z = 130173,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Zhaj'hassa",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Vashai & Skinrai",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Arena",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 65342,
			y = 61550,
			z = 189839,
			r = 1,
		},
	},
	[6] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[7] = {
		name = "Rakkhat",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(725, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_MawOfLorkhaj",
	catName = "nMoL",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(725, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_MawOfLorkhaj",
	catName = "vMoL",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(725, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_MawOfLorkhaj_HM",
	catName = "vMoL HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_40_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",
	splits = splits,
})