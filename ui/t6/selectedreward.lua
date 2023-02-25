CoD.SelectedReward = {}
CoD.SelectedReward.New = function ( menu, controller )
	local self = LUI.UIElement.new( menu )
	local f1_local1 = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1
	} )
	self.backgroundContainer = f1_local1
	self:addElement( f1_local1 )
	f1_local1:addElement( CoD.Border.new( 1, 1, 1, 1, 0.1 ) )
	local f1_local2 = LUI.UIElement.new()
	f1_local2:setLeftRight( true, true, 1, -1 )
	f1_local2:setTopBottom( true, true, 1, -1 )
	f1_local2:setUseStencil( true )
	self:addElement( f1_local2 )
	local f1_local3 = 7
	self.itemImage = LUI.UIImage.new( {
		leftAnchor = false,
		rightAnchor = false,
		left = -controller / 2,
		right = controller / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local3 + -controller / 2,
		bottom = f1_local3 + controller / 2,
		alpha = 0
	} )
	f1_local2:addElement( self.itemImage )
	local f1_local4 = 0
	self.cost = LUI.UIText.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = f1_local4,
		bottom = f1_local4 + CoD.textSize.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Default
	} )
	self:addElement( self.cost )
	return self
end

CoD.SelectedReward.Update = function ( f2_arg0, f2_arg1 )
	if f2_arg1 == nil then
		f2_arg0.cost:setText( "" )
		f2_arg0.itemImage:animateToState( "default" )
	else
		f2_arg0.cost:setText( f2_arg1.momentumCost )
		f2_arg0.itemImage:registerAnimationState( "change_material", {
			material = RegisterMaterial( UIExpression.GetItemImage( nil, f2_arg1.itemIndex ) .. "_menu" ),
			alpha = 1
		} )
		f2_arg0.itemImage:animateToState( "change_material" )
	end
end

