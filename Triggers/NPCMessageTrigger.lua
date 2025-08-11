LiveSplitNPCMessageTrigger = LiveSplitTrigger:Subclass()

function LiveSplitNPCMessageTrigger:New(triggerFn)
    local trigger = LiveSplitTrigger.New(self, "LiveSplitNPCMessageTrigger", {LIVE_SPLIT_TRIGGER_NPC_MESSAGE}, triggerFn)
    LiveSplitNPCMessageTrigger.Initialize(trigger)
    return trigger
end

function LiveSplitNPCMessageTrigger:Initialize()
    self.bounceMessageToLog = false
    EVENT_MANAGER:RegisterForEvent("LiveSplitNPCMessageTrigger", EVENT_CHAT_MESSAGE_CHANNEL, function(evt, channelType, fromName, message) self:OnMessage(channelType, fromName, message) end)
end

function LiveSplitNPCMessageTrigger:OnMessage(channelType, fromName, message)
    if not (channelType == CHAT_CHANNEL_MONSTER_EMOTE or
            channelType == CHAT_CHANNEL_MONSTER_SAY or
            channelType == CHAT_CHANNEL_MONSTER_WHISPER or
            channelType == CHAT_CHANNEL_MONSTER_YELL) then
        return
    end

    if self.bounceMessageToLog then
        DBG:Debug("LiveSplitNPCMessageTrigger: <<2>>: '<<1>>'", message, fromName)
    end

    local breakouter = false
    for _, target in pairs(self.targets) do
        if target.message then
            for _, msg in pairs(target.message) do
                if msg == message then
                    DBG:Info("LiveSplitNPCMessageTrigger: Triggering NPC trigger: Exact message match.")
                    self:Remove(target)
                    self:FireCallbacks("OnTrigger", target)
                    breakouter = true
                    break
                end
            end
            if breakouter then break end
        elseif target.match then
            for _, mtch in pairs(target.match) do
                if string.find(message, mtch) then
                    DBG:Info("LiveSplitNPCMessageTrigger: Triggering NPC trigger: string.find found match.")
                    self:Remove(target)
                    self:FireCallbacks("OnTrigger", target)
                    breakouter = true
                    break
                end
            end
            if breakouter then break end
        elseif target.fromName then
            for _, name in pairs(target.fromName) do
                if string.find(fromName, name) then
                    DBG:Info("LiveSplitNPCMessageTrigger: Triggering NPC trigger: string.find found match in speaker name.")
                    self:Remove(target)
                    self:FireCallbacks("OnTrigger", target)
                    breakouter = true
                    break
                end
            end
            if breakouter then break end
        end
    end
end

function LiveSplitNPCMessageTrigger:CheckTarget(target)
    DBG:LuaAssert(target.match or target.message or target.fromName, "LiveSplitNPCMessageTrigger: Target has nothing to check for")
    return true
end