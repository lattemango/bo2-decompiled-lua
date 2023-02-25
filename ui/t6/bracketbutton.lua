require( "T6.Brackets" )

CoD.BracketButton = {}
local f0_local0, f0_local1 = nil
CoD.BracketButton.new = function ( menu, controller )
	local self = LUI.UIButton.new( menu, controller )
	local f1_local1 = CoD.Brackets.new( 12 )
	f1_local1:processEvent( {
		name = "fade",
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b,
		alpha = 1
	} )
	f1_local1:setPriority( 100 )
	self:addElement( f1_local1 )
	LUI.UIButton.SetupElement( f1_local1 )
	f1_local1:registerAnimationState( "default", {
		alphaMultiplier = 0
	} )
	f1_local1:animateToState( "default" )
	f1_local1:registerAnimationState( "button_over", {
		alphaMultiplier = 1
	} )
	self.brackets = f1_local1
	self.setHintText = CoD.BracketButton.SetHintText
	return self
end

CoD.BracketButton.SetHintText = function ( f2_arg0, f2_arg1, f2_arg2 )
	local self = f2_arg0.hintTextListener
	if self == nil then
		if f2_arg2 == nil then
			return 
		end
		self = LUI.UIElement.new()
		f2_arg0:addElement( self )
		self:registerEventHandler( "gain_focus", f0_local0 )
		self:registerEventHandler( "lose_focus", f0_local1 )
		f2_arg0.hintTextListener = self
	end
	if f2_arg2 ~= nil then
		self.hintTextElement = f2_arg2
	end
	if f2_arg1 ~= nil then
		self.hintText = f2_arg1
	end
end

f0_local0 = function ( f3_arg0, f3_arg1 )
	local f3_local0 = f3_arg0.hintTextElement
	local f3_local1 = f3_arg0.hintText
	if f3_local0 ~= nil and f3_local1 ~= nil then
		f3_local0:updateText( f3_local1 )
	end
end

f0_local1 = function ( f4_arg0, f4_arg1 )
	local f4_local0 = f4_arg0.hintTextElement
	if f4_local0 ~= nil then
		f4_local0:removeText()
	end
end

