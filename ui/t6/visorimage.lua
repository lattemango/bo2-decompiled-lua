CoD.VisorImage = {}
CoD.VisorImage.VisorShaderVector = {
	0.1,
	0.05,
	0,
	0
}
CoD.VisorImage.VisorReflectionShaderVector = {
	0.06,
	0,
	0,
	0
}
CoD.VisorImage.DefaultAlpha = 0.4
CoD.VisorImage.ColorValue = {}
CoD.VisorImage.ColorValue.r = 0.4
CoD.VisorImage.ColorValue.g = 0.4
CoD.VisorImage.ColorValue.b = 0.4
CoD.VisorImage.new = function ( f1_arg0, f1_arg1, f1_arg2 )
	local self = LUI.UIElement.new( f1_arg1 )
	local f1_local1, f1_local2, f1_local3 = nil
	if f1_arg2 == nil then
		f1_local1 = CoD.VisorImage.ColorValue.r
		f1_local2 = CoD.VisorImage.ColorValue.g
		f1_local3 = CoD.VisorImage.ColorValue.b
	else
		f1_local1 = f1_arg2.r
		f1_local2 = f1_arg2.g
		f1_local3 = f1_arg2.b
	end
	self.image = LUI.UIElement.new()
	self.image:setLeftRight( true, true, 0, 0 )
	self.image:setTopBottom( true, true, 0, 0 )
	self.image:setImage( RegisterMaterial( f1_arg0 ) )
	self.image:setRGB( f1_local1, f1_local2, f1_local3 )
	self.image:setShaderVector( 1, 0.1, 0.05, 0, 0 )
	self.image:setupVisorImage()
	self:addElement( self.image )
	return self
end

