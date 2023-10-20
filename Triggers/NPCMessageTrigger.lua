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
	if channelType == CHAT_CHANNEL_MONSTER_EMOTE or channelType == CHAT_CHANNEL_MONSTER_SAY or channelType == CHAT_CHANNEL_MONSTER_WHISPER or channelType == CHAT_CHANNEL_MONSTER_YELL then
		DBG:Debug("NPCMessageTrigger: '<<1>>'", message)
		for _, target in pairs(self.targets) do
			if target.message and target.message == message then
				DBG:Info("Triggering NPC trigger: Exact message match.")
				self:Remove(target)
				self:FireCallbacks("OnTrigger", target)
				break
			elseif target.match and string.find(message, target.match) then
				DBG:Info("Triggering NPC trigger: string.find found match.")
				self:Remove(target)
				self:FireCallbacks("OnTrigger", target)
				break
			end
		end
	end
end

local triggerid = 1
function LiveSplitNPCMessageTrigger:Listen(target)
	target.triggerid = triggerid
	triggerid = triggerid + 1
    table.insert(self.targets, target)
	return triggerid - 1
end

function LiveSplitNPCMessageTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
        end
    end
end