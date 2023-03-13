LUI = {
    UIWidth = 960,
    UIHeight = 720,
    roots = {},
    createMenu = {},
    Alignment = {
        None = 0,
        Left = 1,
        Center = 2,
        Right = 3,
        Top = 4,
        Middle = 5,
        Bottom = 6
    },
    savedMenuStates = {}
}

-- FIXME: hpairs and pairs are undefined. I have no clue what they are.
if hpairs ~= nil then
    pairs = hpairs
end

--- Creates a new class that inherits the baseClass and returns it.
--- @param baseClass any
--- @return any
function InheritFrom(baseClass)
    if not baseClass then
        error("LUI Error: Did not specify bsae class in InheritFrom!")
    end

    local inheritedClass = {
        super = baseClass
    }
    setmetatable(inheritedClass, {
        __index = baseClass
    })

    inheritedClass.m_eventHandlers = {}
    setmetatable(inheritedClass.m_eventHandlers, {
        __index = baseClass.m_eventHandlers
    })

    return inheritedClass
end

--- Shallow copies values from source and returns the new table.
--- @param source any
--- @return table
LUI.ShallowCopy = function(source)
    local dest = {}

    for k, v in pairs(source) do
        dest[k] = v
    end

    return dest
end

--- Concatenates values from source to dest.
--- @param dest table
--- @param source table
LUI.ConcatenateToTable = function(dest, source)
    if source == nil then
        return
    end

    for k, v in pairs(source) do
        table.insert(dest, v)
    end
end

--- Clamps value to a given range and returns the clamped value.
--- @param value number
--- @param min number
--- @param max number
--- @return number
LUI.clamp = function(value, min, max)
    if value <= min then
        return min
    elseif max <= value then
        return max
    else
        return value
    end
end

--- Checks if source starts with match.
--- @param match string
--- @param source string
LUI.startswith = function(match, source)
    return string.sub(match, 1, string.len(source)) == source
end

-- They just casually require stuff at the bottom???????

require("LUI.LUIElement")
require("LUI.LUIElementAllocator")
require("LUI.LUIRoot")
require("LUI.LUITimer")
require("LUI.LUIButtonRepeater")
require("LUI.LUIImage")
require("LUI.LUIStreamedImage")
require("LUI.LUIText")
require("LUI.LUIAnimNumber")
require("LUI.LUITightText")
require("LUI.LUIButton")
require("LUI.LUIMouseCursor")
require("LUI.LUIVerticalList")
require("LUI.LUIHorizontalList")
require("LUI.LUIGridList")
require("LUI.LUIScrollable")
require("LUI.LUIVerticalScrollbar")
require("LUI.LUISafeAreaOverlay")
require("LUI.LUITouchpadButton")
require("LUI.LUITouchpadRadioButton")

if not debug then
    debug = {}
end

debug.postdeploymentfunction = function()
    for k, v in pairs(LUI.roots) do
        v.debugReload = true
    end
end

LargestElements = {}
LargestElementsSize = {}
LargestElementsCount = {}

--- These functions below are confusing as fudge.
--- @param someTable table
--- @param anotherTable table
--- @return number
function CountFieldsHelper(someTable, anotherTable)
    if anotherTable[someTable] then
        return
    end

    anotherTable[someTable] = true

    local numFields = 0
    for k, v in pairs(someTable) do
        if type(k) == "table" then
            numFields = numFields + CountFieldsHelper(k, anotherTable)
        end

        numFields = numFields + 1
    end

    return numFields
end

--- @param someTable table
--- @return number
function CountFields(someTable)
    return CountFieldsHelper(someTable, {})
end

function CountReferencesHelper(f9_arg0, f9_arg1)
    if f9_arg1[f9_arg0] then
        return
    end

    f9_arg1[f9_arg0] = true

    if type(f9_arg0) == "userdata" then
        local f9_local0 = getmetatable(f9_arg0)
        if not f9_local0 then
            return
        end
        f9_arg0 = f9_local0.__index
        if not f9_arg0 then
            return
        elseif type(f9_arg0) == "table" and f9_arg0.id then
            local f9_local1 = CountFields(f9_arg0)
            if not LargestElementsSize[f9_arg0.id] or LargestElementsSize[f9_arg0.id] < f9_local1 then
                LargestElements[f9_arg0.id] = f9_arg0
                LargestElementsSize[f9_arg0.id] = f9_local1
            end
            if not LargestElementsCount[f9_arg0.id] then
                LargestElementsCount[f9_arg0.id] = 0
            end
            LargestElementsCount[f9_arg0.id] = LargestElementsCount[f9_arg0.id] + 1
        end
    end
    if type(f9_arg0) ~= "table" then
        return
    end
    for f9_local3, f9_local4 in pairs(f9_arg0) do
        CountReferencesHelper(f9_local4, f9_arg1)
    end
end

function CountReferences(object)
    local someTable = { [object] = true }

    if type(object) == "userdata" then
        local metatable = getmetatable(object)

        if not metatable then
			return 0
		end

        object = metatable.__index
        if not object then
            return 0
        end
    end

    if type(object) ~= "table" then
        return 0
    end
    for f10_local4, f10_local5 in pairs(object) do
        CountReferencesHelper(f10_local5, someTable)
    end
	
    f10_local1 = 0
    for k, v in pairs(someTable) do
        f10_local1 = f10_local1 + 1
    end
    return f10_local1
end

function DisableGlobals()
    local globalMetatable = getmetatable(_G)
    if not globalMetatable then
        globalMetatable = {}
        setmetatable(_G, globalMetatable)
    end

    globalMetatable.__newindex = function(f12_arg0, global, f12_arg2)
        error("LUI Error: Tried to create global variable " .. global, 2)
    end
end

function EnableGlobals()
    local f13_local0 = getmetatable(_G)
    if not f13_local0 then
        f13_local0 = {}
        setmetatable(_G, f13_local0)
    end
    f13_local0.__newindex = nil
end
