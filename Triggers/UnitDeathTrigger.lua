LiveSplitUnitDeathTrigger = LiveSplitTrigger:Subclass()

function LiveSplitUnitDeathTrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitUnitDeathTrigger", {LIVE_SPLIT_TRIGGER_BOSS_DEATH, LIVE_SPLIT_TRIGGER_BOSS_DEATH_NAMED}, triggerFn)
    LiveSplitUnitDeathTrigger.Initialize(trigger)
    return trigger
end

function LiveSplitUnitDeathTrigger:Initialize()
    EVENT_MANAGER:RegisterForEvent("LiveSplitUnitDeathTrigger", EVENT_UNIT_DEATH_STATE_CHANGED, function(evt, unitTag, isDead) self:OnUnitDeath(unitTag, isDead) end)
end

function LiveSplitUnitDeathTrigger:OnUnitDeath(unitTag, isDead)
    for _, target in pairs(self.targets) do
        if string.sub(unitTag, 1, 4) == "boss" and isDead then
            if target.type == LIVE_SPLIT_TRIGGER_BOSS_DEATH_NAMED then
                local bossName = GetUnitName(unitTag)

                if target.filter then
                    for _, filter in pairs(target.filter) do
                        if filter == bossName then
                            DBG:Info("LiveSplitUnitDeathTrigger: Specifically named boss <<1>> died. Splitting with exact match.", bossName)
                            self:Remove(target)
                            self:FireCallbacks("OnTrigger", target)
                            return
                        end
                    end
                elseif target.filterMatch then
                    for _, filterMatch in pairs(target.filterMatch) do
                        if string.find(bossName, filterMatch) then
                            DBG:Info("LiveSplitUnitDeathTrigger: Specifically named boss <<1>> died. Splitting with match.", bossName)
                            self:Remove(target)
                            self:FireCallbacks("OnTrigger", target)
                            return
                        end
                    end
                end
            elseif target.type == LIVE_SPLIT_TRIGGER_BOSS_DEATH then
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
                    DBG:Info("LiveSplitUnitDeathTrigger: All bosses gone. Splitting due to BOSS_DEATH trigger.")
                    self:Remove(target)
                    self:FireCallbacks("OnTrigger", target)
                    return
                end
            else
                DBG:Error("LiveSplitUnitDeathTrigger: Target has no or invalid type '<<1>>'.", tostring(target.type))
            end
        else
            -- TODO: Non boss units
        end
    end
end