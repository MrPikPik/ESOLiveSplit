local startData = {
	x = 6603,
	y = 48562,
	z = 17171,
	r = 4,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Zatzu The Spine-Breaker",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "The Mighty Chudan",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Xal-Nur The Slaver",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 62718,
			y = 41500,
			z = 3274,
			r = 1,
		},
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Tree-Minder Na-Kesh",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(843, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_RuinsOfMazzatun",
	catName = "Ruins of Mazzatun",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(843, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_RuinsOfMazzatun",
	catName = "Ruins of Mazzatun",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})