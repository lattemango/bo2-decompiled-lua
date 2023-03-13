--[[ The purpose of this file is to satisfy Lua's undefined-global checks (because HavokScript has some differences with Lua) and to document some unknown functions ]]

-- Global Tables

CoD = {}
Dvar = {}
Engine = {}
LUI = {}
UIExpression = {}

-- Global Function Definitions

--- Registers a material in the game for use
--- @param material string
function RegisterMaterial(material) end

--- Registers a font in the game for use
--- @param font string
function RegisterFont(font) end

--- Registers an opened menu
--- @param uiElement LUI.UIElement
--- @param menuId number
function RegisterOpenedMenu(uiElement, menuId) end

--- Unregisters an opened menu
--- @param uiElement LUI.UIElement
--- @param menuId number
function UnregisterOpenedMenu(uiElement, menuId) end

--- Used by devs. This may be similar to `print()`
--- @param message string
function DebugPrint(message) end

--- Gets the 2D dimensions of some text on the screen. `var1` and `var4` are always 0 in my testing.
--- @param text string
--- @param font string
--- @param textSize number
--- @return number var1
--- @return number var2
--- @return number var3
--- @return number var4
--- @nodiscard
function GetTextDimensions(text, font, textSize) return 0, 0, 0, 0 end

--- No clue what this function actually does. Fuck you too!
--- @param text string
function GetDisplayedText(text) end

--- No clue what this function does either. Similar to `GetDisplayedText()`
--- @param text string
function GetDisplayedPassword(text) end

--- No clue what this function does.
--- @param rootName string
--- @param x number
--- @param y number
--- @return boolean ret1
--- @return unknown ret2
--- @return unknown ret3
--- @nodiscard
function ProjectRootCoordinate(rootName, x, y) return false, nil, nil end

--- Constructs an LUI Element
--- @return unknown ret1
--- @nodiscard
function ConstructLUIElement() return nil end

--- I have no idea what this is. I saw it used while registering an event handler.
--- @param element string
function TaperAnimation(element) end

-- Global Field Definitions

-- Registers an animation state or something
--- @param something string
--- @param positionsAndStuff table
function LUI.UIElement:registerAnimationState(something, positionsAndStuff) end
