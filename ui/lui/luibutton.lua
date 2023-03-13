LUI.UIButton = InheritFrom(LUI.UIElement)
LUI.UIButton.GainFocusEvent = {
    name = "gain_focus"
}
LUI.UIButton.LoseFocusEvent = {
    name = "lose_focus"
}

LUI.UIButton.MouseEnter = function(button, client)
    if button.m_leftMouseDown == nil then
        if button.m_focusable and not button:isInFocus() then
            button:processEvent({
                name = "button_over",
                controller = client.controller
            })
        end
    elseif button.m_leftMouseDown ~= nil then
        button:processEvent({
            name = "button_over_down",
            controller = client.controller
        })
    end
end

LUI.UIButton.MouseLeave = function(button, client)
    if button.m_leftMouseDown == nil then
        button:processEvent({
            name = "button_up",
            controller = client.controller
        })
    else
        button:processEvent({
            name = "button_down",
            controller = client.controller
        })
    end
end

LUI.UIButton.LeftMouseDown = function(button, client)
    button:processEvent({
        name = "button_over_down",
        controller = client.controller
    })
end

LUI.UIButton.RightMouseDown = function(button, client)
    button:processEvent({
        name = "button_over_down",
        controller = client.controller
    })
end

LUI.UIButton.LeftMouseUp = function(button, client)
    if client.inside and not button.disabled then
        local f5_local0 = button:processEvent({
            name = "button_action",
            controller = client.controller,
            mouse = true
        })

        if f5_local0 then
            return f5_local0
        end
    end
end

LUI.UIButton.RightMouseUp = function(button, client)
    if client.inside and not button.disabled then
        local f6_local0 = button:processEvent({
            name = "button_actionsecondary",
            controller = client.controller,
            mouse = true
        })
        if f6_local0 then
            return f6_local0
        end
    end
end

LUI.UIButton.GamepadButton = function(button, mouse)
    if button:handleGamepadButton(mouse) then
        return true
    elseif button:isInFocus() and mouse.down == true and mouse.button == "primary" then
        if not button.disabled then
            button:processEvent({
                name = "button_action",
                controller = mouse.controller
            })
        end
        return true
    else
        return button:dispatchEventToChildren(mouse)
    end
end

LUI.UIButton.gainFocus = function(f8_arg0, f8_arg1)
    local f8_local0 = f8_arg0:isInFocus()
    LUI.UIButton.super.gainFocus(f8_arg0, f8_arg1)
    f8_arg0:processEvent({
        name = "button_over",
        controller = f8_arg1.controller
    })
    if f8_arg0.actionPromptString and (not CoD.isPC or f8_arg0.actionEventName) then
        f8_arg0:dispatchEventToParent({
            name = "set_action_prompt_string",
            promptString = f8_arg0.actionPromptString
        })
    end
end

LUI.UIButton.loseFocus = function(f9_arg0, f9_arg1)
    LUI.UIButton.super.loseFocus(f9_arg0, f9_arg1)
    f9_arg0:processEvent({
        name = "button_up",
        controller = f9_arg1.controller
    })
end

LUI.UIButton.Up = function(f10_arg0, f10_arg1)
    if f10_arg0.disabled and f10_arg0.m_animationStates.disabled ~= nil then
        f10_arg0:animateToState("disabled", f10_arg0.disableDuration)
    else
        f10_arg0:animateToState("default", f10_arg0.upDuration, f10_arg0.upEaseIn, f10_arg0.upEaseOut)
    end
    f10_arg0:dispatchEventToChildren(f10_arg1)
    if f10_arg0:isInFocus() then
        f10_arg0:processEvent(LUI.UIButton.GainFocusEvent)
    end
end

LUI.UIButton.Over = function(f11_arg0, f11_arg1)
    if f11_arg0.disabled and f11_arg0.m_animationStates.button_over_disabled ~= nil then
        f11_arg0:animateToState("button_over_disabled", f11_arg0.disableDuration)
    elseif f11_arg0.m_animationStates.button_over ~= nil then
        f11_arg0:animateToState("button_over", f11_arg0.overDuration, f11_arg0.overEaseIn, f11_arg0.overEaseOut)
    end
    f11_arg0:dispatchEventToChildren(f11_arg1)
end

LUI.UIButton.ElementUp = function(f12_arg0, f12_arg1)

end

LUI.UIButton.ElementDown = function(f13_arg0, f13_arg1)
    if f13_arg0.m_animationStates.button_down ~= nil then
        f13_arg0:animateToState("button_down", f13_arg0.downDuration)
    else
        LUI.UIButton.ElementUp(f13_arg0, f13_arg1)
    end
    f13_arg0:dispatchEventToChildren(f13_arg1)
end

LUI.UIButton.ElementOverDown = function(f14_arg0, f14_arg1)
    if f14_arg0.m_animationStates.button_over_down ~= nil then
        f14_arg0:animateToState("button_over_down", f14_arg0.overDownDuration)
    else

    end
    f14_arg0:dispatchEventToChildren(f14_arg1)
end

LUI.UIButton.ElementEnable = function(f15_arg0, f15_arg1)
    f15_arg0.disabled = nil
    f15_arg0:dispatchEventToChildren(f15_arg1)
    f15_arg0:processEvent({
        name = "button_up"
    })
end

LUI.UIButton.ElementDisable = function(f16_arg0, f16_arg1)
    f16_arg0.disabled = true
    f16_arg0:dispatchEventToChildren(f16_arg1)
    f16_arg0:processEvent({
        name = "button_up"
    })
end

LUI.UIButton.enable = function(f17_arg0)
    f17_arg0:processEvent({
        name = "enable"
    })
    f17_arg0:processEvent({
        name = "button_up"
    })
end

LUI.UIButton.disable = function(f18_arg0)
    f18_arg0:processEvent({
        name = "disable"
    })
    f18_arg0:processEvent({
        name = "button_up"
    })
end

LUI.UIButton.SetupElement = function(f19_arg0)
    f19_arg0:registerEventHandler("enable", LUI.UIButton.ElementEnable)
    f19_arg0:registerEventHandler("disable", LUI.UIButton.ElementDisable)
    f19_arg0:registerEventHandler("button_up", LUI.UIButton.Up)
    f19_arg0:registerEventHandler("button_over", LUI.UIButton.Over)
    f19_arg0:registerEventHandler("button_down", LUI.UIButton.ElementDown)
    f19_arg0:registerEventHandler("button_over_down", LUI.UIButton.ElementOverDown)
end

LUI.UIButton.buttonAction = function(f20_arg0, f20_arg1)
    if f20_arg0.actionEventName ~= nil then
        f20_arg0:dispatchEventToParent({
            name = f20_arg0.actionEventName,
            controller = f20_arg1.controller,
            button = f20_arg0
        })
        if f20_arg0.actionSFX ~= nil then
            Engine.PlaySound(f20_arg0.actionSFX)
        end
    end
end

LUI.UIButton.setActionEventName = function(f21_arg0, f21_arg1)
    f21_arg0.actionEventName = f21_arg1
end

LUI.UIButton.setActionPromptString = function(f22_arg0, f22_arg1)
    f22_arg0.actionPromptString = f22_arg1
end

LUI.UIButton.setGainFocusSFX = function(f23_arg0, f23_arg1)
    f23_arg0.gainFocusSFX = f23_arg1
end

LUI.UIButton.setActionSFX = function(f24_arg0, f24_arg1)
    f24_arg0.actionSFX = f24_arg1
end

LUI.UIButton.clearGainFocusSFX = function(f25_arg0)
    f25_arg0.gainFocusSFX = nil
end

LUI.UIButton.clearActionSFX = function(f26_arg0)
    f26_arg0.actionSFX = nil
end

LUI.UIButton.new = function(menu, controller)
    local self = LUI.UIElement.new(menu)
    self:setClass(LUI.UIButton)
    self.id = "LUIButton"
    self:makeFocusable()
    self:setHandleMouse(true)
    self.actionEventName = controller
    if CoD.isSinglePlayer then
        if CoD.isPC then
            self.gainFocusSFX = "cac_grid_nav"
        else
            self.gainFocusSFX = "uin_slide_nav_up"
        end
        self.actionSFX = "uin_main_enter"
    else
        self.gainFocusSFX = "cac_grid_nav"
        self.actionSFX = "cac_grid_equip_item"
    end
    return self
end

LUI.UIButton:registerEventHandler("mouseenter", LUI.UIButton.MouseEnter)
LUI.UIButton:registerEventHandler("mouseleave", LUI.UIButton.MouseLeave)
LUI.UIButton:registerEventHandler("leftmousedown", LUI.UIButton.LeftMouseDown)
LUI.UIButton:registerEventHandler("leftmouseup", LUI.UIButton.LeftMouseUp)
LUI.UIButton:registerEventHandler("rightmousedown", LUI.UIButton.RightMouseDown)
LUI.UIButton:registerEventHandler("rightmouseup", LUI.UIButton.RightMouseUp)
LUI.UIButton:registerEventHandler("gamepad_button", LUI.UIButton.GamepadButton)
LUI.UIButton:registerEventHandler("gain_focus", LUI.UIButton.gainFocus)
LUI.UIButton:registerEventHandler("lose_focus", LUI.UIButton.loseFocus)
LUI.UIButton:registerEventHandler("button_action", LUI.UIButton.buttonAction)
LUI.UIButton:SetupElement()
