-- clear / cls
local function clear()
	LIVE_SPLIT_DEBUG_CONSOLE.output:Clear()
end
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("cls", clear)
LIVE_SPLIT_DEBUG_CONSOLE:AddCommand("clear", clear)

-- script
local function script(...)
	DBG:LuaAssert(LoadString(ESOLS_DebugConsole.Utils.CombineArgs(...)), "Executing script from console failed!")()
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