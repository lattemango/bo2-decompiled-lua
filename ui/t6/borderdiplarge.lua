require( "T6.Border" )

CoD.BorderDipLarge = {}
CoD.BorderDipLarge.LargeDip = "menu_sp_cac_single_dip_dbl"
CoD.BorderDipLarge.LargeDipWidth = 147.2
CoD.BorderDipLarge.LargeDipHeight = 8
CoD.BorderDipLarge.LargeDipLeftOffset = 10
CoD.BorderDipLarge.RectangleWidthOffset = 15
CoD.BorderDipLarge.RectangleHeightOffset = 10
CoD.BorderDipLarge.RectangleLength = 30
CoD.BorderDipLarge.RectangleHeight = 12
local f0_local0 = nil
CoD.BorderDipLarge.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7 )
	local f1_local0 = CoD.Border.new( f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7 )
	f1_local0.bottomBorder:setLeftRight( true, false, 0, CoD.BorderDipLarge.LargeDipLeftOffset )
	local self = LUI.UIImage.new()
	self:setLeftRight( true, true, CoD.BorderDipLarge.LargeDipWidth * f1_arg0 + CoD.BorderDipLarge.LargeDipLeftOffset, 0 )
	self:setTopBottom( false, true, -f1_arg1, 0 )
	self:setRGB( f1_arg2, f1_arg3, f1_arg4 )
	f1_local0.bottomBorderFiller = self
	f1_local0:addElement( self )
	f1_local0.dips = {}
	for f1_local2 = 1, f1_arg0, 1 do
		table.insert( f1_local0.dips, f0_local0( f1_local0, f1_local2, f1_arg1, f1_arg5 ) )
		f1_local0.dips[f1_local2]:setRGB( f1_arg2, f1_arg3, f1_arg4 )
	end
	local f1_local2 = LUI.UIElement.new()
	f1_local2:setTopBottom( true, false, CoD.BorderDipLarge.RectangleHeightOffset, CoD.BorderDipLarge.RectangleHeightOffset + CoD.BorderDipLarge.RectangleHeight )
	f1_local2:setLeftRight( true, false, CoD.BorderDipLarge.RectangleWidthOffset, CoD.BorderDipLarge.RectangleWidthOffset + CoD.BorderDipLarge.RectangleLength )
	f1_local2:addElement( CoD.Border.new( f1_arg1 * 2, f1_arg2, f1_arg3, f1_arg4, f1_arg5 ) )
	f1_local0:addElement( f1_local2 )
	local f1_local4 = LUI.UIElement.new()
	f1_local4:setTopBottom( true, false, CoD.BorderDipLarge.RectangleHeightOffset, CoD.BorderDipLarge.RectangleHeightOffset + CoD.BorderDipLarge.RectangleHeight )
	f1_local4:setLeftRight( false, true, -CoD.BorderDipLarge.RectangleWidthOffset - CoD.BorderDipLarge.RectangleLength, -CoD.BorderDipLarge.RectangleWidthOffset )
	f1_local4:addElement( CoD.Border.new( f1_arg1 * 2, f1_arg2, f1_arg3, f1_arg4, f1_arg5 ) )
	f1_local0:addElement( f1_local4 )
	f1_local0.setRGB = CoD.BorderDipLarge.SetRGB
	return f1_local0
end

f0_local0 = function ( f2_arg0, f2_arg1, f2_arg2 )
	local self = LUI.UIImage.new()
	self:setLeftRight( true, false, CoD.BorderDipLarge.LargeDipWidth * (f2_arg1 - 1) + CoD.BorderDipLarge.LargeDipLeftOffset, CoD.BorderDipLarge.LargeDipWidth * f2_arg1 + CoD.BorderDipLarge.LargeDipLeftOffset )
	self:setTopBottom( false, true, -CoD.BorderDipLarge.LargeDipHeight, 0 )
	self:setImage( RegisterMaterial( CoD.BorderDipLarge.LargeDip ) )
	self:setAlpha( alpha )
	f2_arg0:addElement( self )
	return self
end

CoD.BorderDipLarge.SetRGB = function ( f3_arg0, f3_arg1, f3_arg2, f3_arg3 )
	CoD.Border.SetRGB( f3_arg0, f3_arg1, f3_arg2, f3_arg3 )
	f3_arg0.bottomBorderFiller:setRGB( f3_arg1, f3_arg2, f3_arg3 )
	for f3_local0 = 1, #f3_arg0.dips, 1 do
		f3_arg0.dips[f3_local0]:setRGB( f3_arg1, f3_arg2, f3_arg3 )
	end
end

