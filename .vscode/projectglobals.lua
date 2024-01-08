---@meta

---@type integer
DBG_FORMAT = 1

---@type integer
DBG_FORMAT_2 = 1

---@type integer
DBG_FORMAT_9 = 1

---@type integer
SI_LIVE_SPLIT_MAXSHOWN = 1

---@type integer
SI_LIVE_SPLIT_MAXSHOWN_TT = 1

---@type integer
SI_LIVE_SPLIT_SHOWINFO = 1

---@type integer
SI_LIVE_SPLIT_WR = 1

---@type integer
SI_LIVE_SPLIT_MANUAL_SPLIT = 1

---@type integer
SI_LIVE_SPLIT_TIMER_START = 1

---@type integer
SI_LIVE_SPLIT_TIMER_STOP = 1

---@type integer
SI_LIVE_SPLIT_RESET = 1

---@type integer
SI_LIVE_SPLIT_SELECT_TEMPLATE = 1

---@type integer
SI_LIVE_SPLIT_SCALE = 1

---@type integer
SI_LIVE_SPLIT_SCALE_TT = 1

---@type integer
SI_LIVE_SPLIT_MODE = 1

---@type integer
SI_LIVE_SPLIT_MODE_TT = 1

---@type integer
SI_LIVE_SPLIT_MODE_AUTO = 1

---@type integer
SI_LIVE_SPLIT_MODE_MIXED = 1

---@type integer
SI_LIVE_SPLIT_MODE_MANUAL = 1

---@type integer
SI_LIVE_SPLIT_HEADER_APPEARANCE = 1

---@type integer
SI_LIVE_SPLIT_SHOWINFO_SETTING = 1

---@type integer
SI_LIVE_SPLIT_SHOWINFO_SETTING_TT = 1

---@type integer
SI_LIVE_SPLIT_HEADER_BEHAVIOR = 1

---@type integer
SI_LIVE_SPLIT_COMMIT_IMMEDIATELY = 1

---@type integer
SI_LIVE_SPLIT_COMMIT_IMMEDIATELY_TT = 1

---@param name string
---@param entries table
function AddCustomSubMenuItem(name, entries) end

---@param name string
---@param callback function
---@param type? any
function AddCustomMenuItem(name, callback, type) end


MENU_ADD_OPTION_CHECKBOX = 1

function ShowMenu(where) end
function ClearMenu() end

---Get a console var
---@param cvar string Variable to get
---@return string Value of requested variable
function GetCVar(cvar) return "" end