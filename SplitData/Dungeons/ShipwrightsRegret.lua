local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Bradiggan",
			},
		},
	},
	[2] = {
		name = "Foreman Bradiggan",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Nazaray",
			},
		},
	},
	[4] = {
		name = "Nazaray",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Numirril",
			},
		},
	},
	[6] = {
		name = "Captain Numirril",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1302, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_ShipwrightsRegret",
	catName = "Shipwright's Regret",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_25_MINUTES,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1302, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_ShipwrightsRegret",
	catName = "Shipwright's Regret",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_25_MINUTES,
	wr = 1500000,
	wrPlayer = "Zenimax",
	splits = splits
})