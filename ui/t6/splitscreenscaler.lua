if CoD.isWIIU then
	require( "T6.Drc.DrcOutput" )
end
CoD.SplitscreenScaler = InheritFrom( LUI.UIElement )
CoD.SplitscreenScaler.new = function ( menu, controller )
	local self = LUI.UIElement.new( menu )
	self:setClass( CoD.SplitscreenScaler )
	self.scale = 1
	if 1 == UIExpression.IsInGame() and 1 < UIExpression.SplitscreenNum() then
		self.scale = controller
		if CoD.isWIIU then
			if Engine.WiiUGetDisplayConfiguration( CoD.DrcOutput.DisplayDrc ) ~= CoD.DrcOutput.ShowSecondScreen then
				self:setScale( controller )
			end
		else
			self:setScale( controller )
		end
	end
	if Dvar.r_dualPlayEnable:get() == true then
		self:setScale( 1 )
	end
	self:registerEventHandler( "fullscreen_viewport_start", CoD.SplitscreenScaler.FullscreenViewportStart )
	self:registerEventHandler( "fullscreen_viewport_stop", CoD.SplitscreenScaler.FullscreenViewportStop )
	return self
end

CoD.SplitscreenScaler.FullscreenViewportStart = function ( f2_arg0, f2_arg1 )
	f2_arg0:setScale( 1 )
end

CoD.SplitscreenScaler.FullscreenViewportStop = function ( f3_arg0, f3_arg1 )
	if f3_arg0.scale ~= nil then
		f3_arg0:setScale( f3_arg0.scale )
	else
		f3_arg0:setScale( 1 )
	end
	if Dvar.r_dualPlayEnable:get() == true then
		f3_arg0:setScale( 1 )
	end
end

CoD.SplitscreenScaler.id = "LUIImage"
