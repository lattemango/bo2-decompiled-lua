CoD.MouseControlBar = {}
CoD.MouseControlBar.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4 )
	local self = LUI.UIElement.new()
	self.id = "MouseControlBar." .. f1_arg0
	self:setHandleMouse( true )
	self.m_name = f1_arg0
	self.m_minValue = f1_arg2
	self.m_maxValue = f1_arg3
	self.m_value = f1_arg1
	self.m_barWidth = f1_arg4
	self.m_arrowSize = 6
	self.m_pointerWidth = 2
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight( true, true, 0, 0 )
	f1_local1:setTopBottom( true, true, 0, 0 )
	f1_local1:setRGB( 0.5, 0.5, 0.5 )
	self.background = f1_local1
	self:addElement( f1_local1 )
	local f1_local2 = CoD.Border.new( 1, 0, 0, 0 )
	self.border = f1_local2
	self:addElement( f1_local2 )
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight( true, false, -self.m_pointerWidth / 2, self.m_pointerWidth / 2 )
	f1_local3:setTopBottom( true, true, 0, 0 )
	f1_local3:setRGB( 0, 0, 0 )
	self.pointer = f1_local3
	self:addElement( f1_local3 )
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight( true, false, -self.m_arrowSize / 2, self.m_arrowSize / 2 + 1 )
	f1_local4:setTopBottom( true, false, -self.m_arrowSize, 0 )
	f1_local4:setImage( RegisterMaterial( "ui_scrollbar_arrow_dwn_a" ) )
	f1_local4:setRGB( 1, 1, 1 )
	self.arrow = f1_local4
	self:addElement( f1_local4 )
	self.hide = CoD.MouseControlBar.Hide
	self.show = CoD.MouseControlBar.Show
	self.setValue = CoD.MouseControlBar.SetValue
	self.setColor = CoD.MouseControlBar.SetColor
	self.setBarAlpha = CoD.MouseControlBar.SetBarAlpha
	self:registerEventHandler( "leftmousedown", CoD.NullFunction )
	self:registerEventHandler( "leftmouseup", CoD.MouseControlBar.MouseAction )
	self:registerEventHandler( "mousedrag", CoD.MouseControlBar.MouseAction )
	CoD.MouseControlBar.UpdatePointer( self )
	return self
end

CoD.MouseControlBar.MouseAction = function ( f2_arg0, f2_arg1 )
	local f2_local0, f2_local1, f2_local2, f2_local3 = f2_arg0:getRect()
	f2_arg0.m_value = LUI.clamp( (f2_arg0.m_maxValue - f2_arg0.m_minValue) * (f2_arg1.x - f2_local0) / (f2_local2 - f2_local0) + f2_arg0.m_minValue, f2_arg0.m_minValue, f2_arg0.m_maxValue )
	CoD.MouseControlBar.UpdatePointer( f2_arg0 )
	f2_arg0:dispatchEventToParent( {
		name = "control_bar_updated",
		controller = f2_arg1.controller,
		barName = f2_arg0.m_name,
		value = f2_arg0.m_value
	} )
end

CoD.MouseControlBar.UpdatePointer = function ( f3_arg0 )
	local f3_local0 = f3_arg0.m_value / (f3_arg0.m_maxValue - f3_arg0.m_minValue) * f3_arg0.m_barWidth
	f3_arg0.pointer:setLeftRight( true, false, f3_local0 - f3_arg0.m_pointerWidth / 2, f3_local0 + f3_arg0.m_pointerWidth / 2 )
	f3_arg0.arrow:setLeftRight( true, false, f3_local0 - f3_arg0.m_arrowSize / 2, f3_local0 + f3_arg0.m_arrowSize / 2 + 1 )
end

CoD.MouseControlBar.Hide = function ( f4_arg0 )
	f4_arg0:setAlpha( 0 )
	f4_arg0:setMouseDisabled( true )
end

CoD.MouseControlBar.Show = function ( f5_arg0 )
	f5_arg0:setAlpha( 1 )
	f5_arg0:setMouseDisabled( false )
end

CoD.MouseControlBar.SetValue = function ( f6_arg0, f6_arg1 )
	f6_arg0.m_value = LUI.clamp( f6_arg1, f6_arg0.m_minValue, f6_arg0.m_maxValue )
	CoD.MouseControlBar.UpdatePointer( f6_arg0 )
end

CoD.MouseControlBar.SetColor = function ( f7_arg0, f7_arg1, f7_arg2, f7_arg3 )
	f7_arg0.background:setRGB( f7_arg1, f7_arg2, f7_arg3 )
end

CoD.MouseControlBar.SetBarAlpha = function ( f8_arg0, f8_arg1 )
	f8_arg0.background:setAlpha( f8_arg1 )
end

