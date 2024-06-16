local startData = {
	x = 8172,
	y = 3321,
	z = 79865,
	r = 4.1,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Slimecraw",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Investigator Garron",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Uulgarg The Hungry",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Varaine Pellingare",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[8] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
		data = {
			match = {
				"Pellingares",
			},
			fromName = {
				"Allene Pellingare",
			},
		},
	},
	[9] = {
		name = "Allene Pellingare",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_CUSTOM,
		-- F*** this dungeon in particular for making my life miserable finding a way to detect the boss death "event".........
		splitFunction = function() return GetUnitName("reticleover") == "Allene Pellingare" and IsUnitDead("reticleover") end,
	},
}

SPLIT_MANAGER:RegisterSplit(146, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_WayrestSewers1",
	catName = "Wayrest Sewers I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(146, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_WayrestSewers1",
	catName = "Wayrest Sewers I",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_15_MINUTES,
	wr = 900000,
	wrPlayer = "Zenimax",
	splits = splits
})