SPLIT_MANAGER:RegisterSplit(41, DUNGEON_DIFFICULTY_NONE, {
	catName = "Addon Development - Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_BEGIN_TRIAL,
	startOffset = 5000,
	wr = 18000000,
	wrPlayer = "@MrPikPik",
	
	splits = {
		[1] = {
			name = "Split 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_nightblade.dds",
		},
		[2] = {
			name = "Split 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_sorcerer.dds",
		},
		[3] = {
			name = "Split 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_dragonknight.dds",
		},
		[4] = {
			name = "Split 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_necromancer.dds",
		},
		[5] = {
			name = "Split 5",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_warden.dds",
		},
		[6] = {
			name = "Split 6",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_templar.dds",
		},
		[7] = {
			name = "Split 7",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
			icon = "esoui/art/icons/class/class_arcanist.dds",
		},
		[8] = {
			name = "Split 8",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[9] = {
			name = "Split 9",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[10] = {
			name = "Split 10",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[11] = {
			name = "Split 11",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
		[12] = {
			name = "Split 12",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		}
	}
})