local startData = {
	x = 107269,
	y = 19475,
	z = 175660,
	r = 1.0,
}

local splits = {
	[1] = {
		name = "Trash 1",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[2] = {
		name = "Mantikora",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[3] = {
		name = "Trash 2",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[4] = {
		name = "Stonebreaker",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[5] = {
		name = "Trash 3",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[6] = {
		name = "Ozara",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
	[7] = {
		name = "Trash 4",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
	},
	[8] = {
		name = "The Serpent",
		splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
	},
}

SPLIT_MANAGER:RegisterSplit(639, DUNGEON_DIFFICULTY_NORMAL, {
	id = "ESOLS_SanctumOphidia",
	catName = "nSO",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
	startData = startData,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(639, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_SanctumOphidia",
	catName = "vSO",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})
SPLIT_MANAGER:RegisterSplit(639, DUNGEON_DIFFICULTY_VETERAN, {
	id = "ESOLS_SanctumOphidia_HM",
	catName = "vSO HM",
	menuName = "Official HM",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1980000,
	wrPlayer = "Zenimax",
	splits = splits,
})