---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_ENTER_COMBAT     = 1 -- Player enters combat state
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_EXIT_COMBAT      = 2 -- Player leaves combat state
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_BOSS_ENTER       = 3 -- Advances if the player enters a boss area (= the boss healthbar appears)
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_BOSS_DEATH       = 4 -- Advances if the bosses die (= the boss healthbar disappears, because the boss is gone)
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_LOCATION         = 5 -- All purpose trigger, listening for players in the group being close to a specific point
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_LOCATION_INV     = 6 -- All purpose trigger, listening for players in the group being outside the range of a specific point
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_BEGIN_TRIAL      = 7 -- Trial and Arenas on vet only. Triggered by the game. For normal difficulty use Location Trigger and set position to the door that would start the timer on vet.
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_MOB_KILLS        = 8 -- Trials only. Killed mobs give points once
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_NPC_MESSAGE      = 9 -- Triggers on a NPC voice line (from chat)
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE  = 10 -- Listening for CSA-alert text
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_DELAY            = 11 -- Split after time delay
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_CUSTOM           = 12 -- Indicates a custom function shall be called every frame. If that function returns true, it will split.
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_BEGIN_ENDLESS    = 13 -- Endless Dungeon only. Triggered by the game.
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_END_ENDLESS      = 14 -- Endless Dungeon only. Triggered by the game.
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_ENDLESS_STAGE    = 15 -- Endless Dungeon only. Triggered by the game. Expects data for
---@type LIVE_SPLIT_TRIGGER
LIVE_SPLIT_TRIGGER_LOCATION_MULTI   = 16 -- All purpose trigger, listening for players in the group being close to a specific point of a list o points.

-- For the most part and most occasions, you most likely only need these triggers:
--
-- LIVE_SPLIT_TRIGGER_ENTER_COMBAT
--      For dungeons and trials where the speedrun condition is "once you enrage the first group of enemies" or something in the like of that.
-- LIVE_SPLIT_TRIGGER_BOSS_ENTER
--      Usually indicates, you reached the boss and cleared all trash beforehand.
--      In most trials and dungeons you can't enter doors to bosses before killing all adds in the area or at least being out of combat.
--      Some bosses can be reached while other enemies are still being fought, e.g. first boss in Hel'Ra or first boss in Fungal Grotto 1.
-- LIVE_SPLIT_TRIGGER_BOSS_DEATH
--      When the boss dies, it's healthbar dissappears. This should be you split point for boss-splits.
--      This does not trigger if you leave the boss area of the boss resets due to a wipe.
-- LIVE_SPLIT_TRIGGER_BEGIN_TRIAL
--      Self explanatory: When you enter the trial doors and the "Trial Started" text appears.
--      This is in all trials the point where the speedrun timer for the achievement starts.
-- LIVE_SPLIT_TRIGGER_LOCATION
--      For normal trials (since they don't have the "Trial Started" text, as they don't have an achievement for a speedrun)
--      and dungeons with timer conditions such as "The timer begins when you enter X".
--      Most of the times it's a specific door you need to step trough. right after exiting the door are the coordinates you want to listen for.
-- LIVE_SPLIT_TRIGGER_LOCATION_INV
--      Same as LIVE_SPLIT_TRIGGER_LOCATION but inverted, meaning if a player is outside a specific range of a point.
-- LIVE_SPLIT_TRIGGER_CUSTOM
--      You can create custom splitting conditions with this one. You need to specify a function for splitFunction.
--      Said function will be called every tick (frame). If the function returns true, a split will be triggered.
--      Additionally, you can specify a setupFunction and a cleanupFunction, the first being called when the trigger is reached and loaded and the cleanup when the split occurs.