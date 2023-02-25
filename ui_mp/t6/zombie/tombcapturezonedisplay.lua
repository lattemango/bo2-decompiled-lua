CoD.TCZWaypoint = InheritFrom( CoD.ObjectiveWaypoint )
CoD.TCZWaypoint.GAMEMODEFLAG_TARGET = 1
CoD.TCZWaypoint.flagWaypointZOffset = 35
CoD.TCZWaypoint.snapToHeight = -250
CoD.TCZWaypoint.largeIconWidth = 128
CoD.TCZWaypoint.largeIconHeight = 128
CoD.TCZWaypoint.iconAlpha = 1
CoD.TCZWaypoint.pulseAlphaLow = CoD.TCZWaypoint.iconAlpha * 0.35
CoD.TCZWaypoint.pulseAlphaHigh = CoD.TCZWaypoint.iconAlpha
CoD.TCZWaypoint.progressColor = CoD.blueGlow
CoD.TCZWaypoint.CaptureZoneCount = 6
CoD.TCZWaypoint.NumberGlowMaterialsTable = {}
CoD.TCZWaypoint.numberIconIndentWidth = 42
CoD.TCZWaypoint.numberIconIndentHeight = 42
CoD.TCZWaypoint.numberIconSmallIndentWidth = 20
CoD.TCZWaypoint.numberIconSmallIndentHeight = 20
CoD.TCZWaypoint.worldProgressColor = CoD.brightRed
CoD.TCZRoamingZombies = InheritFrom( CoD.ObjectiveWaypoint )
CoD.TCZRoamingZombies.baseWaypointZOffset = 75
CoD.TCZRoamingZombies.iconWidth = 32
CoD.TCZRoamingZombies.iconHeight = 32
LUI.createMenu.TombCaptureZoneDisplay = function ( f1_arg0 )
	local f1_local0 = CoD.GametypeBase.new( "tomb_capture_display", f1_arg0 )
	f1_local0.objectiveTypes.ZM_TOMB_OBJ_CAPTURE_1 = CoD.TCZWaypoint
	f1_local0.objectiveTypes.ZM_TOMB_OBJ_CAPTURE_2 = CoD.TCZWaypoint
	f1_local0.objectiveTypes.ZM_TOMB_OBJ_RECAPTURE_2 = CoD.TCZWaypoint
	f1_local0.objectiveTypes.ZM_TOMB_OBJ_RECAPTURE_ZOMBIE = CoD.TCZRoamingZombies
	CoD.TCZWaypoint.MainSpinImageMaterial = RegisterMaterial( "hud_zm_tomb_capture_spin" )
	CoD.TCZWaypoint.SpinGlowImageMaterial = RegisterMaterial( "hud_zm_tomb_capture_spin_glow" )
	CoD.TCZWaypoint.ArrowImageMaterial = RegisterMaterial( "waypoint_arrow_tomb" )
	CoD.TCZRoamingZombies.RoamingZombieMaterial = RegisterMaterial( "zm_hud_icon_evil_crusade" )
	for f1_local1 = 1, CoD.TCZWaypoint.CaptureZoneCount, 1 do
		CoD.TCZWaypoint.NumberGlowMaterialsTable[f1_local1] = {}
		CoD.TCZWaypoint.NumberGlowMaterialsTable[f1_local1].glowImage = RegisterMaterial( "tomb_spinner_" .. f1_local1 .. "_glow" )
		CoD.TCZWaypoint.NumberGlowMaterialsTable[f1_local1].shadowImage = RegisterMaterial( "tomb_spinner_" .. f1_local1 .. "_shadow" )
	end
	f1_local0:registerEventHandler( "hud_update_refresh", CoD.GametypeBase.Refresh )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.TCZWaypoint.UpdateVisibility )
	f1_local0.visible = true
	f1_local0.updateVisibility = CoD.TCZWaypoint.UpdateVisibility
	return f1_local0
end

CoD.TCZWaypoint.UpdateVisibility = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_HUD_VISIBLE ) == 1 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_VEHICLE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_GUIDED_MISSILE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_AMMO_COUNTER_HIDE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_UI_ACTIVE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_SPECTATING_CLIENT ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_SCOREBOARD_OPEN ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IS_SCOPED ) == 0 and (not CoD.IsShoutcaster( f2_local0 ) or CoD.ExeProfileVarBool( f2_local0, "shoutcaster_scorestreaks" ) and Engine.IsSpectatingActiveClient( f2_local0 )) and CoD.FSM_VISIBILITY( f2_local0 ) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha( 1 )
			f2_arg0.m_inputDisabled = nil
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha( 0 )
		f2_arg0.m_inputDisabled = true
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren( f2_arg1 )
end

CoD.TCZWaypoint.new = function ( f3_arg0, f3_arg1 )
	local f3_local0 = CoD.ObjectiveWaypoint.new( f3_arg0, f3_arg1, CoD.TCZWaypoint.flagWaypointZOffset )
	f3_local0:setClass( CoD.TCZWaypoint )
	local f3_local1 = Engine.GetObjectiveName( f3_arg0, f3_arg1 )
	f3_local0:registerEventHandler( "objective_update_" .. f3_local1, f3_local0.update )
	f3_local0.mainImage:setImage( CoD.TCZWaypoint.MainSpinImageMaterial )
	f3_local0.arrowImage:setImage( CoD.TCZWaypoint.ArrowImageMaterial )
	f3_local0.progressBackground:close()
	f3_local0.progressController:close()
	f3_local0.progressController:setPriority( 100 )
	f3_local0:addElement( f3_local0.progressController )
	f3_local0.alphaController:setAlpha( 1 )
	f3_local0.disablePulse = true
	f3_local0.isOccupied = true
	local f3_local2 = CoD.TCZWaypoint.numberIconIndentWidth
	local f3_local3 = CoD.TCZWaypoint.numberIconIndentHeight
	f3_local0.numberContainer = LUI.UIElement.new()
	f3_local0.numberContainer:setLeftRight( true, true, f3_local2, -f3_local2 )
	f3_local0.numberContainer:setTopBottom( true, true, f3_local3, -f3_local3 )
	f3_local0.alphaController:addElement( f3_local0.numberContainer )
	f3_local0.numberContainer:alternateStates( 0, CoD.TCZWaypoint.PulseLow, CoD.TCZWaypoint.PulseHigh, f3_local0.pulseTime, f3_local0.pulseTime )
	f3_local0.number = LUI.UIImage.new()
	f3_local0.number:setLeftRight( true, true, 0, 0 )
	f3_local0.number:setTopBottom( true, true, 0, 0 )
	f3_local0.number:setImage( CoD.TCZWaypoint.NumberGlowMaterialsTable[1].shadowImage )
	f3_local0.numberContainer:addElement( f3_local0.number )
	f3_local0.numberGlow = LUI.UIImage.new()
	f3_local0.numberGlow:setLeftRight( true, true, 0, 0 )
	f3_local0.numberGlow:setTopBottom( true, true, 0, 0 )
	f3_local0.numberGlow:setImage( CoD.TCZWaypoint.NumberGlowMaterialsTable[1].glowImage )
	f3_local0.numberContainer:addElement( f3_local0.numberGlow )
	if string.sub( f3_local1, 0, 19 ) == "ZM_TOMB_OBJ_CAPTURE" then
		f3_local0.glow = LUI.UIImage.new()
		f3_local0.glow:setLeftRight( true, true, 0, 0 )
		f3_local0.glow:setTopBottom( true, true, 0, 0 )
		f3_local0.glow:setImage( CoD.TCZWaypoint.SpinGlowImageMaterial )
		f3_local0.glow:setPriority( -100 )
		f3_local0.glow:setAlpha( 0 )
		f3_local0.glow:setRGB( CoD.blueGlow.r, CoD.blueGlow.g, CoD.blueGlow.b )
		f3_local0.glow:registerEventHandler( "transition_complete_pulse_low", function ( element, event )
			if event.interrupted ~= true then
				f3_local0.glow:beginAnimation( "pulse_high", f3_local0.pulseTime, false, false )
				f3_local0.glow:setAlpha( f3_local0.pulseAlphaHigh )
			end
		end )
		f3_local0.glow:registerEventHandler( "transition_complete_pulse_high", function ( element, event )
			if event.interrupted ~= true then
				f3_local0.glow:beginAnimation( "pulse_low", f3_local0.pulseTime, false, false )
				f3_local0.glow:setAlpha( f3_local0.pulseAlphaLow )
			end
		end )
		f3_local0.alphaController:addElement( f3_local0.glow )
		f3_local0.glow:beginAnimation( "pulse_high" )
		f3_local0:registerEventHandler( "entity_container_clamped", CoD.NullFunction )
		f3_local0:registerEventHandler( "entity_container_unclamped", CoD.NullFunction )
		f3_local0:registerEventHandler( "zc_change_progress_bar_color", CoD.TCZWaypoint.SetCaptureProgressBarColor )
	elseif string.sub( f3_local1, 0, 21 ) == "ZM_TOMB_OBJ_RECAPTURE" and f3_local0.progressBar then
		f3_local0.progressBar:setRGB( f3_local0.worldProgressColor.r, f3_local0.worldProgressColor.g, f3_local0.worldProgressColor.b )
	end
	f3_local0.updateProgress = CoD.TCZWaypoint.updateProgress
	f3_local0.updatePlayerUsing = CoD.TCZWaypoint.updatePlayerUsing
	return f3_local0
end

CoD.TCZWaypoint.update = function ( f6_arg0, f6_arg1 )
	local f6_local0 = Engine.GetObjectiveGamemodeFlags( f6_arg1.controller, f6_arg0.index )
	if f6_local0 > 0 then
		f6_arg0.number:setImage( CoD.TCZWaypoint.NumberGlowMaterialsTable[f6_local0].shadowImage )
		f6_arg0.numberGlow:setImage( CoD.TCZWaypoint.NumberGlowMaterialsTable[f6_local0].glowImage )
	end
	if f6_arg1.objId then
		local f6_local1 = Engine.GetObjectiveName( f6_arg1.controller, f6_arg1.objId )
		if string.sub( f6_local1, 0, 19 ) == "ZM_TOMB_OBJ_CAPTURE" then
			f6_arg0.numberGlow:setAlpha( 1 )
		elseif string.sub( f6_local1, 0, 21 ) == "ZM_TOMB_OBJ_RECAPTURE" then
			f6_arg0.numberGlow:setAlpha( 0 )
		end
	end
	CoD.TCZWaypoint.super.update( f6_arg0, f6_arg1 )
end

CoD.TCZWaypoint.updateProgress = function ( f7_arg0, f7_arg1, f7_arg2, f7_arg3 )
	local f7_local0 = Engine.GetObjectiveProgress( f7_arg1, f7_arg0.index )
	local f7_local1 = true
	if not f7_arg0.showProgressToEveryone and (f7_arg0.playerUsing == nil or f7_arg0.playerUsing == false) then
		f7_local1 = false
	end
	local f7_local2 = true
	if f7_local1 and f7_arg0.mayShowProgress then
		f7_local2 = f7_arg0:mayShowProgress( f7_arg1 )
	end
	local f7_local3 = f7_arg2 and f7_arg3
	if not f7_local3 and f7_local1 then
		f7_local1 = f7_local2
	end
	if f7_local1 and not f7_arg0.showProgressToEveryone then
		if f7_local3 then
			f7_arg0.progressBar:setRGB( f7_arg0.contestedProgressColor.r, f7_arg0.contestedProgressColor.g, f7_arg0.contestedProgressColor.b )
			f7_arg0.progressBar:setupUIImage()
			f7_arg0.progressBar:setShaderVector( 0, 1, 0, 0, 0 )
		else
			f7_arg0.progressBar:setRGB( f7_arg0.progressColor.r, f7_arg0.progressColor.g, f7_arg0.progressColor.b )
			f7_arg0.progressBar:setupObjectiveProgress( f7_arg0.index )
		end
	end
	if f7_arg0.showingProgress == false and f7_local1 == true and (f7_local0 > 0 or f7_local3) then
		if f7_arg0.showProgressToEveryone then
			if f7_arg2 and f7_arg3 then
				f7_arg0.progressBar:setRGB( f7_arg0.contestedProgressColor.r, f7_arg0.contestedProgressColor.g, f7_arg0.contestedProgressColor.b )
			elseif f7_arg2 then
				f7_arg0.progressBar:setRGB( CoD.teamColorFriendly.r, CoD.teamColorFriendly.g, CoD.teamColorFriendly.b )
			else
				f7_arg0.progressBar:setRGB( CoD.teamColorEnemy.r, CoD.teamColorEnemy.g, CoD.teamColorEnemy.b )
			end
		end
		local f7_local4 = CoD.ObjectiveWaypoint.progressHeight / 2
		f7_arg0.progressController:beginAnimation( "progress", f7_arg0.snapToTime, true, true )
		f7_arg0.progressController:setLeftRight( false, false, -CoD.ObjectiveWaypoint.progressWidth / 2, CoD.ObjectiveWaypoint.progressWidth / 2 )
		f7_arg0.progressController:setTopBottom( false, false, -f7_local4 - CoD.ObjectiveWaypoint.progressHeightNudge, f7_local4 - CoD.ObjectiveWaypoint.progressHeightNudge )
		f7_arg0.progressController:setAlpha( 1 )
		f7_arg0.showingProgress = true
	elseif not (f7_local0 ~= 0 or f7_local3) or f7_local1 == false then
		local f7_local4 = f7_arg0.iconWidth * 0.5
		local f7_local5 = f7_arg0.iconHeight * 0.5
		f7_arg0.progressController:beginAnimation( "progress", f7_arg0.snapToTime, true, true )
		f7_arg0.progressController:setLeftRight( false, false, -f7_local4 / 2, f7_local4 / 2 )
		f7_arg0.progressController:setTopBottom( false, false, -f7_local5 / 2, f7_local5 / 2 )
		f7_arg0.progressController:setAlpha( 1 )
		f7_arg0.showingProgress = false
	end
end

CoD.TCZWaypoint.updatePlayerUsing = function ( f8_arg0, f8_arg1, f8_arg2, f8_arg3 )
	local f8_local0 = CoD.ObjectiveWaypoint.isPlayerUsing( f8_arg0, f8_arg1, f8_arg2, f8_arg3 )
	if f8_arg0.playerUsing == f8_local0 then
		return 
	elseif f8_local0 == true then
		if f8_arg0.playerUsing ~= nil then
			f8_arg0:beginAnimation( "snap_in", f8_arg0.snapToTime, true, true )
		end
		f8_arg0:setEntityContainerStopUpdating( true )
		f8_arg0:setLeftRight( false, false, -f8_arg0.largeIconWidth / 2, f8_arg0.largeIconWidth / 2 )
		f8_arg0:setTopBottom( false, false, -f8_arg0.largeIconHeight - f8_arg0.snapToHeight, -f8_arg0.snapToHeight )
		f8_arg0.edgePointerContainer:setAlpha( 0 )
		if f8_arg0.numberContainer then
			f8_arg0.numberContainer:completeAnimation()
			f8_arg0.numberContainer:setLeftRight( true, true, f8_arg0.numberIconIndentWidth, -f8_arg0.numberIconIndentWidth )
			f8_arg0.numberContainer:setTopBottom( true, true, f8_arg0.numberIconIndentHeight, -f8_arg0.numberIconIndentHeight )
		end
	else
		if f8_arg0.playerUsing ~= nil then
			f8_arg0:beginAnimation( "snap_out", f8_arg0.snapToTime, true, true )
		end
		f8_arg0:setEntityContainerStopUpdating( false )
		f8_arg0:setLeftRight( false, false, -f8_arg0.iconWidth / 2, f8_arg0.iconWidth / 2 )
		f8_arg0:setTopBottom( false, true, -f8_arg0.iconHeight, 0 )
		f8_arg0.edgePointerContainer:setAlpha( 1 )
		if f8_arg0.numberContainer then
			f8_arg0.numberContainer:completeAnimation()
			f8_arg0.numberContainer:setLeftRight( true, true, f8_arg0.numberIconSmallIndentWidth, -f8_arg0.numberIconSmallIndentWidth )
			f8_arg0.numberContainer:setTopBottom( true, true, f8_arg0.numberIconSmallIndentHeight, -f8_arg0.numberIconSmallIndentHeight )
		end
	end
	f8_arg0.playerUsing = f8_local0
end

CoD.TCZWaypoint.SetCaptureProgressBarColor = function ( f9_arg0, f9_arg1 )
	local f9_local0 = f9_arg1.newValue
	if f9_local0 == 0 then
		f9_arg0.isOccupied = false
		if f9_arg0.progressBar then
			f9_arg0.progressBar:setRGB( f9_arg0.worldProgressColor.r, f9_arg0.worldProgressColor.g, f9_arg0.worldProgressColor.b )
		end
		if f9_arg0.glow then
			f9_arg0.glow:setRGB( f9_arg0.worldProgressColor.r, f9_arg0.worldProgressColor.g, f9_arg0.worldProgressColor.b )
		end
	elseif f9_local0 == 1 then
		f9_arg0.isOccupied = true
		if f9_arg0.progressBar then
			f9_arg0.progressBar:setRGB( f9_arg0.progressColor.r, f9_arg0.progressColor.g, f9_arg0.progressColor.b )
		end
		if f9_arg0.glow then
			f9_arg0.glow:setRGB( CoD.blueGlow.r, CoD.blueGlow.g, CoD.blueGlow.b )
		end
	end
end

CoD.TCZWaypoint.PulseLow = function ( f10_arg0, f10_arg1 )
	f10_arg0:beginAnimation( "pulse_low", f10_arg1, false, false )
	f10_arg0:setAlpha( CoD.TCZWaypoint.pulseAlphaLow )
end

CoD.TCZWaypoint.PulseHigh = function ( f11_arg0, f11_arg1 )
	f11_arg0:beginAnimation( "pulse_high", time, false, false )
	f11_arg0:setAlpha( CoD.TCZWaypoint.pulseAlphaHigh )
end

CoD.TCZRoamingZombies.new = function ( f12_arg0, f12_arg1 )
	local f12_local0 = CoD.ObjectiveWaypoint.new( f12_arg0, f12_arg1, CoD.TCZRoamingZombies.baseWaypointZOffset )
	f12_local0:setClass( CoD.TCZRoamingZombies )
	f12_local0:registerEventHandler( "objective_update_" .. Engine.GetObjectiveName( f12_arg0, f12_arg1 ), f12_local0.update )
	f12_local0.mainImage:setImage( CoD.TCZRoamingZombies.RoamingZombieMaterial )
	f12_local0.arrowImage:setImage( CoD.TCZWaypoint.ArrowImageMaterial )
	f12_local0.alphaController:setAlpha( 1 )
	return f12_local0
end

CoD.TCZRoamingZombies.update = function ( f13_arg0, f13_arg1 )
	local f13_local0 = f13_arg1.controller
	local f13_local1 = f13_arg0.index
	local f13_local2 = Engine.ObjectiveGetTeamUsingCount( f13_local0, f13_local1 )
	if Engine.GetObjectiveEntity( f13_local0, f13_local1 ) then
		f13_arg0.zOffset = f13_arg0.PlayerZOffset
	else
		f13_arg0.zOffset = CoD.TCZRoamingZombies.baseWaypointZOffset
	end
	CoD.TCZRoamingZombies.super.update( f13_arg0, f13_arg1 )
end

