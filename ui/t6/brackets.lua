CoD.Brackets = {}
CoD.Brackets.Fade = function ( f1_arg0, f1_arg1 )
	f1_arg0:beginAnimation( "fade", f1_arg1.duration )
	f1_arg0:setRGB( f1_arg1.red, f1_arg1.green, f1_arg1.blue )
	f1_arg0:setAlpha( f1_arg1.alpha )
end

CoD.Brackets.new = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:setAlpha( f2_arg4 )
	local f2_local1 = nil
	if f2_arg5 then
		f2_local1 = f2_arg5
	else
		f2_local1 = RegisterMaterial( "lui_bracket" )
	end
	if not f2_arg1 then
		f2_arg1 = 1
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
	self.topLeft = LUI.UIImage.new()
	self.topLeft:setLeftRight( true, false, 0, f2_arg0 )
	self.topLeft:setTopBottom( true, false, 0, f2_arg0 )
	self.topLeft:setImage( f2_local1 )
	self.topLeft:setRGB( f2_arg1, f2_arg2, f2_arg3 )
	self.topLeft:setZRot( 180 )
	self:addElement( self.topLeft )
	self.topLeft:registerEventHandler( "fade", CoD.Brackets.Fade )
	self.topRight = LUI.UIImage.new()
	self.topRight:setLeftRight( false, true, -f2_arg0, 0 )
	self.topRight:setTopBottom( true, false, 0, f2_arg0 )
	self.topRight:setImage( f2_local1 )
	self.topRight:setRGB( f2_arg1, f2_arg2, f2_arg3 )
	self.topRight:setZRot( 90 )
	self:addElement( self.topRight )
	self.topRight:registerEventHandler( "fade", CoD.Brackets.Fade )
	self.bottomLeft = LUI.UIImage.new()
	self.bottomLeft:setLeftRight( true, false, 0, f2_arg0 )
	self.bottomLeft:setTopBottom( false, true, -f2_arg0, 0 )
	self.bottomLeft:setImage( f2_local1 )
	self.bottomLeft:setRGB( f2_arg1, f2_arg2, f2_arg3 )
	self.bottomLeft:setZRot( -90 )
	self:addElement( self.bottomLeft )
	self.bottomLeft:registerEventHandler( "fade", CoD.Brackets.Fade )
	self.bottomRight = LUI.UIImage.new()
	self.bottomRight:setLeftRight( false, true, -f2_arg0, 0 )
	self.bottomRight:setTopBottom( false, true, -f2_arg0, 0 )
	self.bottomRight:setImage( f2_local1 )
	self.bottomRight:setRGB( f2_arg1, f2_arg2, f2_arg3 )
	self:addElement( self.bottomRight )
	self.bottomRight:registerEventHandler( "fade", CoD.Brackets.Fade )
	return self
end

