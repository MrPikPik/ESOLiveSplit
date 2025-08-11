--- Base class for triggers.
--- Inherit from this class and create new trigger listeners like this:
--- 
--- MyCoolTriggerClass = LiveSplitTrigger:Subclass()
--- 
--- function MyCoolTriggerClass:New(triggerFn)
---     local trigger = LiveSplitTrigger.New(self, "MyCoolTriggerClass", tableOfSupportedTriggerTypes, triggerFn)
---     MyCoolTriggerClass.Initialize(trigger)
---     return trigger
--- end
--- 
--- function MyCoolTriggerClass:Initialize()
---     -- Optional per module initializes, like event subscriptions
--- end

---@class LiveSplitTrigger: ZO_CallbackObject
---@field name string Module clear name.
---@field triggerTypes table<LIVE_SPLIT_TRIGGER, boolean> Dictionary of supported types.
---@field triggerid number Internal trigger id number.
---@field targets LiveSplitTarget[] List of active targets.
LiveSplitTrigger = ZO_CallbackObject:Subclass()

---Creates a new instance of a `LiveSplitTrigger` object.
---@param name string The name of the module.
---@param supportTypes LIVE_SPLIT_TRIGGER[] Table containing the types the module supports.
---@param triggerFn function The function to call for the `OnTrigger` callback.
---@return LiveSplitTrigger triggerObject The created object.
function LiveSplitTrigger:New(name, supportTypes, triggerFn)
    DBG:Debug("Creating new trigger named '<<1>>'", name)
    local trigger = ZO_CallbackObject.New(self)
    LiveSplitTrigger.Initialize(trigger, name, supportTypes, triggerFn)
    return trigger
end

---Initializes a blank `LiveSplitTrigger` object
---@param name string The name of the module
---@param supportTypes LIVE_SPLIT_TRIGGER[] Table containing the types the module supports.
---@param triggerFn function The function to call for the `OnTrigger` callback.
function LiveSplitTrigger:Initialize(name, supportTypes, triggerFn)
    self.name = name
    self.triggerTypes = {}
    for triggerType in pairs(supportTypes) do
        self.triggerTypes[triggerType] = true
    end
    self.targets = {}
    self.triggerid = 1
    self:RegisterCallback("OnTrigger", triggerFn)
end

---Whether this module supports a given `LIVE_SPLIT_TRIGGER` type.
---@param triggerType LIVE_SPLIT_TRIGGER The `LIVE_SPLIT_TRIGGER` type to be checked for.
---@return boolean hasSupport If the module supports the given `LIVE_SPLIT_TRIGGER` type.
function LiveSplitTrigger:Supports(triggerType)
    return self.triggerTypes[triggerType]
end

---Adds a target to be active.
---@param target LiveSplitTarget The target to be listened for.
---@return number triggerid Assigned triggerid.
function LiveSplitTrigger:Listen(target)
    DBG:LuaAssert(self:CheckTarget(target), "<<1>>: Target did not meet criteria. See console for details.", self.name)
    target = self:SetupTarget(target)
    target.triggerid = self.triggerid
    self.triggerid = self.triggerid + 1
    table.insert(self.targets, target)
    DBG:Verbose("<<1>>: Added new target with id <<2>>", self.name, target.triggerid)
    return self.triggerid - 1
end

---Removes a specific target from the active target.
---@param target LiveSplitTarget The target to remove.
---@return boolean targetRemoved If a target has been removed.
function LiveSplitTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            DBG:Verbose("<<1>>: Removing target with id <<2>>", self.name, target.triggerid)
            table.remove(self.targets, i)
            return true
        end
    end
    DBG:Verbose("<<1>>: Requested deletion of target couldn't be completed: target not found!", self.name)
    return false
end

---Clears all current targets.
function LiveSplitTrigger:ClearTargets()
    DBG:Verbose("<<1>>: Clearing all active targets", self.name)
    ZO_ClearTable(self.targets)
end

---Checks parameters for validity. To be overriden.
---@param target LiveSplitTarget Parameters to check.
function LiveSplitTrigger:CheckTarget(target)
    -- To be overriden.
    return true
end

---Optional setup for targets. To be overriden.
---@param target LiveSplitTarget The target to be set up.
---@return LiveSplitTarget modifiedTarget The modified target.
function LiveSplitTrigger:SetupTarget(target)
    -- To be overriden.
    return target
end