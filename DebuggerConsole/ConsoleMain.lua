---@diagnostic disable: deprecated

-- Maximum lines in the console history. Default is 500
ESOLS_CONSOLE_MAX_LINES = 500

local ESOLS_DebugConsole = ZO_Object:Subclass()

---Create new console instance
---@param control Control
---@return table
function ESOLS_DebugConsole:New(control)
    local c = ZO_Object.New(self)
    c:Initialize(control)
    return c
end

---Initializes the console instance
---@param control Control
function ESOLS_DebugConsole:Initialize(control)
    self.control = control
    self.commands = {}

    self.output = control:GetNamedChild("Output")
    self.input = control:GetNamedChild("EditBox")
    self.input.ownerConsole = self

    SLASH_COMMANDS["/lsdebugconsole"] = ESOLS_DebugConsole_Toggle

    local function Log(debugger, message, debugLevel, ...)
        if not message then return end
        local level = debugLevel or DBG_NORMAL
        self:Write(zo_strformat(DBG_FORMAT, GetTimeString(), GetString("DBG_FORMAT_", level), zo_strformat(message, ...)))
    end

    ZO_PreHook(DBG, "Log", Log)
end

---Write text to the console
---@param text string Text to write
function ESOLS_DebugConsole:Write(text)
    self.output:AddMessage(text)
end

---Adds a command to the list of commands
---@param name string Command name
---@param fn function Function to be executed on invokation
function ESOLS_DebugConsole:AddCommand(name, fn)
    DBG:LuaAssert(type(fn) == "function", "Debugger Console: Command is not a function!")
    self.commands[name] = fn
end

---Invoke command by name with paramerts
---@param name string Command to be invoked
---@vararg any Paramters for the invoked command
function ESOLS_DebugConsole:InvokeCommand(name, ...)
    if self.commands[name] and type(self.commands[name]) == "function" then
        self.commands[name](...)
    else
        self:Write(zo_strformat("Command '<<1>>' unknown.", name))
    end
end

---Execute by string input
---@param str string
function ESOLS_DebugConsole:Exec(str)
    local argv = {}
    for substr in str:gmatch("%S+") do table.insert(argv, substr) end
    self:Write(zo_strformat("Debugger Input: <<1>>", str))
    self:InvokeCommand(unpack(argv))
end

--XML Handlers
function ESOLS_DebugConsole_Init(control)
    LIVE_SPLIT_DEBUG_CONSOLE = ESOLS_DebugConsole:New(control)
end

function ESOLS_DebugConsole_Close()
    LIVE_SPLIT_DEBUG_CONSOLE.control:SetHidden(true)
end

function ESOLS_DebugConsole_Toggle()
    if LIVE_SPLIT_DEBUG_CONSOLE.control:IsHidden() then
        LIVE_SPLIT_DEBUG_CONSOLE.control:SetHidden(false)
        --LIVE_SPLIT_DEBUG_CONSOLE.input:TakeFocus()
    else
        LIVE_SPLIT_DEBUG_CONSOLE.control:SetHidden(true)
    end
end

function ESOLS_DebugConsole_ExecFromInput()
    LIVE_SPLIT_DEBUG_CONSOLE:Exec(LIVE_SPLIT_DEBUG_CONSOLE.input:GetText())
end

function ESOLS_DebugConsole_AddLine(str)
    LIVE_SPLIT_DEBUG_CONSOLE:Write(str)
end

function ESOLS_DebugConsole_OnMouseWheel(control, delta, ctrl, alt, shift)
    local pos = control:GetNamedChild("Output"):GetScrollPosition()
    control:GetNamedChild("Output"):SetScrollPosition(pos - delta)
end

function ESOLS_DebugConsole_ToggleFocus()
    if LIVE_SPLIT_DEBUG_CONSOLE.control:IsHidden() then
        LIVE_SPLIT_DEBUG_CONSOLE.control:SetHidden(false)
        LIVE_SPLIT_DEBUG_CONSOLE.input:TakeFocus()
    else
        LIVE_SPLIT_DEBUG_CONSOLE.control:SetHidden(true)
    end
end

function ESOLS_Debugconsole_PreviousCommand(control)
    --if not control.system:IsAutoCompleteOpen() then
    --    control.owner:PreviousCommand()
    --end
end

function ESOLS_Debugconsole_NextCommand(control)
    --if not control.system:IsAutoCompleteOpen() then
    --    control.owner:NextCommand()
    --end
end

function ESOLS_Debugconsole_Tab(control, newText)
    --control.system:OnTextEntryChanged(newText)
end