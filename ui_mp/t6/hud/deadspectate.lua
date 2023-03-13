require("T6.DualButtonPrompt")

CoD.DeadSpectate = InheritFrom(LUI.UIElement)
CoD.DeadSpectate.SwitchPlayerBarHeight = 22
CoD.DeadSpectate.BodyStart = CoD.DeadSpectate.SwitchPlayerBarHeight
CoD.DeadSpectate.TextSize = CoD.textSize.Default
CoD.DeadSpectate.EmblemSideLength = 38
CoD.DeadSpectate.Width = 300
CoD.DeadSpectate.Height = CoD.DeadSpectate.SwitchPlayerBarHeight + CoD.DeadSpectate.EmblemSideLength
CoD.DeadSpectate.Bottom = -120
CoD.DeadSpectate.Font = CoD.fonts.ExtraSmall
CoD.DeadSpectate.TextSize = CoD.textSize.Default
LUI.createMenu.DeadSpectate = function(f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("DeadSpectate", f1_arg0)
	f1_local0.m_ownerController = f1_arg0
	f1_local0.m_selectedClientNum = nil

	local hud = CoD.SplitscreenScaler.new(nil, 1.5)
	hud:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	hud:setTopBottom(false, true, CoD.DeadSpectate.Bottom - CoD.DeadSpectate.Height, CoD.DeadSpectate.Bottom)
	f1_local0:addElement(hud)
	f1_local0.hud = hud

	local self = LUI.UIImage.new()
	self:setLeftRight(false, false, -76, 150)
	self:setTopBottom(true, false, 0, 62)
	self:setImage(RegisterMaterial(CoD.MPZM("hud_shoutcasting_change_tab", "hud_spectating_change_tab_zm")))
	hud.switchPlayerBar = LUI.UIElement.new()
	hud.switchPlayerBar:setLeftRight(true, false, 64, 237)
	hud.switchPlayerBar:setTopBottom(true, false, -3, 29)
	local f1_local3 = 9
	local f1_local4 = Engine.Localize("MPUI_SPECTATING")
	local f1_local5 = {}
	f1_local5 = GetTextDimensions(f1_local4, CoD.DeadSpectate.Font, CoD.DeadSpectate.TextSize)
	local f1_local6 = f1_local5[3]
	local f1_local7 =
		CoD.DualButtonPrompt.new("shoulderl", f1_local4, "shoulderr", nil, nil, nil, false, false, 0, "mouse1", "mouse2")
	f1_local7:setLeftRight(false, false, -f1_local6 / 2 - f1_local3 - 12, -f1_local6 / 2 - f1_local3)
	f1_local7:setTopBottom(false, false, -10, 10)
	hud.switchPlayerBar:addElement(f1_local7)
	local f1_local8 = LUI.UIImage.new()
	f1_local8:setLeftRight(false, false, -146, 146)
	f1_local8:setTopBottom(true, false, CoD.DeadSpectate.BodyStart - 4, 68)
	f1_local8:setImage(
		RegisterMaterial(CoD.MPZM("hud_shoutcasting_viewing_box_dead", "hud_spectating_viewing_box_dead_zm"))
	)
	f1_local8:setAlpha(1)
	local f1_local9 = CoD.DeadSpectate.Height - CoD.DeadSpectate.BodyStart
	local f1_local10 = CoD.DeadSpectate.BodyStart + f1_local9 / 2 - CoD.DeadSpectate.TextSize / 2
	hud.playerName = LUI.UITightText.new()
	hud.playerName:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	hud.playerName:setTopBottom(true, false, f1_local10, f1_local10 + CoD.DeadSpectate.TextSize)
	hud.playerName:setAlignment(LUI.Alignment.Center)
	local f1_local11 = f1_local10 + f1_local9
	local f1_local12 = LUI.UIHorizontalList.new()
	f1_local12:setLeftRight(false, false, -CoD.DeadSpectate.Width / 2, CoD.DeadSpectate.Width / 2)
	f1_local12:setTopBottom(true, false, f1_local11, f1_local11 + CoD.DeadSpectate.TextSize * 0.75)
	f1_local12:setAlignment(LUI.Alignment.Center)
	if Engine.GetActiveLocalClientsCount() == 1 and 0 == Engine.GetGametypeSetting("disableThirdPersonSpectating") then
		hud.spectateModeButton = CoD.ButtonPrompt.new("alt2", "", hud, nil, false, false, false, "mouse3")
		hud.spectateModeButton:setFont(CoD.DeadSpectate.Font)
		f1_local12:addElement(hud.spectateModeButton)
	end
	hud:addElement(self)
	hud:addElement(f1_local8)
	hud:addElement(hud.switchPlayerBar)
	hud:addElement(hud.playerName)
	hud:addElement(f1_local12)
	hud.playerName:setText("")
	hud:setAlpha(1)
	f1_local0:setAlpha(0)
	f1_local0.visible = false
	f1_local0:registerEventHandler("hud_update_refresh", CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_TEAM_SPECTATOR, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DRAW_SPECTATOR_MESSAGES, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.DeadSpectate.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_THIRD_PERSON, CoD.DeadSpectate.Update)
	return f1_local0
end

CoD.DeadSpectate.UpdateVisibility = function(f2_arg0, client)
	local f2_local0 = client.controller
	if
		UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_TEAM_SPECTATOR) == 0 and
			UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SPECTATING_CLIENT) == 1 and
			UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DRAW_SPECTATOR_MESSAGES) == 1 and
			UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and
			UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and
			UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0
	 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
		CoD.DeadSpectate.Update(f2_arg0, client)
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.DeadSpectate.Update = function(f3_arg0, client)
	local f3_local0 = Engine.GetSpectatingClientInfo(f3_arg0.m_ownerController)
	if f3_arg0.m_selectedClientNum ~= f3_local0.clientNum then
		f3_arg0.m_selectedClientNum = f3_local0.clientNum
		local f3_local1 = nil
		if f3_local0.clanTag ~= nil then
			f3_local1 = CoD.getClanTag(f3_local0.clanTag) .. f3_local0.name
		else
			f3_local1 = f3_local0.name
		end
		f3_arg0.hud.playerName:setText(f3_local1)
	end
	if f3_arg0.hud.spectateModeButton then
		if UIExpression.IsVisibilityBitSet(client.controller, CoD.BIT_IS_THIRD_PERSON) == 1 then
			CoD.ButtonPrompt.SetText(f3_arg0.hud.spectateModeButton, Engine.Localize("MPUI_FIRST_PERSON_VIEW"))
		else
			CoD.ButtonPrompt.SetText(f3_arg0.hud.spectateModeButton, Engine.Localize("MPUI_THIRD_PERSON_VIEW"))
		end
	end
end
