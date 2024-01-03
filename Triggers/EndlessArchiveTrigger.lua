LiveSplitEndlessArchiveTrigger = ZO_CallbackObject:Subclass()

function LiveSplitEndlessArchiveTrigger:New()
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    return listener
end

function LiveSplitEndlessArchiveTrigger:Initialize()
    self.arc = 0
    self.cycle = 0
    self.stage = 0
    self.isSolo = true
    self.hasCompanion = false
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_STARTED, function(evt) self:OnStart() end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_COMPLETED, function(evt, flags) self:OnComplete(flags) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_COUNTER_VALUE_CHANGED, function(evt, counterType, counterValue) self:OnCounterChange(counterType, counterValue) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitEndlessArchiveTrigger", EVENT_ENDLESS_DUNGEON_CONFIRM_COMPANION_SUMMONING, function(evt, collectibleId) self:OnCompanionSummon(collectibleId) end)
end

function LiveSplitEndlessArchiveTrigger:Reset()
    self.arc = 1
    self.cycle = 1
    self.stage = 1

    local companionOut = DoesUnitExist("companion")
    self.isSolo = GetGroupSize() < 2 and not companionOut
    self.hasCompanion = companionOut
end

function LiveSplitEndlessArchiveTrigger:OnStart()
    self:Reset()
    DBG:Info("Started new Endless Archive run.")
    self:FireCallbacks("OnTrigger")
end

function LiveSplitEndlessArchiveTrigger:OnComplete(flags)
    DBG:Info("Completed Endless Archive run at Arc <<1>>, Cycle <<2>>, Stage <<3>>.", self.arc, self.cycle, self.stage)
end

function LiveSplitEndlessArchiveTrigger:OnCounterChange(counterType, counterValue)
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
        DBG:Debug("Received OnCounterChange with counterType <<1>> to value <<2>>, which is not tracked.", counterType, counterValue)
    end
end

function LiveSplitEndlessArchiveTrigger:OnCompanionSummon(collectibleId)
    -- Todo?
end

function LiveSplitEndlessArchiveTrigger:GetCurrentProgress()
    return self.arc, self.cycle, self.stage
end