CoD.ListBoxButton = {}
CoD.ListBoxButton.click = function ( f1_arg0, f1_arg1 )
	f1_arg0:dispatchEventToParent( {
		name = f1_arg1.name,
		controller = f1_arg1.controller,
		mutables = f1_arg0.body.m_mutables
	} )
	f1_arg0.body:processEvent( f1_arg1 )
end

CoD.ListBoxButton.unclick = function ( f2_arg0, f2_arg1 )
	f2_arg0:animateToState( "button_highlighted", 5 )
	f2_arg0.body:processEvent( f2_arg1 )
end

CoD.ListBoxButton.gainFocus = function ( f3_arg0, f3_arg1 )
	LUI.UIElement.gainFocus( f3_arg0, f3_arg1 )
	f3_arg0.body.buttonBorder:animateToState( "bg_highlighted", 0 )
	f3_arg0:animateToState( "button_highlighted", 0 )
	f3_arg0:dispatchEventToParent( {
		name = "listbox_button_gain_focus",
		controller = f3_arg1.controller,
		mutables = f3_arg0.body.m_mutables
	} )
end

CoD.ListBoxButton.loseFocus = function ( f4_arg0, f4_arg1 )
	LUI.UIElement.loseFocus( f4_arg0, f4_arg1 )
	f4_arg0.body.buttonBorder:animateToState( "bg_not_highlighted", 0 )
	f4_arg0:animateToState( "button_not_highlighted", 0 )
	f4_arg0:dispatchEventToParent( {
		name = "listbox_button_lose_focus",
		controller = f4_arg1.controller,
		mutables = f4_arg0.body.m_mutables
	} )
end

CoD.ListBoxButton.setVisible = function ( f5_arg0, f5_arg1 )
	if f5_arg1 == true then
		if f5_arg0.m_visible == false then
			f5_arg0:addElement( f5_arg0.body )
			f5_arg0.m_visible = true
		end
		f5_arg0:makeFocusable()
	else
		if f5_arg0.body ~= nil and f5_arg0.m_visible == true then
			f5_arg0:removeElement( f5_arg0.body )
			f5_arg0.m_visible = false
		end
		f5_arg0:makeNotFocusable()
	end
end

CoD.ListBoxButton.GetBodyUIElement = function ( f6_arg0 )
	if f6_arg0 ~= nil then
		return f6_arg0.body
	else
		return nil
	end
end

CoD.ListBoxButton.GetBackgroundUIImage = function ( f7_arg0 )
	if f7_arg0 ~= nil and f7_arg0.body ~= nil then
		return f7_arg0.body.buttonBg
	else
		return nil
	end
end

CoD.ListBoxButton.DisableHighlighting = function ( f8_arg0 )
	if f8_arg0:getBackgroundUIImage() ~= nil then
		local f8_local0 = f8_arg0:getBackgroundUIImage()
		f8_local0:registerAnimationState( "bg_highlighted", {} )
		f8_local0 = f8_arg0:getBackgroundUIImage()
		f8_local0:registerAnimationState( "bg_not_highlighted", {} )
	end
end

CoD.ListBoxButton.DisableZooming = function ( f9_arg0 )
	f9_arg0:registerAnimationState( "button_clicked", {} )
end

CoD.ListBoxButton.MouseEnter = function ( f10_arg0, f10_arg1 )
	f10_arg0:dispatchEventToParent( {
		name = "listbox_button_mouseenter",
		controller = f10_arg1.controller,
		button = f10_arg0
	} )
end

CoD.ListBoxButton.LeftMouseUp = function ( f11_arg0, f11_arg1 )
	if f11_arg0.m_visible then
		f11_arg0:dispatchEventToParent( {
			name = "listbox_button_clicked",
			controller = f11_arg1.controller,
			button = f11_arg0
		} )
	end
end

CoD.ListBoxButton.new = function ( f12_arg0, f12_arg1, f12_arg2 )
	local self = LUI.UIElement.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	} )
	self.body = LUI.UIElement.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	} )
	self.id = "ListBoxButton"
	self.m_visible = false
	self.backgroundHighlightAlpha = 0.5
	self.backgroundNonHighlightAlpha = 0.2
	self.getBodyUIElement = CoD.ListBoxButton.GetBodyUIElement
	self.getBackgroundUIImage = CoD.ListBoxButton.GetBackgroundUIImage
	self.disableHighlighting = CoD.ListBoxButton.DisableHighlighting
	self.disableZooming = CoD.ListBoxButton.DisableZooming
	self:makeNotFocusable()
	self.getData = f12_arg2
	self.setVisible = CoD.ListBoxButton.setVisible
	local f12_local1 = LUI.UIImage.new()
	f12_local1:setLeftRight( true, true, 0, 0 )
	f12_local1:setTopBottom( true, true, 0, 0 )
	f12_local1:setAlpha( 0.1 )
	f12_local1:setRGB( 0, 0, 0 )
	local f12_local2 = LUI.UIImage.new()
	f12_local2:setLeftRight( true, true, 0, 0 )
	f12_local2:setTopBottom( true, true, 0, 0 )
	f12_local2:setAlpha( 0.1 )
	f12_local2:setImage( RegisterMaterial( CoD.MPZM( "menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch" ) ) )
	local f12_local3 = CoD.Border.new( 1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 0 )
	f12_local3:registerAnimationState( "bg_highlighted", {
		alpha = 1
	} )
	f12_local3:registerAnimationState( "bg_not_highlighted", {
		alpha = 0
	} )
	self:registerAnimationState( "button_highlighted", {
		zoom = f12_arg1
	} )
	self:registerAnimationState( "button_not_highlighted", {
		zoom = 0
	} )
	self:registerAnimationState( "button_clicked", {
		zoom = -5
	} )
	self.body.buttonBorder = f12_local3
	self.body.buttonBg = f12_local1
	self.body:addElement( f12_local1 )
	self.body:addElement( f12_local2 )
	self.body:addElement( f12_local3 )
	self:registerEventHandler( "gain_focus", CoD.ListBoxButton.gainFocus )
	self:registerEventHandler( "lose_focus", CoD.ListBoxButton.loseFocus )
	self:registerEventHandler( "click", CoD.ListBoxButton.click )
	self:registerEventHandler( "unclick", CoD.ListBoxButton.unclick )
	if CoD.useMouse then
		self:setHandleMouse( true )
		self:registerEventHandler( "mouseenter", CoD.ListBoxButton.MouseEnter )
		self:registerEventHandler( "leftmouseup", CoD.ListBoxButton.LeftMouseUp )
		self:registerEventHandler( "leftmousedown", CoD.NullFunction )
	end
	return self
end

