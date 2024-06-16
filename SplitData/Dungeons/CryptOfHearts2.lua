local startData = {
	match = {
		"Nerien'eth",
	},
}
local splits =  {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Ibelgast",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Ruzozuzslpamaz",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 45375,
			y = 9903,
			z = 4379,
			r = 4,
		},
	},
	[6] = {
		name = "Chamber Guardian",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
		data = {
			x = 47177,
			y = 9920,
			z = 4343,
			r = 3,
		},
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Ilambris Amalgam",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Trash 5",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[10] = {
		name = "Mezeluth",
		icon = LIVE_SPLIT_ICON_BOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[11] = {
		name = "Running & Waiting",
		splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
		data = {
			match = {
				"You think that Blade is yours to touch",
			}
		},
	},
	[12] = {
		name = "Nerien'eth",
		icon = LIVE_SPLIT_ICON_ENDBOSS,
		splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
		data = {
			match = {
				"You did it!",
			},
		},
	},
}

SPLIT_MANAGER:RegisterSplit(932, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_CryptOfHearts2",
	catName = "Crypt of Hearts II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
	startData = startData,
	startOffset = 6500,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})
SPLIT_MANAGER:RegisterSplit(932, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_CryptOfHearts2",
	catName = "Crypt of Hearts II",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
	startData = startData,
	startOffset = 6500,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits
})