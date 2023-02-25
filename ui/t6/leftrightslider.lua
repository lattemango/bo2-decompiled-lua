CoD.LeftRightSlider = {}
CoD.LeftRightSlider.Width = 100
CoD.LeftRightSlider.Height = 32
CoD.LeftRightSlider.Speed = 0.3
CoD.LeftRightSlider.NumDashes = 20
CoD.LeftRightSlider.LeftRightSelectorGainFocusEvent = {
	name = "left_right_slider_gain_focus"
}
CoD.LeftRightSlider.LeftRightSelectorLoseFocusEvent = {
	name = "left_right_slider_lose_focus"
}
CoD.LeftRightSlider.HandleGamepadInput = function ( f1_arg0, f1_arg1 )
	if LUI.UIElement.handleGamepadButton( f1_arg0, f1_arg1 ) == true then
		return true
	elseif f1_arg0:isInFocus() and f1_arg0.m_allowValueUpdate ~= false then
		if f1_arg1.button == "left" then
			if f1_arg1.down == true then
				f1_arg0:updateSlideDirection( -1 )
				f1_arg0:addElement( f1_arg0.m_timer )
			else
				f1_arg0:updateSlideDirection( nil )
				f1_arg0.m_timer:close()
			end
		elseif f1_arg1.button == "right" then
			if f1_arg1.down == true then
				f1_arg0:updateSlideDirection( 1 )
				f1_arg0:addElement( f1_arg0.m_timer )
			else
				f1_arg0:updateSlideDirection( nil )
				f1_arg0.m_timer:close()
			end
		end
	end
end

CoD.LeftRightSlider.UpdateBar = function ( f2_arg0, f2_arg1 )
	local f2_local0 = nil
	local f2_local1 = f2_arg0.m_barMin
	local f2_local2 = f2_arg0.m_barMax
	local f2_local3 = f2_arg0.m_sliderCallback
	if not f2_arg0:isInFocus() then
		f2_arg0.m_slideDirection = nil
	end
	local f2_local4 = f2_arg0.m_slideDirection
	local f2_local5 = math.floor( (f2_arg0.m_currentValue - f2_local1) * 100 / (f2_local2 - f2_local1) / 5 )
	if f2_local4 ~= nil and f2_arg1 ~= nil then
		f2_local0 = f2_arg0.m_currentValue + (f2_local2 - f2_local1) * f2_arg0.m_barSpeed * f2_local4 * f2_arg1.timeElapsed / 1000
		if f2_local0 < f2_local1 then
			f2_local0 = f2_arg0.m_barMin
		end
		if f2_local2 < f2_local0 then
			f2_local0 = f2_local2
		end
		f2_arg0.m_currentValue = f2_local0
	else
		f2_local0 = f2_arg0.m_currentValue
	end
	local f2_local6 = math.floor( (f2_local0 - f2_local1) * 100 / (f2_local2 - f2_local1) / 5 )
	if f2_arg0.m_sfx ~= nil and f2_local5 ~= nil and f2_local5 ~= f2_local6 then
		Engine.PlaySound( f2_arg0.m_sfx )
	end
	f2_arg0.bar:setupDashes( f2_arg0.m_numDashes, f2_local6, 0, 8 )
	if f2_arg0.numericDisplay then
		f2_arg0.numericDisplay:setText( string.format( f2_arg0.m_formatString, f2_local0 ) )
	end
	if f2_local3 ~= nil then
		f2_local3( f2_arg0, f2_local0 )
	end
end

CoD.LeftRightSlider.UpdateBarFromProfile = function ( f3_arg0, f3_arg1 )
	if f3_arg1.isProfileFloat then
		f3_arg0.m_currentValue = UIExpression.ProfileFloat( f3_arg1.controller, f3_arg0.m_profileVarName )
	else
		f3_arg0.m_currentValue = Engine.GetProfileVarInt( f3_arg1.controller, f3_arg0.m_profileVarName )
	end
	CoD.LeftRightSlider.UpdateBar( f3_arg0 )
end

CoD.LeftRightSlider.SetSliderCallback = function ( f4_arg0, f4_arg1 )
	f4_arg0.m_sliderCallback = f4_arg1
end

CoD.LeftRightSlider.SetBarSpeed = function ( f5_arg0, f5_arg1 )
	f5_arg0.m_barSpeed = f5_arg1
end

CoD.LeftRightSlider.GainFocus = function ( f6_arg0, f6_arg1 )
	CoD.CoD9Button.GainFocus( f6_arg0, f6_arg1 )
	f6_arg0:dispatchEventToParent( CoD.LeftRightSlider.LeftRightSelectorGainFocusEvent )
	if f6_arg0.m_allowCycling == false and not f6_arg0.disabled then
		f6_arg0:dispatchEventToParent( CoD.LeftRightSlider.LeftRightSelectorLoseFocusEvent )
	end
	if f6_arg0.promptContainer and not Engine.LastInput_Gamepad() and f6_arg0.m_allowValueUpdate ~= false then
		f6_arg0.promptContainer:beginAnimation( "fade_in", 100 )
		f6_arg0.promptContainer:setAlpha( 1 )
	end
end

CoD.LeftRightSlider.LoseFocus = function ( f7_arg0, f7_arg1 )
	CoD.CoD9Button.LoseFocus( f7_arg0, f7_arg1 )
	f7_arg0:dispatchEventToParent( CoD.LeftRightSelector.LeftRightSelectorLoseFocusEvent )
	if f7_arg0.promptContainer then
		f7_arg0.promptContainer:beginAnimation( "fade_out", 100 )
		f7_arg0.promptContainer:setAlpha( 0 )
	end
end

CoD.LeftRightSlider.new = function ( f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7 )
	local f8_local0 = CoD.OptionElement.new( f8_arg0, f8_arg1, f8_arg6 )
	if f8_arg2 == nil then
		f8_arg2 = CoD.LeftRightSlider.Width
	end
	f8_local0.id = "LRSlider." .. f8_arg0
	f8_local0.m_sfx = f8_arg7
	f8_local0.m_numDashes = CoD.LeftRightSlider.NumDashes
	if f8_arg3 == nil then
		f8_local0.m_currentValue = (f8_arg4 + f8_arg5) / 2
	else
		f8_local0.m_currentValue = f8_arg3
	end
	if CoD.isPC then
		f8_local0.horizontalList:addSpacer( 20 )
	end
	f8_local0.bar = LUI.UIElement.new()
	f8_local0.bar:setLeftRight( true, false, 0, 16 )
	f8_local0.bar:setTopBottom( false, false, -CoD.LeftRightSlider.Height / 2, CoD.LeftRightSlider.Height / 2 )
	f8_local0.horizontalList:addElement( f8_local0.bar )
	f8_local0.bar:setupDashes( f8_local0.m_numDashes, 0, 0, 18 )
	f8_local0.m_timer = LUI.UITimer.new( 1, "update_bar", false )
	if CoD.isPC then
		local f8_local1 = 160
		local f8_local2 = LUI.UIElement.new()
		f8_local2:setLeftRight( true, false, 0, f8_local1 )
		f8_local2:setTopBottom( true, true, 0, 0 )
		f8_local2:setHandleMouse( true )
		f8_local0.bar:addElement( f8_local2 )
		f8_local2:registerEventHandler( "leftmousedown", CoD.NullFunction )
		f8_local2:registerEventHandler( "leftmouseup", CoD.LeftRightSlider.SliderMouseListener_Update )
		f8_local2:registerEventHandler( "mousedrag", CoD.LeftRightSlider.SliderMouseListener_Update )
		f8_local0.m_formatString = "%.2f"
		f8_local0.setNumericDisplayFormatString = CoD.LeftRightSlider.SetNumericDisplayFormatString
		f8_local0.setRoundToFraction = CoD.LeftRightSlider.SetRoundToFraction
		f8_local0.setStepValue = CoD.LeftRightSlider.SetStepValue
		local f8_local3 = "ExtraSmall"
		local f8_local4 = LUI.UIText.new()
		f8_local4:setLeftRight( true, false, 0, 1 )
		f8_local4:setTopBottom( false, false, -CoD.textSize[f8_local3] / 2, CoD.textSize[f8_local3] / 2 )
		f8_local4:setText( string.format( f8_local0.m_formatString, f8_local0.m_currentValue ) )
		f8_local0.numericDisplay = f8_local4
		f8_local0.horizontalList:addSpacer( f8_local1 )
		f8_local0.horizontalList:addElement( f8_local4 )
	end
	f8_local0.m_barWidth = f8_arg2
	f8_local0.m_barMin = f8_arg4
	f8_local0.m_barMax = f8_arg5
	f8_local0.m_barSpeed = CoD.LeftRightSlider.Speed
	f8_local0.handleGamepadButton = CoD.LeftRightSlider.HandleGamepadInput
	f8_local0.setSliderCallback = CoD.LeftRightSlider.SetSliderCallback
	f8_local0.setBarSpeed = CoD.LeftRightSlider.SetBarSpeed
	f8_local0.updateSlideDirection = CoD.LeftRightSlider.UpdateSlideDirection
	f8_local0.enableCycling = CoD.LeftRightSlider.EnableCycling
	f8_local0.disableCycling = CoD.LeftRightSlider.DisableCycling
	f8_local0:registerEventHandler( "update_bar", CoD.LeftRightSlider.UpdateBar )
	f8_local0:registerEventHandler( "update_bar_from_profile", CoD.LeftRightSlider.UpdateBarFromProfile )
	f8_local0:registerEventHandler( "mouse_bar_update", CoD.LeftRightSlider.MouseBarUpdate )
	f8_local0:registerEventHandler( "gain_focus", CoD.LeftRightSlider.GainFocus )
	f8_local0:registerEventHandler( "lose_focus", CoD.LeftRightSlider.LoseFocus )
	CoD.LeftRightSlider.UpdateBar( f8_local0 )
	return f8_local0
end

CoD.LeftRightSlider.EnableCycling = function ( f9_arg0, f9_arg1 )
	f9_arg0.m_allowValueUpdate = true
	f9_arg0:enable()
end

CoD.LeftRightSlider.DisableCycling = function ( f10_arg0, f10_arg1 )
	f10_arg0.m_allowValueUpdate = false
	f10_arg0:disable()
end

CoD.LeftRightSlider.SetCurrentValue = function ( f11_arg0, f11_arg1 )
	f11_arg0.m_currentValue = f11_arg1
	CoD.LeftRightSlider.UpdateBar( f11_arg0 )
end

CoD.LeftRightSlider.SetNumericDisplayFormatString = function ( f12_arg0, f12_arg1 )
	f12_arg0.m_formatString = f12_arg1
	f12_arg0:updateSlideDirection( nil )
	f12_arg0:addElement( f12_arg0.m_timer )
end

CoD.LeftRightSlider.SetRoundToFraction = function ( f13_arg0, f13_arg1 )
	f13_arg0.m_roundFraction = f13_arg1
end

CoD.LeftRightSlider.SetStepValue = function ( f14_arg0, f14_arg1 )
	if f14_arg1 and 0 < f14_arg1 then
		f14_arg0.m_step = f14_arg1
	end
end

CoD.LeftRightSlider.SliderMouseListener_Update = function ( f15_arg0, f15_arg1 )
	local f15_local0, f15_local1, f15_local2, f15_local3 = f15_arg0:getRect()
	f15_arg0:dispatchEventToParent( {
		name = "mouse_bar_update",
		controller = f15_arg1.controller,
		fraction = (f15_arg1.x - f15_local0) / (f15_local2 - f15_local0)
	} )
end

CoD.LeftRightSlider.MouseBarUpdate = function ( f16_arg0, f16_arg1 )
	local f16_local0 = nil
	local f16_local1 = f16_arg0.m_barMin
	local f16_local2 = f16_arg0.m_barMax
	local f16_local3 = f16_arg0.m_sliderCallback
	if not f16_arg0:isInFocus() or f16_arg0.m_allowValueUpdate == false then
		return 
	end
	f16_local0 = (f16_arg0.m_barMax - f16_arg0.m_barMin) * f16_arg1.fraction + f16_arg0.m_barMin
	if f16_arg0.m_roundFraction then
		f16_local0 = math.ceil( f16_local0 / f16_arg0.m_roundFraction ) * f16_arg0.m_roundFraction
	end
	if f16_arg0.m_step then
		f16_local0 = math.floor( (f16_local0 + f16_arg0.m_step / 2) / f16_arg0.m_step ) * f16_arg0.m_step
	end
	local f16_local4 = math.floor( (f16_arg0.m_currentValue - f16_local1) * 100 / (f16_local2 - f16_local1) / 5 )
	if f16_local0 < f16_local1 then
		f16_local0 = f16_arg0.m_barMin
	end
	if f16_local2 < f16_local0 then
		f16_local0 = f16_local2
	end
	f16_arg0.m_currentValue = f16_local0
	local f16_local5 = math.floor( (f16_local0 - f16_local1) * 100 / (f16_local2 - f16_local1) / 5 )
	if f16_arg0.m_sfx ~= nil and f16_local4 ~= nil and f16_local4 ~= f16_local5 then
		Engine.PlaySound( f16_arg0.m_sfx )
	end
	f16_arg0.bar:setupDashes( f16_arg0.m_numDashes, f16_local5, 0, 8 )
	if f16_arg0.numericDisplay then
		f16_arg0.numericDisplay:setText( string.format( f16_arg0.m_formatString, f16_local0 ) )
	end
	if f16_local3 ~= nil then
		f16_local3( f16_arg0, f16_local0 )
	end
end

CoD.LeftRightSlider.UpdateSlideDirection = function ( f17_arg0, f17_arg1 )
	f17_arg0.m_slideDirection = f17_arg1
end

