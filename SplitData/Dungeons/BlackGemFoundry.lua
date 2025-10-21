local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Saldezaar",
			},
		},
	},
	[2] = {
		name = "Quarrymaster Saldezaar",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Monstro"
			},
		},
	},
	[4] = {
		name = "Black Gem Monstrosity",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		data = {
			filterMatch = {
				[1] = "Vykand",
			},
		},
	},
	[6] = {
		name = "High Soulbinder Vykand",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(1552, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_BlackGemFoundry",
	catName = "Black Gem Foundry",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(1552, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_BlackGemFoundry",
	catName = "Black Gem Foundry",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})