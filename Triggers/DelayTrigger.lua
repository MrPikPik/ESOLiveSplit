LiveSplitDelayTrigger = ZO_CallbackObject:Subclass()

function LiveSplitDelayTrigger:New(triggerFn)
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    self:RegisterCallback("OnTrigger", triggerFn)
    return listener
end

function LiveSplitDelayTrigger:Initialize()
    self.targets = {}
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
            DBG:Info("Triggering delay trigger.")
            self:Remove(target)
            self:FireCallbacks("OnTrigger", target)
            break
        end
    end
end

local triggerid = 1
function LiveSplitDelayTrigger:Listen(target)
    DBG:LuaAssert(target.time and type(target.time) == "number", "LiveSplitDelayTrigger: Delay time for target is missing or not a number!")

    target.triggerid = triggerid
    triggerid = triggerid + 1
    target.timeremaining = target.time
    table.insert(self.targets, target)
    return triggerid - 1
end

function LiveSplitDelayTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
            return true
        end
    end
    DBG:Verbose("LiveSplitDelayTrigger: Requested deletion of target couldn't be completed: target not found!")
end

function LiveSplitDelayTrigger:ClearTargets()
    self.targets = {}
end