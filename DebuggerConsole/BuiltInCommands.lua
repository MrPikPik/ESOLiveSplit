-- clear / cls
local function clear()
    LIVE_SPLIT_DEBUG_CONSOLE.output:Clear()
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("cls", clear)
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("clear", clear)

-- script
local function script(...)
    assert(LoadString(ESOLS_DebugConsole.Utils.CombineArgs(...)))()
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("script", script)

-- nuke
local function nuke(confirm)
    if confirm == "confirm" then
        DBG:Warn("Nuking all saved progress, aka hard wipe!")
        ESOLS.SV.splits = {}
    else
        DBG:Warn("To nuke saved data, execute 'nuke confirm'.")
    end
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("nuke", nuke)

-- hide
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("hide", ESOLS_DebugConsole_Close)

-- zoneid
local function GetLocalZoneId()
    local zoneId = GetZoneId(GetUnitZoneIndex("player"))
    DBG:Log(zo_strformat("Current zone: <<1>> (<<2>>)",  GetZoneNameById(zoneId), zoneId))
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("zone", GetLocalZoneId)

-- targets
local function PrintAllTargets()
    local targets = {}
    for _, target in pairs(LIVE_SPLIT.coordinateListener.targets) do
        table.insert(targets, {type = "LiveSplitCoordinateTrigger", data = target})
    end
    for _, target in pairs(LIVE_SPLIT.csaListener.targets) do
        table.insert(targets, {type = "LiveSplitCSATrigger", data = target})
    end
    for _, target in pairs(LIVE_SPLIT.npcListener.targets) do
        table.insert(targets, {type = "LiveSplitNPCMessageTrigger", data = target})
    end
    for _, target in pairs(LIVE_SPLIT.delayListener.targets) do
        table.insert(targets, {type = "LiveSplitDelayTrigger", data = target})
    end
    for _, target in pairs(LIVE_SPLIT.bossEnterListener.targets) do
        table.insert(targets, {type = "LiveSplitBossEnterTrigger", data = target})
    end
    for _, target in pairs(LIVE_SPLIT.unitDeathListener.targets) do
        table.insert(targets, {type = "LiveSplitUnitDeathTrigger", data = target})
    end

    LIVE_SPLIT_DEBUG_CONSOLE:Write(string.format("%s %s", ESOLS_DebugConsole.Utils.LJust("Trigger Class", 28), "Data"))
    LIVE_SPLIT_DEBUG_CONSOLE:Write(string.format("%s %s", string.rep("=", 28), string.rep("=", 48)))
    for _, target in pairs(targets) do
        local data = ""
        for k, v in pairs(target.data) do
            data = data .. k .. "=" .. v .. ", "
        end
        data = string.sub(data, 1, -2)
        LIVE_SPLIT_DEBUG_CONSOLE:Write(string.format("%s %s", ESOLS_DebugConsole.Utils.LJust(target.type, 28), data))
    end
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("targets", PrintAllTargets)



local function PrintAvailableCommands()
    DBG:Log("Registered Commands:")
    for command, _ in pairs(LIVE_SPLIT_DEBUG_CONSOLE.commands) do
        DBG:Log(zo_strformat(" - <<1>>", command))
    end
    
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("?", PrintAvailableCommands)
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("help", PrintAvailableCommands)