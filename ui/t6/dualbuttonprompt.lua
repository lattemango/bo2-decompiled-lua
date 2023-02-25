require( "T6.ButtonPrompt" )

if CoD == nil then
	CoD = {}
end
CoD.DualButtonPrompt = {}
CoD.DualButtonPrompt.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, f1_arg10, f1_arg11, f1_arg12 )
	local f1_local0 = CoD.ButtonPrompt.TextHeight
	local f1_local1 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local f1_local2, f1_local3, f1_local4, f1_local5 = GetTextDimensions( f1_arg1, f1_local1, f1_local0 )
	local f1_local6 = CoD.ButtonPrompt.Height
	local f1_local7 = f1_local4 + f1_local6 + CoD.ButtonPrompt.ButtonToTextSpacing + f1_local6 + CoD.ButtonPrompt.ButtonToTextSpacing
	local f1_local8 = 0
	local f1_local9 = f1_local7
	local f1_local10 = true
	local f1_local11 = false
	if f1_arg7 == LUI.Alignment.Right then
		f1_local11 = true
		f1_local10 = false
		f1_local8 = -f1_local7
		f1_local9 = 0
	end
	if f1_arg7 == LUI.Alignment.Center then
		f1_local11 = false
		f1_local10 = false
		f1_local8 = -(f1_local7 / 2) + f1_arg8
		f1_local9 = f1_local7 / 2 + f1_arg8
	end
	local self = LUI.UIHorizontalList.new( {
		left = f1_local8,
		top = -CoD.ButtonPrompt.Height / 2,
		right = f1_local9,
		bottom = CoD.ButtonPrompt.Height / 2,
		leftAnchor = f1_local10,
		topAnchor = false,
		rightAnchor = f1_local11,
		bottomAnchor = false,
		alignment = f1_arg7
	} )
	self.id = self.id .. ".DualButtonPrompt"
	self.enable = CoD.ButtonPrompt.Enable
	self.disable = CoD.ButtonPrompt.Disable
	CoD.ButtonPrompt.SetupElement( self )
	self:registerAnimationState( "enabled", {
		alpha = 1
	} )
	self:registerAnimationState( "disabled", {
		alpha = 1
	} )
	if f1_arg12 then
		self.m_shortcut = true
	end
	if f1_arg3 ~= nil and f1_arg5 ~= nil then
		self:registerEventHandler( "gamepad_button", function ( element, event )
			if not element.disabled and event.down == true then
				if event.button == f1_arg2 then
					if not element.m_shortcut or Engine.LastInput_Gamepad() then
						f1_arg3:processEvent( {
							name = f1_arg5,
							controller = event.controller
						} )
						return true
					end
				elseif CoD.isPC and event.button == "key_shortcut" and event.key == f1_arg12 then
					f1_arg3:processEvent( {
						name = f1_arg5,
						controller = event.controller
					} )
					return true
				end
			end
			element:dispatchEventToChildren( event )
		end )
	end
	self.leftButton = CoD.ButtonPrompt.new( f1_arg0, f1_arg1, f1_arg3, f1_arg4, f1_arg6, nil, true, f1_arg9, f1_arg11 )
	if f1_arg7 ~= LUI.Alignment.Right then
		self:addElement( self.leftButton )
	end
	local f1_local13 = nil
	if not f1_arg6 then
		f1_local13 = LUI.UIText.new()
		f1_local13:setLeftRight( true, false, 0, f1_local6 )
		f1_local13:setTopBottom( false, false, -CoD.ButtonPrompt.Height / 2, CoD.ButtonPrompt.Height / 2 )
		f1_local13:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
		f1_local13:setFont( f1_local1 )
		f1_local13:setAlpha( 1 )
		if f1_local13 ~= nil then
			if CoD.isPC then
				if f1_arg10 ~= nil then
					f1_local13.buttonStringShortCut = f1_arg10
				else
					f1_local13.buttonStringShortCut = f1_arg2
				end
			end
			if CoD.useController and Engine.LastInput_Gamepad() then
				f1_local13:setText( CoD.buttonStrings[f1_arg2] )
			elseif CoD.isPC then
				if not f1_arg12 then
					if string.sub( CoD.buttonStringsShortCut[f1_local13.buttonStringShortCut], 1, 1 ) == "+" then
						f1_arg12 = Engine.GetKeyBindingLocalizedString( 0, CoD.buttonStringsShortCut[f1_local13.buttonStringShortCut], 0 )
					else
						f1_arg12 = CoD.buttonStringsShortCut[f1_local13.buttonStringShortCut]
					end
				end
				f1_local13:setText( f1_arg12 )
				f1_local13.shortCutKey = f1_arg12
			end
			if CoD.useMouse then
				f1_local13.button = f1_arg2
				f1_local13:registerEventHandler( "input_source_changed", CoD.DualButtonPrompt.InputSourceChanged )
				f1_local13:registerEventHandler( "mouseenter", CoD.DualButtonPrompt.MouseEnter )
				f1_local13:registerEventHandler( "mouseleave", CoD.DualButtonPrompt.MouseLeave )
				f1_local13:setHandleMouseMove( true )
			end
			f1_local13:registerAnimationState( "enabled", {
				alpha = 1
			} )
			f1_local13:registerAnimationState( "disabled", {
				alpha = 0.25
			} )
			if f1_arg7 ~= LUI.Alignment.Right then
				self:addSpacer( CoD.ButtonPrompt.ButtonToTextSpacing )
			end
			CoD.ButtonPrompt.SetupElement( f1_local13 )
			self:addElement( f1_local13 )
			if f1_arg7 == LUI.Alignment.Right then
				self:addSpacer( CoD.ButtonPrompt.ButtonToTextSpacing )
			end
		end
	end
	if CoD.useMouse then
		local f1_local14 = LUI.UIButton.new( {
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		} )
		if f1_local13 ~= nil then
			f1_local13:addElement( f1_local14 )
		else
			self:addSpacer( f1_local6 )
			self:addElement( f1_local14 )
		end
		if f1_arg3 ~= nil and f1_arg5 ~= nil then
			f1_local14:registerEventHandler( "button_action", function ( element, event )
				f1_arg3:processEvent( {
					name = f1_arg5,
					controller = event.controller
				} )
				return true
			end )
		end
		f1_local14:setHandleMouseMove( false )
	end
	if f1_arg7 == LUI.Alignment.Right then
		self:addElement( self.leftButton )
	end
	return self
end

CoD.DualButtonPrompt.InputSourceChanged = function ( f4_arg0 )
	if CoD.useMouse then
		if CoD.useController and Engine.LastInput_Gamepad() then
			f4_arg0:setText( CoD.buttonStrings[f4_arg0.button] )
		else
			local f4_local0 = nil
			if f4_arg0.shortCutKey then
				f4_local0 = f4_arg0.shortCutKey
			elseif string.sub( CoD.buttonStringsShortCut[f4_arg0.buttonStringShortCut], 1, 1 ) == "+" then
				f4_local0 = Engine.GetKeyBindingLocalizedString( 0, CoD.buttonStringsShortCut[f4_arg0.buttonStringShortCut], 0 )
			else
				f4_local0 = CoD.buttonStringsShortCut[f4_arg0.buttonStringShortCut]
			end
			f4_arg0:setText( f4_local0 )
		end
	end
end

CoD.DualButtonPrompt.MouseEnter = function ( f5_arg0, f5_arg1 )
	f5_arg0:beginAnimation( "pop", 50 )
	f5_arg0:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
end

CoD.DualButtonPrompt.MouseLeave = function ( f6_arg0, f6_arg1 )
	local f6_local0 = CoD.ButtonPrompt.TextHeight
	f6_arg0:beginAnimation( "default", 50 )
	f6_arg0:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
end

