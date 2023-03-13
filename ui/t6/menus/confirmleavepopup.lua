CoD.ConfirmLeave = {}
local f0_local0 = function(f1_arg0, f1_arg1)
    if f1_arg0.confirmEvent == nil then
        return
    else
        f1_arg0:goBack(f1_arg1.controller)
        f1_arg0.occludedMenu:processEvent({
            name = f1_arg0.confirmEvent,
            controller = f1_arg1.controller
        })
    end
end

local f0_local1 = function(f2_arg0, f2_arg1)
    if f2_arg0.cancelEvent == nil then
        return
    else
        f2_arg0.occludedMenu:processEvent({
            name = f2_arg0.cancelEvent,
            controller = f2_arg1.controller
        })
        f2_arg0:goBack(f2_arg1.controller)
    end
end

CoD.ConfirmLeave.SetConfirmEvent = function(f3_arg0, event)
    f3_arg0.confirmEvent = event
end

CoD.ConfirmLeave.SetCancelEvent = function(f4_arg0, event)
    f4_arg0.cancelEvent = event
end

CoD.ConfirmLeave.CustomAction = function(f5_arg0, client)
    if client.button.leaveEvent == nil then
        return
    elseif CoD.isZombie and 
	(Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == true or 
	Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true) and 
	UIExpression.IsPrimaryLocalClient(client.controller) == 0 then
        f5_arg0:openPopup("NoLeave")
        return
    else
        f5_arg0:goBack(client.controller)
        f5_arg0.occludedMenu:processEvent({
            name = client.button.leaveEvent,
            controller = client.controller
        })
    end
end

LUI.createMenu.ConfirmLeave = function(f6_arg0, popupArg)
    local confirmLeavePopup = CoD.Menu.NewSmallPopup("ConfirmLeave")
    confirmLeavePopup:addSelectButton()
    confirmLeavePopup:addBackButton()
    confirmLeavePopup:registerEventHandler("confirm_action", f0_local0)
    confirmLeavePopup:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
    confirmLeavePopup:registerEventHandler("custom_action", CoD.ConfirmLeave.CustomAction)
    confirmLeavePopup.setMessageText = CoD.ConfirmLeave.SetMessageText
    confirmLeavePopup.setConfirmEvent = CoD.ConfirmLeave.SetConfirmEvent
    confirmLeavePopup.setCancelEvent = CoD.ConfirmLeave.SetCancelEvent

    local f6_local1 = 0
    local popupTitle = LUI.UIText.new()
    popupTitle:setLeftRight(true, false, 0, CoD.Menu.SmallPopupWidth)
    popupTitle:setTopBottom(true, false, f6_local1, f6_local1 + CoD.textSize.Big)
    popupTitle:setFont(CoD.fonts.Big)
    popupTitle:setAlignment(LUI.Alignment.Left)
    popupTitle:setText(popupArg.titleText)
    confirmLeavePopup:addElement(popupTitle)

    f6_local1 = f6_local1 + CoD.textSize.Big
	
    local popupDesc = LUI.UIText.new()
    popupDesc:setLeftRight(true, true, 0, 0)
    popupDesc:setTopBottom(true, false, f6_local1, f6_local1 + CoD.textSize.Default)
    popupDesc:setFont(CoD.fonts.Default)
    popupDesc:setAlignment(LUI.Alignment.Left)
    confirmLeavePopup:addElement(popupDesc)

    if popupArg ~= nil and popupArg.messageText ~= nil then
        popupDesc:setText(popupArg.messageText)
    end

    local paramCount = 1
    local f6_local5 = 10
    if popupArg and popupArg.params and #popupArg.params > 0 then
        paramCount = #popupArg.params
        if paramCount == 2 and CoD.isZombie == true then
            f6_local5 = 0
        end
    end

    confirmLeavePopup.buttonList = CoD.ButtonList.new({
        leftAnchor = true,
        rightAnchor = true,
        left = 0,
        right = 0,
        topAnchor = false,
        bottomAnchor = true,
        top = -CoD.ButtonPrompt.Height * paramCount - CoD.CoD9Button.Height * 3 + f6_local5,
        bottom = 0
    })

    confirmLeavePopup:addElement(confirmLeavePopup.buttonList)
    if popupArg ~= nil then
        for k, v in pairs(popupArg.params) do
            local f6_local11 = confirmLeavePopup.buttonList:addButton(v.leaveText)
            f6_local11:setActionEventName("custom_action")
            f6_local11.leaveEvent = v.leaveEvent
        end
    else
        local confirmButton = confirmLeavePopup.buttonList:addButton(Engine.Localize("MPUI_YES"))
        confirmButton:setActionEventName("confirm_action")
    end
	
    local cancelButton = confirmLeavePopup.buttonList:addButton(Engine.Localize("MPUI_CANCEL"))
    cancelButton:setActionEventName("cancel_action")
    cancelButton:processEvent({ name = "gain_focus" })

    Engine.PlaySound("caC_main_exit_cac")
    return confirmLeavePopup
end

