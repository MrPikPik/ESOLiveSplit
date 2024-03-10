local splits = {
	id = "ESOLS_MyId",
	catName = "Name",
	menuName = "ShortName",
	startTrigger = LIVE_SPLIT_TRIGGER_ENTER_COMBAT,
	
	startData = {
		x = 28147,
		y = 13592,
		z = 39949,
		r = 59.4,
	},

	par = LIVE_SPLIT_TIME_20_MINUTES,
	wr = 1200000,
	wrPlayer = "Zenimax",
	
	splits = {
		[1] = {
			name = "Trash 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[2] = {
			name = "Boss1",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[3] = {
			name = "Trash 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[4] = {
			name = "Boss2",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[5] = {
			name = "Trash 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[6] = {
			name = "Boss3",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[7] = {
			name = "Trash 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[8] = {
			name = "Boss4",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[9] = {
			name = "Trash 5",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[10] = {
			name = "Boss5",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[11] = {
			name = "Trash 6",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[12] = {
			name = "Boss6",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[13] = {
			name = "Trash 7",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[14] = {
			name = "Boss7",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[15] = {
			name = "Trash 8",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_ENTER,
		},
		[16] = {
			name = "Boss8",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
	}
}

SPLIT_MANAGER:RegisterSplit(0, DUNGEON_DIFFICULTY_NORMAL, splits)
SPLIT_MANAGER:RegisterSplit(0, DUNGEON_DIFFICULTY_VETERAN, splits)