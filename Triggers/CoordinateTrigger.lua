LiveSplitCoordinateTrigger = ZO_CallbackObject:Subclass()

function LiveSplitCoordinateTrigger:New(triggerFn)
    local listener = ZO_CallbackObject.New(self)
    listener:Initialize()
    self:RegisterCallback("OnTrigger", triggerFn)
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
        local z1 = target.z or 0
        local z2 = target.z and z or 0

        local distM = zo_floor(zo_distance3D(target.x, target.y, z1, x, y, z2)) / 100

        if target.inverted and distM >= target.r then
            DBG:Info("LiveSplitCoordinateTrigger: Triggering inverted location trigger <<3>>: <<1>>@<<2>>m", GetUnitName(unittag), distM, target.triggerid)
            self:Remove(target)
            self:FireCallbacks("OnTrigger", target)
            return true
        elseif not target.inverted and distM <= target.r then
            DBG:Info("LiveSplitCoordinateTrigger: Triggering location trigger <<3>>: <<1>>@<<2>>m", GetUnitName(unittag), distM, target.triggerid)
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
                    DBG:Verbose("LiveSplitCoordinateTrigger: Member of the group triggered location trigger. Skipping pending members...")
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
    DBG:LuaAssert(target.x and type(target.x) == "number", "LiveSplitCoordinateTrigger: X coordinate for target is missing or not a number!")
    DBG:LuaAssert(target.y and type(target.y) == "number", "LiveSplitCoordinateTrigger: Y coordinate for target is missing or not a number!")
    DBG:LuaAssert(target.r and type(target.r) == "number", "LiveSplitCoordinateTrigger: Radius r for target is missing or not a number!")

    target.triggerid = triggerid
    triggerid = triggerid + 1
    table.insert(self.targets, target)
    return triggerid - 1
end

function LiveSplitCoordinateTrigger:Remove(target)
    for i, t in ipairs(self.targets) do
        if t.triggerid == target.triggerid then
            table.remove(self.targets, i)
            return true
        end
    end
    DBG:Verbose("LiveSplitCoordinateTrigger: Requested deletion of target couldn't be completed: target not found!")
end

function LiveSplitCoordinateTrigger:ClearTargets()
    self.targets = {}
end