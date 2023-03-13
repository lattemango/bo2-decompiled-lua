require("T6.CoD9Button")

if CoD == nil then
    CoD = {}
end
CoD.ButtonPrompt = {}
CoD.ButtonPrompt.FontName = "ExtraSmall"
CoD.ButtonPrompt.Height = 25
CoD.ButtonPrompt.TextHeight = CoD.textSize[CoD.ButtonPrompt.FontName]
CoD.ButtonPrompt.ButtonToTextSpacing = 3
local f0_local0 = function(f1_arg0, f1_arg1)
    f1_arg0.disabled = nil
    f1_arg0:animateToState("enabled")
    f1_arg0:dispatchEventToChildren(f1_arg1)
end

local f0_local1 = function(f2_arg0, f2_arg1)
    f2_arg0.disabled = true
    f2_arg0:animateToState("disabled")
    f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.ButtonPrompt.Enable = function(f3_arg0)
    f3_arg0:processEvent({name = "enable"})
end

CoD.ButtonPrompt.Disable = function(f4_arg0)
    f4_arg0:processEvent({name = "disable"})
end

CoD.ButtonPrompt.SetupElement = function(f5_arg0)
    f5_arg0:registerEventHandler("enable", f0_local0)
    f5_arg0:registerEventHandler("disable", f0_local1)
end

CoD.ButtonPrompt.new = function(
    button,
    labelText,
    someElement,
    eventName,
    f6_arg4,
    f6_arg5,
    f6_arg6,
    shortcut,
    shortcutKey,
    bind1)
    local promptHeight = CoD.ButtonPrompt.Height
    local textHeight = CoD.ButtonPrompt.TextHeight
    local promptFont = CoD.fonts[CoD.ButtonPrompt.FontName]

    local uiElement = LUI.UIElement.new()
    uiElement:setTopBottom(false, false, -promptHeight / 2, promptHeight / 2)
    uiElement.button = button
    uiElement.enable = CoD.ButtonPrompt.Enable
    uiElement.disable = CoD.ButtonPrompt.Disable
    uiElement.setNew = CoD.ButtonPrompt.SetNew
    uiElement.setText = CoD.ButtonPrompt.SetText
    CoD.ButtonPrompt.SetupElement(uiElement)
    uiElement:registerAnimationState("enabled", {alpha = 1})
    uiElement:registerAnimationState("disabled", {alpha = 1})

    if shortcutKey then
        uiElement.m_shortcut = true
    end

    if someElement ~= nil and eventName ~= nil then
        uiElement:registerEventHandler(
            "gamepad_button",
            function(element, event)
                if not element.disabled and event.down == true then
                    if event.button == button and (f6_arg5 == nil or event.qualifier == f6_arg5) then
                        if not element.m_shortcut or Engine.LastInput_Gamepad() then
                            element:processEvent({name = eventName, controller = event.controller})
                            return true
                        end
                    elseif
                        CoD.isPC and event.button == "key_shortcut" and
                            (event.key == shortcutKey or event.bind1 == bind1)
                     then
                        element:processEvent({name = eventName, controller = event.controller})
                        return true
                    end
                end
            end
        )
    end

    local uiText = LUI.UIText.new()
    uiText:setTopBottom(false, false, -textHeight / 2, textHeight / 2)
    uiText:setFont(promptFont)
    uiText:setAlpha(1)
    uiText:registerAnimationState("enabled", {alpha = 1})
    uiText:registerAnimationState("disabled", {alpha = 0.5})
    CoD.ButtonPrompt.SetupElement(uiText)
    uiElement:addElement(uiText)
    uiText:setText(labelText)
    uiElement.label = uiText
    uiElement.labelText = labelText

    local uiText2 = nil
    if not f6_arg4 then
        uiText2 = LUI.UIText.new()
        uiText2:setTopBottom(false, false, -promptHeight / 2, promptHeight / 2)
        uiText2:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
        uiText2:setFont(promptFont)
        uiText2:setAlpha(1)
        if uiText2 ~= nil then
            if CoD.isPC then
                if shortcutKey ~= nil then
                    uiText2.shortcutKey = shortcutKey
                end

                if shortcut ~= nil then
                    uiText2.shortcut = shortcut
                else
                    uiText2.shortcut = button
                end
            end

            local buttonString = nil
            if CoD.useController and Engine.LastInput_Gamepad() then
                buttonString = CoD.buttonStrings[button]
            elseif CoD.isPC then
                if shortcutKey then
                    buttonString = shortcutKey
                elseif string.sub(CoD.buttonStringsShortCut[uiText2.shortcut], 1, 1) == "+" then
                    buttonString =
                        Engine.GetKeyBindingLocalizedString(0, CoD.buttonStringsShortCut[uiText2.shortcut], 0)
                elseif string.sub(CoD.buttonStringsShortCut[uiText2.shortcut], 1, 1) == "@" then
                    buttonString = Engine.Localize(string.sub(CoD.buttonStringsShortCut[uiText2.shortcut], 2))
                else
                    buttonString = CoD.buttonStringsShortCut[uiText2.shortcut]
                end
            end
            uiText2:setText(buttonString)
            uiElement.prompt = buttonString
            uiText2:registerAnimationState("enabled", {alpha = 1})
            uiText2:registerAnimationState("disabled", {alpha = 0.25})
            CoD.ButtonPrompt.SetupElement(uiText2)
            uiElement.buttonImage = uiText2
            uiElement:addElement(uiText2)
        end
    end

    if CoD.useMouse and (uiText2 ~= nil or labelText ~= "") then
        local uiButton =
            LUI.UIButton.new(
            {
                left = 0,
                top = 0,
                right = 0,
                bottom = 0,
                leftAnchor = true,
                topAnchor = true,
                rightAnchor = true,
                bottomAnchor = true
            }
        )
        if uiText2 ~= nil and isDualButton then
            uiText2:addElement(uiButton)
        else
            uiElement:addElement(uiButton)
        end
        if someElement ~= nil and eventName ~= nil then
            uiButton:registerEventHandler(
                "button_action",
                function(element, event)
                    element:processEvent({name = eventName, controller = event.controller})
                    return true
                end
            )
        end
        uiButton:setHandleMouseMove(false)
        uiElement:setHandleMouseMove(true)
        uiElement:registerEventHandler("mouseenter", CoD.ButtonPrompt.MouseEnter)
        uiElement:registerEventHandler("mouseleave", CoD.ButtonPrompt.MouseLeave)
        uiElement:registerEventHandler("input_source_changed", CoD.ButtonPrompt.InputSourceChanged)
    end

    CoD.ButtonPrompt.ResizeButtonPrompt(uiElement)
    return uiElement
end

CoD.ButtonPrompt.ResizeButtonPrompt = function(uiElement)
    local buttonPadding = CoD.ButtonPrompt.ButtonToTextSpacing
    local buttonHeight = CoD.ButtonPrompt.Height

    local textHeight = CoD.ButtonPrompt.TextHeight
    local textFont = CoD.fonts[CoD.ButtonPrompt.FontName]
    local positionX, positionY, textWidth, textHeight = GetTextDimensions(uiElement.labelText, textFont, textHeight)
    local someButtonDimension = textWidth - positionX
    print("[buttonprompt.lua] See below:")
    print(positionX, positionY, textWidth, textHeight)

    uiElement.label:setLeftRight(false, true, -someButtonDimension, 0)
    buttonPadding = buttonPadding + someButtonDimension

    if uiElement.prompt ~= nil then
        local promptHeight = nil

        if string.sub(uiElement.prompt, 1, 2) == "^B" and not uiElement.forceMeasureButtonWidth then
            promptHeight = CoD.ButtonPrompt.Height
        else
            textDimensions = GetTextDimensions(uiElement.prompt, textFont, buttonHeight)
            promptHeight = textDimensions[3] - textDimensions[1]
        end
        uiElement.buttonImage:setLeftRight(true, false, 0, promptHeight)
        buttonPadding = buttonPadding + promptHeight
    end

    if uiElement.newIcon then
        local f9_local6 = 5
        buttonPadding = buttonPadding + f9_local6
        uiElement.newIcon:setLeftRight(
            true,
            false,
            buttonPadding,
            buttonPadding + CoD.CACUtility.ButtonGridNewImageWidth
        )
        uiElement.label:setLeftRight(
            false,
            true,
            -someButtonDimension - CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f9_local6,
            -CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f9_local6
        )
        buttonPadding = buttonPadding + CoD.CACUtility.ButtonGridNewImageRightAlignWidth
    end

    uiElement:setLeftRight(true, false, 0, buttonPadding)
end

CoD.ButtonPrompt.InputSourceChanged = function(f10_arg0, f10_arg1)
    if f10_arg0.buttonImage == nil then
        return
    elseif CoD.useMouse then
        if CoD.useController and f10_arg1.source == 0 then
            f10_arg0.prompt = CoD.buttonStrings[f10_arg0.button]
            f10_arg0.buttonImage:setText(f10_arg0.prompt)
        else
            if f10_arg0.buttonImage.shortcutKey then
                f10_arg0.prompt = f10_arg0.buttonImage.shortcutKey
            elseif string.sub(CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 1, 1) == "+" then
                f10_arg0.prompt =
                    Engine.GetKeyBindingLocalizedString(
                    0,
                    CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut],
                    0
                )
            elseif string.sub(CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 1, 1) == "@" then
                f10_arg0.prompt =
                    Engine.Localize(string.sub(CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 2))
            else
                f10_arg0.prompt = CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut]
            end
            f10_arg0.buttonImage:setText(f10_arg0.prompt)
        end
        CoD.ButtonPrompt.ResizeButtonPrompt(f10_arg0)
    end
end

CoD.ButtonPrompt.SetNew = function(f11_arg0, f11_arg1)
    if f11_arg1 then
        if not f11_arg0.newIcon then
            local newIcon = LUI.UIImage.new()
            newIcon:setLeftRight(true, false, 0, CoD.CACUtility.ButtonGridNewImageWidth)
            newIcon:setTopBottom(
                false,
                false,
                -CoD.CACUtility.ButtonGridNewImageHeight / 2,
                CoD.CACUtility.ButtonGridNewImageHeight / 2
            )
            newIcon:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
            f11_arg0:addElement(newIcon)
            f11_arg0.newIcon = newIcon
        end
    elseif f11_arg0.newIcon then
        f11_arg0.newIcon:close()
        f11_arg0.newIcon = nil
    end
    CoD.ButtonPrompt.ResizeButtonPrompt(f11_arg0)
end

CoD.ButtonPrompt.SetText = function(f12_arg0, f12_arg1)
    f12_arg0.label:setText(f12_arg1)
    f12_arg0.labelText = f12_arg1
    CoD.ButtonPrompt.ResizeButtonPrompt(f12_arg0)
end

CoD.ButtonPrompt.MouseEnter = function(f13_arg0, f13_arg1)
    if f13_arg0.buttonImage == nil then
        return
    else
        f13_arg0.buttonImage:beginAnimation("pop", 50)
        f13_arg0.buttonImage:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
    end
end

CoD.ButtonPrompt.MouseLeave = function(f14_arg0, f14_arg1)
    if f14_arg0.buttonImage == nil then
        return
    else
        local f14_local0 = CoD.ButtonPrompt.TextHeight
        f14_arg0.buttonImage:beginAnimation("default", 50)
        f14_arg0.buttonImage:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
    end
end
