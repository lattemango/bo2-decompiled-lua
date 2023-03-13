LUI.UIText = InheritFrom(LUI.UIElement)

LUI.UIText.addElement = function(f1_arg0, f1_arg1)
    DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
    LUI.UIElement.addElement(f1_arg0, f1_arg1)
end

LUI.UIText.addElementBefore = function(f2_arg0, f2_arg1)
    DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
    LUI.UIElement.addElementBefore(f2_arg0, f2_arg1)
end

LUI.UIText.addElementAfter = function(f3_arg0, f3_arg1)
    DebugPrint("WARNING: An element is being added to a UIText element. This will cause undesired behavior!")
    LUI.UIElement.addElementAfter(f3_arg0, f3_arg1)
end

--- @param colour table
--- @param dontCache boolean
--- @return LUI.UIElement uiElement
LUI.UIText.new = function(colour, dontCache)
    -- If the colour passed through is nil
    if colour == nil then
        colour = {
            red = CoD.DefaultTextColor.r,
            green = CoD.DefaultTextColor.g,
            blue = CoD.DefaultTextColor.b
        }
    elseif colour.red == nil and colour.green == nil and colour.blue == nil then
        colour.red = CoD.DefaultTextColor.r
        colour.green = CoD.DefaultTextColor.g
        colour.blue = CoD.DefaultTextColor.b
    end

    -- Create new UIElement as UIText
    local uiElement = LUI.UIElement.new(colour)
    uiElement:setClass(LUI.UIText)

    --[[if not shouldCache then
		uiElement:setupUIText()
	else
		uiElement:setupUITextUncached()
	end--]]
    -- I rewrote the if statement because using not confuses me like crazy.
    if dontCache then
        uiElement:setupUITextUncached()
    else
        uiElement:setupUIText()
    end

    return uiElement
end

LUI.UIText.TransitionComplete_OutState = function(f5_arg0, f5_arg1)
    f5_arg0:setText(f5_arg0.replaceContentData.text)
    f5_arg0:registerEventHandler("transition_complete_" .. f5_arg0.replaceContentData.outState, nil)
    f5_arg0:animateToState(f5_arg0.replaceContentData.inState, f5_arg0.replaceContentData.inDuration)
    f5_arg0.replaceContentData = nil
end

LUI.UIText.setText = function(uiText, text, outState, inState, outDuration, inDuration)
    if outState ~= nil and inState ~= nil then
        uiText.replaceContentData = {}
        uiText.replaceContentData.outState = outState
        uiText.replaceContentData.inState = inState
        uiText.replaceContentData.outDuration = outDuration
        uiText.replaceContentData.inDuration = inDuration
        uiText.replaceContentData.text = text
        uiText:registerEventHandler("transition_complete_" .. outState, LUI.UIText.TransitionComplete_OutState)
        uiText:animateToState(outState, outDuration)
        return
    else
        uiText:setTextInC(text)
    end
end

LUI.UIText.id = "LUIText"
