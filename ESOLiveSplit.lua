ESOLS = {}
local ESOLS = ESOLS

ESOLS.name = "ESOLiveSplit"
ESOLS.version = "0.4b (Update 46, Version 11.0.6)"

ESOLS.defaults = {
    splits = {},
    offsetX = 200,
    offsetY = 200,
    scale = 1.0,
    maxsplitsshown = 7,
    additionalInfo = true,
    mode = 2, -- Mixed mode
    commitImmediatly = false,
}

local function OnAddonLoaded(event, addonName)
    if addonName ~= ESOLS.name then return end
    EVENT_MANAGER:UnregisterForEvent(ESOLS.name, EVENT_ADD_ON_LOADED) 
     
    ESOLS.SV = ZO_SavedVars:NewAccountWide("LiveSplitSavedVars", 0.1, nil, ESOLS.defaults)
    LIVE_SPLIT.SV = ESOLS.SV.splits

    LIVE_SPLIT.maxsplitsshown = ESOLS.SV.maxsplitsshown
    LIVE_SPLIT:ShowAdditionalInfo(ESOLS.SV.additionalInfo)
    LiveSplit_RestorePositionAndScale(LIVE_SPLIT.control)
    
    LIVE_SPLIT:UpdateMode(ESOLS.SV.mode)

    SLASH_COMMANDS["/livesplit"] = function() LIVE_SPLIT:ToggleWindow() end
    
    local p1 = {}
    local p2 = {}
    SLASH_COMMANDS["/lszone"] = function()
        local zoneId = GetZoneId(GetUnitZoneIndex("player"))
        DBG:Info("Player is in zone <<1>> (<<2>>)", GetZoneNameById(zoneId), zoneId)
    end
    SLASH_COMMANDS["/lsp1"] = function()
        _, p1.x, p1.y, p1.z = GetUnitWorldPosition("player")
        DBG:Info("Point 1: X=<<1>> Y=<<2>> Z=<<3>>", p1.x, p1.y, p1.z)
    end
    SLASH_COMMANDS["/lsp2"] = function()
        _, p2.x, p2.y, p2.z = GetUnitWorldPosition("player")
        DBG:Info("Point 2: X=<<1>> Y=<<2>> Z=<<3>>", p2.x, p2.y, p2.z)
    end
    SLASH_COMMANDS["/lsdist"] = function()
        local distCM = zo_floor(zo_distance3D(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z))
        local distM = distCM / 100
        DBG:Info("Distance between points: <<1>>", distM)
    end
    SLASH_COMMANDS["/lsdistnoy"] = function()
        local distCM = zo_floor(zo_distance(p1.x, p1.z, p2.x, p2.z))
        local distM = distCM / 100
        DBG:Info("Distance between points (no y): <<1>>", distM)
    end
    SLASH_COMMANDS["/lspos"] = function()
        DBG:Info("Player pos: X: <<2>>, Y: <<3>>, Z: <<4>> (Zone: <<1>>)", GetUnitWorldPosition("player"))
    end

    SLASH_COMMANDS["/lsbossinfo"] = function()
        if DoesUnitExist("boss1") then 
            DBG:Info("Current bosses:")
            for i = 1, MAX_BOSSES do
                if DoesUnitExist("boss"..i) then
                    DBG:Info("   boss<<1>>: '<<2>>'", i, GetUnitName("boss"..i))
                end
            end
        else
            DBG:Info("Currently no bosses.")
        end
    end

    -- Add dummmy trigger to test delay
    SLASH_COMMANDS["/lsenabledebuginfo"] = function()
        DBG:SetLogLevel(DBG_DEBUG)
    end

    -- Enable NPC messages to log
    SLASH_COMMANDS["/lsenablenpcmessages"] = function()
        LIVE_SPLIT.npcListener.bounceMessageToLog = true
    end

    DBG:SetTag("ESOLiveSplit")
    DBG:SetLogLevel(DBG_DEBUG)
    DBG:SetLogLevel(DBG_ERROR)

    if LibAddonMenu2 then
        ESOLS.InitializeAddonMenu()
    end
end
EVENT_MANAGER:RegisterForEvent(ESOLS.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)