--- Contains only luadoc information


---@alias TexturePath string # File path of a texture.

---Table of named string representing a string in differen Langauges
---@class MultiLang
---@field en string English version of the string.
---@field de string? German version of the string.
---@field fr string? French version of the string.
---@field ru string? Russian version of the string.
---@field es string? Spanish version of the string.
---@field zh string? Chinese version of the string.
---@field jp string? Japanese version of the string.


---@alias LIVE_SPLIT_TRIGGER number # Trigger Types.
--- |`LIVE_SPLIT_TRIGGER_ENTER_COMBAT` # Player enters combat state.
--- |`LIVE_SPLIT_TRIGGER_EXIT_COMBAT` # Player leaves combat state.
--- |`LIVE_SPLIT_TRIGGER_BOSS_ENTER` # Advances if the player enters a boss area (= the boss healthbar appears).
--- |`LIVE_SPLIT_TRIGGER_BOSS_DEATH` # Advances if the bosses die (= the boss healthbar disappears, because the boss is gone).
--- |`LIVE_SPLIT_TRIGGER_LOCATION` # All purpose trigger, listening for players in the group being close to a specific point.
--- |`LIVE_SPLIT_TRIGGER_LOCATION_INV` # All purpose trigger, listening for players in the group being outside the range of a specific point.
--- |`LIVE_SPLIT_TRIGGER_BEGIN_TRIAL` # Trial and Arenas on vet only. Triggered by the game. For normal difficulty use Location Trigger and set position to the door that would start the timer on vet.
--- |`LIVE_SPLIT_TRIGGER_MOB_KILLS` # Trials only. Killed mobs give points once.
--- |`LIVE_SPLIT_TRIGGER_NPC_MESSAGE` # Triggers on a NPC voice line (from chat).
--- |`LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE` # Listening for CSA-alert text.
--- |`LIVE_SPLIT_TRIGGER_DELAY` # Split after time delay.
--- |`LIVE_SPLIT_TRIGGER_CUSTOM` # Indicates a custom function shall be called every frame. If that function returns true, it will split.
--- |`LIVE_SPLIT_TRIGGER_BEGIN_ENDLESS` # Endless Dungeon only. Triggered by the game.
--- |`LIVE_SPLIT_TRIGGER_END_ENDLESS` # Endless Dungeon only. Triggered by the game.
--- |`LIVE_SPLIT_TRIGGER_ENDLESS_STAGE` # Endless Dungeon only. Triggered by the game.
--- |`LIVE_SPLIT_TRIGGER_LOCATION_MULTI` # All purpose trigger, listening for players in the group being close to a specific point of a list o points.
--- |`LIVE_SPLIT_TRIGGER_ZONE` # When player enters specific zone.
--- |`LIVE_SPLIT_TRIGGER_BOSS_DEATH_NAMED` # Specify a named boss that needs to perish.
--- |`LIVE_SPLIT_TRIGGER_END_TRIAL` # Trigger for the EVENT_RAID_TRIAL_COMPLETE firing.

---@alias LIVE_SPLIT_TIME number # Predifined times
--- | `LIVE_SPLIT_TIME_15_MINUTES` # 900000  milliseconds
--- | `LIVE_SPLIT_TIME_20_MINUTES` # 1200000 milliseconds
--- | `LIVE_SPLIT_TIME_25_MINUTES` # 1500000 milliseconds
--- | `LIVE_SPLIT_TIME_30_MINUTES` # 1800000 milliseconds
--- | `LIVE_SPLIT_TIME_33_MINUTES` # 1980000 milliseconds
--- | `LIVE_SPLIT_TIME_35_MINUTES` # 2100000 milliseconds
--- | `LIVE_SPLIT_TIME_40_MINUTES` # 2400000 milliseconds
--- | `LIVE_SPLIT_TIME_45_MINUTES` # 2700000 milliseconds

---@alias LIVE_SPLIT_ICON TexturePath # Predifined icons
--- | `LIVE_SPLIT_ICON_BOSS`    # Preset icon for a boss (Crossed swords)
--- | `LIVE_SPLIT_ICON_ENDBOSS` # Preset icon for a final boss (Crossed swords with skull)


---Dataset used by `SplitManager` for data registration.
---@class CategoryData
---@field id string|number Unique ID of the category.
---@field catName string|MultiLang Display name of the category. May be an array of localized string
---@field menuName string? Optional name given priority over the `catName` in the Template Selector menu of the UI widget.
---@field startTrigger LIVE_SPLIT_TRIGGER Trigger type for starting a run. May require optional `LIVE_SPLIT_TRIGGER_DATA`.
---@field startData LIVE_SPLIT_TRIGGER_DATA? Additional data for the trigger. Data depending on selected `startTrigger`-type.
---@field startOffset number? Offset in milliseconds from which the timer will count up to 0 from.
---@field par number? Par time (speedrun time) in milliseconds.
---@field wr number World record time in milliseconds.
---@field wrPlayer string Name of the world record holder.
---@field splits SplitData[] Array (table) of splits/segement data (see below how to form).

---Single split/segment dataset.
---@class SplitData
---@field name string|MultiLang Display name of the segment.
---@field icon TexturePath? Texture to be displayed in front of the split name.
---@field splitTrigger LIVE_SPLIT_TRIGGER Trigger type for automatic advancing.
---@field data LIVE_SPLIT_TRIGGER_DATA? Additional data needed for triggers.

---Base object. Needs to be inherited from.
---@class LIVE_SPLIT_TRIGGER_DATA

-- Reference sheet for `LIVE_SPLIT_TRIGGER` to `LIVE_SPLIT_TRIGGER_DATA`-subtypes:
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_BEGIN_ENDLESS    - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_BEGIN_TRIAL      - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_BOSS_DEATH       - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_BOSS_ENTER       - [optional] LIVE_SPLIT_BOSS_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE  - LIVE_SPLIT_CSA_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_CUSTOM           - LIVE_SPLIT_CUSTOM_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_DELAY            - LIVE_SPLIT_DELAY_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_END_ENDLESS      - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_ENDLESS_STAGE    - LIVE_SPLIT_ENDLESS_DUNGEON_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_ENTER_COMBAT     - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_EXIT_COMBAT      - No additional data
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_LOCATION         - LIVE_SPLIT_LOCATION_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_LOCATION_INV     - LIVE_SPLIT_LOCATION_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_LOCATION_MULTI   - LIVE_SPLIT_LOCATION_TRIGGER_DATA[]
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_MOB_KILLS        - LIVE_SPLIT_MOB_KILL_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_NPC_MESSAGE      - LIVE_SPLIT_NPC_MESSAGE_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_ZONE             - LIVE_SPLIT_ZONE_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_BOSS_DEATH_NAMED - LIVE_SPLIT_BOSS_TRIGGER_DATA
-- LIVE_SPLIT_TRIGGER:LIVE_SPLIT_TRIGGER_END_TRIAL        - No additional data

---Additional data for `LIVE_SPLIT_TRIGGER_BOSS_ENTER`.
---@class LIVE_SPLIT_BOSS_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field filter string[]? Exact match for boss name.
---@field filterMatch string[]? Partial match for boss name using `string.match`.

---Additional data for `LIVE_SPLIT_TRIGGER_CUSTOM`.
---@class LIVE_SPLIT_CUSTOM_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field splitFunction function Funtion that is called every frame. Return true to signal the addon to split.
---@field setupFunction function? Function being called when segment is reached. Will be executed before any other logic. Usually used to setup your `splitFunction`.
---@field cleanupFunction function? Function being called when segment is about so split. Used to cleanup anything touched by your `splitFunction` (for example to properly reset for another try with that category data).

---Additional data for `LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE`.
---@class LIVE_SPLIT_CSA_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field message string[]? Exact match
---@field match string[]? Partial match
---@field subMessage string[]? Exact match (in submessage)
---@field subMatch string[]? Partial match (in submessage)
---@field parsePattern string? Pattern to scan for (main message only)
---@field parseMatch string? Trigger if `parsePattern` return is equal to this `parseMatch`.

---Additional data for `LIVE_SPLIT_TRIGGER_DELAY`.
---@todo
---@class LIVE_SPLIT_DELAY_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field time number Delay time in milliseconds until next split.

---Additional data for `LIVE_SPLIT_TRIGGER_ENDLESS_STAGE`.
---@class LIVE_SPLIT_ENDLESS_DUNGEON_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field arc number Required arc for the state of `LiveSplitEndlessArchiveTrigger` to be in.
---@field cycle number Required cycle for the state of `LiveSplitEndlessArchiveTrigger` to be in.
---@field stage number Required stage for the state of `LiveSplitEndlessArchiveTrigger` to be in.

---Additional data for `LIVE_SPLIT_TRIGGER_LOCATION`, `LIVE_SPLIT_TRIGGER_LOCATION_INV` and `LIVE_SPLIT_TRIGGER_LOCATION_MULTI`.
---@class LIVE_SPLIT_LOCATION_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field x number X coordinate of the location.
---@field y number Y coordinate of the location.
---@field z number? Z coordinate of the location. If left out, a planar distance check will occur.
---@field r number Trigger radius of the location.

---Additional data for `LIVE_SPLIT_TRIGGER_MOB_KILLS`.
---@todo
---@class LIVE_SPLIT_MOB_KILL_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA

---Additional data for `LIVE_SPLIT_TRIGGER_NPC_MESSAGE`. Needs either `message`or `match`.
---@class LIVE_SPLIT_NPC_MESSAGE_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field fromName string? If set, the NPC message must be spoken by the specified from name before further checking.
---@field message string[]? Check for either exact (`message`) or partrial (`match`) match of the message.
---@field match string[]? Check for either exact (`message`) or partrial (`match`) match of the message.

---Additional data for `LIVE_SPLIT_TRIGGER_ZONE`.
---@class LIVE_SPLIT_ZONE_TRIGGER_DATA: LIVE_SPLIT_TRIGGER_DATA
---@field zone number ZoneId to split when player activates there.