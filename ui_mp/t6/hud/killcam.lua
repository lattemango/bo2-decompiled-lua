local f0_local0 = 120
local f0_local1 = 1
local f0_local2 = 0
local f0_local3 = 0
local f0_local4 = 0.2
local f0_local5 = 0.75
local f0_local6 = "Morris"
local f0_local7 = 0
local f0_local8 = 0
local f0_local9 = 0
local f0_local10 = 0.2
LUI.createMenu.Killcam = function ( f1_arg0 )
	local f1_local0 = CoD.Menu.NewFromState( "Killcam" )
	f1_local0:setOwner( f1_arg0 )
	f1_local0:setLeftRight( true, true, 0, 0 )
	f1_local0:setTopBottom( true, true, 0, 0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, 0, f0_local0 )
	f1_local0:addElement( self )
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setLeftRight( true, true, 0, 0 )
	f1_local2:setTopBottom( true, true, 0, 0 )
	self:addElement( f1_local2 )
	local f1_local3 = LUI.UIElement.new()
	f1_local3:setLeftRight( true, true, 0, 0 )
	f1_local3:setTopBottom( false, true, -f0_local0, 0 )
	f1_local0:addElement( f1_local3 )
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight( true, true, 0, 0 )
	f1_local4:setTopBottom( true, true, 0, 0 )
	f1_local3:addElement( f1_local4 )
	local f1_local5 = LUI.UIText.new()
	f1_local5:setLeftRight( true, true, 0, 0 )
	f1_local5:setTopBottom( false, true, -CoD.textSize[f0_local6], 0 )
	f1_local5:setFont( CoD.fonts[f0_local6] )
	f1_local5:setAlpha( f0_local5 )
	self:addElement( f1_local5 )
	f1_local0.isFinalKillcam = UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_FINAL_KILLCAM ) == 1
	f1_local0.isRoundEndKillcam = UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_ROUND_END_KILLCAM ) == 1
	local f1_local6 = UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_NEMESIS_KILLCAM ) == 1
	if f1_local0.isFinalKillcam or f1_local0.isRoundEndKillcam then
		f1_local2:setRGB( f0_local7, f0_local8, f0_local9 )
		f1_local2:setAlpha( f0_local10 )
		f1_local4:setRGB( f0_local7, f0_local8, f0_local9 )
		f1_local4:setAlpha( f0_local10 )
		if f1_local0.isFinalKillcam then
			f1_local5:setText( Engine.Localize( "MP_FINAL_KILLCAM_CAPS" ) )
		else
			f1_local5:setText( Engine.Localize( "MP_ROUND_END_KILLCAM" ) )
		end
	else
		f1_local2:setRGB( f0_local1, f0_local2, f0_local3 )
		f1_local2:setAlpha( f0_local4 )
		f1_local4:setRGB( f0_local1, f0_local2, f0_local3 )
		f1_local4:setAlpha( f0_local4 )
		if f1_local6 then
			f1_local5:setText( Engine.Localize( "MP_NEMESIS_KILLCAM_CAPS" ) )
		else
			f1_local5:setText( Engine.Localize( "MP_KILLCAM_CAPS" ) )
		end
	end
	local f1_local7 = CoD.NamePlate.New( f1_arg0, Engine.GetCalloutPlayerData( f1_arg0, Engine.GetPredictedClientNum( f1_arg0 ) ) )
	f1_local7:setTopBottom( false, true, -(2 * CoD.NotificationPopups.PlayerCallout_Height), -(1 * CoD.NotificationPopups.PlayerCallout_Height) )
	f1_local3:addElement( f1_local7 )
	return f1_local0
end

