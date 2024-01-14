--- @class MPP_Debugger
--- @field public logLevel number Loglevel of the debugger
--- @field public showDebug boolean Whether to show DBG_DEBUG level outputs
--- @field public tag string The tag to be shown in beginning of messages
--- @field public New function
--- @field public Initialize function
--- @field public SetLogLevel function
--- @field public SetDebugOutputEnabled function
--- @field public SetTag function
--- @field public GetLogLevel function
--- @field public Log function
--- @field public TestLevels function
--- @field public Warn function
--- @field public Info function
--- @field public Verbose function
--- @field public Error function
--- @field public Critical function
--- @field public Debug function
--- @field public Assert function
--- @field public LuaError function
--- @field public LuaAssert function

--debugger version 1.8

-- Debugger
ZO_CreateStringId("DBG_FORMAT",  "|cffac30[<<1>>]<<2>> <<3>>|r|r")
ZO_CreateStringId("DBG_FORMAT_0", "")
ZO_CreateStringId("DBG_FORMAT_1", "")
ZO_CreateStringId("DBG_FORMAT_2", "|cc40000 [Critical]")
ZO_CreateStringId("DBG_FORMAT_3", "|cff1c1c [Error]")
ZO_CreateStringId("DBG_FORMAT_4", "")
ZO_CreateStringId("DBG_FORMAT_5", "|cff9d00 [Warning]")
ZO_CreateStringId("DBG_FORMAT_6", "|c0fb800 [Info]")
ZO_CreateStringId("DBG_FORMAT_7", "|c00b5b5 [Verbose]")
ZO_CreateStringId("DBG_FORMAT_8", "|c0081b8 [Debug]")
ZO_CreateStringId("DBG_FORMAT_9", "|cff1c1c [Assert] Assertion failed:")


DBG_ALWAYS_SHOW = 0
DBG_QUIET       = 1
DBG_CRITICAL    = 2
DBG_ERROR       = 3
DBG_NORMAL      = 4
DBG_WARNING     = 5
DBG_INFO        = 6
DBG_VERBOSE     = 7
DBG_DEBUG       = 8
DBG_ASSERT      = 9

--- @alias DebugLevel
--- |`DBG_ALWAYS_SHOW` # Always show at this level
--- |`DBG_QUIET` # Quietest level, shows almost never
--- |`DBG_CRITICAL` # For critical non-recoverable errors
--- |`DBG_ERROR` # For recoverable errors
--- |`DBG_NORMAL` # Normal debug level, like standard output
--- |`DBG_WARNING` # Warning level
--- |`DBG_INFO` # Informational level
--- |`DBG_VERBOSE` # Verbose output level
--- |`DBG_DEBUG` # Debug level
--- |`DBG_ASSERT` # Assertion level. Always shows if assertion fails

MPP_Debugger = ZO_Object:Subclass()

--- Creates a new debugger instance
--- @return MPP_Debugger debugger
function MPP_Debugger:New()
    local debugger = ZO_Object.New(self)
    debugger:Initialize()
    return debugger
end

--- Initializes the debugger
function MPP_Debugger:Initialize()
    self.logLevel = DBG_NORMAL or DBG_QUIET
    self.showDebug = false
    self.tag = "Debugger"
end

---Sets the current log level
---@param level DebugLevel
function MPP_Debugger:SetLogLevel(level)
    if level < DBG_QUIET then
        self.logLevel = DBG_QUIET
    elseif level >= DBG_DEBUG then
        self.logLevel = DBG_DEBUG
        self.showDebug = true
    else
        self.logLevel = level
    end
end

---Set the debug output enabled or disabled
---@param enabled boolean
function MPP_Debugger:SetDebugOutputEnabled(enabled)
    self.showDebug = enabled
end

---Gets the current log level
---@return number currentLogLevel
function MPP_Debugger:GetLogLevel()
    return self.logLevel
end

---Sets the tag at the beginning of messages
---@param tag string Desired tag. Will be wrapped in square brackets.
function MPP_Debugger:SetTag(tag)
    self.tag = tag
end

---Prints a message to chat
---@param message string Format string used by zo_strformat
---@param debugLevel number
function MPP_Debugger:Log(message, debugLevel, ...)
    if not message then return end
    local level = debugLevel or DBG_NORMAL

    if level <= self.logLevel or level == DBG_ALWAYS_SHOW  or level == DBG_ASSERT then
        if level == DBG_DEBUG and not self.showDebug then return end
        CHAT_ROUTER:AddDebugMessage(zo_strformat(DBG_FORMAT, self.tag, GetString("DBG_FORMAT_", level), zo_strformat(message, ...)))
    end
end

--- Prints a message of each type to chat to test settings and output.
function MPP_Debugger:TestLevels()
    self:Log("Debugger Test: Always Show",  DBG_ALWAYS_SHOW)
    self:Log("Debugger Test: Quiet",        DBG_QUIET)
    self:Log("Debugger Test: Critical",     DBG_CRITICAL)
    self:Log("Debugger Test: Error",        DBG_ERROR)
    self:Log("Debugger Test: Normal",       DBG_NORMAL)
    self:Log("Debugger Test: Warning",      DBG_WARNING)
    self:Log("Debugger Test: Info",         DBG_INFO)
    self:Log("Debugger Test: Verbose",      DBG_VERBOSE)
    self:Log("Debugger Test: Debug",        DBG_DEBUG)
end

---Displays a warning in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Warn(message, ...)
    if not message then return end
    self:Log(message, DBG_WARNING, ...)
end

---Displays a info in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Info(message, ...)
    if not message then return end
    self:Log(message, DBG_INFO, ...)
end

---Displays a verbose message in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Verbose(message, ...)
    if not message then return end
    self:Log(message, DBG_VERBOSE, ...)
end

---Displays an error in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Error(message, ...)
    if not message then return end
    self:Log(message, DBG_ERROR, ...)
end

---Displays a critical error in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Critical(message, ...)
    if not message then return end
    self:Log(message, DBG_CRITICAL, ...)
end

---Displays a debug message in chat
---@param message string Format string used by zo_strformat
function MPP_Debugger:Debug(message, ...)
    if not message then return end
    self:Log(message, DBG_DEBUG, ...)
end

---Displays an assertion  in chat
---@param condition boolean Expression to be checked. If true nothing happens, if false, the given `message` will be shown.
---@param message string Format string used by zo_strformat
function MPP_Debugger:Assert(condition, message, ...)
    message = message or "No message"
    if not condition then
        self:Log(message, DBG_ASSERT, ...)
    end
end

---Throws a Lua error
---@param message string Format string used by zo_strformat
function MPP_Debugger:LuaError(message, ...)
    message = message or "No message"
    self:Log(message, DBG_CRITICAL, ...)
    error(zo_strformat(GetString(DBG_FORMAT_2) .. " " .. message .. "|r", ...))
end

---Throws a Lua assertion
---@param condition boolean Condition for assertion
---@param message string Format string used by zo_strformat
function MPP_Debugger:LuaAssert(condition, message, ...)
    message = message or "No message"
    if not condition then
        self:Log(message, DBG_ASSERT, ...)
    end
    assert(condition, zo_strformat(GetString(DBG_FORMAT_9) .. " " .. message .. "|r", ...))
end

DBG = MPP_Debugger:New()
DBG:SetLogLevel(DBG_DEBUG)