SPLIT_MANAGER:RegisterSplit(41, DUNGEON_DIFFICULTY_NONE, {
	id = "TESTING_3",
	catName = "TriggerFlowTest",
	menuName = "Testing only!",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	wr = 1000000,
	wrPlayer = "@MrPikPik",

	splits = {
		[1] = {
			name = "Split 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
			data = {
				x = 378958,
				y = 14319,
				z = 180064,
				r = 8
			}
		},
		[2] = {
			name = "Split 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
			data = {
				x = 376210,
				y = 14389,
				z = 177682,
				r = 4
			}
		},
	}
})