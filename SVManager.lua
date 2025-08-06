SVManager = ZO_Object:Subclass()

---Creates a SVManager object
function SVManager:New(sv)
    local obj = ZO_Object.New(self)
    obj:Initialize(sv)
    return obj
end

---Initializes a SVManager object
function SVManager:Initialize(sv)
    DBG:LuaAssert(sv and type(sv) == "table", "SVManager: No or invalid SavedVariables given!")
    self.SV = sv
end

function SVManager:GetSplitTime(id, difficulty, segment)
    DBG:Debug("SVManager: GetSplitTime(<<1>>, <<2>>, <<3>>)", id, difficulty, segment)
    local times = self:GetSplitTimes(id, difficulty)
    if not times then
        DBG:Debug("No times found for <<1>> (<<2>>): Segment <<3>>", id, difficulty, segment)
        return nil
    end
    return times[segment]
end

function SVManager:GetSplitTimes(id, difficulty)
    DBG:Debug("SVManager: GetSplitTimes(<<1>>, <<2>>)", id, difficulty)
    if self.SV[id] and self.SV[id][difficulty] then
        return self.SV[id][difficulty]
    end
    return nil
end

function SVManager:GetPB(id, difficulty)
    DBG:Debug("SVManager: GetPB(<<1>>, <<2>>)", id, difficulty)
    return self:GetSplitTime(id, difficulty, "PB")
end

function SVManager:SetSplitTime(id, difficulty, segment, data)
    DBG:Debug("SVManager: SetSplitTime(<<1>>, <<2>>, <<3>>, <<4>>)", id, difficulty, segment, data)
    if not self.SV[id] then
        self.SV[id] = {}
    end
    if not self.SV[id][difficulty] then
        self.SV[id][difficulty] = {}
    end
    self.SV[id][difficulty][segment] = data
end

function SVManager:HasSavedTimes(id, difficulty)
    DBG:Debug("SVManager: HasSavedTimes(<<1>>, <<2>>)", id, difficulty)
    return self.SV[id][difficulty] ~= nil
end
function SVManager:HasSavedTime(id, difficulty, segment)
    DBG:Debug("SVManager: HasSavedTime(<<1>>, <<2>>, <<3>>)", id, difficulty, segment)
    return self.SV[id][difficulty][segment] ~= nil
end
function SVManager:HasPB(id, difficulty)
    DBG:Debug("SVManager: HasPB(<<1>>, <<2>>)", id, difficulty)
    return self.SV[id][difficulty]["PB"] ~= nil
end