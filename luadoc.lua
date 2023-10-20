--- Contains only luadoc information

---@class LIVE_SPLIT_START_DATA
---@field x number
---@field y number
---@field z number
---@field r number

---@class Split
---@field catName string
---@field startTrigger LIVE_SPLIT_TRIGGER
---@field wr number
---@field wrPlayer string
---@field splits table

---@alias LIVE_SPLIT_TRIGGER
--- |`LIVE_SPLIT_TRIGGER_ENTER_COMBAT` # Player enters combat state
--- |`LIVE_SPLIT_TRIGGER_EXIT_COMBAT` # Player leaves combat state
--- |`LIVE_SPLIT_TRIGGER_BOSS_ENTER` # Advances if the player enters a boss area (= the boss healthbar appears)
--- |`LIVE_SPLIT_TRIGGER_BOSS_DEATH` # Advances if the bosses die (= the boss healthbar disappears, because the boss is gone)
--- |`LIVE_SPLIT_TRIGGER_LOCATION` # All purpose trigger, listening for players in the group being close to a specific point
--- |`LIVE_SPLIT_TRIGGER_LOCATION_INV` # All purpose trigger, listening for players in the group being outside the range of a specific point
--- |`LIVE_SPLIT_TRIGGER_BEGIN_TRIAL` # Trial and Arenas on vet only. Triggered by the game. For normal difficulty use Location Trigger and set position to the door that would start the timer on vet.
--- |`LIVE_SPLIT_TRIGGER_MOB_KILLS` # Trials only. Killed mobs give points once
--- |`LIVE_SPLIT_TRIGGER_LOCATION_DELAY` # Starts after a location trigger with a delay also defined in startData
--- |`LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE` # Listening for CSA-alert text
--- |`LIVE_SPLIT_TRIGGER_DELAY` # Split after time delay