CoD.GameMessages = {}
CoD.GameMessages.ObituraryWindowIndex = 0
CoD.GameMessages.BoldGameMessagesWindowIndex = 1
CoD.GameMessages.ObituaryWindowUpdateVisibility = function ( f1_arg0, f1_arg1 )
	if UIExpression.IsVisibilityBitSet( controller, CoD.BIT_HUD_OBITUARIES ) == 1 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_UI_ACTIVE ) == 0 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) == 0 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_IN_KILLCAM ) == 0 and (not CoD.IsShoutcaster( f1_arg1.controller ) or CoD.ExeProfileVarBool( f1_arg1.controller, "shoutcaster_killfeed" )) then
		f1_arg0:setAlpha( 1 )
	else
		f1_arg0:setAlpha( 0 )
	end
end

CoD.GameMessages.AddObituaryWindow = function ( menu, controller )
	local self = LUI.UIElement.new( controller )
	self:setupGameMessages( CoD.GameMessages.ObituraryWindowIndex )
	self:setAlignment( LUI.Alignment.Left )
	self:setFont( CoD.fonts.ExtraSmall )
	self:registerEventHandler( "hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.GameMessages.ObituaryWindowUpdateVisibility )
	self:registerEventHandler( "hud_update_bit_" .. CoD.BIT_HUD_OBITUARIES, CoD.GameMessages.ObituaryWindowUpdateVisibility )
	self:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.GameMessages.ObituaryWindowUpdateVisibility )
	self:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.GameMessages.ObituaryWindowUpdateVisibility )
	self:registerEventHandler( "hud_update_refresh", CoD.GameMessages.ObituaryWindowUpdateVisibility )
	menu.safeArea:addElement( self )
end

CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility = function ( f3_arg0, f3_arg1 )
	if UIExpression.IsVisibilityBitSet( controller, CoD.BIT_HUD_OBITUARIES ) == 1 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_UI_ACTIVE ) == 0 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN ) == 0 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM ) == 0 and UIExpression.IsVisibilityBitSet( controller, CoD.BIT_IN_KILLCAM ) == 0 then
		f3_arg0:setAlpha( 1 )
	else
		f3_arg0:setAlpha( 0 )
	end
end

CoD.GameMessages.BoldGameMessagesWindow = function ( f4_arg0, f4_arg1 )
	local f4_local0 = CoD.SplitscreenScaler.new( f4_arg1, 1.5 )
	f4_local0:setupGameMessages( CoD.GameMessages.BoldGameMessagesWindowIndex )
	f4_local0:setAlignment( LUI.Alignment.Center )
	f4_local0:setFont( CoD.fonts.Default )
	f4_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility )
	f4_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_HUD_OBITUARIES, CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility )
	f4_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility )
	f4_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility )
	f4_local0:registerEventHandler( "hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.GameMessages.BoldGameMessagesWindowUpdateVisibility )
	f4_arg0.safeArea:addElement( f4_local0 )
end

