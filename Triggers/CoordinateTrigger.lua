LiveSplitCoordinateTrigger = ZO_CallbackObject:Subclass()

function LiveSplitCoordinateTrigger:New()
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    return listener
end

function LiveSplitCoordinateTrigger:Initialize()
    self.targets = {}
    EVENT_MANAGER:RegisterForUpdate("LiveSplitCoordinateTrigger", nil, function() self:Update() end)
end

function LiveSplitCoordinateTrigger:CheckTarget(target, unittag)
	if not unittag then unittag = "player" end
	
	local zone, x, y, z = GetUnitWorldPosition(unittag)
					
	if target.zone == zone then
		local y1 = target.y or 0
		local y2 = target.y and y or 0

		local distM = zo_floor(zo_distance3D(target.x, y1, target.z, x, y2, z)) / 100

		if target.inverted and distM >= target.r then
			DBG:Info("Triggering inverted location trigger: <<1>>@<<2>>", GetUnitName(unittag), distM)
			self:Remove(target)
			self:FireCallbacks("OnTrigger", target)
			return true
		elseif not target.inverted and distM <= target.r then
			DBG:Info("Triggering location trigger: <<1>>@<<2>>", GetUnitName(unittag), distM)
			self:Remove(target)
			self:FireCallbacks("OnTrigger", target)
			return true
		end
	end
	return false
end

-- Update function that checks if the player is in range of any active trigger
function LiveSplitCoordinateTrigger:Update()
    for _, target in pairs(self.targets) do
		if IsUnitGrouped("player") then
			for i = 1, GetGroupSize() do
				if self:CheckTarget(target, "group" .. i) then
					DBG:Verbose("Member of the group triggered location trigger. Skipping pending members...")
					break
				end
			end
		else
			self:CheckTarget(target)
		end
    end
end

local triggerid = 1
function LiveSplitCoordinateTrigger:Listen(target)
	target.triggerid = triggerid
	triggerid = triggerid + 1
    table.insert(self.targets, target)
	return triggerid - 1
end

function LiveSplitCoordinateTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
        end
    end
end

function LiveSplitCoordinateTrigger:ClearTargets()
	self.targets = {}
end