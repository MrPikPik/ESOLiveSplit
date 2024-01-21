---@meta
---@diagnostic disable: lowercase-global


---@alias UnitTag "player"|"reticleover"|"reticletarget"|"boss1"|"boss2"|"boss3"|"boss4"|"boss5"|"boss6"|"boss7"|"boss8"|"group1"|"group2"|"group3"|"group4"|"group5"|"group6"|"group7"|"group8"|"group9"|"group10"|"group11"|"group12"|"playerpet1"|"playerpet2"|"playerpet3"|"playerpet4"|"companion"
---@alias EventCode integer
---@alias SavedVars table

---@class Control
Control = {}

---Gets a child control by name
---@param str string Name of the control
---@return Control
function Control:GetNamedChild(str) return {} end


---Adds a message
---@param str string Mesage to be added
function Control:AddMessage(str) end


---@class ZO_Control

--- Creates a string instance
---@param id string
---@param string string
---@return number #Generated string id
function ZO_CreateStringId(id, string) return 1 end

---Gets the string begind a given stringId
---@param stringId string|integer
---@param affix? string|integer|number
---@return string
function GetString(stringId, affix) return "" end

---@class ZO_CallbackObject
---@field public Subclass function
---@field public New function
ZO_CallbackObject = {}

---@generic T
---@return T object
---@param baseClass T
function ZO_CallbackObject.New(baseClass) return baseClass end

---@generic T
---@return T object
function ZO_CallbackObject:Subclass() return {} end

---Fires all functions attached to the given callback name.
---@param callbackName string Named callback to fire
---@param ... any Parameters to ge given to the attached functions
function ZO_CallbackObject:FireCallbacks(callbackName, ...) end


---@class ZO_Object
---@field public New function
---@field public Subclass function
ZO_Object = {}

---@generic T
---@return T object
---@param baseClass T
function ZO_Object.New(baseClass) return baseClass end

---@generic T
---@return T object
function ZO_Object.Subclass() return {} end

---@class EventManager
---@field public RegisterForEvents function
---@field public UnregisterForEvents function
---@field private New function
EventManager = {}

---@return EventManager eventmanager
function EventManager:New() return {} end

---Loads a string as lua code
---@param str string
---@returns function byteCodeFunction
function LoadString(str)
    return function() end
end

---Gets the current time
---@return string time Current Time
function GetTimeString() return "" end

---Registers to an Event
---@param name string Name to whom the event should be registered for
---@param eventCode EventCode EventCode to be registered to
---@param callback function Function to be called, if the event occurs
function EventManager:RegisterForEvent(name, eventCode, callback) end

---Unregisters previously registered events
---@param name string
---@param eventCode EventCode
function EventManager:UnregisterForEvent(name, eventCode) end

---Registers a periodic function call
---@param name string Name to whom the update should be registered for
---@param intervall? integer Update interval in milliseconds
---@param callback function Function to be called, when the update occurs
function EventManager:RegisterForUpdate(name, intervall, callback) end


EVENT_MANAGER = EventManager:New()


---comment
---@param unittag UnitTag Unittag to get the position for
---@return integer zoneId Zone id of the unit
---@return integer x X coordinate of the unit
---@return integer y Y coordinate of the unit
---@return integer z Z coordinate of the unit
function GetUnitWorldPosition(unittag) return 1, 1, 1, 1 end


zo_floor = math.floor

---Returns the current groups size
---@return integer groupsize
function GetGroupSize() return 1 end

---Checks if the given unit is grouped
---@param unittag UnitTag
---@return boolean
function IsUnitGrouped(unittag) return true end

---Calculates the distance between two 3D coordinates   
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z3 number
---@return number distance
function zo_distance3D(x1, y1, z1, x2, y2, z3) return 1.0 end

---Calculates the distance between two 2D coordinates   
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number distance
function zo_distance(x1, y1, x2, y2) return 1.0 end

---Formats a given format string with Lingoona engine
---@param format string|number Can be either format string directly or an StringId
---@param ... any Paramters (up to 6) to be inserted
---@return string formattedString
function zo_strformat(format, ...) return "" end


---@class ZO_SavedVars
---@field public NewAccountWide function
---@field public New function
ZO_SavedVars = {}

---Creates new account wide saved variables
---@param name string
---@param version number
---@param key? any
---@param defaults table
---@return SavedVars
function ZO_SavedVars:NewAccountWide(name, version, key, defaults) return {} end

---@param zoneIndex integer
---@return integer
function GetZoneId(zoneIndex) return 1 end

---Debug prints to chat
---@param ... any
---@return string
function d(...) return "" end

---@param unittag UnitTag
---@return integer zoneIndex
function GetUnitZoneIndex(unittag) return 1 end

---@class ZO_Scene
---@field private New function
ZO_Scene = {}

---@return ZO_Scene ZO_Scene
function ZO_Scene:New() return {} end

---@param fragment ZO_SceneFragment
function ZO_Scene:AddFragment(fragment) end

---@param fragment ZO_SceneFragment
function ZO_Scene:RemoveFragment(fragment) end


---@class SceneManager
---@field private New function
SceneManager = {}

---@return SceneManager scenemanager
function SceneManager:New() return {} end

---Gets a named scene
---@param sceneName string
---@return ZO_Scene scene
function SceneManager:GetScene(sceneName) return {} end

---Shows a scene by name
---@param sceneName string
function SceneManager:Show(sceneName) end
SCENE_MANAGER = SceneManager:New()

---@class ZO_Control
---@field public SetText function
ZO_Control = {}

---Sets a label text
---@param text any
function ZO_Control:SetText(text) end

---Pulls focus to control
function ZO_Control:TakeFocus() end

---@class ZO_SceneFragment
---@field private New function
---@field state string
ZO_SceneFragment = {}

---@return ZO_SceneFragment ZO_SceneFragment
function ZO_SceneFragment:New() return {} end


---@class ZO_HUDFadeSceneFragment
---@field private New function
ZO_HUDFadeSceneFragment = {}

---Creates a new ZO_HUDFadeSceneFragment for a given control
---@param control Control
---@return ZO_SceneFragment fragment
function ZO_HUDFadeSceneFragment:New(control) return {} end


---@param unittag UnitTag
---@return boolean
function IsUnitDead(unittag) return true end

---@param unittag UnitTag
---@return boolean
function DoesUnitExist(unittag) return true end

---@param unittag UnitTag
---@return string
function GetUnitName(unittag) return "" end

---@return integer difficulty
function GetCurrentZoneDungeonDifficulty() return 1 end

---Milliseconds since game start
---@return integer millis
function GetGameTimeMilliseconds() return 1 end

---@param checkbox table
function ZO_CheckButton_SetChecked(checkbox) end

---Calls a function after a given delay
---@param fn function
---@param delay number
function zo_callLater(fn, delay) end

---@type ZO_Control
ZO_MailSendToField = {}
---@type ZO_Control
ZO_MailSendSubjectField = {}
---@type ZO_Control
ZO_MailSendBodyField = {}