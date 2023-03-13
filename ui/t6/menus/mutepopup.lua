CoD.MutePopup = {}

LUI.createMenu.Mute = function(controller)
    local mutePopup = CoD.Menu.NewSmallPopup("Mute")
    mutePopup.m_ownerController = controller
    mutePopup:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_MUTING")))
    mutePopup:addSelectButton()
    mutePopup:addBackButton()
	
    local buttonList = CoD.ButtonList.new({
        leftAnchor = true,
        rightAnchor = true,
        left = 0,
        right = 0,
        topAnchor = true,
        bottomAnchor = true,
        top = CoD.textSize.Big + 30,
        bottom = 0
    })
    mutePopup:addElement(buttonList)

	-- Mute all except party
    local muteAllButton = buttonList:addButton(Engine.Localize("MENU_MUTE_ALL_EXCEPT_PARTY_CAPS"), Engine.Localize("MENU_MUTE_ALL_EXCEPT_PARTY_DESC"))
    muteAllButton:setActionEventName("mute_all_but_party")
    mutePopup:registerEventHandler("mute_all_but_party", CoD.MutePopup.MuteAllButParty)

	-- Unmute all
    local unmuteButton = buttonList:addButton(Engine.Localize("MENU_UNMUTE_ALL_CAPS"), Engine.Localize("MENU_UNMUTE_ALL_DESC"))
    unmuteButton:setActionEventName("unmute_all")
    mutePopup:registerEventHandler("unmute_all", CoD.MutePopup.UnmuteAll)

    if CoD.useController then
        muteAllButton:processEvent({ name = "gain_focus" })
    end

    Engine.PlaySound("cac_loadout_edit_sel")
    return mutePopup
end

CoD.MutePopup.MuteAll = function(f2_arg0, client)
    Engine.PartyMuteAll()
    f2_arg0:goBack(client.controller)
end

CoD.MutePopup.MuteAllButParty = function(f3_arg0, client)
    Engine.PartyMuteAllButParty(client.controller)
    f3_arg0:goBack(client.controller)
end

CoD.MutePopup.UnmuteAll = function(f4_arg0, client)
    Engine.PartyUnmuteAll()
    f4_arg0:goBack(client.controller)
end

