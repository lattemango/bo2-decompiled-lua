CoD.SpectateTeamCardTwoTeam = InheritFrom( LUI.UIElement )
CoD.SpectateTeamCardTwoTeam.Height = 64
CoD.SpectateTeamCardTwoTeam.Width = 256
CoD.SpectateTeamCardTwoTeam.RealWidth = 179
CoD.SpectateTeamCardTwoTeam.ScoreFont = CoD.fonts.Big
CoD.SpectateTeamCardTwoTeam.ScoreFontSize = CoD.textSize.Big * 0.9
CoD.SpectateTeamCardTwoTeam.IconDimension = CoD.SpectateTeamCardTwoTeam.Height
CoD.SpectateTeamCardTwoTeam.Hide = function ( f1_arg0, f1_arg1 )
	f1_arg0:setAlpha( 0 )
end

CoD.SpectateTeamCardTwoTeam.Pulse = function ( f2_arg0 )
	local f2_local0, f2_local1, f2_local2 = CoD.SpectateHUD.GetTeamColor( f2_arg0.m_team )
	f2_arg0.bgPulse:completeAnimation()
	f2_arg0.bgPulse:setRGB( f2_local0, f2_local1, f2_local2 )
	f2_arg0.bgPulse:setAlpha( 0.5 )
	f2_arg0.bgPulse:beginAnimation( "pulse_out", 750 )
	f2_arg0.bgPulse:setAlpha( 0 )
end

CoD.SpectateTeamCardTwoTeam.Populate = function ( f3_arg0, f3_arg1, f3_arg2 )
	f3_arg0.m_team = f3_arg1
	local f3_local0 = CoD.SpectateHUD.GetTeamIcon( f3_arg1 )
	if f3_local0 ~= nil then
		f3_arg0.icon:setImage( f3_local0 )
		f3_arg0.icon:setAlpha( 1 )
	else
		f3_arg0.icon:setAlpha( 0 )
	end
	f3_arg0.score:setText( f3_arg2 )
end

CoD.SpectateTeamCardTwoTeam.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	self:setLeftRight( false, true, -CoD.SpectateTeamCardTwoTeam.Width, 0 )
	self:setTopBottom( true, false, 0, CoD.SpectateTeamCardTwoTeam.Height )
	self:setClass( CoD.SpectateTeamCardTwoTeam )
	self.m_ownerController = menu
	local f4_local1 = LUI.UIImage.new()
	f4_local1:setTopBottom( true, true, 0, 0 )
	f4_local1:setLeftRight( true, true, 0, 0 )
	f4_local1:setImage( RegisterMaterial( "hud_shoutcasting_boxes" ) )
	f4_local1:setAlpha( 1 )
	self.bgPulse = LUI.UIImage.new()
	self.bgPulse:setTopBottom( true, true, 0, 0 )
	self.bgPulse:setLeftRight( true, true, 0, 0 )
	self.bgPulse:setImage( RegisterMaterial( "hud_shoutcasting_boxes_glow" ) )
	self.bgPulse:setAlpha( 0 )
	self.score = LUI.UIText.new()
	self.score:setLeftRight( true, true, 0, 0 )
	self.score:setTopBottom( false, false, -(CoD.SpectateTeamCardTwoTeam.ScoreFontSize / 2), CoD.SpectateTeamCardTwoTeam.ScoreFontSize / 2 )
	self.score:setFont( CoD.SpectateTeamCardTwoTeam.ScoreFont )
	self.score:setAlignment( LUI.Alignment.Center )
	local f4_local2 = LUI.UIElement.new()
	f4_local2:setLeftRight( false, true, -75, -4 )
	f4_local2:setTopBottom( true, false, 2, 55 )
	f4_local2:addElement( self.score )
	local f4_local3 = CoD.SpectateTeamCardTwoTeam.IconDimension
	self.icon = LUI.UIImage.new()
	self.icon:setLeftRight( false, false, -(f4_local3 / 2), f4_local3 / 2 )
	self.icon:setTopBottom( false, false, -(f4_local3 / 2), f4_local3 / 2 )
	self.icon:setAlpha( 0 )
	local f4_local4 = LUI.UIElement.new()
	f4_local4:setLeftRight( false, true, -174, -88 )
	f4_local4:setTopBottom( true, false, 2, 55 )
	f4_local4:addElement( self.icon )
	if controller == true then
		f4_local1:setLeftRight( true, true, CoD.SpectateTeamCardTwoTeam.Width, -CoD.SpectateTeamCardTwoTeam.Width )
		self.bgPulse:setLeftRight( true, true, CoD.SpectateTeamCardTwoTeam.Width, -CoD.SpectateTeamCardTwoTeam.Width )
		f4_local2:setLeftRight( true, false, 75, 4 )
		f4_local4:setLeftRight( true, false, 174, 88 )
	end
	self:addElement( f4_local1 )
	self:addElement( self.bgPulse )
	self:addElement( f4_local4 )
	self:addElement( f4_local2 )
	self.m_team = nil
	self.populate = CoD.SpectateTeamCardTwoTeam.Populate
	return self
end

CoD.SpectateTeamCardTwoTeam:registerEventHandler( "spectate_teamstatuscard_pulse", CoD.SpectateTeamCardTwoTeam.Pulse )
