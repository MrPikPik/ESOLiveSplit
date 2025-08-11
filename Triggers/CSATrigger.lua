LiveSplitCSATrigger = LiveSplitTrigger:Subclass()

function LiveSplitCSATrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitCSATrigger", {LIVE_SPLIT_TRIGGER_CENTER_ANNOUNCE}, triggerFn)
    LiveSplitCSATrigger.Initialize(trigger)
    return trigger
end

function LiveSplitCSATrigger:Initialize()
    EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_BROADCAST, function(evt, ...) self:OnMessage(...) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_DISPLAY_ALERT, function(evt, ...) self:OnMessage(...) end)
    EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_DISPLAY_ANNOUNCEMENT, function(evt, ...) self:OnMessage(...) end)
end

function LiveSplitCSATrigger:OnMessage(message, subMessage)
    DBG:Debug("LiveSplitCSATrigger: '<<1>>' (<<2>>)", message, subMessage)

    local triggerMessage = "Nothing specified"
    local triggerTarget = nil

    for _, target in pairs(self.targets) do
        if target.message then
            if type(target.message) == "table" then
                for _, msg in pairs(target.message) do
                    if msg == message then
                        triggerMessage = "Triggering due to exact match."
                        triggerTarget = target
                        break
                    end
                end
            else
                if target.message == message then
                    triggerMessage = "Triggering due to exact match."
                    triggerTarget = target
                    break
                end
            end
        elseif target.match then
            if type(target.match) == "table" then
                for _, m in pairs(target.match) do
                    if string.find(message, m) then
                        triggerMessage = "Triggering due to match."
                        triggerTarget = target
                        break
                    end
                end
            else
                if string.find(message, target.match) then
                    triggerMessage = "Triggering due to match."
                    triggerTarget = target
                    break
                end
            end
        elseif target.subMessage then
            if type(target.subMessage) == "table" then
                for _, msg in pairs(target.subMessage) do
                    if msg == subMessage then
                        triggerMessage = "Triggering due to exact match in subMessage."
                        triggerTarget = target
                        break
                    end
                end
            else
                if target.subMessage == subMessage then
                    triggerMessage = "Triggering due to exact match in subMessage."
                    triggerTarget = target
                    break
                end
            end
        elseif target.subMatch then
            if type(target.subMatch) == "table" then
                for _, m in pairs(target.subMatch) do
                    if string.find(message, m) then
                        triggerMessage = "Triggering due to match."
                        triggerTarget = target
                        break
                    end
                end
            else
                if string.find(message, target.subMatch) then
                    triggerMessage = "Triggering due to match."
                    triggerTarget = target
                    break
                end
            end
        elseif target.parsePattern and target.parseMatch then
            if type(target.parsePattern) == "table" then
                for _, pattern in pairs(target.parsePattern) do
                    local breakOuter = false
                    if type(target.parseMatch) == "table" then
                        for _, match in pairs(target.match) do
                            if string.match(message, pattern) == match then
                                triggerMessage = "Triggering due to parse match in message."
                                triggerTarget = target
                                breakOuter = true
                                break
                            elseif string.match(subMessage, pattern) == match then
                                triggerMessage = "Triggering due to parse match in subMessage."
                                triggerTarget = target
                                breakOuter = true
                                break
                            end
                        end
                        if breakOuter then
                            break
                        end
                    else
                        if string.match(message, pattern) == target.parseMatch then
                            triggerMessage = "Triggering due to parse match in message."
                            triggerTarget = target
                            break
                        elseif string.match(subMessage, pattern) == target.parseMatch then
                            triggerMessage = "Triggering due to parse match in subMessage."
                            triggerTarget = target
                            break
                        end
                    end
                end
            else
                if type(target.parseMatch) == "table" then
                    local breakOuter = false
                    for _, match in pairs(target.match) do
                        if string.match(message, target.parsePattern) == match then
                            triggerMessage = "Triggering due to parse match in message."
                            triggerTarget = target
                            breakOuter = true
                            break
                        elseif string.match(subMessage, target.parsePattern) == match then
                            triggerMessage = "Triggering due to parse match in subMessage."
                            triggerTarget = target
                            breakOuter = true
                            break
                        end
                    end
                    if breakOuter then
                        break
                    end
                else
                    if string.match(message, target.parsePattern) == target.parseMatch then
                        triggerMessage = "Triggering due to parse match in message."
                        triggerTarget = target
                        break
                    elseif string.match(subMessage, target.parsePattern) == target.parseMatch then
                        triggerMessage = "Triggering due to parse match in subMessage."
                        triggerTarget = target
                        break
                    end
                end
            end
        end
    end

    if triggerTarget then
        DBG:Info("LiveSplitCSATrigger: <<1>>", triggerMessage)
        self:Remove(triggerTarget)
        self:FireCallbacks("OnTrigger", triggerTarget)
    end
end

function LiveSplitCSATrigger:CheckTarget(target)
    DBG:LuaAssert(target.match or target.message or target.subMessage or target.subMatch or (target.parsePattern and target.parseMatch), "LiveSplitCSATrigger: Target has nothing to check for!")
    return true
end