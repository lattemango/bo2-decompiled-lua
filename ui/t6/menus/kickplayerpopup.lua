CoD.KickPlayerPopup = {}

CoD.KickPlayerPopup.Button_Yes = function(kickPlayerWidget, client)
    if UIExpression.IsInGame() == 1 then
        Engine.Exec(client.controller, "kickplayer_ingame " .. kickPlayerWidget.selectedPlayerXuid)
    else
        Engine.Exec(client.controller, "kickplayer " .. kickPlayerWidget.selectedPlayerXuid)
    end
	
    kickPlayerWidget:processEvent({ name = "closeallpopups", controller = client.controller })
end

--- @return table
LUI.createMenu.KickPlayerPopup = function(f2_arg0)
    local kickPopup = CoD.Menu.NewSmallPopup("KickPlayerPopup")
    kickPopup:addTitle(Engine.Localize("MPUI_KICK_PLAYER"))
    kickPopup:addSelectButton()
    kickPopup:addBackButton()
    kickPopup:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
    kickPopup.selectedPlayerXuid = CoD.FriendPopup.SelectedPlayerXuid
    kickPopup.selectedPlayerName = CoD.FriendPopup.SelectedPlayerName
	
    local buttonList = CoD.ButtonList.new({
        leftAnchor = true,
        rightAnchor = true,
        left = 0,
        right = 0,
        topAnchor = false,
        bottomAnchor = true,
        top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
        bottom = 0
    })
    kickPopup:addElement(buttonList)

	-- Yes
    kickPopup.yesButton = buttonList:addButton(Engine.Localize("MENU_YES"))
    kickPopup.yesButton:setActionEventName("kickplayer_yes")
    kickPopup:registerEventHandler("kickplayer_yes", CoD.KickPlayerPopup.Button_Yes)
	-- No
    kickPopup.noButton = buttonList:addButton(Engine.Localize("MENU_NO"))
    kickPopup.noButton:setActionEventName("kickplayer_no")
    kickPopup:registerEventHandler("kickplayer_no", kickPopup.goBack)
    kickPopup.noButton:processEvent({ name = "gain_focus" })

    return kickPopup
end

