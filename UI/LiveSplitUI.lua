LIVE_SPLIT_WIDTH = 300
LIVE_SPLIT_LABEL_WIDTH = LIVE_SPLIT_WIDTH - 70
LIVE_SPLIT_DIFF_WIDTH = 60
LIVE_SPLIT_ROW_HEIGHT = 30

local TIMER_PRECISION_SECONDS 	= 0
local TIMER_PRECISION_TENTHS 	= 1
local TIMER_PRECISION_HUNDREDS 	= 2
local TIMER_PRECISION_COUNTDOWN = 3

local LOW_ALPHA = 0.2
local HIGH_ALPHA = 0.5

local MODE_AUTO = 1
local MODE_MIXED = 2
local MODE_MANUAL = 3

local SOURCE_TYPE_SELF = 1
local SOURCE_TYPE_ADDON = 2
local SOURCE_TYPE_KEYBIND = 3
local SOURCE_TYPE_MENU = 4

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
	self.controls.worldRecordLabel = additional:GetNamedChild("Record")
	self.controls.summary = summary
	self.controls.additional = additional
	
	self.difficulty = DUNGEON_DIFFICULTY_NONE

	self.totaltime = 0
	self.activerun = false
	self.timerenabled = false
	self.currentsplit = 1
	self.currentSplitStartTime = 0
	self.lastSelectedCategory = ""
	self.splitdata = {}

	-- Listeners
	self.coordinateListener = LiveSplitCoordinateTrigger:New()
	self.coordinateListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

	self.csaListener = LiveSplitCSATrigger:New()
	self.csaListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

	self.npcListener = LiveSplitNPCMessageTrigger:New()
	self.npcListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

	self.delayListener = LiveSplitDelayTrigger:New()
	--self.delayListener:RegisterCallback("OnTrigger", function(target) self:OnTrigger(target) end)

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

function LiveSplit:AddEvents()
	EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_PLAYER_ACTIVATED, function() self:OnPlayerActivated() end)
	EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_RAID_TRIAL_STARTED, function() self:StartTimer(SOURCE_TYPE_SELF) end)
	EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_BOSSES_CHANGED, function() self:OnBossChange() end)
	EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_UNIT_DEATH_STATE_CHANGED, function(evt, unitTag, isDead) self:OnUnitDeath(unitTag, isDead) end)
	EVENT_MANAGER:RegisterForEvent("LiveSplit", EVENT_PLAYER_COMBAT_STATE, function(code, inCombat) self:OnCombatStateChanged(inCombat) end)
	EVENT_MANAGER:RegisterForUpdate("LiveSplit", nil, function() self:OnTick() end)
end

function LiveSplit:OnTick()
	if self.timerenabled then
		self.totaltime = GetGameTimeMilliseconds() - self.starttime
		
		self:UpdateMainTimer()
		self:UpdateSplitTimer()
		self:UpdateCurrentSplitRow()
	end
end

function LiveSplit:OnPlayerActivated()
	--DBG:Debug("OnPlayerActivated()")
	if not self.activerun then
		self.zoneId = GetZoneId(GetUnitZoneIndex("player"))
		self.difficulty = GetCurrentZoneDungeonDifficulty()
		
		DBG:Info("Updating zone to <<1>> and difficulty to <<2>>", self.zoneId, self.difficulty)

		local availableSplits = SPLIT_MANAGER:GetSplitsForZoneAndDifficulty(self.zoneId, self.difficulty)

		if #availableSplits > 0 then
			self:SetShown(true)
		
			if #availableSplits > 1  then
				DBG:Log("This zone has multiple speed run splits!", DBG_NORMAL)
			end
			
			-- Try and set last selected category
			for index, data in pairs(availableSplits) do
				if data.catName == self.lastSelectedCategory then
					DBG:Debug("Found manual selected category from previous visit to instance. Restoring selection.")
					self:SetSelectedSplit(availableSplits[index])
					return
				end
			end
			-- If no match is found, select first split from available list
			self:SetSelectedSplit(availableSplits[1])
			return
		else
			-- No split data found, hide window
			DBG:Verbose("No split data found for current zone.")
			self:SetShown(false)
		end
	elseif self.activerun and not self.timerenabled then
		-- Exiting instance with a started timer should reset the timers.
		DBG:Warn("Incoming reset! (run active)")
		--self:Reset(SOURCE_TYPE_SELF)
	elseif not self.timerenabled then
		DBG:Warn("Incoming reset! (no run active)")
		--self:Reset(SOURCE_TYPE_SELF)
	elseif self.zoneId ~= GetZoneId(GetUnitZoneIndex("player")) then
		-- Zone changed
		DBG:Warn("Zone changed. Aborting current run.")
		self:Reset(SOURCE_TYPE_SELF)
	elseif not self.selectedSplit then
		DBG:Verbose("No split selected and no splits available. Hiding UI.")
		self:SetShown(false)
	end
end

function LiveSplit:OnBossChange()
	if not self.timerenabled then return end
	if not self.selectedSplit and not self.currentsplit and not self.selectedSplit.splits[self.currentsplit] then return end
	
	if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_BOSS_ENTER then
		if GetUnitName("boss1") ~= "" then
			DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger.", GetUnitName("boss1"))
			self:Split(SOURCE_TYPE_SELF)
		end
	end
end

function LiveSplit:OnUnitDeath(unitTag, isDead)
	if not self.activerun then return end
	
	if string.sub(unitTag, 1, 4) == "boss" and isDead then
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
			if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_BOSS_DEATH then
				DBG:Info("All bosses gone. Splitting due to BOSS_DEATH trigger.")
				self:Split(SOURCE_TYPE_SELF)
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
	if not self.timerenabled then
		if self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION or self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
			DBG:Info("Player entered trigger. Starting run...")
			self:StartTimer(SOURCE_TYPE_SELF)
		elseif self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
			DBG:Info("Magic words have been spoken. Starting run...")
			self:StartTimer(SOURCE_TYPE_SELF)
		end
	elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_LOCATION or self.selectedSplit.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
		DBG:Info("Player entered trigger. Splitting due to location trigger.")
		self:Split(SOURCE_TYPE_SELF)
	elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE then
		DBG:Info("Received CSA Message. Splitting due to message match to trigger condition.")
		self:Split(SOURCE_TYPE_SELF)
	elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
		-- TODO
	elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_DELAY then
		-- TODO
	end
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
			row.name:SetText(entry.name)
			if entry.icon then
				row.icon:SetTexture(entry.icon)
				row.icon:SetHidden(false)
			else
				row.icon:SetHidden(true)
			end

			row.bg:SetAlpha((i % 2 == 1 or i == self.currentsplit) and LOW_ALPHA or HIGH_ALPHA)
			
			
			if entry.pb then
				pbsum = pbsum + entry.pb
				row.time:SetText(self.FormatTime(pbsum, TIMER_PRECISION_SECONDS))
				
				if entry.diff and (entry.diff > -60000 and entry.diff < 60000) then
					local diff = self.FormatTime(math.abs(entry.diff), TIMER_PRECISION_COUNTDOWN)
					row.diff:SetText(entry.diff < 0 and "-" .. diff or diff)
					if entry.wasbest then
						row.diff:SetColor(1, 1, 0)
					elseif entry.diff < 0 then
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

function LiveSplit.FormatTime(milliseconds, precicion)
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
	self.controls.timer:SetText(self.FormatTime(self.totaltime))
end

function LiveSplit:UpdateSplitTimer()
	self.controls.splittimer:SetText(self.FormatTime(self.totaltime - self.currentSplitStartTime))
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
			local diff = self.FormatTime(math.abs(difference), TIMER_PRECISION_COUNTDOWN)
			
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
	if self.SV[self.selectedSplit.catName] and self.SV[self.selectedSplit.catName][self.difficulty] then
		-- Bail if there are less saved split tims than there are splits
		if #self.SV[self.selectedSplit.catName][self.difficulty] ~= #self.selectedSplit.splits then
			return -1
		end

		for i, t in ipairs(self.SV[self.selectedSplit.catName][self.difficulty]) do
			if i >= offset then
				total = total + t
			end
		end

		if offset == #self.selectedSplit.splits then
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

	self.controls.headerTitle:SetText(split.catName)

	-- Build splits list
    ZO_ClearNumericallyIndexedTable(self.splitEntries)
	for i, s in ipairs(split.splits) do
		local pb = nil
		if self.SV[split.catName] and self.SV[split.catName][self.difficulty] then
			pb = self.SV[split.catName][self.difficulty][i]
		end
		self:AddSplitEntry(s.name, s.icon, pb)
	end
	self:UpdateSplitEntries()
	
	-- Main timer, optional time offset
	if self.selectedSplit.startOffset then
		DBG:Info("This split category has a timed start offset of <<1>>", self.selectedSplit.startOffset)
		self.totaltime = self.totaltime - self.selectedSplit.startOffset
		self:UpdateMainTimer()
	end


	-- Previous segment
	self.controls.previousSegementLabel:SetText("-")
	
	-- Best possible time
	local bestpossible = self:GetBestPossibleTime()
	if bestpossible > 0 then
		self.controls.bestPossibleTimeLabel:SetText(self.FormatTime(bestpossible, TIMER_PRECISION_SECONDS))
	else
		self.controls.bestPossibleTimeLabel:SetText("-")
	end
	
	-- Sum of best segements
	local sumofbest = self:GetSumBestSegments()
	if sumofbest > 0 then
		self.controls.sumOfBestSegmentsLabel:SetText(self.FormatTime(sumofbest, TIMER_PRECISION_SECONDS))
	else
		self.controls.sumOfBestSegmentsLabel:SetText("-")
	end
	
	-- Personal best
	local pb = -1
	if self.SV[self.selectedSplit.catName] and self.SV[self.selectedSplit.catName][self.difficulty] then
		pb = self.SV[self.selectedSplit.catName][self.difficulty]["PB"] or -1
	end
	
	if pb > 0 then
		self.controls.personalBestLabel:SetText(self.FormatTime(pb, TIMER_PRECISION_TENTHS))
	else
		self.controls.personalBestLabel:SetText("-")
	end
	
	-- World record
	self.controls.worldRecordLabel:SetText(zo_strformat(SI_LIVE_SPLIT_WR, self.FormatTime(split.wr, TIMER_PRECISION_TENTHS), split.wrPlayer))
	
	if split.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION then
		local target = {
			x = split.startData.x,
			y = split.startData.y,
			z = split.startData.z,
			r = split.startData.r,
			zone = split.zone,
		}
		self.coordinateListener:Listen(target)
	elseif split.startTrigger == LIVE_SPLIT_TRIGGER_LOCATION_INV then
		local target = {
			x = split.startData.x,
			y = split.startData.y,
			z = split.startData.z,
			r = split.startData.r,
			zone = split.zone,
			inverted = true,
		}
		self.coordinateListener:Listen(target)
	elseif split.startTrigger == LIVE_SPLIT_TRIGGER_NPC_MESSAGE then
		local target = {
			message = split.startData.message,
			match = split.startData.match,
		}
		self.npcListener:Listen(target)
	elseif split.startTrigger == LIVE_SPLIT_TRIGGER_BEGIN_TRIAL and self.difficulty ~= DUNGEON_DIFFICULTY_VETERAN then
		DBG:Error("Category start trigger is begin trial, but difficulty is not veteran! This event does not fire on non-veteran content!")
	end

	if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_LOCATION then
		local target = {
			x = split.splits[self.currentsplit].data.x,
			y = split.splits[self.currentsplit].data.y,
			z = split.splits[self.currentsplit].data.z,
			r = split.splits[self.currentsplit].data.r,
			zone = split.zone,
		}
		self.coordinateListener:Listen(target)
	elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_LOCATION_INV then
		local target = {
			x = split.splits[self.currentsplit].data.x,
			y = split.splits[self.currentsplit].data.y,
			z = split.splits[self.currentsplit].data.z,
			r = split.splits[self.currentsplit].data.r,
			zone = split.zone,
			inverted = true,
		}
		self.coordinateListener:Listen(target)
	end
	
	local left, top = self.control:GetLeft(), self.control:GetTop()
	self.control:SetHeight()
	self.control:ClearAnchors()
	self.control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function LiveSplit:SetScale(scale)
	DBG:Debug("Setting scale to <<1>>", tostring(scale))
	ESOLS.SV.scale = scale
	self.control:SetScale(scale)
end

function LiveSplit:SetMaxDisplaySplits(maxSplits)
	self.maxsplitsshown = maxSplits
	ESOLS.SV.maxsplitsshown = maxSplits
	DBG:Info("Showing <<1>> entries in the list.", maxSplits)
	self:UpdateSplitEntries()
	--DBG:Error("LiveSplit:SetMaxDisplaySplits() - Not implemented")
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

	self:UpdateMainTimer()
	self:UpdateSplitTimer()
end

function LiveSplit:StartTimer(source)
	-- Mode handling
	if not self:SourceAllowedForCurrentMode(source) then return end

	self.currentsplit = 1
	self.starttime = GetGameTimeMilliseconds()
	if self.selectedSplit and self.selectedSplit.startOffset then
		DBG:Info("This split category has a timed start offset of <<1>>", self.selectedSplit.startOffset)
		self.totaltime = 0 --Need to reset this back to 0 as it has been set to the offset earlier by the SetSelectedSplit() method
		self.starttime = self.starttime + self.selectedSplit.startOffset
	end
	self.activerun = true
	self.timerenabled = true
end

function LiveSplit:StopTimer(source)
	-- Mode handling
	if not self:SourceAllowedForCurrentMode(source) then return end

	DBG:Info("Stopping timer")

	self.timerenabled = false
	self.activerun = false
end

function LiveSplit:Split(source)
	if not self.timerenabled then return end

	-- Mode handling
	if not self:SourceAllowedForCurrentMode(source) then return end

	local splittime = self.totaltime - self.currentSplitStartTime
	
	if not self.SV[self.selectedSplit.catName] then
		self.SV[self.selectedSplit.catName] = {}
	end
	if not self.SV[self.selectedSplit.catName][self.difficulty] then
		self.SV[self.selectedSplit.catName][self.difficulty] = {}
	end
	
	if not self.SV[self.selectedSplit.catName][self.difficulty][self.currentsplit] then
		self.SV[self.selectedSplit.catName][self.difficulty][self.currentsplit] = splittime
	else
		if splittime < self.SV[self.selectedSplit.catName][self.difficulty][self.currentsplit] then
			self.SV[self.selectedSplit.catName][self.difficulty][self.currentsplit] = splittime
		end
	end
	
	self.splitEntries[self.currentsplit].pb = splittime
	self.currentSplitStartTime = self.totaltime


	
	if #self.selectedSplit.splits > self.currentsplit then
		self.currentsplit = self.currentsplit + 1
		if self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_LOCATION then
			local target = {
				x = self.selectedSplit.splits[self.currentsplit].data.x,
				y = self.selectedSplit.splits[self.currentsplit].data.y,
				z = self.selectedSplit.splits[self.currentsplit].data.z,
				r = self.selectedSplit.splits[self.currentsplit].data.r,
				zone = self.selectedSplit.zone,
			}
			self.coordinateListener:Listen(target)
		elseif self:GetCurrentSplitTrigger() == LIVE_SPLIT_TRIGGER_LOCATION_INV then
			local target = {
				x = self.selectedSplit.splits[self.currentsplit].data.x,
				y = self.selectedSplit.splits[self.currentsplit].data.y,
				z = self.selectedSplit.splits[self.currentsplit].data.z,
				r = self.selectedSplit.splits[self.currentsplit].data.r,
				zone = self.selectedSplit.zone,
				inverted = true,
			}
			self.coordinateListener:Listen(target)
		end
	else
		if self.SV[self.selectedSplit.catName] then
			if self.SV[self.selectedSplit.catName][self.difficulty] then
				if self.SV[self.selectedSplit.catName][self.difficulty]["PB"] then
					if self.totaltime < self.SV[self.selectedSplit.catName][self.difficulty]["PB"] then
						self.SV[self.selectedSplit.catName][self.difficulty]["PB"] = self.totaltime
						self.controls.personalBestLabel:SetText(self.FormatTime(self.totaltime, TIMER_PRECISION_TENTHS))
					end
				else
					self.SV[self.selectedSplit.catName][self.difficulty]["PB"] = self.totaltime
					self.controls.personalBestLabel:SetText(self.FormatTime(self.totaltime, TIMER_PRECISION_TENTHS))
				end
			end
		else
			-- Should never happen :x
			DBG:LuaAssert(false, "Reached")
		end

		DBG:Info("No further splits left. Stopping run.")
		self:StopTimer(SOURCE_TYPE_SELF)
	end
	
	self.controls.bestPossibleTimeLabel:SetText(self.FormatTime(self:GetBestPossibleTime(), TIMER_PRECISION_SECONDS))
	self.controls.sumOfBestSegmentsLabel:SetText(self.FormatTime(self:GetSumBestSegments(), TIMER_PRECISION_SECONDS))
	self.controls.previousSegementLabel:SetText(self.FormatTime(splittime, TIMER_PRECISION_TENTHS))


	self:UpdateSplitEntries()
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
					self.lastSelectedCategory = split.catName
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