local splits = {
    id = "ESOLS_BlackrosePrison",
	catName = "Blackrose Prison",
	menuName = "Official",
	startTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
	startData = {
		parsePattern = "%d+",
        parseMatch = "1",
	},

    par = LIVE_SPLIT_TIME_30_MINUTES,
	wr = 2400000,
	wrPlayer = "Zenimax",

	splits = {
		[1] = {
			name = "Arena 1 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[2] = {
			name = "Arena 1 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[3] = {
			name = "Arena 1 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[4] = {
			name = "Arena 1 - Round 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                message = {
                    [1] = "Final Round",
                    [2] = "Letzte Runde",
                    [3] = "Dernière manche"
                },
            },
		},
		[5] = {
			name = "Arena 1 - Boss",
            icon = LIVE_SPLIT_ICON_BOSS,
			splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
            data = {
                match = {
                    [1] = "I yield",
                }
            },
		},
        [6] = {
			name = "Inter-Round",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "1",
            },
		},
        [7] = {
			name = "Arena 2 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[8] = {
			name = "Arena 2 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[9] = {
			name = "Arena 2 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[10] = {
			name = "Arena 2 - Round 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                message = {
                    [1] = "Final Round",
                    [2] = "Letzte Runde",
                    [3] = "Dernière manche"
                },
            },
		},
		[11] = {
			name = "Arena 2 - Boss",
            icon = LIVE_SPLIT_ICON_BOSS,
			splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
            data = {
                match = {
                    [1] = "I yield",
                }
            },
		},
        [12] = {
			name = "Inter-Round",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "1",
            },
		},
        [13] = {
			name = "Arena 3 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[14] = {
			name = "Arena 3 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[15] = {
			name = "Arena 3 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[16] = {
			name = "Arena 3 - Round 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                message = {
                    [1] = "Final Round",
                    [2] = "Letzte Runde",
                    [3] = "Dernière manche"
                },
            },
		},
		[17] = {
			name = "Arena 3 - Boss",
            icon = LIVE_SPLIT_ICON_BOSS,
			splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
            data = {
                match = {
                    [1] = "I yield",
                }
            },
		},
        [18] = {
			name = "Inter-Round",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "1",
            },
		},
        [19] = {
			name = "Arena 4 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[20] = {
			name = "Arena 4 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[21] = {
			name = "Arena 4 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[22] = {
			name = "Arena 4 - Round 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                message = {
                    [1] = "Final Round",
                    [2] = "Letzte Runde",
                    [3] = "Dernière manche"
                },
            },
		},
		[23] = {
			name = "Arena 4 - Boss",
            icon = LIVE_SPLIT_ICON_BOSS,
			splitTrigger = LIVE_SPLIT_TRIGGER_NPC_MESSAGE,
            data = {
                match = {
                    [1] = "bloody contest",
                }
            },
		},
        [24] = {
			name = "Inter-Round",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "1",
            },
		},
        [25] = {
			name = "Arena 5 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[26] = {
			name = "Arena 5 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[27] = {
			name = "Arena 5 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[28] = {
			name = "Arena 5 - Round 4",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                message = {
                    [1] = "Final Round",
                    [2] = "Letzte Runde",
                    [3] = "Dernière manche"
                },
            },
		},
		[29] = {
			name = "Arena 5 - Endboss",
            icon = LIVE_SPLIT_ICON_ENDBOSS,
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
	}
}

SPLIT_MANAGER:RegisterSplit(1082, DUNGEON_DIFFICULTY_NORMAL, splits)
SPLIT_MANAGER:RegisterSplit(1082, DUNGEON_DIFFICULTY_VETERAN, splits)