LiveSplitBossEnterTrigger = ZO_CallbackObject:Subclass()

function LiveSplitBossEnterTrigger:New(triggerFn)
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    self:RegisterCallback("OnTrigger", triggerFn)
    return listener
end

function LiveSplitBossEnterTrigger:Initialize()
    self.targets = {}
    EVENT_MANAGER:RegisterForEvent("LiveSplitBossEnterTrigger", EVENT_BOSSES_CHANGED, function() self:OnBossChange() end)
end

function LiveSplitBossEnterTrigger:OnBossChange()
    for _, target in pairs(self.targets) do
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
            if target.filter then
                for _, filter in pairs(target.filter) do
                    if filter == bossName then
                        DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with exact match.", bossName)
                        self:Remove(target)
                        self:FireCallbacks("OnTrigger", target)
                        break
                    end
                end
            elseif target.filterMatch then
                for _, filterMatch in pairs(target.filterMatch) do
                    if string.find(bossName, filterMatch) then
                        DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with match.", bossName)
                        self:Remove(target)
                        self:FireCallbacks("OnTrigger", target)
                        break
                    end
                end
            else
                DBG:Info("Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger.", bossName)
                self:Remove(target)
                self:FireCallbacks("OnTrigger", target)
            end
        end
    end
end



local triggerid = 1
function LiveSplitBossEnterTrigger:Listen(target)
    target.triggerid = triggerid
    triggerid = triggerid + 1
    table.insert(self.targets, target)
    return triggerid - 1
end

function LiveSplitBossEnterTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
            return true
        end
    end
    DBG:Verbose("LiveSplitBossEnterTrigger: Requested deletion of target couldn't be completed: target not found!")
end

function LiveSplitBossEnterTrigger:ClearTargets()
    self.targets = {}
end