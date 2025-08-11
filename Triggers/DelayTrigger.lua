LiveSplitDelayTrigger = LiveSplitTrigger:Subclass()

function LiveSplitDelayTrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitDelayTrigger", {LIVE_SPLIT_TRIGGER_DELAY}, triggerFn)
    LiveSplitDelayTrigger.Initialize(trigger)
    return trigger
end

function LiveSplitDelayTrigger:Initialize()
    EVENT_MANAGER:RegisterForUpdate("LiveSplitDelayTrigger", nil, function() self:OnUpdate() end)
end

local lastframetimestamp
function LiveSplitDelayTrigger:OnUpdate()
    if not lastframetimestamp then lastframetimestamp = GetGameTimeMilliseconds() end
    local gametimems = GetGameTimeMilliseconds()
    local deltaT = gametimems - lastframetimestamp
    lastframetimestamp = gametimems
    for _, target in pairs(self.targets) do
        target.timeremaining = target.timeremaining - deltaT
        if target.timeremaining <= 0 then
            DBG:Info("LiveSplitDelayTrigger: Triggering delay trigger.")
            self:Remove(target)
            self:FireCallbacks("OnTrigger", target)
            break
        end
    end
end

function LiveSplitDelayTrigger:CheckTarget(target)
    DBG:LuaAssert(target.time and type(target.time) == "number", "LiveSplitDelayTrigger: Delay time for target is missing or not a number!")
    return true
end

function LiveSplitDelayTrigger:SetupTarget(target)
    target.timeremaining = target.time
    return target
end