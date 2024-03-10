local startData = {
	x = 91644,
	y = 32702,
	z = 53361,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Oaxiltso",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Flame-Herald Bahsei",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Ashtitan",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Xalvakka",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

local splitsWithSideBoss = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Bask-In-Snakes",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Oaxiltso",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Flame-Herald Bahsei",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "Ashtitan",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[9] = {
		name = "Xalvakka",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

-- Without side boss
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_RockGrove_Main",
	catName = "nRG - Main Bosses",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_RockGrove_Main",
	catName = "vRG - Main Bosses",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_RockGrove_Main_HM",
	catName = "vRG HM",
	menuName = "Offical HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splits,
})

-- With side boss
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_RockGrove_Sideboss",
	catName = "nRG +Sideboss",
	menuName = "Official +Sideboss",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splitsWithSideBoss,
})
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_RockGrove_Sideboss",
	catName = "vRG +Sideboss",
	menuName = "Official +Sideboss",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splitsWithSideBoss,
})
SPLIT_MANAGER:RegisterSplit(1263, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_RockGrove_Sideboss_HM",
	catName = "vRG HM +Sideboss",
	menuName = "Official HM +Sideboss",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 1800000,
	wrPlayer = "Zenimax",
	splits = splitsWithSideBoss,
})