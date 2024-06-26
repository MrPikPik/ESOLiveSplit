local startData = {
	x = 32633,
	y = 52102,
	z = 26271,
	r = 1,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Overfiend",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Ibomez The Flesh Sculptor",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Gravelight Sentry",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Flesh Abomination",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Lard Warden's Quartett",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Trash 6",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[12] = {
		name = "Lord Warden",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(678, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_ImperialCityPrison",
	catName = "Imperial City Prison",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_45_MINUTES,
	wr = 2700000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(678, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_ImperialCityPrison",
	catName = "Imperial City Prison",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_45_MINUTES,
	wr = 2700000,
	wrPlayer = "Zenimax",
	splits = splits
})