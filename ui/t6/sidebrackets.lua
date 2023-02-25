CoD.SideBrackets = {}
CoD.SideBrackets.Fade = function ( f1_arg0, f1_arg1 )
	f1_arg0:beginAnimation( "fade", f1_arg1.duration )
	f1_arg0:setRGB( f1_arg1.red, f1_arg1.green, f1_arg1.blue )
	f1_arg0:setAlpha( f1_arg1.alpha )
end

CoD.SideBrackets.new = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:setAlpha( f2_arg5 )
	local f2_local1 = 2
	local f2_local2 = 10
	if f2_arg0 ~= nil then
		f2_local1 = f2_arg0
	end
	if f2_arg1 ~= nil then
		f2_local2 = f2_arg1
	end
	if not f2_arg2 then
		f2_arg2 = 1
	end
	if not f2_arg3 then
		f2_arg3 = 1
	end
	if not f2_arg4 then
		f2_arg4 = 1
	end
	if not f2_arg5 then
		f2_arg5 = 1
	end
	self.leftTopHook = LUI.UIImage.new()
	self.leftTopHook:setLeftRight( true, false, 0, f2_local2 )
	self.leftTopHook:setTopBottom( true, false, 0, f2_local1 )
	self.leftTopHook:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.leftTopHook )
	self.leftTopHook:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	self.leftLine = LUI.UIImage.new()
	self.leftLine:setLeftRight( true, false, 0, f2_local1 )
	self.leftLine:setTopBottom( true, true, f2_local1, -f2_local1 )
	self.leftLine:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.leftLine )
	self.leftLine:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	self.leftBottomHook = LUI.UIImage.new()
	self.leftBottomHook:setLeftRight( true, false, 0, f2_local2 )
	self.leftBottomHook:setTopBottom( false, true, -f2_local1, 0 )
	self.leftBottomHook:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.leftBottomHook )
	self.leftBottomHook:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	self.rightTopHook = LUI.UIImage.new()
	self.rightTopHook:setLeftRight( false, true, -f2_local2, 0 )
	self.rightTopHook:setTopBottom( true, false, 0, f2_local1 )
	self.rightTopHook:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.rightTopHook )
	self.rightTopHook:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	self.rightLine = LUI.UIImage.new()
	self.rightLine:setLeftRight( false, true, -f2_local1, 0 )
	self.rightLine:setTopBottom( true, true, f2_local1, -f2_local1 )
	self.rightLine:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.rightLine )
	self.rightLine:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	self.rightBottomHook = LUI.UIImage.new()
	self.rightBottomHook:setLeftRight( false, true, -f2_local2, 0 )
	self.rightBottomHook:setTopBottom( false, true, -f2_local1, 0 )
	self.rightBottomHook:setRGB( f2_arg2, f2_arg3, f2_arg4 )
	self:addElement( self.rightBottomHook )
	self.rightBottomHook:registerEventHandler( "fade", CoD.SideBrackets.Fade )
	return self
end

