ESOLS = {}
local ESOLS = ESOLS

ESOLS.name = "ESOLiveSplit"
ESOLS.version = "1.0 (Update 9.1.8, Records v1)"

ESOLS.defaults = {
	splits = {},
	offsetX = 200,
	offsetY = 200,
	scale = 1.0,
	maxsplitsshown = 7,
	additionalInfo = true,
	mode = 2, -- Mixed mode
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
		DBG:Info("Player is in zone with id <<1>>", GetZoneId(GetUnitZoneIndex("player")))
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

	-- Add dummmy trigger to test csa messages
	SLASH_COMMANDS["/lscsatrigger"] = function()
		LIVE_SPLIT.csaListener:Listen({message="1"})
	end

	-- Add dummmy trigger to test npc messages
	SLASH_COMMANDS["/lsnpctrigger"] = function()
		LIVE_SPLIT.npcListener:Listen({message="1"})
	end

	-- Add dummmy trigger to test delay
	SLASH_COMMANDS["/lsdelaytrigger"] = function()
		LIVE_SPLIT.delayListener:Listen({time="5000"})
	end

	-- Add dummmy trigger to test delay
	SLASH_COMMANDS["/lsenabledebuginfo"] = function()
		DBG:SetLogLevel(DBG_DEBUG)
	end

	DBG:SetLogLevel(DBG_ERROR)

	if LibAddonMenu2 then
		ESOLS.InitializeAddonMenu()
	end
end
EVENT_MANAGER:RegisterForEvent(ESOLS.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)