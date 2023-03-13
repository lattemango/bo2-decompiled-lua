CoD.RoundStatus = {}
CoD.RoundStatus.FactionIconLeftOffset = 0
CoD.RoundStatus.FactionIconSize = 96
CoD.RoundStatus.RoundIconLeftOffset = CoD.RoundStatus.FactionIconSize + 0
CoD.RoundStatus.LeftOffset = 0
CoD.RoundStatus.ChalkTop = -96
CoD.RoundStatus.ChalkSize = 96
CoD.RoundStatus.SpecialRoundIconSize = 85
CoD.RoundStatus.RoundCenterHeight = 80
CoD.RoundStatus.Chalks = {}
CoD.RoundStatus.FirstRoundDuration = 1000
CoD.RoundStatus.FirstRoundIdleDuration = 3000
CoD.RoundStatus.FirstRoundFallDuration = 2000
CoD.RoundStatus.RoundPulseDuration = 500
CoD.RoundStatus.RoundPulseTimes = 2
CoD.RoundStatus.RoundPulseTimesDelta = 5
CoD.RoundStatus.RoundPulseTimesMin = 2
CoD.RoundStatus.RoundMax = 100
CoD.RoundStatus.ChalkFontName = "Morris"
LUI.createMenu.RoundStatus = function(f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("RoundStatus", f1_arg0)
	if
		CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps)
		or CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps)
		or CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps)
	then
		CoD.RoundStatus.DefaultColor = {
			r = 0.21,
			g = 0,
			b = 0,
		}
		CoD.RoundStatus.AlternatePulseColor = {
			r = 1,
			g = 1,
			b = 1,
		}
		CoD.RoundStatus.Chalks[1] = RegisterMaterial("chalkmarks_hellcatraz_1")
		CoD.RoundStatus.Chalks[2] = RegisterMaterial("chalkmarks_hellcatraz_2")
		CoD.RoundStatus.Chalks[3] = RegisterMaterial("chalkmarks_hellcatraz_3")
		CoD.RoundStatus.Chalks[4] = RegisterMaterial("chalkmarks_hellcatraz_4")
		CoD.RoundStatus.Chalks[5] = RegisterMaterial("chalkmarks_hellcatraz_5")
	else
		CoD.RoundStatus.DefaultColor = {
			r = 0.21,
			g = 0,
			b = 0,
		}
		CoD.RoundStatus.AlternatePulseColor = {
			r = 1,
			g = 1,
			b = 1,
		}
		CoD.RoundStatus.Chalks[1] = RegisterMaterial("hud_chalk_1")
		CoD.RoundStatus.Chalks[2] = RegisterMaterial("hud_chalk_2")
		CoD.RoundStatus.Chalks[3] = RegisterMaterial("hud_chalk_3")
		CoD.RoundStatus.Chalks[4] = RegisterMaterial("hud_chalk_4")
		CoD.RoundStatus.Chalks[5] = RegisterMaterial("hud_chalk_5")
	end

	roundSafeArea.gameTypeGroup = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
	roundSafeArea.gameType = UIExpression.DvarString(nil, "ui_gametype")
	roundSafeArea.startRound = Engine.GetGametypeSetting("startRound")
	if roundSafeArea.gameTypeGroup ~= CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
		CoD.RoundStatus.LeftOffset = CoD.RoundStatus.FactionIconLeftOffset
	else
		CoD.RoundStatus.LeftOffset = CoD.RoundStatus.RoundIconLeftOffset
	end
	roundSafeArea.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.Zombie.SplitscreenMultiplier)
	roundSafeArea.scaleContainer:setLeftRight(true, false, 0, 0)
	roundSafeArea.scaleContainer:setTopBottom(false, true, 0, 0)
	roundSafeArea:addElement(roundSafeArea.scaleContainer)
	local f1_local1, f1_local2, f1_local3, f1_local4 = Engine.GetUserSafeAreaForController(f1_arg0)
	roundSafeArea.safeAreaWidth = (f1_local3 - f1_local1) / roundSafeArea.scaleContainer.scale
	roundSafeArea.safeAreaHeight = (f1_local4 - f1_local2) / roundSafeArea.scaleContainer.scale
	roundSafeArea.chalkCenterTop = -roundSafeArea.safeAreaHeight * 0.5 - CoD.RoundStatus.ChalkSize * 1.5
	roundSafeArea.roundContainer = LUI.UIElement.new()
	roundSafeArea.roundContainer:setLeftRight(true, false, 0, 0)
	roundSafeArea.roundContainer:setTopBottom(false, true, 0, 0)
	roundSafeArea.scaleContainer:addElement(roundSafeArea.roundContainer)
	roundSafeArea.roundIconContainer = LUI.UIElement.new()
	roundSafeArea.roundIconContainer:setLeftRight(true, false, 0, 0)
	roundSafeArea.roundIconContainer:setTopBottom(false, true, 0, 0)
	roundSafeArea.scaleContainer:addElement(roundSafeArea.roundIconContainer)
	local f1_local5 = roundSafeArea.safeAreaWidth * 0.5
	roundSafeArea.roundTextCenter = LUI.UIText.new()
	roundSafeArea.roundTextCenter:setLeftRight(
		true,
		false,
		f1_local5 * 0.5 + CoD.RoundStatus.ChalkSize * -0.5,
		f1_local5 * 0.5 + CoD.RoundStatus.ChalkSize * 0.5
	)
	roundSafeArea.roundTextCenter:setTopBottom(
		false,
		true,
		roundSafeArea.chalkCenterTop,
		roundSafeArea.chalkCenterTop + CoD.RoundStatus.RoundCenterHeight
	)
	roundSafeArea.roundTextCenter:setFont(CoD.fonts[CoD.RoundStatus.ChalkFontName])
	roundSafeArea.roundTextCenter:setAlignment(LUI.Alignment.Center)
	roundSafeArea.roundTextCenter:setAlpha(0)
	roundSafeArea.roundTextCenter:registerEventHandler(
		"transition_complete_first_round",
		CoD.RoundStatus.ShowFirstRoundFinish
	)
	roundSafeArea.roundTextCenter:registerEventHandler(
		"transition_complete_idle",
		CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish
	)
	roundSafeArea.roundContainer:addElement(roundSafeArea.roundTextCenter)
	roundSafeArea.roundText = LUI.UIText.new()
	roundSafeArea.roundText:setLeftRight(
		true,
		false,
		CoD.RoundStatus.LeftOffset,
		CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
	)
	roundSafeArea.roundText:setTopBottom(
		false,
		true,
		CoD.RoundStatus.ChalkTop,
		CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
	)
	roundSafeArea.roundText:setFont(CoD.fonts[CoD.RoundStatus.ChalkFontName])
	roundSafeArea.roundText:setAlpha(0)
	roundSafeArea.roundText:registerEventHandler(
		"transition_complete_first_round",
		CoD.RoundStatus.ShowFirstRoundFinish
	)
	roundSafeArea.roundText:registerEventHandler(
		"transition_complete_idle",
		CoD.RoundStatus.ShowFirstRoundTextIdleFinish
	)
	roundSafeArea.roundText:registerEventHandler(
		"transition_complete_round_switch_show",
		CoD.RoundStatus.RoundSwitchShowFinish
	)
	roundSafeArea.roundText:registerEventHandler(
		"transition_complete_round_switch_hide",
		CoD.RoundStatus.RoundSwitchHideFinish
	)
	roundSafeArea.roundContainer:addElement(roundSafeArea.roundText)
	roundSafeArea.roundChalk1 = LUI.UIImage.new()
	roundSafeArea.roundChalk1:setLeftRight(
		true,
		false,
		CoD.RoundStatus.LeftOffset,
		CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
	)
	roundSafeArea.roundChalk1:setTopBottom(
		false,
		true,
		CoD.RoundStatus.ChalkTop,
		CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
	)
	roundSafeArea.roundChalk1:setImage(CoD.RoundStatus.Chalks[1])
	roundSafeArea.roundChalk1:setAlpha(0)
	roundSafeArea.roundChalk1:registerEventHandler(
		"transition_complete_first_round",
		CoD.RoundStatus.ShowFirstRoundFinish
	)
	roundSafeArea.roundChalk1:registerEventHandler(
		"transition_complete_idle",
		CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish
	)
	roundSafeArea.roundChalk1:registerEventHandler(
		"transition_complete_round_switch_show",
		CoD.RoundStatus.RoundSwitchShowFinish
	)
	roundSafeArea.roundChalk1:registerEventHandler(
		"transition_complete_round_switch_hide",
		CoD.RoundStatus.RoundSwitchHideFinish
	)
	roundSafeArea.roundContainer:addElement(roundSafeArea.roundChalk1)
	roundSafeArea.roundChalk2 = LUI.UIImage.new()
	roundSafeArea.roundChalk2:setLeftRight(
		true,
		false,
		CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize,
		CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2
	)
	roundSafeArea.roundChalk2:setTopBottom(
		false,
		true,
		CoD.RoundStatus.ChalkTop,
		CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
	)
	roundSafeArea.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
	roundSafeArea.roundChalk2:setAlpha(0)
	roundSafeArea.roundChalk2:registerEventHandler(
		"transition_complete_first_round",
		CoD.RoundStatus.ShowFirstRoundFinish
	)
	roundSafeArea.roundChalk2:registerEventHandler(
		"transition_complete_idle",
		CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish
	)
	roundSafeArea.roundChalk2:registerEventHandler(
		"transition_complete_round_switch_show",
		CoD.RoundStatus.RoundSwitchShowFinish
	)
	roundSafeArea.roundChalk2:registerEventHandler(
		"transition_complete_round_switch_hide",
		CoD.RoundStatus.RoundSwitchHideFinish
	)
	roundSafeArea.roundContainer:addElement(roundSafeArea.roundChalk2)
	roundSafeArea.factionIcon = LUI.UIImage.new()
	roundSafeArea.factionIcon:setLeftRight(
		true,
		false,
		CoD.RoundStatus.FactionIconLeftOffset,
		CoD.RoundStatus.FactionIconLeftOffset + CoD.RoundStatus.FactionIconSize
	)
	roundSafeArea.factionIcon:setTopBottom(
		false,
		true,
		CoD.RoundStatus.ChalkTop,
		CoD.RoundStatus.ChalkTop + CoD.RoundStatus.FactionIconSize
	)
	roundSafeArea.factionIcon:setAlpha(0)
	roundSafeArea.scaleContainer:addElement(roundSafeArea.factionIcon)
	roundSafeArea:registerEventHandler("hud_update_refresh", CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler(
		"hud_update_bit_" .. CoD.BIT_IS_PLAYER_IN_AFTERLIFE,
		CoD.RoundStatus.UpdateVisibility
	)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler(
		"hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC,
		CoD.RoundStatus.UpdateVisibility
	)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.RoundStatus.UpdateVisibility)
	roundSafeArea:registerEventHandler(
		"hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM,
		CoD.RoundStatus.UpdateVisibility
	)
	roundSafeArea:registerEventHandler(
		"hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN,
		CoD.RoundStatus.UpdateVisibility
	)
	roundSafeArea:registerEventHandler("hud_update_rounds_played", CoD.RoundStatus.UpdateRoundsPlayed)
	roundSafeArea:registerEventHandler("hud_update_team_change", CoD.RoundStatus.UpdateTeamChange)
	roundSafeArea:registerEventHandler("sq_tpo_special_round_active", CoD.RoundStatus.UpdateSpecialRound)
	roundSafeArea.timebombOverride = false
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) then
		roundSafeArea:registerEventHandler("time_bomb_lua_override", CoD.RoundStatus.TimeBombRoundAnimationOverride)
	end
	roundSafeArea.visible = true
	return roundSafeArea
end

CoD.RoundStatus.UpdateVisibility = function(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if
		UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_PLAYER_IN_AFTERLIFE) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0
		and (not CoD.IsShoutcaster(f2_local0) or CoD.ExeProfileVarBool(f2_local0, "shoutcaster_teamscore"))
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_SCOPED) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0
		and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0
	then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.RoundStatus.UpdateRoundsPlayed = function(f3_arg0, f3_arg1)
	if
		f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZCLASSIC
		or f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZSTANDARD
		or f3_arg0.gameType == CoD.Zombie.GAMETYPE_ZGRIEF
	then
		CoD.RoundStatus.RoundPulseTimes = math.ceil(
			CoD.RoundStatus.RoundPulseTimesMin
				+ (1 - math.min(f3_arg1.roundsPlayed, CoD.RoundStatus.RoundMax) / CoD.RoundStatus.RoundMax)
					* CoD.RoundStatus.RoundPulseTimesDelta
		)
		if f3_arg0.startRound == f3_arg1.roundsPlayed then
			if
				f3_arg1.wasDemoJump == false
				and f3_arg0.timebombOverride == false
				and CoD.Zombie.AllowRoundAnimation == 1
			then
				CoD.RoundStatus.ShowFirstRound(f3_arg0, f3_arg1.roundsPlayed)
			else
				f3_arg0.roundChalk1:setLeftRight(
					true,
					false,
					CoD.RoundStatus.LeftOffset,
					CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
				)
				f3_arg0.roundChalk1:setTopBottom(
					false,
					true,
					CoD.RoundStatus.ChalkTop,
					CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
				)
				local f3_local0 = CoD.RoundStatus.StartNewRound
				local f3_local1 = f3_arg0
				local roundsPlayed = f3_arg1.roundsPlayed
				local wasDemoJump = f3_arg1.wasDemoJump
				if not wasDemoJump then
					wasDemoJump = f3_arg0.timebombOverride == true
				end
				f3_local0(f3_local1, roundsPlayed, wasDemoJump)
			end
		elseif f3_arg0.startRound < f3_arg1.roundsPlayed then
			f3_arg0.roundChalk1:setLeftRight(
				true,
				false,
				CoD.RoundStatus.LeftOffset,
				CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
			)
			f3_arg0.roundChalk1:setTopBottom(
				false,
				true,
				CoD.RoundStatus.ChalkTop,
				CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
			)
			f3_arg0.roundChalk2:setLeftRight(
				true,
				false,
				CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize,
				CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2
			)
			f3_arg0.roundChalk2:setTopBottom(
				false,
				true,
				CoD.RoundStatus.ChalkTop,
				CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
			)
			f3_arg0.roundText:setLeftRight(
				true,
				false,
				CoD.RoundStatus.LeftOffset,
				CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
			)
			f3_arg0.roundText:setTopBottom(
				false,
				true,
				CoD.RoundStatus.ChalkTop,
				CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
			)
			local f3_local0 = CoD.RoundStatus.StartNewRound
			local f3_local1 = f3_arg0
			local f3_local2 = f3_arg1.roundsPlayed
			local f3_local3 = f3_arg1.wasDemoJump
			if not f3_local3 then
				f3_local3 = f3_arg0.timebombOverride == true
			end
			f3_local0(f3_local1, f3_local2, f3_local3)
		else
			CoD.RoundStatus.HideAllRoundIcons(f3_arg0, f3_arg1)
		end
	else
		CoD.RoundStatus.HideAllRoundIcons(f3_arg0, f3_arg1)
	end
end

CoD.RoundStatus.ShowFirstRound = function(roundWidget, roundsPlayed)
	local roundText = Engine.Localize("ZOMBIE_ROUND")
	local v1, v2, v3, v4 = GetTextDimensions(roundText, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)

	local widgetSafeArea = roundWidget.safeAreaWidth * 0.5
	local widgetCenterTop = roundWidget.chalkCenterTop

	roundWidget.roundTextCenter:setLeftRight(
		false,
		true,
		widgetSafeArea + CoD.RoundStatus.ChalkSize * -0.5 - v3,
		widgetSafeArea + CoD.RoundStatus.ChalkSize * 0.5 + v3
	)
	roundWidget.roundTextCenter:setText(roundText)
	roundWidget.roundTextCenter:setAlpha(1)
	roundWidget.roundTextCenter:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
	roundWidget.roundTextCenter:setRGB(
		CoD.RoundStatus.DefaultColor.r,
		CoD.RoundStatus.DefaultColor.g,
		CoD.RoundStatus.DefaultColor.b
	)

	if roundsPlayed <= 5 then
		if roundsPlayed == 1 then
			local paddedWidgetSafeArea = widgetSafeArea - 15
			roundWidget.roundChalk1:setLeftRight(
				true,
				false,
				paddedWidgetSafeArea,
				paddedWidgetSafeArea + CoD.RoundStatus.ChalkSize
			)
		else
			roundWidget.roundChalk1:setLeftRight(
				true,
				false,
				widgetSafeArea + CoD.RoundStatus.ChalkSize * -0.5,
				widgetSafeArea + CoD.RoundStatus.ChalkSize * 0.5
			)
		end

		roundWidget.roundChalk1:setTopBottom(
			false,
			true,
			widgetCenterTop + CoD.RoundStatus.ChalkSize,
			widgetCenterTop + CoD.RoundStatus.ChalkSize * 2
		)

		roundWidget.roundChalk1:setImage(CoD.RoundStatus.Chalks[roundsPlayed])
		roundWidget.roundChalk1:setAlpha(1)
		roundWidget.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		roundWidget.roundChalk1:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		roundWidget.roundChalk2:completeAnimation()
		roundWidget.roundChalk2:setAlpha(0)
		roundWidget.roundText:completeAnimation()
		roundWidget.roundText:setAlpha(0)
	elseif roundsPlayed <= 10 then
		roundWidget.roundChalk1:setLeftRight(true, false, widgetSafeArea - CoD.RoundStatus.ChalkSize, widgetSafeArea)
		roundWidget.roundChalk1:setTopBottom(
			false,
			true,
			widgetCenterTop + CoD.RoundStatus.ChalkSize,
			widgetCenterTop + CoD.RoundStatus.ChalkSize * 2
		)
		roundWidget.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		roundWidget.roundChalk1:setAlpha(1)
		roundWidget.roundChalk1:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		roundWidget.roundChalk1:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		roundWidget.roundChalk2:setLeftRight(true, false, widgetSafeArea, widgetSafeArea + CoD.RoundStatus.ChalkSize)
		roundWidget.roundChalk2:setTopBottom(
			false,
			true,
			widgetCenterTop + CoD.RoundStatus.ChalkSize,
			widgetCenterTop + CoD.RoundStatus.ChalkSize * 2
		)
		roundWidget.roundChalk2:setImage(CoD.RoundStatus.Chalks[roundsPlayed - 5])
		roundWidget.roundChalk2:setAlpha(1)
		roundWidget.roundChalk2:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		roundWidget.roundChalk2:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
	else
		status, error = pcall(function()
			local roundsPlayedDimensions = {}
			roundsPlayedDimensions = GetTextDimensions(roundsPlayed, CoD.fonts[CoD.RoundStatus.ChalkFontName], CoD.RoundStatus.ChalkSize)
			print("-----dimensions: " .. textWidth .. " " .. textHeight .. " " .. v3)
			local roundsPlayedZ = roundsPlayedDimensions[3]
		end)
		print("PCALL_STATUS=" .. status .. "\nPCALL_ERROR=" .. error)
		
		roundWidget.roundText:setLeftRight(
			true,
			false,
			widgetSafeArea + CoD.RoundStatus.ChalkSize * -0.5 - f4_local6,
			widgetSafeArea + CoD.RoundStatus.ChalkSize * 0.5 + f4_local6
		)
		roundWidget.roundText:setTopBottom(
			false,
			true,
			widgetCenterTop + CoD.RoundStatus.ChalkSize,
			widgetCenterTop + CoD.RoundStatus.ChalkSize * 2
		)
		roundWidget.roundText:setText(roundsPlayed)
		roundWidget.roundText:setAlignment(LUI.Alignment.Center)
		roundWidget.roundText:setAlpha(1)
		roundWidget.roundText:beginAnimation("first_round", CoD.RoundStatus.FirstRoundDuration)
		roundWidget.roundText:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
	end
end

CoD.RoundStatus.ShowFirstRoundFinish = function(roundWidget, f5_arg1)
	if f5_arg1.interrupted ~= true then
		roundWidget:beginAnimation("idle", CoD.RoundStatus.FirstRoundIdleDuration)
	end
end

CoD.RoundStatus.ShowFirstRoundTextCenterIdleFinish = function(f6_arg0, f6_arg1)
	if f6_arg1.interrupted ~= true then
		f6_arg0:beginAnimation("fade_out", CoD.RoundStatus.FirstRoundDuration)
		f6_arg0:setAlpha(0)
	end
end

CoD.RoundStatus.ShowFirstRoundTextIdleFinish = function(f7_arg0, f7_arg1)
	if f7_arg1.interrupted ~= true then
		f7_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		f7_arg0:setLeftRight(
			true,
			false,
			CoD.RoundStatus.LeftOffset,
			CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
		)
		f7_arg0:setTopBottom(
			false,
			true,
			CoD.RoundStatus.ChalkTop,
			CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
		)
	end
end

CoD.RoundStatus.ShowFirstRoundChalk1IdleFinish = function(f8_arg0, f8_arg1)
	if f8_arg1.interrupted ~= true then
		f8_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		f8_arg0:setLeftRight(
			true,
			false,
			CoD.RoundStatus.LeftOffset,
			CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize
		)
		f8_arg0:setTopBottom(
			false,
			true,
			CoD.RoundStatus.ChalkTop,
			CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
		)
	end
end

CoD.RoundStatus.ShowFirstRoundChalk2IdleFinish = function(f9_arg0, f9_arg1)
	if f9_arg1.interrupted ~= true then
		f9_arg0:beginAnimation("fall_down", CoD.RoundStatus.FirstRoundFallDuration)
		f9_arg0:setLeftRight(
			true,
			false,
			CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize,
			CoD.RoundStatus.LeftOffset + CoD.RoundStatus.ChalkSize * 2
		)
		f9_arg0:setTopBottom(
			false,
			true,
			CoD.RoundStatus.ChalkTop,
			CoD.RoundStatus.ChalkTop + CoD.RoundStatus.ChalkSize
		)
	end
end

CoD.RoundStatus.StartNewRound = function(f10_arg0, f10_arg1, f10_arg2)
	if f10_arg1 <= 5 then
		f10_arg0.roundChalk1:setAlpha(1)
		if f10_arg2 == true then
			f10_arg0.roundChalk1:completeAnimation()
			f10_arg0.roundChalk1:setAlpha(1)
			f10_arg0.roundChalk1:setRGB(
				CoD.RoundStatus.DefaultColor.r,
				CoD.RoundStatus.DefaultColor.g,
				CoD.RoundStatus.DefaultColor.b
			)
			f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[f10_arg1])
		else
			if f10_arg1 > 1 then
				f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 1])
			end
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[f10_arg1]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
		end
		f10_arg0.roundChalk2:completeAnimation()
		f10_arg0.roundChalk2:setAlpha(0)
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 == 6 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		if f10_arg2 == true then
			f10_arg0.roundChalk2:setAlpha(1)
			f10_arg0.roundChalk2:setRGB(
				CoD.RoundStatus.DefaultColor.r,
				CoD.RoundStatus.DefaultColor.g,
				CoD.RoundStatus.DefaultColor.b
			)
			f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[1])
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[f10_arg1 - 5]
			f10_arg0.roundChalk2.showInLastPulse = true
			f10_arg0.roundChalk2.showInPreviousPulses = false
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
		end
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 <= 10 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		f10_arg0.roundChalk2:setAlpha(1)
		f10_arg0.roundChalk2:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 5 - 1])
		if f10_arg2 == true then
			f10_arg0.roundChalk1:setAlpha(1)
			f10_arg0.roundChalk2:setAlpha(1)
			f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[f10_arg1 - 5])
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = true
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[f10_arg1 - 5]
			f10_arg0.roundChalk2.showInLastPulse = true
			f10_arg0.roundChalk2.showInPreviousPulses = true
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
		end
		f10_arg0.roundText:completeAnimation()
		f10_arg0.roundText:setAlpha(0)
	elseif f10_arg1 == 11 then
		f10_arg0.roundChalk1:setAlpha(1)
		f10_arg0.roundChalk1:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundChalk1:setImage(CoD.RoundStatus.Chalks[5])
		f10_arg0.roundChalk2:setAlpha(1)
		f10_arg0.roundChalk2:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundChalk2:setImage(CoD.RoundStatus.Chalks[5])
		if f10_arg2 == true then
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundText:setAlpha(1)
			f10_arg0.roundText:setRGB(
				CoD.RoundStatus.DefaultColor.r,
				CoD.RoundStatus.DefaultColor.g,
				CoD.RoundStatus.DefaultColor.b
			)
			f10_arg0.roundText:setText(f10_arg1)
		else
			f10_arg0.roundChalk1.pulseTimes = 0
			f10_arg0.roundChalk1.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk1.showInLastPulse = false
			f10_arg0.roundChalk1.showInPreviousPulses = true
			f10_arg0.roundChalk1:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk1:setAlpha(0)
			f10_arg0.roundChalk1:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
			f10_arg0.roundChalk2.pulseTimes = 0
			f10_arg0.roundChalk2.material = CoD.RoundStatus.Chalks[5]
			f10_arg0.roundChalk2.showInLastPulse = false
			f10_arg0.roundChalk2.showInPreviousPulses = true
			f10_arg0.roundChalk2:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundChalk2:setAlpha(0)
			f10_arg0.roundChalk2:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
			f10_arg0.roundText.pulseTimes = 0
			f10_arg0.roundText.material = f10_arg1
			f10_arg0.roundText.showInLastPulse = true
			f10_arg0.roundText.showInPreviousPulses = false
			f10_arg0.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundText:setAlpha(0)
			f10_arg0.roundText:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
		end
	else
		f10_arg0.roundText:setAlpha(1)
		f10_arg0.roundText:setRGB(
			CoD.RoundStatus.DefaultColor.r,
			CoD.RoundStatus.DefaultColor.g,
			CoD.RoundStatus.DefaultColor.b
		)
		f10_arg0.roundText:setText(f10_arg1 - 1)
		if f10_arg2 == true then
			f10_arg0.roundText:setText(f10_arg1)
		else
			f10_arg0.roundText.pulseTimes = 0
			f10_arg0.roundText.material = f10_arg1
			f10_arg0.roundText.showInLastPulse = true
			f10_arg0.roundText.showInPreviousPulses = true
			f10_arg0.roundText:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			f10_arg0.roundText:setAlpha(0)
			f10_arg0.roundText:setRGB(
				CoD.RoundStatus.AlternatePulseColor.r,
				CoD.RoundStatus.AlternatePulseColor.g,
				CoD.RoundStatus.AlternatePulseColor.b
			)
		end
		f10_arg0.roundChalk1:completeAnimation()
		f10_arg0.roundChalk1:setAlpha(0)
		f10_arg0.roundChalk2:completeAnimation()
		f10_arg0.roundChalk2:setAlpha(0)
	end
end

CoD.RoundStatus.RoundSwitchShowFinish = function(f11_arg0, f11_arg1)
	if f11_arg1.interrupted ~= true then
		f11_arg0.pulseTimes = f11_arg0.pulseTimes + 1
		if f11_arg0.pulseTimes <= CoD.RoundStatus.RoundPulseTimes then
			if f11_arg0.pulseTimes > CoD.RoundStatus.RoundPulseTimes - 1 then
				f11_arg0:beginAnimation("round_switch_hide", CoD.RoundStatus.FirstRoundDuration)
				f11_arg0:setRGB(
					CoD.RoundStatus.DefaultColor.r,
					CoD.RoundStatus.DefaultColor.g,
					CoD.RoundStatus.DefaultColor.b
				)
			else
				f11_arg0:beginAnimation("round_switch_hide", CoD.RoundStatus.RoundPulseDuration)
			end
			f11_arg0:setAlpha(0)
		end
	end
end

CoD.RoundStatus.RoundSwitchHideFinish = function(f12_arg0, f12_arg1)
	if f12_arg1.interrupted ~= true then
		local f12_local0 = 1
		if f12_arg0.pulseTimes > CoD.RoundStatus.RoundPulseTimes - 1 then
			if type(f12_arg0.material) == "number" then
				f12_arg0:setText(f12_arg0.material)
			else
				f12_arg0:setImage(f12_arg0.material)
			end
			if f12_arg0.showInLastPulse == false then
				f12_local0 = 0
			end
			f12_arg0:beginAnimation("round_switch_show", CoD.RoundStatus.FirstRoundDuration)
		else
			if f12_arg0.showInPreviousPulses == false then
				f12_local0 = 0
			end
			f12_arg0:beginAnimation("round_switch_show", CoD.RoundStatus.RoundPulseDuration)
		end
		f12_arg0:setAlpha(f12_local0)
	end
end

CoD.RoundStatus.UpdateTeamChange = function(f13_arg0, f13_arg1)
	if f13_arg0.team ~= f13_arg1.team and type(f13_arg1.team) == "number" and f13_arg1.team < CoD.TEAM_SPECTATOR then
		f13_arg0.team = f13_arg1.team
		if f13_arg0.team ~= CoD.TEAM_FREE then
			local f13_local0 = Engine.GetFactionForTeam(f13_arg1.team)
			if f13_local0 ~= "" and f13_arg0.gameTypeGroup == CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
				if CoD.Zombie.GAMETYPE_ZCLEANSED == Dvar.ui_gametype:get() and f13_arg0.team == CoD.TEAM_AXIS then
					f13_local0 = "zombie"
				elseif CoD.Zombie.GAMETYPE_ZMEAT == Dvar.ui_gametype:get() and f13_arg0.team == CoD.TEAM_AXIS then
					f13_local0 = "cia"
				end
				f13_arg0.factionIcon:setImage(RegisterMaterial("faction_" .. f13_local0))
				f13_arg0.factionIcon:setAlpha(1)
			else
				f13_arg0.factionIcon:setAlpha(0)
			end
		else
			f13_arg0.factionIcon:setAlpha(0)
		end
	end
end

CoD.RoundStatus.HideAllRoundIcons = function(
	roundWidget,
	f14_arg1 --[[ UNUSED SOMEHOW ]]
)
	roundWidget.roundTextCenter:setAlpha(0)
	roundWidget.roundText:setAlpha(0)
	roundWidget.roundChalk1:setAlpha(0)
	roundWidget.roundChalk2:setAlpha(0)
end

CoD.RoundStatus.UpdateSpecialRound = function(roundWidget, f15_arg1)
	if f15_arg1.newValue == 1 then
		if not roundWidget.specialRoundIcon then
			roundWidget.specialRoundIcon = LUI.UIImage.new()
			roundWidget.specialRoundIcon:setLeftRight(
				true,
				false,
				CoD.RoundStatus.LeftOffset,
				CoD.RoundStatus.LeftOffset + CoD.RoundStatus.SpecialRoundIconSize
			)
			roundWidget.specialRoundIcon:setTopBottom(
				false,
				true,
				CoD.RoundStatus.ChalkTop,
				CoD.RoundStatus.ChalkTop + CoD.RoundStatus.SpecialRoundIconSize / 2
			)
			roundWidget.specialRoundIcon:setImage(RegisterMaterial("hud_zm_chalk_infinity"))
			roundWidget.specialRoundIcon:setAlpha(0)
			roundWidget.roundIconContainer:addElement(roundWidget.specialRoundIcon)
		end

		-- Begin special round
		roundWidget.specialRoundIcon:beginAnimation("fade_in", 1000)
		roundWidget.specialRoundIcon:setAlpha(1)
		roundWidget.roundContainer:beginAnimation("fade_out", 500)
		roundWidget.roundContainer:setAlpha(0)
	else
		-- End special round
		roundWidget.specialRoundIcon:beginAnimation("fade_out", 500)
		roundWidget.specialRoundIcon:setAlpha(0)
		roundWidget.roundContainer:beginAnimation("fade_in", 1000)
		roundWidget.roundContainer:setAlpha(1)
	end
end

CoD.RoundStatus.TimeBombRoundAnimationOverride = function(roundWidget, f16_arg1)
	if f16_arg1.newValue == 1 then
		roundWidget.timebombOverride = true
	else
		roundWidget.timebombOverride = false
	end
end
