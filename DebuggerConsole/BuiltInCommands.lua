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


local function PrintAvailableCommands()
    DBG:Log("Registered Commands:")
    for command, _ in pairs(LIVE_SPLIT_DEBUG_CONSOLE.commands) do
        DBG:Log(zo_strformat(" - <<1>>", command))
    end
    
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("?", PrintAvailableCommands)
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("help", PrintAvailableCommands)