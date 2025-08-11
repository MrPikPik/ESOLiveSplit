LiveSplitBossEnterTrigger = LiveSplitTrigger:Subclass()

function LiveSplitBossEnterTrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitBossEnterTrigger", {LIVE_SPLIT_TRIGGER_BOSS_ENTER}, triggerFn)
    LiveSplitBossEnterTrigger.Initialize(trigger)
    return trigger
end

function LiveSplitBossEnterTrigger:Initialize()
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
                        DBG:Info("LiveSplitBossEnterTrigger: Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with exact match.", bossName)
                        self:Remove(target)
                        self:FireCallbacks("OnTrigger", target)
                        break
                    end
                end
            elseif target.filterMatch then
                for _, filterMatch in pairs(target.filterMatch) do
                    if string.find(bossName, filterMatch) then
                        DBG:Info("LiveSplitBossEnterTrigger: Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger with match.", bossName)
                        self:Remove(target)
                        self:FireCallbacks("OnTrigger", target)
                        break
                    end
                end
            else
                DBG:Info("LiveSplitBossEnterTrigger: Entered boss arena for <<1>>. Splitting due to BOSS_ENTER trigger.", bossName)
                self:Remove(target)
                self:FireCallbacks("OnTrigger", target)
            end
        end
    end
end