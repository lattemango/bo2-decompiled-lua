require( "T6.DrcButton" )
require( "T6.TouchpadVerticalList" )

CoD.DrcButtonList = {}
CoD.DrcButtonList.ButtonSpacing = -100
CoD.DrcButtonList.DefaultWidth = 256
CoD.DrcButtonList.DefaultHeight = 256
CoD.DrcButtonList.TouchpadMoveEpsilon = 5
CoD.DrcButtonList.ScrollFriction = 0.05
CoD.DrcButtonList.AddButton = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5 )
	local f1_local0 = CoD.DrcButton.new( {
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = CoD.DrcButtonList.DefaultWidth,
		top = 0,
		bottom = CoD.DrcButtonList.DefaultHeight
	}, f1_arg5 )
	f1_local0:setLabel( f1_arg2 )
	f1_local0.getHeight = function ( f2_arg0 )
		return 150
	end
	
	f1_local0:setupLabelFocusedAndUnfocused( "NEXT CLASS", f1_arg2 )
	f1_arg0:addElement( f1_local0 )
	local f1_local1, f1_local2, f1_local3, f1_local4 = GetTextDimensions( f1_arg1, CoD.fonts.Condensed, CoD.textSize.Condensed )
	local f1_local5 = f1_local4 - f1_local2
	f1_local0.label:registerAnimationState( "focused", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = -f1_local3 / 2,
		right = f1_local3 / 2,
		top = f1_local5 / 2 - 5,
		bottom = -f1_local5 / 2 - 5
	} )
	if f1_arg0.gainFocusSFX ~= nil then
		f1_local0.gainFocusSFX = f1_arg0.gainFocusSFX
	end
	if f1_arg0.actionSFX ~= nil then
		f1_local0.actionSFX = f1_arg0.actionSFX
	end
	return f1_local0
end

CoD.DrcButtonList.AddText = function ( menu, controller )
	local self = LUI.UIText.new( {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	} )
	self:setText( controller )
	menu:addElement( self )
	return self
end

CoD.DrcButtonList.new = function ( f4_arg0, f4_arg1 )
	if not f4_arg0 then
		f4_arg0 = CoD.DrcButtonList.ButtonSpacing
	end
	local f4_local0 = CoD.TouchpadVerticalList.new( f4_arg1, f4_arg0 )
	f4_local0.addButton = CoD.DrcButtonList.AddButton
	f4_local0.addText = CoD.DrcButtonList.AddText
	f4_local0.list.tickDistance = 150
	f4_local0.list.tickSound = "uin_scroll_tick_drc"
	f4_local0.addSpacer = function ( f5_arg0, f5_arg1 )
		
	end
	
	return f4_local0
end

