require( "T6.CarouselCommon" )

CoD.HorizontalCarousel = {}
CoD.HorizontalCarousel.ExpansionScale = 1.5
CoD.HorizontalCarousel.ItemWidth = 100
CoD.HorizontalCarousel.ItemHeight = 100
CoD.HorizontalCarousel.Spacing = 10
CoD.HorizontalCarousel.ScrollTime = 100
CoD.HorizontalCarousel.EdgeBounceOffset = 10
CoD.HorizontalCarousel.MiniCarouselSize = 10
if CoD.isSinglePlayer then
	CoD.HorizontalCarousel.ScrollSFX = "uin_main_nav"
else
	CoD.HorizontalCarousel.ScrollSFX = "uin_slide_nav_lr"
end
CoD.HorizontalCarousel.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6 )
	local self = LUI.UIElement.new( f1_arg0 )
	self.id = "HorizontalCarousel"
	self:setUseStencil( true )
	if CoD.HorizontalCarousel.PipMaterial == nil then
		CoD.HorizontalCarousel.PipMaterial = RegisterMaterial( "menu_vis_carousel_pip" )
	end
	if CoD.HorizontalCarousel.PipFillMaterial == nil then
		CoD.HorizontalCarousel.PipFillMaterial = RegisterMaterial( "menu_vis_carousel_pip_fill" )
	end
	self.m_itemWidth = CoD.HorizontalCarousel.ItemWidth
	if f1_arg1 ~= nil then
		self.m_itemWidth = f1_arg1
	end
	self.m_itemHeight = CoD.HorizontalCarousel.ItemHeight
	if f1_arg2 ~= nil then
		self.m_itemHeight = f1_arg2
	end
	self.m_spacing = CoD.HorizontalCarousel.Spacing
	if f1_arg3 ~= nil then
		self.m_spacing = f1_arg3
	end
	self.m_expansionScale = CoD.HorizontalCarousel.ExpansionScale
	if f1_arg4 ~= nil then
		self.m_expansionScale = f1_arg4
	end
	self.m_scrollTime = CoD.HorizontalCarousel.ScrollTime
	if f1_arg5 ~= nil then
		self.m_scrollTime = f1_arg5
	end
	if CoD.useMouse then
		local f1_local1 = self.m_itemHeight * self.m_expansionScale / 2
		self.mouseDragListener = CoD.MouseDragListener.new( CoD.CarouselCommon.MouseDragDistance )
		self.mouseDragListener:setLeftRight( true, true, 0, 0 )
		self.mouseDragListener:setTopBottom( false, false, -f1_local1, f1_local1 )
		self.mouseDragListener:setHandleMouseAnim( false )
		self:addElement( self.mouseDragListener )
	end
	self.list = LUI.UIHorizontalList.new( {
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		spacing = self.m_spacing
	} )
	self.list.containers = {}
	self:addElement( self.list )
	self.miniList = LUI.UIHorizontalList.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.HorizontalCarousel.MiniCarouselSize,
		bottom = 0,
		spacing = 2,
		alignment = LUI.Alignment.Center
	} )
	self.miniList.miniContainers = {}
	if f1_arg6 == true then
		self:addElement( self.miniList )
	end
	CoD.CarouselCommon.SetupCarousel( self )
	self.handleGamepadButton = CoD.HorizontalCarousel.HandleGamepadButton
	self.addItem = CoD.HorizontalCarousel.AddItem
	self.scrollToItem = CoD.HorizontalCarousel.ScrollToItem
	if CoD.useMouse then
		self:registerEventHandler( "listener_mouse_drag", CoD.HorizontalCarousel.MouseDrag )
	end
	self.leftButtonRepeater = LUI.UIButtonRepeater.new( "left", {
		name = "gamepad_button",
		button = "left",
		down = true
	} )
	self:addElement( self.leftButtonRepeater )
	self.rightButtonRepeater = LUI.UIButtonRepeater.new( "right", {
		name = "gamepad_button",
		button = "right",
		down = true
	} )
	self:addElement( self.rightButtonRepeater )
	return self
end

CoD.HorizontalCarousel.MouseDrag = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg0.list:getNumChildren()
	if f2_local0 <= 0 then
		return 
	end
	local f2_local1 = nil
	if f2_arg1.direction == "right" and f2_arg0.m_currentItem > 1 then
		f2_local1 = -1
	elseif f2_arg1.direction == "left" and f2_arg0.m_currentItem < f2_local0 then
		f2_local1 = 1
	end
	if f2_arg0.m_currentItem and f2_local1 then
		f2_arg0:scrollToItem( f2_arg0.m_currentItem + f2_local1, f2_arg0.m_scrollTime )
	end
	f2_arg0.m_mouseDrag = true
end

CoD.HorizontalCarousel.HandleGamepadButton = function ( f3_arg0, f3_arg1 )
	if LUI.UIElement.handleGamepadButton( f3_arg0, f3_arg1 ) == true then
		return true
	elseif f3_arg0.list:getNumChildren() > 1 then
		local f3_local0 = nil
		if f3_arg1.down == true then
			if f3_arg1.button == "right" then
				f3_local0 = 1
			elseif f3_arg1.button == "left" then
				f3_local0 = -1
			end
		end
		if f3_local0 ~= nil and f3_arg0.m_currentItem ~= nil then
			f3_arg0:scrollToItem( f3_arg0.m_currentItem + f3_local0, f3_arg0.m_scrollTime )
		end
	end
end

CoD.HorizontalCarousel.ScrollToItem = function ( f4_arg0, f4_arg1, f4_arg2 )
	local f4_local0 = f4_arg0.list:getNumChildren()
	if f4_local0 == 0 or f4_arg0.list.m_scrolling == true then
		return 
	end
	local f4_local1 = f4_arg2 ~= 0
	if f4_arg2 == nil then
		f4_arg2 = f4_arg0.m_scrollTime
		f4_local1 = false
	end
	local f4_local2 = nil
	if f4_arg1 < 1 then
		f4_arg0.list:beginAnimation( "edge_bounce", f4_arg2 / 4, false, false )
		f4_arg0.list:setLeftRight( false, false, -(f4_arg0.m_itemWidth * f4_arg0.m_expansionScale) / 2 + CoD.HorizontalCarousel.EdgeBounceOffset, 0 )
		f4_arg0.leftButtonRepeater:cancelRepetition()
	elseif f4_local0 < f4_arg1 then
		local f4_local3 = (f4_arg0.m_itemWidth + f4_arg0.m_spacing) * (f4_local0 - 1) + f4_arg0.m_itemWidth * f4_arg0.m_expansionScale / 2
		f4_arg0.list:beginAnimation( "edge_bounce", f4_arg2 / 4, false, false )
		f4_arg0.list:setLeftRight( false, false, -f4_local3 - CoD.HorizontalCarousel.EdgeBounceOffset, 0 )
		f4_arg0.rightButtonRepeater:cancelRepetition()
	else
		f4_local2 = f4_arg0.list.containers[f4_arg0.m_currentItem]
		if f4_arg1 ~= f4_arg0.m_currentItem and f4_local2 ~= nil then
			CoD.HorizontalCarousel.ElemContainer_DefaultAnim( f4_local2, f4_arg0, f4_arg2 )
			f4_local2:processEvent( {
				name = "lose_focus"
			} )
			f4_local2.miniContainer.background:beginAnimation( "default", f4_arg2 )
			f4_local2.miniContainer.background:setImage( CoD.HorizontalCarousel.PipMaterial )
		end
		f4_arg0.m_currentItem = f4_arg1
		f4_local2 = f4_arg0.list.containers[f4_arg0.m_currentItem]
		f4_local2:processEvent( {
			name = "gain_focus"
		} )
		CoD.HorizontalCarousel.ElemContainer_ExpandAnim( f4_local2, f4_arg0, f4_arg2 )
		f4_local2.miniContainer.background:beginAnimation( "selected", f4_arg2 )
		f4_local2.miniContainer.background:setImage( CoD.HorizontalCarousel.PipFillMaterial )
		local f4_local3 = (f4_arg0.m_itemWidth + f4_arg0.m_spacing) * (f4_arg0.m_currentItem - 1)
		f4_arg0.list:beginAnimation( "carousel_scroll", f4_arg2, false, false )
		f4_arg0:processEvent( {
			name = "carousel_scroll"
		} )
		f4_arg0.list:setLeftRight( false, false, -(f4_arg0.m_itemWidth * f4_arg0.m_expansionScale) / 2 - f4_local3, 0 )
		if f4_local1 == true then
			Engine.PlaySound( CoD.HorizontalCarousel.ScrollSFX )
		end
		f4_arg0.list.m_scrolling = true
	end
	return f4_local2
end

CoD.HorizontalCarousel.AddItem = function ( menu, controller )
	local self = LUI.UIElement.new()
	self.id = "HorizontalCarouselContainer"
	CoD.HorizontalCarousel.ElemContainer_DefaultAnim( self, menu, 0 )
	menu.list:addElement( self )
	table.insert( menu.list.containers, self )
	self.index = #menu.list.containers
	local f5_local1 = LUI.UIElement.new()
	f5_local1:setLeftRight( true, false, 0, CoD.HorizontalCarousel.MiniCarouselSize )
	f5_local1:setTopBottom( true, true, 0, 0 )
	f5_local1.background = LUI.UIImage.new()
	f5_local1.background:setLeftRight( true, true, 0, 0 )
	f5_local1.background:setTopBottom( true, true, 0, 0 )
	f5_local1.background:setImage( CoD.HorizontalCarousel.PipMaterial )
	f5_local1:addElement( f5_local1.background )
	menu.miniList:addElement( f5_local1 )
	table.insert( menu.miniList.miniContainers, f5_local1 )
	f5_local1.index = #menu.miniList.miniContainers
	self.miniContainer = f5_local1
	controller:setHandleMouse( false )
	self.content = controller
	self:addElement( controller )
	if CoD.useMouse then
		self:setHandleMouse( true )
		self:registerEventHandler( "leftmousedown", CoD.NullFunction )
		self:registerEventHandler( "leftmouseup", CoD.CarouselCommon.Container_LeftMouseUp )
		self:registerEventHandler( "mouseenter", CoD.CarouselCommon.Container_MouseEnter )
		self:registerEventHandler( "mouseleave", CoD.CarouselCommon.Container_MouseLeave )
		f5_local1:setHandleMouse( true )
		f5_local1:registerEventHandler( "leftmousedown", CoD.NullFunction )
		f5_local1:registerEventHandler( "leftmouseup", CoD.CarouselCommon.MiniContainer_LeftMouseUp )
		f5_local1:registerEventHandler( "mouseenter", CoD.CarouselCommon.MiniContainer_MouseEnter )
		f5_local1:registerEventHandler( "mouseleave", CoD.CarouselCommon.MiniContainer_MouseLeave )
		if self.index > 1 then
			menu.mouseDragListener:setHandleMouseAnim( true )
		end
	end
	if menu.m_currentItem == nil then
		menu.m_currentItem = 1
	end
	return self
end

CoD.HorizontalCarousel.ElemContainer_DefaultAnim = function ( f6_arg0, f6_arg1, f6_arg2 )
	f6_arg0:beginAnimation( "default", f6_arg2 )
	f6_arg0:setLeftRight( true, false, 0, f6_arg1.m_itemWidth )
	f6_arg0:setTopBottom( false, false, -f6_arg1.m_itemHeight / 2, f6_arg1.m_itemHeight / 2 )
end

CoD.HorizontalCarousel.ElemContainer_ExpandAnim = function ( f7_arg0, f7_arg1, f7_arg2 )
	f7_arg0:beginAnimation( "expand", f7_arg2 )
	f7_arg0:setLeftRight( true, false, 0, f7_arg1.m_itemWidth * f7_arg1.m_expansionScale )
	f7_arg0:setTopBottom( false, false, -(f7_arg1.m_itemHeight / 2 * f7_arg1.m_expansionScale), f7_arg1.m_itemHeight / 2 * f7_arg1.m_expansionScale )
end

