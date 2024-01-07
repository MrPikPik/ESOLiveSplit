local splits = {
	catName = "Blackrose Prison",
	menuName = "Any%",
	startTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
	startData = {
		parsePattern = "%d+",
        parseMatch = "1",
	},

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
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
            data = {
                x = 100688,
                y = 60951,
                z = 69095,
                r = 1.4,
            },
		},
        [6] = {
			name = "Arena 2 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[7] = {
			name = "Arena 2 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[8] = {
			name = "Arena 2 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[9] = {
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
		[10] = {
			name = "Arena 2 - Boss",
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
            data = {
                x = 90050,
                y = 57152,
                z = 60598,
                r = 2.4,
            },
		},
        [11] = {
			name = "Arena 3 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[12] = {
			name = "Arena 3 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[13] = {
			name = "Arena 3 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[14] = {
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
		[15] = {
			name = "Arena 3 - Boss",
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
            data = {
                x = 99746,
                y = 53926,
                z = 48762,
                r = 1.5,
            },
		},
        [16] = {
			name = "Arena 4 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[17] = {
			name = "Arena 4 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[18] = {
			name = "Arena 4 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[19] = {
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
		[20] = {
			name = "Arena 4 - Boss",
			splitTrigger = LIVE_SPLIT_TRIGGER_LOCATION,
            data = {
                x = 107860,
                y = 50690,
                z = 35007,
                r = 1.8,
            },
		},
        [21] = {
			name = "Arena 5 - Round 1",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "2",
            },
		},
		[22] = {
			name = "Arena 5 - Round 2",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "3",
            },
		},
		[23] = {
			name = "Arena 5 - Round 3",
			splitTrigger = LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE,
            data = {
                parsePattern = "%d+",
                parseMatch = "4",
            },
		},
		[24] = {
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
		[25] = {
			name = "Arena 5 - Endboss",
			splitTrigger = LIVE_SPLIT_TRIGGER_BOSS_DEATH,
		},
	}
}

SPLIT_MANAGER:RegisterSplit(1082, DUNGEON_DIFFICULTY_NORMAL, splits)
SPLIT_MANAGER:RegisterSplit(1082, DUNGEON_DIFFICULTY_VETERAN, splits)