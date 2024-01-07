SplitManager = ZO_Object:Subclass()

---Creates a SplitManager object
function SplitManager:New()
	local obj = ZO_Object.New(self)
	obj:Initialize()
	return obj
end

---Initializes a SplitManager object
function SplitManager:Initialize()
	self.splitdata = {}
end

---Register a splits
---@param zoneId number
---@param difficulty DUNGEON_DIFFICULTY
---@param splitdata Split
function SplitManager:RegisterSplit(zoneId, difficulty, splitdata)
	DBG:LuaAssert(zoneId and type(zoneId) == "number", "SplitManager: Registering split failed: Invalid or missing zoneId")
	DBG:LuaAssert(difficulty and type(difficulty) == "number", "SplitManager: Registering split failed: Invalid or missing difficulty")
	DBG:LuaAssert(splitdata and type(splitdata) == "table", "SplitManager: Registering split failed: Invalid or missing splitdata")

	if not self.splitdata[zoneId] then self.splitdata[zoneId] = {} end
	if not self.splitdata[zoneId][difficulty] then self.splitdata[zoneId][difficulty] = {} end
	splitdata.zone = zoneId
	table.insert(self.splitdata[zoneId][difficulty], splitdata)
	DBG:Info("Registered new split data for zoneId <<1>>: <<2>>", zoneId, splitdata.catName)
end

---Returns all registered splits. Sorted by zone, then difficulty
---@return table
function SplitManager:GetAllSplits()
	return self.splitdata
end

---Returns all registered splits for a given difficulty. Sorted by zone
---@param difficulty DUNGEON_DIFFICULTY
---@return table
function SplitManager:GetSplitsForDifficulty(difficulty)
	local splits = {}
	for zoneId, data in pairs(self.splitdata) do
		if data[difficulty] then
			splits[zoneId] = data[difficulty]
		end
	end
	return splits
end

---Returns all splits for a given zone, split by difficulty at root level
---@param zoneId number
---@return table
function SplitManager:GetSplitsForZone(zoneId)
	return self.splitdata[zoneId]
end

---Returns all splits for a given zone and difficulty
---@param zoneId number
---@param difficulty DUNGEON_DIFFICULTY
---@return table
function SplitManager:GetSplitsForZoneAndDifficulty(zoneId, difficulty)
	if self.splitdata[zoneId] then
		return self.splitdata[zoneId][difficulty] or {}
	else
		return {}
	end
end

---Gets all splits for the current zone, split by difficulty at root level
---@return table
function SplitManager:GetSplitsForCurrentZone()
	local zoneId = GetZoneId(GetUnitZoneIndex("player"))
	return self:GetSplitsForZone(zoneId)
end

---Returns all available splits for the current zone and difficulty of the player
---@return table
function SplitManager:GetSplitsForCurrentZoneAndDifficulty()
	local zoneId = GetZoneId(GetUnitZoneIndex("player"))
	local difficulty = GetCurrentZoneDungeonDifficulty()
	return self:GetSplitsForZoneAndDifficulty(zoneId, difficulty)
end

SPLIT_MANAGER = SplitManager:New()