require( "LUI.LUITouchpadButton" )

LUI.UITouchpadRadioButton = {}
LUI.UITouchpadRadioButton.Groups = {}
LUI.UITouchpadRadioButton.TouchpadDownDelay = function ( f1_arg0, f1_arg1 )
	if f1_arg0.touchpadDownX and not f1_arg0.m_down then
		f1_arg0:processEvent( {
			name = "button_over_down",
			controller = f1_arg1.controller
		} )
	end
	f1_arg0.buttonDownTimer = nil
	f1_arg0.buttonDownAnimFinished = false
end

LUI.UITouchpadRadioButton.TouchpadUp = function ( f2_arg0, f2_arg1 )
	local f2_local0 = f2_arg0.touchpadDownX
	local f2_local1 = f2_arg0.touchpadDownY
	f2_arg0.touchpadDownX = nil
	f2_arg0.touchpadDownY = nil
	local f2_local2 = nil
	if f2_arg0.buttonDownTimer then
		f2_arg0.buttonDownTimer:close()
		f2_arg0.buttonDownTimer = nil
		f2_local2 = true
	end
	if (not (not f2_arg1.inside or not f2_local0) or f2_arg1.force) and not f2_arg0.disabled then
		local f2_local3 = f2_arg1.x - f2_local0
		local f2_local4 = f2_arg1.y - f2_local1
		if f2_local3 * f2_local3 + f2_local4 * f2_local4 < CoD.Wiiu.DRAG_THRESHOLD_SQUARED or f2_arg1.force then
			if not f2_arg0.downAnimationCompleteEvent then
				LUI.UIButton.buttonAction( f2_arg0, {
					name = "button_action",
					controller = f2_arg1.controller,
					mouse = true
				} )
			elseif f2_local2 then
				f2_arg0.buttonClicked = true
				f2_arg0:processEvent( {
					name = "button_over_down",
					controller = f2_arg1.controller
				} )
			elseif f2_arg0.buttonDownAnimFinished then
				f2_arg0.buttonClicked = true
				LUI.UITouchpadRadioButton.DownAnimationComplete( f2_arg0, f2_arg1 )
			elseif f2_arg0.downAnimationCompleteEvent then
				f2_arg0.buttonClicked = true
				LUI.UITouchpadRadioButton.DownAnimationComplete( f2_arg0, f2_arg1 )
			end
		else
			f2_arg0:processEvent( LUI.UITouchpadRadioButton.ButtonUpEvent )
		end
	end
end

LUI.UITouchpadRadioButton.DownAnimationComplete = function ( f3_arg0, f3_arg1 )
	if f3_arg0.buttonClicked then
		LUI.UIButton.buttonAction( f3_arg0, {
			name = "button_action",
			controller = 0,
			mouse = true
		} )
		if f3_arg0.m_down then
			f3_arg0:addElement( LUI.UITimer.new( 333, LUI.UITouchpadButton.ButtonUpEvent, true, f3_arg0 ) )
			f3_arg0.m_down = false
		else
			f3_arg0.m_down = true
			if f3_arg0.buttonGroup then
				local f3_local0 = f3_arg0.buttonGroup.pressedButton
				if f3_local0 and f3_local0 ~= f3_arg0 then
					f3_local0:processEvent( LUI.UITouchpadButton.ButtonUpEvent )
					f3_local0.m_down = false
				end
				f3_arg0.buttonGroup.pressedButton = f3_arg0
			end
		end
	end
	f3_arg0.buttonClicked = false
	f3_arg0.buttonDownAnimFinished = true
end

LUI.UITouchpadRadioButton.ClearGroup = function ( f4_arg0 )
	LUI.UITouchpadRadioButton.Groups[f4_arg0.m_groupId] = nil
end

local f0_local0 = function ( f5_arg0 )
	f5_arg0:registerEventHandler( "leftmousedown", function ( element, event )
		if not element.m_down then
			LUI.UITouchpadButton.TouchpadDown( element, event )
		end
	end )
end

LUI.UITouchpadRadioButton.new = function ( f7_arg0, f7_arg1, f7_arg2 )
	local self = LUI.UITouchpadButton.new( f7_arg0, f7_arg1 )
	self.m_groupId = f7_arg2
	self.disableButtonUpOnClick = f0_local0
	self:registerEventHandler( "leftmouseup", LUI.UITouchpadRadioButton.TouchpadUp )
	self:registerEventHandler( "touchpad_down_delay", LUI.UITouchpadRadioButton.TouchpadDownDelay )
	self:registerEventHandler( "touchpad_down_animation_complete", LUI.UITouchpadRadioButton.DownAnimationComplete )
	if f7_arg2 then
		local f7_local1 = LUI.UITouchpadRadioButton.Groups[f7_arg2]
		if not f7_local1 then
			f7_local1 = {
				buttons = {},
				pressedButton = nil
			}
			LUI.UITouchpadRadioButton.Groups[f7_arg2] = f7_local1
		end
		f7_local1.buttons[1 + table.getn( f7_local1.buttons )] = self
		self.buttonGroup = f7_local1
	end
	return self
end

