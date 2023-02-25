CoD.VisorTimer = {}
CoD.VisorTimer.ContainerWidth = 100
CoD.VisorTimer.ContainerHeight = 30
CoD.VisorTimer.FontAlpha = 0.75
CoD.VisorTimer.Blue = CoD.visorBlue
CoD.VisorTimer.new = function ()
	local f1_local0 = CoD.VisorLeftBracket.BracketWidth
	local f1_local1 = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.ObjectiveText.DefaultHeight + 20
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, f1_local0, CoD.VisorTimer.ContainerWidth + f1_local0 )
	self:setTopBottom( false, false, -CoD.VisorTimer.ContainerHeight / 2 - f1_local1, CoD.VisorTimer.ContainerHeight / 2 - f1_local1 )
	self.id = self.id .. ".VisorTimer"
	self:registerEventHandler( "hud_create_timer", CoD.VisorTimer.CreateTimer )
	self:registerEventHandler( "hud_destroy_timer", CoD.VisorTimer.DestroyTimer )
	return self
end

CoD.VisorTimer.CreateTimer = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg1.data[1] * 1000 or 600000
	local f2_local1
	if f2_arg1.data[2] ~= 0 then
		f2_local1 = true
	else
		f2_local1 = false
	end
	local f2_local2
	if f2_arg1.data[3] ~= 0 then
		f2_local2 = true
	else
		f2_local2 = false
	end
	local f2_local3
	if f2_arg1.data[4] ~= 0 then
		f2_local3 = true
	else
		f2_local3 = false
	end
	local f2_local4
	if f2_arg1.data[5] ~= 0 then
		f2_local4 = true
	else
		f2_local4 = false
	end
	local f2_local5 = f2_arg1.data[6]
	if f2_local5 then
		f2_local5 = f2_local5 * 1000
	else
		f2_local5 = 30000
	end
	local f2_local6 = CoD.fonts.Default
	local f2_local7 = CoD.textSize.Default
	local self = LUI.UIText.new( nil, true )
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( false, false, -f2_local7 / 2, f2_local7 / 2 )
	self:setRGB( CoD.VisorTimer.Blue.r, CoD.VisorTimer.Blue.g, CoD.VisorTimer.Blue.b )
	self:setFont( f2_local6 )
	self:setAlignment( LUI.Alignment.Left )
	self:setAlpha( CoD.VisorTimer.FontAlpha )
	f2_arg0:addElement( self )
	if f2_local1 == false then
		CoD.CountdownTimer.Setup( self, f2_local5, f2_local3 )
		self:setTimeLeft( f2_local0 )
	else
		CoD.CountupTimer.Setup( self, f2_local2, f2_local4 )
		self:setTimeStart( f2_local0 )
	end
	f2_arg0.timerText = self
end

CoD.VisorTimer.DestroyTimer = function ( f3_arg0, f3_arg1 )
	if f3_arg0.timerText then
		f3_arg0.timerText:close()
	end
end

