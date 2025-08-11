LiveSplitTrialEventsTrigger = LiveSplitTrigger:Subclass()

function LiveSplitTrialEventsTrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitTrialEventsTrigger", {LIVE_SPLIT_TRIGGER_BEGIN_TRIAL, LIVE_SPLIT_TRIGGER_END_TRIAL}, triggerFn)
    LiveSplitTrialEventsTrigger.Initialize(trigger)
    return trigger
end

function LiveSplitTrialEventsTrigger:Initialize()
    EVENT_MANAGER:RegisterForEvent("LiveSplitTrialEventsTrigger", EVENT_RAID_TRIAL_STARTED, function(event, ...) self:OnTrialBegin(...) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitTrialEventsTrigger", EVENT_RAID_TRIAL_COMPLETE, function(event, ...) self:OnTrialEnd(...) end)
end

function LiveSplitTrialEventsTrigger:OnTrialBegin(trialName)
    self:FireCallbacks("OnTrigger")
end

function LiveSplitTrialEventsTrigger:OnTrialEnd(trialName, score, finalTime)
    self:FireCallbacks("OnTrigger")
end

-- Override base to not care for given targets.
function LiveSplitTrialEventsTrigger:Listen(target)
    return 0
end