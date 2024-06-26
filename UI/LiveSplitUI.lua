LIVE_SPLIT_WIDTH = 300 -- Change this to globally change the width of the UI widget
LIVE_SPLIT_LABEL_WIDTH = LIVE_SPLIT_WIDTH - 70
LIVE_SPLIT_DIFF_WIDTH = 60
LIVE_SPLIT_ROW_HEIGHT = 30

local TIMER_PRECISION_SECONDS 	= 0 -- 1:23:45
local TIMER_PRECISION_TENTHS 	= 1 -- 1:23:45.6
local TIMER_PRECISION_HUNDREDS 	= 2 -- 1:23:45.67
local TIMER_PRECISION_COUNTDOWN = 3 -- 12.34

local LOW_ALPHA = 0.2
local HIGH_ALPHA = 0.5

local MODE_AUTO = 1
local MODE_MIXED = 2
local MODE_MANUAL = 3

local SOURCE_TYPE_SELF = 1		-- Source is this addon itself
local SOURCE_TYPE_ADDON = 2		-- Source is external addon
local SOURCE_TYPE_KEYBIND = 3	-- Source is keybind
local SOURCE_TYPE_MENU = 4		-- Source is UI widget (mouseclick)

LiveSplit = ZO_Object:Subclass()

function LiveSplit:New(control)
    local obj = ZO_Object.New(self)
    obj:Initialize(control)
    return obj
end

function LiveSplit:Initialize(control)
    -- Controls
    self.control = control
    self.controls = {}

    self.language = GetCVar("language.2")

    LIVE_SPLIT_FRAGMENT = ZO_HUDFadeSceneFragment:New(control)
    self.fragment = LIVE_SPLIT_FRAGMENT
    self:SetShown(true) -- This adds the fragment to the ingame UI scene.

    local header = control:GetNamedChild("Header")
    self.controls.headerTitle = header:GetNamedChild("Text")
    self.controls.optionsButton = header:GetNamedChild("OptionsButton")
    self.controls.splits = control:GetNamedChild("Splits")
    self.controls.background = control:GetNamedChild("BG")
    local summary = control:GetNamedChild("Summary")
    local additional = control:GetNamedChild("Additional")

    self.controls.timer = summary:GetNamedChild("Time")
    self.controls.splittimer = summary:GetNamedChild("SplitTime")
    self.controls.previousSegementLabel = additional:GetNamedChild("PreviousSegmentTime")
    self.controls.bestPossibleTimeLabel = additional:GetNamedChild("BestPossibleTime")
    self.controls.sumOfBestSegmentsLabel = additional:GetNamedChild("BestSegmentsTime")
    self.controls.personalBestLabel = additional:GetNamedChild("PersonalBestTime")
    self.controls.worldRecordTimeLabel = additional:GetNamedChild("RecordTime")
    self.controls.worldRecordHolderLabel = additional:GetNamedChild("RecordHolder")
    self.controls.summary = summary
    self.controls.additional = additional

    self.difficulty = DUNGEON_DIFFICULTY_NONE

    self.totaltime = 0
    self.activerun = false
    self.timerenabled = false
    self.currentsplit = 1
    self.currentSplitStartTime = 0
    self.lastSelectedCategory = ""
    self.freshInstance = true
    self.splitdata = {}
    self.uncommitedTimes = {}

    -- Listeners
    self.coordinateListener = LiveSplitCoordinateTrigger:New()
    self.coordinateListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

    self.csaListener = LiveSplitCSATrigger:New()
    self.csaListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

    self.npcListener = LiveSplitNPCMessageTrigger:New()
    self.npcListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

    self.delayListener = LiveSplitDelayTrigger:New()
    --self.delayListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

    self.endlessArchiveListener = LiveSplitEndlessArchiveTrigger:New()
    self.endlessArchiveListener:RegisterCallback("OnTrigger", function() self:OnTrigger() end)

    -- Row Pool
    local function RowFactory(pool, objectKey)
        local row = ZO_ObjectPool_CreateNamedControl(pool.name, pool.templateName, pool, pool.parent)
        row.time = row:GetNamedChild("Time")
        row.diff = row:GetNamedChild("Diff")
        row.name = row:GetNamedChild("Name")
        row.icon = row:GetNamedChild("Icon")
        row.bg = row:GetNamedChild("BG")
        return row
    end

    local function RowReset(row, pool)
        row.diff:SetText()
        row.diff:SetColor(1, 1, 1)
        row.bg:SetColor(0, 0, 0)
        row.name:SetWidth(LIVE_SPLIT_LABEL_WIDTH)
        row:SetHidden(true)
        row:ClearAnchors()
    end

    self.rowpool = ZO_ControlPool:New("LiveSplitTimerRow" , self.controls.splits)
    self.rowpool:SetFactory(RowFactory)
    self.rowpool:SetResetFunction(RowReset)

    --Misc
    self.maxsplitsshown = 7
    self.splitEntries = {}
    self.mode = MODE_MIXED

    --Events
    self:AddEvents()

    --Initial update
    self:UpdateSplitEntries()
end

function LiveSplit:GetLocalizedName(object)
    return type(object) == "table" and object[self.language] or object
end

function LiveSplit:AddEvents()
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_PLAYER_ACTIVATED, function() self:OnPlayerActivated() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_RAID_TRIAL_STARTED, function() self:StartTimer(SOURCE_TYPE_SELF) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_RAID_TRIAL_COMPLETE, function() self:OnTrigger() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_BOSSES_CHANGED, function() self:OnBossChange() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_UNIT_DEATH_STATE_CHANGED, function(evt, unitTag, isDead) self:OnUnitDeath(unitTag, isDead) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_PLAYER_COMBAT_STATE, function(code, inCombat) self:OnCombatStateChanged(inCombat) end)
    EVENT_MANAGER:RegisterForUpdate("LiveSplit", nil, function() self:OnTick() end)
end

function LiveSplit:OnTick()
    if self.timerenabled then
        if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_CUSTOM then
            local split = self:GetCurrentSplit()
            if not split.splitFunction or type(split.splitFunction) ~= "function" then
                DBG:Critical("Current split trigger is set to custom function, but no function is defined!")
                self:StopTimer(SOURCE_TYPE_SELF)
            else
                if split.splitFunction() == true then
                    self:Split(SOURCE_TYPE_SELF)
                end
            end
        end

        -- This should be in theory frame rate independet, if the game runtime value is not coupled to a fps based update loop.
        self.totaltime = GetGameTimeMilliseconds() - self.starttime

        self:UpdateMainTimer()
        self:UpdateSplitTimer()
        self:UpdateCurrentSplitRow()
    end
end

local lastZoneId = 0
function LiveSplit:OnPlayerActivated()
    DBG:Debug("OnPlayerActivated()")

    local currentZone = GetZoneId(GetUnitZoneIndex("player"))

    if lastZoneId == 0 then
        lastZoneId = currentZone
        self.freshInstance = true
    end

    if self.activerun then
        if currentZone == self.zoneId then
            DBG:Info("Player activated in same zone. Continuing run.")
        else
            if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_ZONE then
                local data = self:GetCurrentSplitData()
                DBG:LuaAssert(data.zone and type(data.zone == "number"), "Split trigger is LIVE_SPLIT_TRIGGER_ZONE but either no zoneId given or given zoneId is not a number")
                if data.zone == currentZone then
                    DBG:Info("Player changed zone to target zone. Splitting...")
                    self:Split(SOURCE_TYPE_SELF)
                end
            else
                lastZoneId = currentZone
                DBG:Info("Player exited zone. Resetting...")
                self.freshInstance = true
                self:Reset(SOURCE_TYPE_SELF)
            end
        end
    else
        -- Player has either a completed run or no started run
        self.zoneId = currentZone
        self.difficulty = GetCurrentZoneDungeonDifficulty()

        local diffNames = {
            [DUNGEON_DIFFICULTY_NONE] = "None",
            [DUNGEON_DIFFICULTY_NORMAL] = "Normal",
            [DUNGEON_DIFFICULTY_VETERAN] = "Veteran"
        }
        DBG:Info("Updating zone to <<1>> and difficulty to <<2>>", self.zoneId, diffNames[self.difficulty])

        local availableSplits = SPLIT_MANAGER:GetSplitsForZoneAndDifficulty(self.zoneId, self.difficulty)
        if #availableSplits > 0 then
            self:SetShown(true)

            if #availableSplits > 1  then
                DBG:Log("This zone has multiple speed run splits!", DBG_NORMAL)
            end

            -- Try and set last selected category
            for index, data in pairs(availableSplits) do
                if data.id == self.lastSelectedCategory then
                    DBG:Debug("Found manual selected category from previous visit to instance. Restoring selection.")
                    self:SetSelectedSplit(availableSplits[index])
                    return
                end
            end
            -- If no match is found, select first split from available list
            self:SetSelectedSplit(availableSplits[1])
            return
        else
            self:SetShown(false)
        end
    end
end

function LiveSplit:OnBossChange()
    if not self.timerenabled then return end
    if not self.selectedSplit then return end

    if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_BOSS_ENTER then
        local bossFound = false
        local bossUnitTag = ""
        for i = 1, MAX_BOSSES do
            if DoesUnitExist("boss"..i) then
                bossFound = true
                bossUnitTag = "boss"..i
            end
        end
        if bossFound then
            local bossName = GetUnitName(bossUnitTag)
            local splitData = self:GetCurrentSplitData()

            if splitData and splitData.filter then
                for _, filter in pairs(splitData.filter) do
                    if filter == bossName then
                        DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with exact match.", bossName)
                        self:Split(SOURCE_TYPE_SELF)
                        break
                    end
                end
            elseif splitData and splitData.filterMatch then
                for _, filterMatch in pairs(splitData.filterMatch) do
                    if string.find(bossName, filterMatch) then
                        DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with match.", bossName)
                        self:Split(SOURCE_TYPE_SELF)
                        break
                    end
                end
            else
                DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger.", bossName)
                self:Split(SOURCE_TYPE_SELF)
            end
        end
    end
end

function LiveSplit:OnUnitDeath(unitTag, isDead)
    if not self.activerun then return end

    if string.sub(unitTag, 1, 4) == "boss" and isDead then
        if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_BOSS_DEATH_NAMED then
            local bossName = GetUnitName(unitTag)
            local splitData = self:GetCurrentSplitData()

            if splitData and splitData.filter then
                for _, filter in pairs(splitData.filter) do
                    if filter == bossName then
                        DBG:Info("Specifically named boss <<1>> died. Splitting with exact match.", bossName)
                        self:Split(SOURCE_TYPE_SELF)
                        return
                    end
                end
            elseif splitData and splitData.filterMatch then
                for _, filterMatch in pairs(splitData.filterMatch) do
                    if string.find(bossName, filterMatch) then
                        DBG:Info("Specifically named boss <<1>> died. Splitting with match.", bossName)
                        self:Split(SOURCE_TYPE_SELF)
                        return
                    end
                end
            end
        elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_BOSS_DEATH then
            local numbosses = 0
            local numdead = 0
            for i = 1, MAX_BOSSES do
                if DoesUnitExist("boss"..i) then
                    numbosses = numbosses + 1
                    if IsUnitDead("boss"..i) then
                        numdead = numdead + 1
                    end
                end
            end
            if numbosses == numdead then
                DBG:Info("All bosses gone. Splitting due to BOSS_DEATH trigger.")
                self:Split(SOURCE_TYPE_SELF)
                return
            end
        end
    end
end

function LiveSplit:OnCombatStateChanged(isInCombat)
    if not self.activerun and not self.timerenabled and isInCombat and self.selectedSplit then
        if self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_ENTER_COMBAT then
            DBG:Info("Player engaged in combat and starting condition is enter combat. Starting run...")
            self:StartTimer(SOURCE_TYPE_SELF)
        end
    end
end

function LiveSplit:OnTrigger(target)
    if not self.selectedSplit then return end

    -- Run is not started which means we need to start a run
    if not self.timerenabled then
        if self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION or self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
            DBG:Info("Player entered trigger. Starting run...")
            self:StartTimer(SOURCE_TYPE_SELF)
        elseif self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_MULTI then
            DBG:Info("Player entered one of the start triggers. Starting run...")
            self.coordinateListener:ClearTargets()
            self:StartTimer(SOURCE_TYPE_SELF)
        elseif self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
            DBG:Info("Magic words have been spoken. Starting run...")
            self:StartTimer(SOURCE_TYPE_SELF)
        elseif self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_BEGIN_ENDLESS and self.endlessArchiveListener.runStarted then
            DBG:Info("Player started endless dungeon. Starting run...")
            self:StartTimer(SOURCE_TYPE_SELF)
        elseif self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE then
            DBG:Info("Center Annouce showed with magic words. Starting run...")
            self:StartTimer(SOURCE_TYPE_SELF)
        else
            DBG:Warn("Something triggered, but no run is going on and it's not handled!")
        end
        return
    end

    -- Run is started so we need to find out how to handle the triggering
    local currentSplitTrigger = self:GetCurrentSplitTrigger()
    if currentSplitTrigger == LIVE_SPLIT_TRIGGER_LOCATION or self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
        DBG:Info("Player entered trigger. Splitting due to location trigger.")
        self:Split(SOURCE_TYPE_SELF)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_LOCATION_MULTI then
        DBG:Info("Player entered one of the triggers. Splitting due to location trigger.")
        self.coordinateListener:ClearTargets()
        self:Split(SOURCE_TYPE_SELF)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE then
        DBG:Info("Received CSA Message. Splitting due to message match to trigger condition.")
        self:Split(SOURCE_TYPE_SELF)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
        DBG:Info("NPCMessage triggered.")
        self:Split(SOURCE_TYPE_SELF)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_DELAY then
        -- TODO
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_ENDLESS_STAGE then
        local arc, cycle, stage = self.endlessArchiveListener:GetCurrentProgress()
        local currentSplitData = self:GetCurrentSplitData()
        if not currentSplitData or currentSplitData == {} then
            DBG:Error("Missing data for Endless Dungeon progress check! There will be no automatic splitting due to this!")
        else
            if not currentSplitData.arc or not currentSplitData.cycle or not currentSplitData.stage then
                DBG:Error("Arc, Cycle or Stage data is not set fur the current split! There will be no automatic splitting due to this!")
            end
        end
        if 	currentSplitData.arc == arc and currentSplitData.cycle == cycle and currentSplitData.stage == stage then
            DBG:Info("Splitting due to achieved desired Endless Dungeon progress.")
            self:Split(SOURCE_TYPE_SELF)
        end
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_END_TRIAL then
        DBG:Info("Splitting due to trial end trigger.")
        self:Split(SOURCE_TYPE_SELF)
    else
        DBG:Warn("Something triggered, but type is not handled!")
    end
end

function LiveSplit:GetCurrentSplit()
    if not self.selectedSplit then return end
    return self.selectedSplit.splits[self.currentsplit]
end

function LiveSplit:GetCurrentSplitData()
    if not self.selectedSplit then return end
    return self.selectedSplit.splits[self.currentsplit].data or {}
end

function LiveSplit:GetCurrentSplitTrigger()
    if not self.selectedSplit then return end
    return self.selectedSplit.splits[self.currentsplit].splitTrigger
end

function LiveSplit:AddSplitEntry(displayname, icon, personalbest)
    local entry = {
        name = displayname,
        icon = icon,
        pb = personalbest,
    }
    table.insert(self.splitEntries, entry)
end

local function IsEntryToBeShown(index, currentIndex, numshown, maxshown, maxdata)
    if index > maxdata then return false end
    if index < 1 then return false end
    if numshown >= maxshown then
        return false
    end

    local upperbound = math.min(currentIndex + 1, maxdata)
    local lowerbound = upperbound - maxshown

    if lowerbound < 0 then
        lowerbound = 0
        upperbound = maxshown
    end

    if index > lowerbound then
        return index <= upperbound
    else
        return false
    end
end

function LiveSplit:UpdateSplitEntries()
    self.rowpool:ReleaseAllObjects()

    local pbsum = 0

    local numshown = 0
    for i, entry in ipairs(self.splitEntries) do
        if IsEntryToBeShown(i, self.currentsplit, numshown, self.maxsplitsshown, #self.splitEntries) then
            numshown = numshown + 1

            local row, key = self.rowpool:AcquireObject()
            if i == self.currentsplit then
                self.currentRow = key
            end

            row:SetAnchor(TOPLEFT, nil, TOPLEFT, 0, (numshown - 1) * LIVE_SPLIT_ROW_HEIGHT)

            local name = self:GetLocalizedName(entry.name)

            row.name:SetText(name)
            if entry.icon then
                row.icon:SetTexture(entry.icon)
                row.icon:SetHidden(false)
            else
                row.icon:SetHidden(true)
            end

            row.bg:SetAlpha((i % 2 == 1 or i == self.currentsplit) and LOW_ALPHA or HIGH_ALPHA)

            if entry.pb then
                pbsum = pbsum + entry.pb
                row.time:SetText(self:FormatTime(pbsum, TIMER_PRECISION_SECONDS))

                if entry.diff and (entry.diff > -60000 and entry.diff < 60000) then
                    local diff = self:FormatTime(math.abs(entry.diff), TIMER_PRECISION_COUNTDOWN)
                    row.diff:SetText(entry.diff < 0 and "-" .. diff or diff)
                    if entry.diff < 0 then
                        row.diff:SetColor(0, 1, 0)
                    else
                        row.diff:SetColor(1, 0, 0)
                    end
                    row.name:SetWidth(LIVE_SPLIT_LABEL_WIDTH - LIVE_SPLIT_DIFF_WIDTH)
                else
                    row.diff:SetText()
                    row.name:SetWidth(LIVE_SPLIT_LABEL_WIDTH)
                end
            else
                row.time:SetText("-")
            end
            row.data = entry
        end
    end

    self.controls.splits:SetHeight(#self.splitEntries * LIVE_SPLIT_ROW_HEIGHT)
    self.controls.splits:SetHeight(numshown * LIVE_SPLIT_ROW_HEIGHT)
    --self.controls.summary:SetAnchor(TOPLEFT,  self.controls.splits, BOTTOMLEFT)
    --self.controls.summary:ClearAnchors()
    --self.controls.summary:SetAnchor(TOPRIGHT, self.controls.splits, BOTTOMRIGHT)
end

function LiveSplit:FormatTime(milliseconds, precicion)
    local sign = ""
    -- Return blank if negative time is given
    if milliseconds < 0 then
        sign = "-"
        milliseconds = -milliseconds
        --return "-"
    end

    local ms = milliseconds % 1000
    local secs = milliseconds - ms
    local frac = ms / 1000 + 0.0001

    local strSec = ZO_FormatTimeMilliseconds(secs, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TENTHS)

    -- French specific formatting......
    if self.lang == "fr" then
        strSec = string.gsub(strSec, "j ", ":") -- Maybe overkill?
        strSec = string.gsub(strSec, "h ", ":")
        strSec = string.gsub(strSec, "m ", ":")
        strSec = string.gsub(strSec, "s", "")
    end

    if precicion == TIMER_PRECISION_COUNTDOWN then -- Expected sub 60 seconds, otherwise, total seconds would be displayed, i.e. 123.4 instead of 2:03.4
        return string.format("%.1f", milliseconds / 1000)
    elseif precicion == TIMER_PRECISION_SECONDS then
        return strSec
    elseif precicion == TIMER_PRECISION_TENTHS then
        return string.format("%s%s.%s", sign, strSec, string.sub(string.format("%.1f", frac), 3))
    else -- precicion == TIMER_PRECISION_HUNDREDS
        return string.format("%s%s.%s", sign, strSec, string.sub(string.format("%.2f", frac), 3))
    end
end

function LiveSplit:UpdateMainTimer()
    self.controls.timer:SetText(self:FormatTime(self.totaltime))
end

function LiveSplit:UpdateSplitTimer()
    self.controls.splittimer:SetText(self:FormatTime(self.totaltime - self.currentSplitStartTime))
end

function LiveSplit:UpdateCurrentSplitRow()
    if not self.activerun then return end

    -- Get current splits row-control
    local row = self.rowpool:GetActiveObject(self.currentRow)

    -- Highlight current row in blue
    row.bg:SetColor(0.25, 0.33, 0.75)

    -- If there is a personal best, we can calculate split differences
    if row.data.pb then
        -- if current split time is +/- 60s show the difference timer
        local splittime = self.totaltime - self.currentSplitStartTime
        if splittime > row.data.pb - 60000 and splittime < row.data.pb + 60000 then
            local difference = splittime - row.data.pb
            local diff = self:FormatTime(math.abs(difference), TIMER_PRECISION_COUNTDOWN)

            self.splitEntries[self.currentsplit].diff = difference
            row.diff:SetText(difference < 0 and "-" .. diff or diff)
            if difference < 0 then
                row.diff:SetColor(0, 1, 0)
            else
                row.diff:SetColor(1, 0, 0)
            end
            row.name:SetWidth(LIVE_SPLIT_LABEL_WIDTH - LIVE_SPLIT_DIFF_WIDTH)
        else
            -- Reset to normal, if it doesn't apply
            row.diff:SetText()
            row.name:SetWidth(LIVE_SPLIT_LABEL_WIDTH)
        end
    else
        row.diff:SetText() -- Just to be sure ;)
    end
end

function LiveSplit:GetSumBestSegments(offset)
    local offset = offset or 1
    local total = 0
    if self.SV[self.selectedSplit.id] and self.SV[self.selectedSplit.id][self.difficulty] then
        -- Bail if there are less saved split tims than there are splits
        if #self.SV[self.selectedSplit.id][self.difficulty] ~= #self.selectedSplit.splits then
            return -1
        end

        for i, t in ipairs(self.SV[self.selectedSplit.id][self.difficulty]) do
            if i >= offset then
                total = total + t
            end
        end

        if not self.activerun and offset == #self.selectedSplit.splits then
            return self.totaltime
        elseif offset > 1 then
            return total + self.totaltime
        else
            return total
        end
    else
        return -1
    end
end

function LiveSplit:GetBestPossibleTime()
    return self:GetSumBestSegments(self.currentsplit)
end

function LiveSplit:SetSelectedSplit(split)
    -- Reset all timers
    self:Reset(SOURCE_TYPE_SELF)

    self.selectedSplit = split

    if not split.catName then
        DBG:Error("Selected split is missing catName!")
        return
    end

    local name = self:GetLocalizedName(split.catName)
    self.controls.headerTitle:SetText(name)

    -- Build splits list
    if not split.splits or type(split.splits) ~= "table" then
        DBG:Error("Selected split is missing split data or split data is not a table!")
        return
    end
    ZO_ClearNumericallyIndexedTable(self.splitEntries)
    for i, s in ipairs(split.splits) do
        local pb = nil
        if self.SV[split.id] and self.SV[split.id][self.difficulty] then
            pb = self.SV[split.id][self.difficulty][i]
        end
        self:AddSplitEntry(s.name, s.icon, pb) -- Any of these may be nil, but this won't break anything.
    end
    self:UpdateSplitEntries()

    -- Main timer, optional time offset
    if self.selectedSplit.startOffset then
        DBG:LuaAssert(type(self.selectedSplit.startOffset == "number"), "Selected split's startOffset is not a number!")
        DBG:Info("This split category has a timed start offset of <<1>>", self.selectedSplit.startOffset)
        self.totaltime = self.totaltime - self.selectedSplit.startOffset
        self:UpdateMainTimer()
    end

    -- Previous segment
    self.controls.previousSegementLabel:SetText("-")

    -- Best possible time
    local bestpossible = self:GetBestPossibleTime()
    if bestpossible > 0 then
        self.controls.bestPossibleTimeLabel:SetText(self:FormatTime(bestpossible, TIMER_PRECISION_SECONDS))
    else
        self.controls.bestPossibleTimeLabel:SetText("-")
    end

    -- Sum of best segements
    local sumofbest = self:GetSumBestSegments()
    if sumofbest > 0 then
        self.controls.sumOfBestSegmentsLabel:SetText(self:FormatTime(sumofbest, TIMER_PRECISION_SECONDS))
    else
        self.controls.sumOfBestSegmentsLabel:SetText("-")
    end

    -- Personal best
    local pb = -1
    if self.SV[self.selectedSplit.id] and self.SV[self.selectedSplit.id][self.difficulty] then
        pb = self.SV[self.selectedSplit.id][self.difficulty]["PB"] or -1
    end

    if pb > 0 then
        self.controls.personalBestLabel:SetText(self:FormatTime(pb, TIMER_PRECISION_TENTHS))
    else
        self.controls.personalBestLabel:SetText("-")
    end

    -- World record
    self.controls.worldRecordTimeLabel:SetText(zo_strformat(SI_LIVE_SPLIT_WR, self:FormatTime(split.wr, TIMER_PRECISION_TENTHS)))
    self.controls.worldRecordHolderLabel:SetText(zo_strformat(SI_LIVE_SPLIT_WR_BY, split.wrPlayer))

    -- Start Trigger handling
    local IS_START_TRIGGER = true
    self:SetupTriggersForSplit(IS_START_TRIGGER)

    local left, top = self.control:GetLeft(), self.control:GetTop()
    self.control:SetHeight()
    self.control:ClearAnchors()
    self.control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function LiveSplit:SetScale(scale)
    DBG:LuaAssert(type(scale) == "number", "scale is not a number!")
    DBG:Debug("Setting scale to <<1>>", tostring(scale))
    ESOLS.SV.scale = scale
    self.control:SetScale(scale)
end

function LiveSplit:SetMaxDisplaySplits(maxSplits)
    DBG:LuaAssert(type(maxSplits) == "number", "maxSplits is not a number!")
    self.maxsplitsshown = maxSplits
    ESOLS.SV.maxsplitsshown = maxSplits
    DBG:Info("Showing <<1>> entries in the list.", maxSplits)
    self:UpdateSplitEntries()
end

function LiveSplit:ShowAdditionalInfo(showInfo)
    ESOLS.SV.additionalInfo = showInfo
    DBG:Debug("showinfo=<<1>>", tostring(showInfo))
    if showInfo == true then
        self.controls.additional:SetHidden(false)
        self.controls.background:ClearAnchors()
        self.controls.background:SetAnchor(TOPLEFT, self.control)
        self.controls.background:SetAnchor(BOTTOMRIGHT, self.controls.additional)
    else
        self.controls.additional:SetHidden(true)
        self.controls.background:ClearAnchors()
        self.controls.background:SetAnchor(TOPLEFT, self.control)
        self.controls.background:SetAnchor(BOTTOMRIGHT, self.controls.summary)
    end
end

function LiveSplit:UpdateMode(mode)
    if mode == 1 then -- Automatic
        self.mode = MODE_AUTO
        ESOLS.SV.mode = MODE_AUTO
    elseif mode == 2 then -- Mixed
        self.mode = MODE_MIXED
        ESOLS.SV.mode = MODE_MIXED
    elseif mode == 3 then -- Manual
        self.mode = MODE_MANUAL
        ESOLS.SV.mode = MODE_MANUAL
    else
        DBG:Error("Tried to set unsupported operation mode <<1>>. Defaulting to Automatic (1)", mode)
        self.mode = MODE_AUTO
        ESOLS.SV.mode = MODE_AUTO
    end
end

function LiveSplit:SourceAllowedForCurrentMode(source)
    if source == SOURCE_TYPE_SELF then
        if self.mode > MODE_MIXED then
            DBG:Warn("Internal requested action, but current mode disallows automatic actions.")
            return false
        end
    elseif source == SOURCE_TYPE_ADDON then
        -- External addons calling. Maybe handle in a specific way
        DBG:Error("External request for action. Currently unsupported!")
        return false
    elseif source == SOURCE_TYPE_KEYBIND then
        if self.mode < MODE_MIXED then
            DBG:Warn("User requested action, but current mode disallows manual actions.")
            return false
        end
    elseif source == SOURCE_TYPE_MENU then
        -- Split from menu always allowed, as bugs may happen :')
        DBG:Info("Requested from menu.")
    else
        DBG:Warn("No or invalid splitting source provided! This may cancel your request in a later version!")
    end
    return true
end

function LiveSplit:Reset(source)
    -- Mode handling
    if not self:SourceAllowedForCurrentMode(source) then return end

    DBG:Warn("Resetting timers!")

    self.totaltime = 0
    self.currentsplit = 1
    self.currentSplitStartTime = 0
    self.activerun = false
    self.timerenabled = false
    self.uncommitedTimes = {}

    -- Clear all listeners
    self.coordinateListener:ClearTargets()
    self.npcListener:ClearTargets()
    self.delayListener:ClearTargets()
    self.csaListener:ClearTargets()

    self:UpdateMainTimer()
    self:UpdateSplitTimer()

    if source == SOURCE_TYPE_MENU then
        self:OnPlayerActivated() -- Force UI reloading current zone splits
    end
end

function LiveSplit:StartTimer(source)
    if not self.selectedSplit then return end
    if not self.freshInstance then
        DBG:Info("Requested timer start in a already used instance. Please change zones to reset to a fresh instance.")
        return
    end

    -- Mode handling
    if not self:SourceAllowedForCurrentMode(source) then return end

    self.currentsplit = 1
    self.starttime = GetGameTimeMilliseconds()

    -- Time deviation timer
    self.starttimeTimestamp = GetTimeStamp()

    if self.selectedSplit and self.selectedSplit.startOffset then
        DBG:Info("This split category has a timed start offset of <<1>>", self.selectedSplit.startOffset)
        self.totaltime = 0 --Need to reset this back to 0 as it has been set to the offset earlier by the SetSelectedSplit() method
        self.starttime = self.starttime + self.selectedSplit.startOffset
    end
    self.activerun = true
    self.timerenabled = true

    -- Setup first Trigger
    self:SetupTriggersForSplit()

    local catName = type(self.selectedSplit.catName) == "table" and self.selectedSplit.catName["en"] or self.selectedSplit.catName
    DBG:Info("Starting new run for '<<1>>'", catName)
end

function LiveSplit:StopTimer(source)
    if not self.selectedSplit then return end

    -- Mode handling
    if not self:SourceAllowedForCurrentMode(source) then return end

    DBG:Info("Stopping timer")

    -- Setup for time saving
    if not self.SV[self.selectedSplit.id] then
        self.SV[self.selectedSplit.id] = {}
    end
    if not self.SV[self.selectedSplit.id][self.difficulty] then
        self.SV[self.selectedSplit.id][self.difficulty] = {}
    end
    -- Individual best times, if not already committed
    if not self.commitImmediatly then
        DBG:Info("Saving split times...")
        for splitindex, splittime in pairs(self.uncommitedTimes) do
            if not self.SV[self.selectedSplit.id][self.difficulty][splitindex] then
                DBG:Info("Added best time for split '<<1>>': <<2>>.", self.selectedSplit.splits[splitindex].name, splittime)
                self.SV[self.selectedSplit.id][self.difficulty][splitindex] = splittime
            else
                if splittime < self.SV[self.selectedSplit.id][self.difficulty][splitindex] then
                    DBG:Info("Achieved new best time for split '<<1>>': <<2>>!", self.selectedSplit.splits[splitindex].name, splittime)
                    self.SV[self.selectedSplit.id][self.difficulty][splitindex] = splittime
                end
            end
        end
    end
    -- Personal best
    if self.SV[self.selectedSplit.id][self.difficulty]["PB"] then
        if self.totaltime < self.SV[self.selectedSplit.id][self.difficulty]["PB"] then
            DBG:Info("Achieved new overall best time for '<<1>>': <<2>>!", self.selectedSplit.id, self.totaltime)
            self.SV[self.selectedSplit.id][self.difficulty]["PB"] = self.totaltime
            self.controls.personalBestLabel:SetText(self:FormatTime(self.totaltime, TIMER_PRECISION_TENTHS))
        end
    else
        DBG:Info("Recorded overall best time for '<<1>>': <<2>>.", self.selectedSplit.id, self.totaltime)
        self.SV[self.selectedSplit.id][self.difficulty]["PB"] = self.totaltime
        self.controls.personalBestLabel:SetText(self:FormatTime(self.totaltime, TIMER_PRECISION_TENTHS))
    end

    -- Setting this so no further stages trigger anything and the timer just stands stopped.
    self.endlessArchiveListener.runComplete = true

    self.timerenabled = false
    self.activerun = false
end

function LiveSplit:Split(source)
    if not self.timerenabled then return end
    if not self.selectedSplit then return end

    -- Mode handling
    if not self:SourceAllowedForCurrentMode(source) then return end

    local splittime = self.totaltime - self.currentSplitStartTime
    local splitName = type(self.selectedSplit.splits[self.currentsplit].name) == "table" and self.selectedSplit.splits[self.currentsplit].name["en"] or self.selectedSplit.splits[self.currentsplit].name
    DBG:Info("Splitting the split '<<1>>' with a time of <<2>>", splitName, self:FormatTime(splittime, TIMER_PRECISION_TENTHS))


    if self.commitImmediatly then
        if not self.SV[self.selectedSplit.id] then
            self.SV[self.selectedSplit.id] = {}
        end
        if not self.SV[self.selectedSplit.id][self.difficulty] then
            self.SV[self.selectedSplit.id][self.difficulty] = {}
        end

        if not self.SV[self.selectedSplit.id][self.difficulty][self.currentsplit] then
            self.SV[self.selectedSplit.id][self.difficulty][self.currentsplit] = splittime
        else
            if splittime < self.SV[self.selectedSplit.id][self.difficulty][self.currentsplit] then
                DBG:Info("Achieved new best time for split '<<1>>'!", self.selectedSplit.splits[self.currentsplit].name)
                self.SV[self.selectedSplit.id][self.difficulty][self.currentsplit] = splittime
            end
        end
    else
        self.uncommitedTimes[self.currentsplit] = splittime
    end

    self.splitEntries[self.currentsplit].pb = splittime

    self.currentSplitStartTime = self.totaltime

    local deviance = self.starttimeTimestamp + (self.totaltime / 1000) - GetTimeStamp()
    if zo_floor(deviance) ~= 0 then
        DBG:Warn("Timer deviance! <<1>>s", string.format("%.2f", deviance))
    end

    local currentSplit = self:GetCurrentSplit()

    if currentSplit.cleanupFunction and type(currentSplit.cleanupFunction) == "function" then
        currentSplit.cleanupFunction()
    end

    if self.currentsplit < #self.selectedSplit.splits then
        self.currentsplit = self.currentsplit + 1
        self:SetupTriggersForSplit()
    else
        DBG:Info("No further splits left. Stopping run.")
        DBG:Info("Stopping timer with a time of <<1>>", self:FormatTime(self.totaltime, TIMER_PRECISION_HUNDREDS))
        self:StopTimer(SOURCE_TYPE_SELF)
    end

    self.controls.bestPossibleTimeLabel:SetText(self:FormatTime(self:GetBestPossibleTime(), TIMER_PRECISION_SECONDS))
    self.controls.sumOfBestSegmentsLabel:SetText(self:FormatTime(self:GetSumBestSegments(), TIMER_PRECISION_SECONDS))
    self.controls.previousSegementLabel:SetText(self:FormatTime(splittime, TIMER_PRECISION_TENTHS))

    self:UpdateSplitEntries()
end

function LiveSplit:SetupTriggersForSplit(isStartTrigger)
    local currentSplitData = self:GetCurrentSplitData()
    local currentSplitTrigger = self:GetCurrentSplitTrigger()

    if isStartTrigger == true then
        currentSplitData = self.selectedSplit.startData
        currentSplitTrigger = self.selectedSplit.startTrigger
    end

    if currentSplitTrigger == LIVE_SPLIT_TRIGGER_LOCATION then
        local target = {
            x = currentSplitData.x,
            y = currentSplitData.y,
            z = currentSplitData.z,
            r = currentSplitData.r,
            zone = self.selectedSplit.zone,
        }
        self.coordinateListener:Listen(target)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
        local target = {
            x = currentSplitData.x,
            y = currentSplitData.y,
            z = currentSplitData.z,
            r = currentSplitData.r,
            zone = self.selectedSplit.zone,
            inverted = true,
        }
        self.coordinateListener:Listen(target)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_LOCATION_MULTI then
        for _, data in pairs(currentSplitData) do
            local target = {
                x = data.x,
                y = data.y,
                z = data.z,
                r = data.r,
                zone = self.selectedSplit.zone,
            }
            self.coordinateListener:Listen(target)
        end
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_CUSTOM then
        -- Get current split
        local currentSplit = self:GetCurrentSplit()
        if isStartTrigger == true then
            currentSplit = currentSplitData
        end

        -- If a setup function is defined, call it.
        if currentSplit.setupFunction and type(currentSplit.setupFunction) == "function" then
            currentSplit.setupFunction()
        end
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
        local target = {
            message  = currentSplitData.message,
            match 	 = currentSplitData.match,
            fromName = currentSplitData.fromName,
        }
        self.npcListener:Listen(target)
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_BEGIN_TRIAL and self.difficulty ~= DUNGEON_DIFFICULTY_VETERAN then
        if isStartTrigger == true then
            DBG:Error("Category start trigger is begin trial, but difficulty is not veteran! This event does not fire on non-veteran content!")
        else
            DBG:Error("Split trigger is begin trial, but this is not a starting trigger!")
        end
    elseif currentSplitTrigger == LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE then
        local target = {
            message = currentSplitData.message,
            match = currentSplitData.match,
            subMessage = currentSplitData.subMessage,
            subMatch = currentSplitData.subMatch,
            parsePattern = currentSplitData.parsePattern,
            parseMatch = currentSplitData.parseMatch,
        }
        self.csaListener:Listen(target)
    end
end

function LiveSplit:ShowOptionsMenu()
    ClearMenu()
    -- Split
    AddCustomMenuItem(GetString(SI_LIVE_SPLIT_MANUAL_SPLIT), function()
        DBG:Log("Manually splitting!", DBG_NORMAL)
        self:Split(SOURCE_TYPE_MENU)
    end)
    -- Start
    AddCustomMenuItem(GetString(SI_LIVE_SPLIT_TIMER_START), function()
        DBG:Log("Manually starting!", DBG_NORMAL)
        self:StartTimer(SOURCE_TYPE_MENU)
    end)
    -- Stop
    AddCustomMenuItem(GetString(SI_LIVE_SPLIT_TIMER_STOP), function()
        DBG:Log("Manually stopping!", DBG_NORMAL)
        self:StopTimer(SOURCE_TYPE_MENU)
    end)
    -- Reset
    AddCustomMenuItem(GetString(SI_LIVE_SPLIT_RESET), function()
        DBG:Log("Manually resetting!", DBG_NORMAL)
        self:Reset(SOURCE_TYPE_MENU)
    end)

    -- Scale
    local scaleMenuEntries = {
        { label = "50%",  callback = function() self:SetScale(0.50) end},
        { label = "60%",  callback = function() self:SetScale(0.60) end},
        { label = "75%",  callback = function() self:SetScale(0.75) end},
        { label = "80%",  callback = function() self:SetScale(0.80) end},
        { label = "85%",  callback = function() self:SetScale(0.85) end},
        { label = "90%",  callback = function() self:SetScale(0.90) end},
        { label = "95%",  callback = function() self:SetScale(0.95) end},
        { label = "100%", callback = function() self:SetScale(1.00) end},
    }
    AddCustomSubMenuItem(GetString(SI_LIVE_SPLIT_SCALE), scaleMenuEntries)

    -- MaxSplitsShown
    local maxSplitsEntries = {
        { label = "3",  callback = function() self:SetMaxDisplaySplits(3)  end},
        { label = "4",  callback = function() self:SetMaxDisplaySplits(4)  end},
        { label = "5",  callback = function() self:SetMaxDisplaySplits(5)  end},
        { label = "6",  callback = function() self:SetMaxDisplaySplits(6)  end},
        { label = "7",  callback = function() self:SetMaxDisplaySplits(7)  end},
        { label = "8",  callback = function() self:SetMaxDisplaySplits(8)  end},
        { label = "9",  callback = function() self:SetMaxDisplaySplits(9)  end},
        { label = "10", callback = function() self:SetMaxDisplaySplits(10) end},
    }
    AddCustomSubMenuItem(GetString(SI_LIVE_SPLIT_MAXSHOWN), maxSplitsEntries)

    -- Additional Info
    local additionalDisplayToggle = ESOLS.SV.additionalInfo
    AddCustomMenuItem(GetString(SI_LIVE_SPLIT_SHOWINFO), function()
        additionalDisplayToggle = not additionalDisplayToggle
        self:ShowAdditionalInfo(additionalDisplayToggle)
    end)

    -- Operation Mode
    local modeEntries = {
        { label = GetString(SI_LIVE_SPLIT_MODE_AUTO),   callback = function() self:UpdateMode(MODE_AUTO)   end},
        { label = GetString(SI_LIVE_SPLIT_MODE_MIXED),  callback = function() self:UpdateMode(MODE_MIXED)  end},
        { label = GetString(SI_LIVE_SPLIT_MODE_MANUAL), callback = function() self:UpdateMode(MODE_MANUAL) end},
    }
    AddCustomSubMenuItem(GetString(SI_LIVE_SPLIT_MODE), modeEntries)

    -- Possibly split selection
    local availableSplits = SPLIT_MANAGER:GetSplitsForZoneAndDifficulty(self.zoneId, self.difficulty)
    if #availableSplits > 1  then
        -- Zone has multiple speed run splits
        local submenu = {}

        for i, split in pairs(availableSplits) do
            table.insert(submenu, {
                label = split.menuName or split.catName,
                callback = function()
                    -- Remember selected category for subsequent loads to the zone, i.e. resetting an instance,
                    -- but only for manual selected template data.
                    DBG:Debug("Setting lastSelectedCategory to '<<1>>'", split.catName)
                    self.lastSelectedCategory = split.id
                    self:SetSelectedSplit(split)
                end
            })
        end

        AddCustomSubMenuItem(GetString(SI_LIVE_SPLIT_SELECT_TEMPLATE), submenu)
    end

    ShowMenu(self.controls.optionsButton)
    AnchorMenu(self.controls.optionsButton, -32)
end

function LiveSplit:SetShown(shown)
    if shown then
        SCENE_MANAGER:GetScene('hud'):AddFragment(LIVE_SPLIT_FRAGMENT)
        SCENE_MANAGER:GetScene('hudui'):AddFragment(LIVE_SPLIT_FRAGMENT)
    else
        SCENE_MANAGER:GetScene('hud'):RemoveFragment(LIVE_SPLIT_FRAGMENT)
        SCENE_MANAGER:GetScene('hudui'):RemoveFragment(LIVE_SPLIT_FRAGMENT)
    end
end

function LiveSplit:ToggleWindow()
    if LIVE_SPLIT_FRAGMENT.state == "shown" or LIVE_SPLIT_FRAGMENT.state == "showing" then
        self:SetShown(false)
    else
        self:SetShown(true)
    end
end

-- XML Handlers
function LiveSplit_OnInitialized(control)
    LIVE_SPLIT = LiveSplit:New(control)
end

function LiveSplit_OnOptionsClicked()
    LIVE_SPLIT:ShowOptionsMenu()
end

function LiveSplit_OnMoveStop(control)
    ESOLS.SV.offsetX = control:GetLeft()
    ESOLS.SV.offsetY = control:GetTop()
end

function LiveSplit_RestorePositionAndScale(control)
    control:ClearAnchors()
    control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, ESOLS.SV.offsetX, ESOLS.SV.offsetY)
    control:SetScale(ESOLS.SV.scale)
end