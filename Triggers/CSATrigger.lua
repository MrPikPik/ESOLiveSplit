LiveSplitCSATrigger = ZO_CallbackObject:Subclass()

function LiveSplitCSATrigger:New()
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    return listener
end

function LiveSplitCSATrigger:Initialize()
    self.targets = {}
    EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_BROADCAST, function(evt, ...) self:OnMessage(...) end)
	EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_DISPLAY_ALERT, function(evt, ...) self:OnMessage(...) end)
	EVENT_MANAGER:RegisterForEvent("LiveSplitCSATrigger", EVENT_DISPLAY_ANNOUNCEMENT, function(evt, ...) self:OnMessage(...) end)
end

function LiveSplitCSATrigger:OnMessage(...)
	for _, target in pairs(self.targets) do
		DBG:Debug("CSATrigger: <<1>> new messages:", select("#", ...))
		for _, message in pairs({...}) do
			if type(message) == "number" or message == "" then break end
			DBG:Debug("CSATrigger: '<<1>>'", message)
			if message == target.message then
				DBG:Info("Triggering CSA trigger.")
				self:Remove(target)
				self:FireCallbacks("OnTrigger", target)
				break
			end
		end
	end
end

local triggerid = 1
function LiveSplitCSATrigger:Listen(target)
	target.triggerid = triggerid
	triggerid = triggerid + 1
    table.insert(self.targets, target)
	return triggerid - 1
end

function LiveSplitCSATrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
        end
    end
end