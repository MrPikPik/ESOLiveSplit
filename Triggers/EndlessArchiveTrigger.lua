LiveSplitEndlessArchiveTrigger = ZO_CallbackObject:Subclass()

function LiveSplitEndlessArchiveTrigger:New(triggerFn)
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    self:RegisterCallback("OnTrigger", triggerFn)
    return listener
end

function LiveSplitEndlessArchiveTrigger:Initialize()
    self.arc = 0
    self.cycle = 0
    self.stage = 0
    self.isSolo = true
    self.hasCompanion = false
    self.runStarted = false
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_PLAYER_ACTIVATED, function(evt) self:OnPlayerActivated() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_STARTED, function(evt) self:OnStart() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_COMPLETED, function(evt, flags) self:OnComplete(flags) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_COUNTER_VALUE_CHANGED, function(evt, counterType, counterValue) self:OnCounterChange(counterType, counterValue) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_CONFIRM_COMPANION_SUMMONING, function(evt, collectibleId) self:OnCompanionSummon(collectibleId) end)
end

function LiveSplitEndlessArchiveTrigger:OnPlayerActivated()
    if not self.runStarted then
        if ENDLESS_DUNGEON_MANAGER:IsEndlessDungeonStarted() then
            DBG:Error("LiveSplitEndlessArchiveTrigger: Player already in a started instance! Please reset the Endless Archive to be able to start a run!")
        elseif ENDLESS_DUNGEON_MANAGER:IsEndlessDungeonCompleted() then
            DBG:Error("LiveSplitEndlessArchiveTrigger: Player already in a completed instance! Please reset the Endless Archive to be able to start a run!")
        end
    end
end

function LiveSplitEndlessArchiveTrigger:Reset()
    self.arc = 1
    self.cycle = 1
    self.stage = 1

    self.runStarted = false
    self.runComplete = false

    local companionOut = DoesUnitExist("companion")
    self.isSolo = GetGroupSize() < 2 and not companionOut
    self.hasCompanion = companionOut
end

function LiveSplitEndlessArchiveTrigger:OnStart()
    self:Reset()
    self.runStarted = true
    DBG:Info("LiveSplitEndlessArchiveTrigger: Started new Endless Archive run.")
    self:FireCallbacks("OnTrigger")
end

function LiveSplitEndlessArchiveTrigger:OnComplete(flags)
    self.runComplete = true
    DBG:Info("LiveSplitEndlessArchiveTrigger: Completed Endless Archive run at Arc <<1>>, Cycle <<2>>, Stage <<3>>.", self.arc, self.cycle, self.stage)
    self:FireCallbacks("OnTrigger")
end

function LiveSplitEndlessArchiveTrigger:OnCounterChange(counterType, counterValue)
    if self.runStarted and not self.runComplete then
        if counterType == ENDLESS_DUNGEON_COUNTER_TYPE_ARC then
            self.arc = counterValue
            self:FireCallbacks("OnTrigger")
        elseif counterType == ENDLESS_DUNGEON_COUNTER_TYPE_CYCLE then
            self.cycle = counterValue
            self:FireCallbacks("OnTrigger")
        elseif counterType == ENDLESS_DUNGEON_COUNTER_TYPE_STAGE then
            self.stage = counterValue
            self:FireCallbacks("OnTrigger")
        else
            DBG:Debug("LiveSplitEndlessArchiveTrigger: Received OnCounterChange with counterType <<1>> to value <<2>>, which is not tracked.", counterType, counterValue)
        end
    end
end

function LiveSplitEndlessArchiveTrigger:OnCompanionSummon(collectibleId)
    -- Todo?
end

function LiveSplitEndlessArchiveTrigger:GetCurrentProgress()
    return self.arc, self.cycle, self.stage
end