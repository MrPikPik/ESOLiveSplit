LiveSplitNPCMessageTrigger = ZO_CallbackObject:Subclass()

function LiveSplitNPCMessageTrigger:New()
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    return listener
end

function LiveSplitNPCMessageTrigger:Initialize()
    self.targets = {}
    EVENT_MANAGER:RegisterForEvent("LiveSplitNPCMessageTrigger", EVENT_CHAT_MESSAGE_CHANNEL, function(evt, channelType, fromName, message) self:OnMessage(channelType, fromName, message) end)
end

function LiveSplitNPCMessageTrigger:OnMessage(channelType, fromName, message)
    if not (channelType == CHAT_CHANNEL_MONSTER_EMOTE or
            channelType == CHAT_CHANNEL_MONSTER_SAY or
            channelType == CHAT_CHANNEL_MONSTER_WHISPER or
            channelType == CHAT_CHANNEL_MONSTER_YELL) then
        return
    end

    DBG:Debug("NPCMessageTrigger: <<2>>: '<<1>>'", message, fromName)
    local breakouter = false
    for _, target in pairs(self.targets) do
        if target.message then
            for _, msg in pairs(target.message) do
                if msg == message then
                    DBG:Info("Triggering NPC trigger: Exact message match.")
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
                    DBG:Info("Triggering NPC trigger: string.find found match.")
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
                    DBG:Info("Triggering NPC trigger: string.find found match in speaker name.")
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

local triggerid = 1
function LiveSplitNPCMessageTrigger:Listen(target)
    DBG:LuaAssert(target.match or target.message or target.fromName, "LiveSplitNPCMessageTrigger: Target has nothing to check for")

    target.triggerid = triggerid
    triggerid = triggerid + 1
    table.insert(self.targets, target)
    return triggerid - 1
end

function LiveSplitNPCMessageTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
            return true
        end
    end
    DBG:Verbose("LiveSplitNPCMessageTrigger: Requested deletion of target couldn't be completed: target not found!")
end

function LiveSplitNPCMessageTrigger:ClearTargets()
    self.targets = {}
end