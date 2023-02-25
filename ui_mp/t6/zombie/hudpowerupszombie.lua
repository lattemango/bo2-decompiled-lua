CoD.PowerUps = {}
CoD.PowerUps.IconSize = 48
CoD.PowerUps.UpgradeIconSize = 36
CoD.PowerUps.Spacing = 8
CoD.PowerUps.STATE_OFF = 0
CoD.PowerUps.STATE_ON = 1
CoD.PowerUps.STATE_FLASHING_OFF = 2
CoD.PowerUps.STATE_FLASHING_ON = 3
CoD.PowerUps.FLASHING_STAGE_DURATION = 500
CoD.PowerUps.MOVING_DURATION = 500
CoD.PowerUps.UpGradeIconColorRed = {
	r = 1,
	g = 0,
	b = 0
}
CoD.PowerUps.ClientFieldNames = {}
CoD.PowerUps.ClientFieldNames[1] = {
	clientFieldName = "powerup_instant_kill",
	material = RegisterMaterial( "specialty_instakill_zombies" )
}
CoD.PowerUps.ClientFieldNames[2] = {
	clientFieldName = "powerup_double_points",
	material = RegisterMaterial( "specialty_doublepoints_zombies" ),
	z_material = RegisterMaterial( "specialty_doublepoints_zombies_blue" )
}
CoD.PowerUps.ClientFieldNames[3] = {
	clientFieldName = "powerup_fire_sale",
	material = RegisterMaterial( "specialty_firesale_zombies" )
}
CoD.PowerUps.ClientFieldNames[4] = {
	clientFieldName = "powerup_bon_fire",
	material = RegisterMaterial( "zom_icon_bonfire" )
}
CoD.PowerUps.ClientFieldNames[5] = {
	clientFieldName = "powerup_mini_gun",
	material = RegisterMaterial( "zom_icon_minigun" )
}
CoD.PowerUps.ClientFieldNames[6] = {
	clientFieldName = "powerup_zombie_blood",
	material = RegisterMaterial( "specialty_zomblood_zombies" )
}
CoD.PowerUps.UpgradeClientFieldNames = {}
CoD.PowerUps.UpgradeClientFieldNames[1] = {
	clientFieldName = CoD.PowerUps.ClientFieldNames[1].clientFieldName .. "_ug",
	material = RegisterMaterial( "specialty_instakill_zombies" ),
	color = CoD.PowerUps.UpGradeIconColorRed
}
LUI.createMenu.PowerUpsArea = function ( f1_arg0 )
	local f1_local0 = CoD.Menu.NewSafeAreaFromState( "PowerUpsArea", f1_arg0 )
	f1_local0:setOwner( f1_arg0 )
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new( nil, CoD.Zombie.SplitscreenMultiplier )
	f1_local0.scaleContainer:setLeftRight( false, false, 0, 0 )
	f1_local0.scaleContainer:setTopBottom( false, true, 0, 0 )
	f1_local0:addElement( f1_local0.scaleContainer )
	local f1_local1 = CoD.PowerUps.IconSize * 0.5
	local f1_local2 = CoD.PowerUps.IconSize + CoD.PowerUps.UpgradeIconSize + 10
	local self = nil
	f1_local0.powerUps = {}
	for f1_local4 = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		self = LUI.UIElement.new()
		self:setLeftRight( false, false, -f1_local1, f1_local1 )
		self:setTopBottom( false, true, -f1_local2, 0 )
		self:registerEventHandler( "transition_complete_off_fade_out", CoD.PowerUps.PowerUpIcon_UpdatePosition )
		
		local powerUpIcon = LUI.UIImage.new()
		powerUpIcon:setLeftRight( true, true, 0, 0 )
		powerUpIcon:setTopBottom( false, true, -CoD.PowerUps.IconSize, 0 )
		powerUpIcon:setAlpha( 0 )
		self:addElement( powerUpIcon )
		self.powerUpIcon = powerUpIcon
		
		local upgradePowerUpIcon = LUI.UIImage.new()
		upgradePowerUpIcon:setLeftRight( false, false, -CoD.PowerUps.UpgradeIconSize / 2, CoD.PowerUps.UpgradeIconSize / 2 )
		upgradePowerUpIcon:setTopBottom( true, false, 0, CoD.PowerUps.UpgradeIconSize )
		upgradePowerUpIcon:setAlpha( 0 )
		self:addElement( upgradePowerUpIcon )
		self.upgradePowerUpIcon = upgradePowerUpIcon
		
		self.powerupId = nil
		f1_local0.scaleContainer:addElement( self )
		f1_local0.powerUps[f1_local4] = self
		f1_local0:registerEventHandler( CoD.PowerUps.ClientFieldNames[f1_local4].clientFieldName, CoD.PowerUps.Update )
		f1_local0:registerEventHandler( CoD.PowerUps.ClientFieldNames[f1_local4].clientFieldName .. "_ug", CoD.PowerUps.UpgradeUpdate )
	end
	f1_local0.activePowerUpCount = 0
	f1_local0:registerEventHandler( "hud_update_refresh", CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IS_PLAYER_IN_AFTERLIFE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.PowerUps.UpdateVisibility )
	f1_local0:registerEventHandler( "powerups_update_position", CoD.PowerUps.UpdatePosition )
	f1_local0.visible = true
	return f1_local0
end

CoD.PowerUps.UpdateVisibility = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_HUD_VISIBLE ) == 1 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IS_PLAYER_IN_AFTERLIFE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_EMP_ACTIVE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_UI_ACTIVE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_KILLCAM ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_SCOREBOARD_OPEN ) == 0 and (not CoD.IsShoutcaster( f2_local0 ) or CoD.ExeProfileVarBool( f2_local0, "shoutcaster_teamscore" )) and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_GUIDED_MISSILE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IS_SCOPED ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IN_VEHICLE ) == 0 and UIExpression.IsVisibilityBitSet( f2_local0, CoD.BIT_IS_FLASH_BANGED ) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha( 1 )
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha( 0 )
		f2_arg0.visible = nil
	end
end

CoD.PowerUps.Update = function ( f3_arg0, f3_arg1 )
	CoD.PowerUps.UpdateState( f3_arg0, f3_arg1 )
	CoD.PowerUps.UpdatePosition( f3_arg0, f3_arg1 )
end

CoD.PowerUps.UpdateState = function ( f4_arg0, f4_arg1 )
	local f4_local0 = nil
	local f4_local1 = CoD.PowerUps.GetExistingPowerUpIndex( f4_arg0, f4_arg1.name )
	if f4_local1 ~= nil then
		f4_local0 = f4_arg0.powerUps[f4_local1]
		if f4_arg1.newValue == CoD.PowerUps.STATE_ON then
			f4_local0.powerUpId = f4_arg1.name
			f4_local0.powerUpIcon:setImage( CoD.PowerUps.GetMaterial( f4_arg0, f4_arg1.controller, f4_arg1.name ) )
			f4_local0.powerUpIcon:setAlpha( 1 )
		elseif f4_arg1.newValue == CoD.PowerUps.STATE_OFF then
			f4_local0.powerUpIcon:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f4_local0.powerUpIcon:setAlpha( 0 )
			f4_local0.upgradePowerUpIcon:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f4_local0.upgradePowerUpIcon:setAlpha( 0 )
			f4_local0.powerUpId = nil
			f4_arg0.activePowerUpCount = f4_arg0.activePowerUpCount - 1
		elseif f4_arg1.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			f4_local0.powerUpIcon:beginAnimation( "fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f4_local0.powerUpIcon:setAlpha( 0 )
		elseif f4_arg1.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			f4_local0.powerUpIcon:beginAnimation( "fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f4_local0.powerUpIcon:setAlpha( 1 )
		end
	elseif f4_arg1.newValue == CoD.PowerUps.STATE_ON or f4_arg1.newValue == CoD.PowerUps.STATE_FLASHING_ON then
		local f4_local2 = CoD.PowerUps.GetFirstAvailablePowerUpIndex( f4_arg0 )
		if f4_local2 ~= nil then
			f4_local0 = f4_arg0.powerUps[f4_local2]
			f4_local0.powerUpId = f4_arg1.name
			f4_local0.powerUpIcon:setImage( CoD.PowerUps.GetMaterial( f4_arg0, f4_arg1.controller, f4_arg1.name ) )
			f4_local0.powerUpIcon:setAlpha( 1 )
			f4_arg0.activePowerUpCount = f4_arg0.activePowerUpCount + 1
		end
	end
end

CoD.PowerUps.UpgradeUpdate = function ( f5_arg0, f5_arg1 )
	CoD.PowerUps.UpgradeUpdateState( f5_arg0, f5_arg1 )
end

CoD.PowerUps.UpgradeUpdateState = function ( f6_arg0, f6_arg1 )
	local f6_local0 = nil
	local f6_local1 = CoD.PowerUps.GetExistingPowerUpIndex( f6_arg0, string.sub( f6_arg1.name, 0, -4 ) )
	if f6_local1 ~= nil then
		f6_local0 = f6_arg0.powerUps[f6_local1].upgradePowerUpIcon
		if f6_arg1.newValue == CoD.PowerUps.STATE_ON then
			f6_local0:setImage( CoD.PowerUps.GetUpgradeMaterial( f6_arg0, f6_arg1.name ) )
			f6_local0:setAlpha( 1 )
			CoD.PowerUps.SetUpgradeColor( f6_local0, f6_arg1.name )
		elseif f6_arg1.newValue == CoD.PowerUps.STATE_OFF then
			f6_local0:beginAnimation( "off_fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f6_local0:setAlpha( 0 )
		elseif f6_arg1.newValue == CoD.PowerUps.STATE_FLASHING_OFF then
			f6_local0:beginAnimation( "fade_out", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f6_local0:setAlpha( 0 )
		elseif f6_arg1.newValue == CoD.PowerUps.STATE_FLASHING_ON then
			f6_local0:beginAnimation( "fade_in", CoD.PowerUps.FLASHING_STAGE_DURATION )
			f6_local0:setAlpha( 1 )
		end
	end
end

CoD.PowerUps.GetMaterial = function ( f7_arg0, f7_arg1, f7_arg2 )
	local f7_local0 = nil
	for f7_local1 = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if CoD.PowerUps.ClientFieldNames[f7_local1].clientFieldName == f7_arg2 then
			f7_local0 = CoD.PowerUps.ClientFieldNames[f7_local1].material
			if UIExpression.IsVisibilityBitSet( f7_arg1, CoD.BIT_IS_PLAYER_ZOMBIE ) == 1 and CoD.PowerUps.ClientFieldNames[f7_local1].z_material then
				f7_local0 = CoD.PowerUps.ClientFieldNames[f7_local1].z_material
				break
			end
		end
	end
	return f7_local0
end

CoD.PowerUps.GetUpgradeMaterial = function ( f8_arg0, f8_arg1 )
	local f8_local0 = nil
	for f8_local1 = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[f8_local1].clientFieldName == f8_arg1 then
			f8_local0 = CoD.PowerUps.UpgradeClientFieldNames[f8_local1].material
			break
		end
	end
	return f8_local0
end

CoD.PowerUps.SetUpgradeColor = function ( f9_arg0, f9_arg1 )
	local f9_local0 = nil
	for f9_local1 = 1, #CoD.PowerUps.UpgradeClientFieldNames, 1 do
		if CoD.PowerUps.UpgradeClientFieldNames[f9_local1].clientFieldName == f9_arg1 then
			if CoD.PowerUps.UpgradeClientFieldNames[f9_local1].color then
				f9_arg0:setRGB( CoD.PowerUps.UpgradeClientFieldNames[f9_local1].color.r, CoD.PowerUps.UpgradeClientFieldNames[f9_local1].color.g, CoD.PowerUps.UpgradeClientFieldNames[f9_local1].color.b )
				break
			end
		end
	end
end

CoD.PowerUps.GetExistingPowerUpIndex = function ( f10_arg0, f10_arg1 )
	for f10_local0 = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if f10_arg0.powerUps[f10_local0].powerUpId == f10_arg1 then
			return f10_local0
		end
	end
	return nil
end

CoD.PowerUps.GetFirstAvailablePowerUpIndex = function ( f11_arg0 )
	for f11_local0 = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		if not f11_arg0.powerUps[f11_local0].powerUpId then
			return f11_local0
		end
	end
	return nil
end

CoD.PowerUps.PowerUpIcon_UpdatePosition = function ( f12_arg0, f12_arg1 )
	if f12_arg1.interrupted ~= true then
		f12_arg0:dispatchEventToParent( {
			name = "powerups_update_position"
		} )
	end
end

CoD.PowerUps.UpdatePosition = function ( f13_arg0, f13_arg1 )
	local f13_local0 = nil
	local f13_local1 = 0
	local f13_local2 = 0
	local f13_local3 = nil
	for f13_local4 = 1, #CoD.PowerUps.ClientFieldNames, 1 do
		f13_local0 = f13_arg0.powerUps[f13_local4]
		if f13_local0.powerUpId ~= nil then
			if not f13_local3 then
				f13_local1 = -(CoD.PowerUps.IconSize * 0.5 * f13_arg0.activePowerUpCount + CoD.PowerUps.Spacing * 0.5 * (f13_arg0.activePowerUpCount - 1))
			else
				f13_local1 = f13_local3 + CoD.PowerUps.IconSize + CoD.PowerUps.Spacing
			end
			f13_local2 = f13_local1 + CoD.PowerUps.IconSize
			f13_local0:beginAnimation( "move", CoD.PowerUps.MOVING_DURATION )
			f13_local0:setLeftRight( false, false, f13_local1, f13_local2 )
			f13_local3 = f13_local1
		end
	end
end

