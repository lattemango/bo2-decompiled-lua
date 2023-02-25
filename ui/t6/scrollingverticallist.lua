CoD.ScrollingVerticalList = {}
CoD.ScrollingVerticalList.ScrollBarWidth = 4
CoD.ScrollingVerticalList.ScrollBarInactiveWidth = 2
CoD.ScrollingVerticalList.new = function ( menu, controller )
	local self = LUI.UIElement.new( menu )
	self.id = "ScrollingVerticalList"
	
	local verticalList = LUI.UIVerticalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = controller
	} )
	verticalList:setUseStencil( true )
	self:addElement( verticalList )
	self.verticalList = verticalList
	
	verticalList:addElement( LUI.UIButtonRepeater.new( "up", {
		name = "gamepad_button",
		button = "up",
		down = true
	} ) )
	verticalList:addElement( LUI.UIButtonRepeater.new( "down", {
		name = "gamepad_button",
		button = "down",
		down = true
	} ) )
	
	local scrollbar = LUI.UIVerticalScrollbar.new( verticalList, CoD.ScrollingVerticalList.ScrollBarInactiveWidth, CoD.ScrollingVerticalList.ScrollBarWidth, 1, 1, 1, 0.5, 0.1 )
	self:addElement( scrollbar )
	self.scrollbar = scrollbar
	
	self.addElementToList = CoD.ScrollingVerticalList.AddElementToList
	if CoD.useMouse then
		self.verticalList:setRestrictMouseInsideElement( true )
		self:registerEventHandler( "scrollbar_update", CoD.ScrollingVerticalList.ScrollBarUpdate )
	end
	return self
end

CoD.ScrollingVerticalList.AddElementToList = function ( f2_arg0, f2_arg1 )
	f2_arg0.verticalList:addElement( f2_arg1 )
	if f2_arg1.m_focusable then
		local self = LUI.UIElement.new()
		self.id = "ScrollingVerticalList_GainFocusListener"
		self:registerEventHandler( "gain_focus", CoD.ScrollingVerticalList.GainFocusListenerTriggered )
		if CoD.useMouse then
			self:setHandleMouseMove( true )
			self:setLeftRight( true, true, 0, 0 )
			self:setTopBottom( true, true, 0, 0 )
			self:registerEventHandler( "mouseenter", CoD.ScrollingVerticalList.GainFocusListener_MouseEnter )
		end
		self.scrollingVerticalList = f2_arg0
		f2_arg1:addElement( self )
	end
end

CoD.ScrollingVerticalList.GainFocusListenerTriggered = function ( f3_arg0, f3_arg1 )
	f3_arg0.scrollingVerticalList.scrollbar:processEvent( {
		name = "focus_changed"
	} )
end

CoD.ScrollingVerticalList.GainFocusListener_MouseEnter = function ( f4_arg0, f4_arg1 )
	local f4_local0 = f4_arg0.scrollingVerticalList
	if f4_local0.m_forceAutoScroll then
		f4_local0.m_forceAutoScroll = nil
		f4_local0.verticalList:setupUIVerticalList( 0 )
	end
end

CoD.ScrollingVerticalList.ScrollBarUpdate = function ( f5_arg0, f5_arg1 )
	if not f5_arg0.m_forceAutoScroll then
		f5_arg0.verticalList:setupUIVerticalList( 1 )
		f5_arg0.m_forceAutoScroll = true
	end
	local f5_local0 = math.floor( f5_arg0.verticalList:getNumChildren() * f5_arg1.scrollBarPos )
	local f5_local1, f5_local2 = nil
	local f5_local3 = f5_arg0.verticalList:getFirstChild()
	local f5_local4 = 0
	while f5_local3 ~= nil do
		if f5_local3.m_focusable then
			f5_local2 = f5_local3
			f5_local2:processEvent( {
				name = "lose_focus"
			} )
			if f5_local4 == f5_local0 then
				f5_local1 = f5_local2
			end
			f5_local4 = f5_local4 + 1
		end
		f5_local3 = f5_local3:getNextSibling()
	end
	if f5_local1 ~= nil then
		f5_local1:processEvent( {
			name = "gain_focus"
		} )
	end
end

