if CoD == nil then
	CoD = {}
end
CoD.Ticker = {}
local f0_local0 = function ( f1_arg0, f1_arg1 )
	local f1_local0 = 1
	local f1_local1 = f1_arg0.verticalList:getFirstChild()
	while f1_local1 ~= nil do
		if f1_local0 == 1 then
			f1_local1.categoryItem:animateToState( "default" )
			f1_local1.textItem:animateToState( "default" )
		elseif f1_local0 == 2 then
			f1_local1.categoryItem:animateToState( "fading", f1_arg1 )
			f1_local1.textItem:animateToState( "fading", f1_arg1 )
		else
			f1_local1.categoryItem:animateToState( "faded", f1_arg1 )
			f1_local1.textItem:animateToState( "faded", f1_arg1 )
		end
		f1_local0 = f1_local0 + 1
		f1_local1 = f1_local1:getNextSibling()
	end
end

local f0_local1 = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg0.verticalList:getLastChild()
	while f2_local0.disposable do
		f2_local0:close()
		f2_local0 = f2_arg0.verticalList:getLastChild()
	end
	f2_local0:close()
	f2_local0:setPriority( -10000 )
	f2_arg0.verticalList:addElement( f2_local0 )
	f2_local0:setPriority( nil )
	f2_arg0:scrollY( -f2_arg0.itemHeight, 0 )
	f2_arg0:scrollY( 0, 1000, true, true )
	f2_arg0:reset( 1000 )
end

local f0_local2 = function ( f3_arg0, f3_arg1, f3_arg2, f3_arg3 )
	local f3_local0 = f3_arg0.itemHeight
	local f3_local1 = CoD.fonts.Condensed
	local f3_local2 = 130
	local self = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = f3_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	} )
	f3_arg0.verticalList:addElement( self )
	self.categoryItem = LUI.UIText.new( {
		left = 0,
		top = 0,
		bottom = f3_local0,
		right = f3_local2,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f3_local1,
		red = CoD.orange.r,
		green = CoD.orange.g,
		blue = CoD.orange.b,
		alpha = 1
	} )
	self:addElement( self.categoryItem )
	self.categoryItem:setText( f3_arg1 )
	self.categoryItem:registerAnimationState( "fading", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.25
	} )
	self.categoryItem:registerAnimationState( "faded", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.05
	} )
	self.textItem = LUI.UIText.new( {
		left = 0,
		top = 0,
		bottom = f3_local0,
		right = 10000,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f3_local1,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	} )
	self:addElement( self.textItem )
	self.textItem:setText( f3_arg2 )
	self.textItem:registerAnimationState( "fading", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.25
	} )
	self.textItem:registerAnimationState( "faded", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.05
	} )
	if f3_arg3 then
		f3_arg0.timer:reset()
		f0_local1( f3_arg0 )
		self.disposable = true
	end
end

CoD.Ticker.new = function ( f4_arg0, f4_arg1, f4_arg2 )
	local self = LUI.UIScrollable.new( f4_arg0, 10000, 10000 )
	self.itemHeight = f4_arg1
	self.verticalList = LUI.UIVerticalList.new( {
		left = 0,
		right = 0,
		top = 0,
		bottom = 10000,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false
	} )
	self:addElement( self.verticalList )
	self.timer = LUI.UITimer.new( f4_arg2, "ticker_tick" )
	LUI.UIElement.addElement( self, self.timer )
	self:registerEventHandler( "ticker_tick", f0_local1 )
	self.addMessage = f0_local2
	self.reset = f0_local0
	return self
end

