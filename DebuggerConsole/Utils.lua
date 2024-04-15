local Utils = {}

-- === String utils ===

---Checks if a string starts with a specified value
---@param text string Input text
---@param search string Search text
---@return boolean match
function Utils.StartsWith(text, search)
    return text:find(search, 1, #search) == 1
end

---Left justify in given length
---@param text string Input text
---@param len number Desired length
---@return string return
function Utils.LJust(text, len)
    text = tostring(text)
    local pad = string.rep(" ", len - #text)
    return text .. pad
end

---Right justify in given length
---@param text string Input text
---@param len number Desired length
---@return string return
function Utils.RJust(text, len)
    text = tostring(text)
    local pad = string.rep(" ", len - #text)
    return pad .. text
end

---Center justify to given length
---@param text string Input text
---@param len number Desired length
---@return string return
function Utils.CJust(text, len)
    text = tostring(text)
    local ws = (len - #text) / 2
    local pad = string.rep(" ", math.floor(ws))
    local opad = ((ws % 1) ~= 0.0) and " " or ""
    return pad .. text .. pad .. opad
end

-- === General utils ===

---Append all input args
---@param ... any
---@return string return
function Utils.CombineArgs(...)
    local text = ""
    for i = 1, select('#', ...) do
        text = text .. select(i, ...) .. " "
    end
    return string.sub(text, 1, -2)
end

---Iterator over a table's keys, sorted
---@param t table Table which keys are to be returned sorted
---@param order? function Optional sorting function
---@return function Iterator function
function Utils.SortedPairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

ESOLS_DebugConsole = getmetatable(LIVE_SPLIT_DEBUG_CONSOLE) or {}
ESOLS_DebugConsole.Utils = Utils