require( "T6.CoD9Button" )

if CoD == nil then
	CoD = {}
end
CoD.ButtonPrompt = {}
CoD.ButtonPrompt.FontName = "ExtraSmall"
CoD.ButtonPrompt.Height = 25
CoD.ButtonPrompt.TextHeight = CoD.textSize[CoD.ButtonPrompt.FontName]
CoD.ButtonPrompt.ButtonToTextSpacing = 3
local f0_local0 = function ( f1_arg0, f1_arg1 )
	f1_arg0.disabled = nil
	f1_arg0:animateToState( "enabled" )
	f1_arg0:dispatchEventToChildren( f1_arg1 )
end

local f0_local1 = function ( f2_arg0, f2_arg1 )
	f2_arg0.disabled = true
	f2_arg0:animateToState( "disabled" )
	f2_arg0:dispatchEventToChildren( f2_arg1 )
end

CoD.ButtonPrompt.Enable = function ( f3_arg0 )
	f3_arg0:processEvent( {
		name = "enable"
	} )
end

CoD.ButtonPrompt.Disable = function ( f4_arg0 )
	f4_arg0:processEvent( {
		name = "disable"
	} )
end

CoD.ButtonPrompt.SetupElement = function ( f5_arg0 )
	f5_arg0:registerEventHandler( "enable", f0_local0 )
	f5_arg0:registerEventHandler( "disable", f0_local1 )
end

CoD.ButtonPrompt.new = function ( f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9 )
	local f6_local0 = CoD.ButtonPrompt.Height
	local f6_local1 = CoD.ButtonPrompt.TextHeight
	local f6_local2 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local self = LUI.UIElement.new()
	self:setTopBottom( false, false, -f6_local0 / 2, f6_local0 / 2 )
	self.button = f6_arg0
	self.enable = CoD.ButtonPrompt.Enable
	self.disable = CoD.ButtonPrompt.Disable
	self.setNew = CoD.ButtonPrompt.SetNew
	self.setText = CoD.ButtonPrompt.SetText
	CoD.ButtonPrompt.SetupElement( self )
	self:registerAnimationState( "enabled", {
		alpha = 1
	} )
	self:registerAnimationState( "disabled", {
		alpha = 1
	} )
	if f6_arg8 then
		self.m_shortcut = true
	end
	if f6_arg2 ~= nil and f6_arg3 ~= nil then
		self:registerEventHandler( "gamepad_button", function ( element, event )
			if not element.disabled and event.down == true then
				if event.button == f6_arg0 and (f6_arg5 == nil or event.qualifier == f6_arg5) then
					if not element.m_shortcut or Engine.LastInput_Gamepad() then
						f6_arg2:processEvent( {
							name = f6_arg3,
							controller = event.controller
						} )
						return true
					end
				elseif CoD.isPC and event.button == "key_shortcut" and (event.key == f6_arg8 or event.bind1 == f6_arg9) then
					f6_arg2:processEvent( {
						name = f6_arg3,
						controller = event.controller
					} )
					return true
				end
			end
		end )
	end
	local f6_local4 = LUI.UIText.new()
	f6_local4:setTopBottom( false, false, -f6_local1 / 2, f6_local1 / 2 )
	f6_local4:setFont( f6_local2 )
	f6_local4:setAlpha( 1 )
	f6_local4:registerAnimationState( "enabled", {
		alpha = 1
	} )
	f6_local4:registerAnimationState( "disabled", {
		alpha = 0.5
	} )
	CoD.ButtonPrompt.SetupElement( f6_local4 )
	self:addElement( f6_local4 )
	f6_local4:setText( f6_arg1 )
	self.label = f6_local4
	self.labelText = f6_arg1
	local f6_local5 = nil
	if not f6_arg4 then
		f6_local5 = LUI.UIText.new()
		f6_local5:setTopBottom( false, false, -f6_local0 / 2, f6_local0 / 2 )
		f6_local5:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
		f6_local5:setFont( f6_local2 )
		f6_local5:setAlpha( 1 )
		if f6_local5 ~= nil then
			if CoD.isPC then
				if f6_arg8 ~= nil then
					f6_local5.shortcutKey = f6_arg8
				end
				if f6_arg7 ~= nil then
					f6_local5.buttonStringShortCut = f6_arg7
				else
					f6_local5.buttonStringShortCut = f6_arg0
				end
			end
			local f6_local6 = nil
			if CoD.useController and Engine.LastInput_Gamepad() then
				f6_local6 = CoD.buttonStrings[f6_arg0]
			elseif CoD.isPC then
				if f6_arg8 then
					f6_local6 = f6_arg8
				elseif string.sub( CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 1, 1 ) == "+" then
					f6_local6 = Engine.GetKeyBindingLocalizedString( 0, CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 0 )
				elseif string.sub( CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 1, 1 ) == "@" then
					f6_local6 = Engine.Localize( string.sub( CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut], 2 ) )
				else
					f6_local6 = CoD.buttonStringsShortCut[f6_local5.buttonStringShortCut]
				end
			end
			f6_local5:setText( f6_local6 )
			self.prompt = f6_local6
			f6_local5:registerAnimationState( "enabled", {
				alpha = 1
			} )
			f6_local5:registerAnimationState( "disabled", {
				alpha = 0.25
			} )
			CoD.ButtonPrompt.SetupElement( f6_local5 )
			self.buttonImage = f6_local5
			self:addElement( f6_local5 )
		end
	end
	if CoD.useMouse and (f6_local5 ~= nil or f6_arg1 ~= "") then
		local f6_local6 = LUI.UIButton.new( {
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		} )
		if f6_local5 ~= nil and isDualButton then
			f6_local5:addElement( f6_local6 )
		else
			self:addElement( f6_local6 )
		end
		if f6_arg2 ~= nil and f6_arg3 ~= nil then
			f6_local6:registerEventHandler( "button_action", function ( element, event )
				f6_arg2:processEvent( {
					name = f6_arg3,
					controller = event.controller
				} )
				return true
			end )
		end
		f6_local6:setHandleMouseMove( false )
		self:setHandleMouseMove( true )
		self:registerEventHandler( "mouseenter", CoD.ButtonPrompt.MouseEnter )
		self:registerEventHandler( "mouseleave", CoD.ButtonPrompt.MouseLeave )
		self:registerEventHandler( "input_source_changed", CoD.ButtonPrompt.InputSourceChanged )
	end
	CoD.ButtonPrompt.ResizeButtonPrompt( self )
	return self
end

CoD.ButtonPrompt.ResizeButtonPrompt = function ( f9_arg0 )
	local f9_local0 = CoD.ButtonPrompt.ButtonToTextSpacing
	local f9_local1 = CoD.ButtonPrompt.Height
	local f9_local2 = CoD.ButtonPrompt.TextHeight
	local f9_local3 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local f9_local4 = {}
	f9_local4 = GetTextDimensions( f9_arg0.labelText, f9_local3, f9_local2 )
	local f9_local5 = f9_local4[3] - f9_local4[1]
	f9_arg0.label:setLeftRight( false, true, -f9_local5, 0 )
	f9_local0 = f9_local0 + f9_local5
	if f9_arg0.prompt ~= nil then
		local f9_local6 = nil
		if string.sub( f9_arg0.prompt, 1, 2 ) == "^B" and not f9_arg0.forceMeasureButtonWidth then
			f9_local6 = CoD.ButtonPrompt.Height
		else
			local f9_local7 = {}
			f9_local7 = GetTextDimensions( f9_arg0.prompt, f9_local3, f9_local1 )
			f9_local6 = f9_local7[3] - f9_local7[1]
		end
		f9_arg0.buttonImage:setLeftRight( true, false, 0, f9_local6 )
		f9_local0 = f9_local0 + f9_local6
	end
	if f9_arg0.newIcon then
		local f9_local6 = 5
		f9_local0 = f9_local0 + f9_local6
		f9_arg0.newIcon:setLeftRight( true, false, f9_local0, f9_local0 + CoD.CACUtility.ButtonGridNewImageWidth )
		f9_arg0.label:setLeftRight( false, true, -f9_local5 - CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f9_local6, -CoD.CACUtility.ButtonGridNewImageRightAlignWidth - f9_local6 )
		f9_local0 = f9_local0 + CoD.CACUtility.ButtonGridNewImageRightAlignWidth
	end
	f9_arg0:setLeftRight( true, false, 0, f9_local0 )
end

CoD.ButtonPrompt.InputSourceChanged = function ( f10_arg0, f10_arg1 )
	if f10_arg0.buttonImage == nil then
		return 
	elseif CoD.useMouse then
		if CoD.useController and f10_arg1.source == 0 then
			f10_arg0.prompt = CoD.buttonStrings[f10_arg0.button]
			f10_arg0.buttonImage:setText( f10_arg0.prompt )
		else
			if f10_arg0.buttonImage.shortcutKey then
				f10_arg0.prompt = f10_arg0.buttonImage.shortcutKey
			elseif string.sub( CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 1, 1 ) == "+" then
				f10_arg0.prompt = Engine.GetKeyBindingLocalizedString( 0, CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 0 )
			elseif string.sub( CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 1, 1 ) == "@" then
				f10_arg0.prompt = Engine.Localize( string.sub( CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut], 2 ) )
			else
				f10_arg0.prompt = CoD.buttonStringsShortCut[f10_arg0.buttonImage.buttonStringShortCut]
			end
			f10_arg0.buttonImage:setText( f10_arg0.prompt )
		end
		CoD.ButtonPrompt.ResizeButtonPrompt( f10_arg0 )
	end
end

CoD.ButtonPrompt.SetNew = function ( f11_arg0, f11_arg1 )
	if f11_arg1 then
		if not f11_arg0.newIcon then
			local newIcon = LUI.UIImage.new()
			newIcon:setLeftRight( true, false, 0, CoD.CACUtility.ButtonGridNewImageWidth )
			newIcon:setTopBottom( false, false, -CoD.CACUtility.ButtonGridNewImageHeight / 2, CoD.CACUtility.ButtonGridNewImageHeight / 2 )
			newIcon:setImage( RegisterMaterial( CoD.CACUtility.NewImageMaterial ) )
			f11_arg0:addElement( newIcon )
			f11_arg0.newIcon = newIcon
			
		end
	elseif f11_arg0.newIcon then
		f11_arg0.newIcon:close()
		f11_arg0.newIcon = nil
	end
	CoD.ButtonPrompt.ResizeButtonPrompt( f11_arg0 )
end

CoD.ButtonPrompt.SetText = function ( f12_arg0, f12_arg1 )
	f12_arg0.label:setText( f12_arg1 )
	f12_arg0.labelText = f12_arg1
	CoD.ButtonPrompt.ResizeButtonPrompt( f12_arg0 )
end

CoD.ButtonPrompt.MouseEnter = function ( f13_arg0, f13_arg1 )
	if f13_arg0.buttonImage == nil then
		return 
	else
		f13_arg0.buttonImage:beginAnimation( "pop", 50 )
		f13_arg0.buttonImage:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
	end
end

CoD.ButtonPrompt.MouseLeave = function ( f14_arg0, f14_arg1 )
	if f14_arg0.buttonImage == nil then
		return 
	else
		local f14_local0 = CoD.ButtonPrompt.TextHeight
		f14_arg0.buttonImage:beginAnimation( "default", 50 )
		f14_arg0.buttonImage:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
	end
end

