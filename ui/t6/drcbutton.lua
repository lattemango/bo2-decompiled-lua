CoD.DrcButton = {}
CoD.DrcButton.EnabledMaterial = "wiiu_drc_button_frame"
CoD.DrcButton.DisabledMaterial = "menu_mp_cac_wcard_line"
CoD.DrcButton.GlowMaterial = "menu_mp_cac_wcard_wc"
CoD.DrcButton.Highlightmaterial = "menu_mp_cac_wcard_hl"
CoD.DrcButton.AnimateUp = 100
CoD.DrcButton.AnimateDown = 225
CoD.DrcButton.WedgeWidth = 108
CoD.DrcButton.WedgeHeight = 68
CoD.DrcButton.WedgeColorUp = {
	red = 0.2,
	green = 0.23,
	blue = 0.29,
	alpha = 1
}
CoD.DrcButton.WedgeColorDown = {
	red = 1,
	green = 0.4,
	blue = 0,
	alpha = 1
}
CoD.DrcButton.Height = 256
CoD.DrcButton.Materials = {
	"menu_mp_bonuscard_primary_gunfighter",
	"menu_mp_bonuscard_secondary_gunfighter",
	"menu_mp_bonuscard_overkill",
	"menu_mp_bonuscard_danger_close",
	"menu_mp_bonuscard_perk_1_greed",
	"menu_mp_bonuscard_perk_2_greed",
	"menu_mp_bonuscard_perk_3_greed"
}
CoD.DrcButton.SetLabel = function ( f1_arg0, f1_arg1 )
	f1_arg0.label.prevText = f1_arg0.label.text
	f1_arg0.label.text = f1_arg1
	f1_arg0.label:setText( f1_arg1 )
end

CoD.DrcButton.GainFocus = function ( f2_arg0, f2_arg1 )
	if f2_arg0.focusedLabelText then
		f2_arg0.label:setText( f2_arg0.focusedLabelText )
	end
	f2_arg0.wedge:animateToState( "button_over" )
	f2_arg0.button.drawnContainer:animateToState( "press_animation_grow", CoD.DrcButton.AnimateUp )
	f2_arg0.label:animateToState( "focused", 0 )
	if f2_arg0.icon then
		f2_arg0.icon:setAlpha( 0 )
	end
end

CoD.DrcButton.LoseFocus = function ( f3_arg0, f3_arg1 )
	if f3_arg0.unfocusedLabelText then
		f3_arg0.label:setText( f3_arg0.unfocusedLabelText )
	end
	f3_arg0.wedge:animateToState( "visible", 0 )
	f3_arg0.button.drawnContainer:animateToState( "default", CoD.DrcButton.AnimateUp )
	f3_arg0.label:animateToState( "default", 0 )
	if f3_arg0.icon then
		f3_arg0.icon:setAlpha( 1 )
	end
end

CoD.DrcButton.SetupLabelFocusedAndUnfocused = function ( f4_arg0, f4_arg1, f4_arg2 )
	f4_arg0.focusedLabelText = f4_arg1
	f4_arg0.unfocusedLabelText = f4_arg2
end

CoD.DrcButton.ButtonAction = function ( f5_arg0, f5_arg1 )
	LUI.UIButton.buttonAction( f5_arg0, f5_arg1 )
end

CoD.DrcButton.PressAnimationGrowComplete = function ( f6_arg0, f6_arg1 )
	
end

CoD.DrcButton.PressAnimationShrinkComplete = function ( f7_arg0, f7_arg1 )
	
end

CoD.DrcButton.SetIcon = function ( f8_arg0, f8_arg1 )
	local self = f8_arg0.icon
	if not self then
		self = LUI.UIImage.new()
		f8_arg0:addElement( self )
		f8_arg0.icon = self
	end
	self:setImage( RegisterMaterial( f8_arg1 ) )
	return self
end

CoD.DrcButton.MouseEnter = function ( f9_arg0, f9_arg1 )
	f9_arg0.drawnContainer.wedge:animateToState( "button_over" )
	LUI.UIButton.MouseEnter( f9_arg0, f9_arg1 )
end

CoD.DrcButton.MouseLeave = function ( f10_arg0, f10_arg1 )
	f10_arg0.drawnContainer.wedge:animateToState( "visible" )
	LUI.UIButton.MouseLeave( f10_arg0, f10_arg1 )
end

CoD.DrcButton.new = function ( f11_arg0, f11_arg1, f11_arg2 )
	local f11_local0 = {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	}
	local self = LUI.UIImage.new( f11_local0 )
	self:setRGB( CoD.DrcButton.WedgeColorUp.red, CoD.DrcButton.WedgeColorUp.green, CoD.DrcButton.WedgeColorUp.blue )
	self.debugName = "DrcButton.wedge"
	self:setImage( RegisterMaterial( CoD.DrcButton.EnabledMaterial ) )
	self:registerAnimationState( "button_over", CoD.DrcButton.WedgeColorDown )
	self:registerAnimationState( "visible", CoD.DrcButton.WedgeColorUp )
	local f11_local2 = LUI.UIText.new( {
		leftAnchor = true,
		rightAnchor = false,
		left = 32,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 64,
		bottom = 64 + CoD.CoD9Button.TextHeight,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	} )
	f11_local2.debugName = "DrcButton.text"
	local f11_local3 = LUI.UIElement.new( f11_local0 )
	f11_local3:addElement( self )
	f11_local3:addElement( f11_local2 )
	f11_local3:registerAnimationState( "press_animation_grow", {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 8,
		right = 8,
		top = 8,
		bottom = 8
	} )
	f11_local3:registerEventHandler( "transition_complete_press_animation_grow", CoD.DrcButton.PressAnimationGrowComplete )
	f11_local3:registerEventHandler( "transition_complete_default", CoD.DrcButton.PressAnimationShrinkComplete )
	f11_local3.wedge = self
	f11_local3.label = f11_local2
	local f11_local4 = LUI.UIButton.new( {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 25,
		right = -28,
		top = 65,
		bottom = -65
	}, f11_arg1 )
	if f11_arg2 then
		f11_local4.debugName = "button.UIButton." .. f11_arg2
	end
	f11_local4:registerEventHandler( "mouseleave", CoD.DrcButton.MouseLeave )
	f11_local4:registerEventHandler( "button_action", CoD.DrcButton.ButtonAction )
	f11_local4.actionSFX = "uin_button_press_drc"
	f11_local4.drawnContainer = f11_local3
	f11_local4:setHandleMouseButton( true )
	if f11_arg0 == nil then
		f11_arg0 = {
			leftAnchor = true,
			rightAnchor = false,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = 256,
			top = 0,
			bottom = 256
		}
	end
	local f11_local5 = LUI.UIElement.new( f11_arg0 )
	f11_local5:addElement( f11_local3 )
	f11_local5:addElement( f11_local4 )
	f11_local5.wedge = self
	f11_local5.label = f11_local2
	f11_local5.button = f11_local4
	f11_local5.setLabel = CoD.DrcButton.SetLabel
	f11_local5.setIcon = CoD.DrcButton.SetIcon
	f11_local5.setupLabelFocusedAndUnfocused = CoD.DrcButton.SetupLabelFocusedAndUnfocused
	f11_local5.setActionEventName = function ( f12_arg0, f12_arg1 )
		f12_arg0.button.actionEventName = f12_arg1
	end
	
	local f11_local6 = function ( f13_arg0, f13_arg1 )
		
	end
	
	f11_local5.gainFocus = f11_local6
	f11_local5.loseFocus = f11_local6
	f11_local4.container = f11_local5
	f11_local5:registerEventHandler( "gain_focus", CoD.DrcButton.GainFocus )
	f11_local5:registerEventHandler( "lose_focus", CoD.DrcButton.LoseFocus )
	return f11_local5
end

