require( "T6.DrcButton" )
require( "T6.Drc.DrcPopup" )

CoD.DrcOutput = {}
CoD.DrcOutput.DisplayTv = 0
CoD.DrcOutput.DisplayDrc = 1
CoD.DrcOutput.ShowSingleClient = 0
CoD.DrcOutput.ShowSplitScreen = 1
CoD.DrcOutput.ShowSecondScreen = 2
CoD.DrcOutput.ShowLUIDrcRoot = 3
CoD.DrcOutput.ShowDisabled = 4
local f0_local0 = function ( f1_arg0, f1_arg1 )
	if f1_arg1 then
		local f1_local0 = nil
		if Engine.IsSplitscreen() then
			f1_local0 = CoD.DrcOutput.ShowSecondScreen
		else
			f1_local0 = CoD.DrcOutput.ShowSingleClient
		end
		local f1_local1, f1_local2 = Engine.WiiUGetDisplayConfiguration( CoD.DrcOutput.DisplayDrc )
		Engine.WiiUDisplayConfigure( CoD.DrcOutput.DisplayDrc, f1_local0, f1_local2 )
	end
	f1_arg0:drcPopupClose()
end

LUI.createMenu.DrcOutputDevicePopup = function ( f2_arg0 )
	local self = LUI.UIText.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( false, true, -(-120 + CoD.Menu.TitleHeight), 120 )
	self:setRGB( CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b )
	self:setFont( CoD.Menu.TitleFont )
	self:setText( Engine.Localize( "DRC_EXPLAIN_FULL_SCREEN_DRC" ) )
	local f2_local1 = CoD.DrcPopup.New( "DrcOutputDevicePopup", Engine.Localize( "DRC_TOUCHSCREEN_DISPLAY" ), "yesno" )
	f2_local1.controller = f2_arg0
	f2_local1:registerEventHandler( "drc_popup_yes", function ( element, event )
		f0_local0( element, true )
	end )
	f2_local1:registerEventHandler( "drc_popup_no", function ( element, event )
		f0_local0( element, false )
	end )
	f2_local1:addElement( self )
	return f2_local1
end

CoD.DrcOutput.OpenDrcOuputDevicePopup = function ( f5_arg0 )
	f5_arg0:dispatchEventToParent( {
		name = "open_drc_popup",
		popupName = "DrcOutputDevicePopup",
		controller = 0
	} )
end

local f0_local1 = function ( f6_arg0, f6_arg1 )
	if f6_arg1 then
		local f6_local0, f6_local1 = Engine.WiiUGetDisplayConfiguration( CoD.DrcOutput.DisplayDrc )
		Engine.WiiUDisplayConfigure( CoD.DrcOutput.DisplayDrc, CoD.DrcOutput.ShowLUIDrcRoot, f6_local1 )
	end
	f6_arg0:drcPopupClose()
end

local f0_local2 = function ( f7_arg0, f7_arg1 )
	if f7_arg1.popupName == "TVOutputDevicePopup" then
		return true
	else
		return CoD.Menu.OpenPopup( f7_arg0, f7_arg1 )
	end
end

LUI.createMenu.TVOutputDevicePopup = function ( f8_arg0 )
	local f8_local0 = CoD.DrcPopup.New( "TVOutputDevicePopup", Engine.Localize( "DRC_GADGET_DISPLAY" ), "yesno" )
	f8_local0.controller = f8_arg0
	f8_local0:registerEventHandler( "drc_popup_yes", function ( element )
		f0_local1( element, true )
	end )
	f8_local0:registerEventHandler( "drc_popup_no", function ( element )
		f0_local1( element, false )
	end )
	f8_local0:registerEventHandler( "open_popup", f0_local2 )
	return f8_local0
end

CoD.DrcOutput.CreateDrcOutputButton = function ( f11_arg0 )
	if not f11_arg0 then
		f11_arg0 = {
			leftAnchor = true,
			rightAnchor = false,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = CoD.DrcPopup.ButtonWidth,
			top = 0,
			bottom = CoD.DrcPopup.ButtonHeight
		}
	end
	local f11_local0 = CoD.DrcPanelButton.new( f11_arg0, "drc_output_button_pressed" )
	local f11_local1 = Engine.Localize( "DRC_DISPLAY" )
	f11_local0:setLabel( f11_local1 )
	f11_local0.drawnContainer.actionDelay = 500
	f11_local0.button:registerEventHandler( "mouseenter", function ( element, event )
		element:processEvent( {
			name = "button_over_down",
			controller = event.controller
		} )
	end )
	f11_local0.button:registerEventHandler( "mouseleave", function ( element, event )
		element:processEvent( {
			name = "button_over",
			controller = event.controller
		} )
	end )
	f11_local0.button:makeNotFocusable()
	f11_local0:registerEventHandler( "drc_output_button_pressed", function ( element )
		if not f11_local0.buttonUpTimer then
			f11_local0.buttonUpTimer = LUI.UITimer.new( 400, {
				name = "drc_output_button_up"
			}, true, f11_local0 )
			f11_local0:addElement( f11_local0.buttonUpTimer )
		end
	end )
	f11_local0:registerEventHandler( "drc_output_button_up", function ( element )
		element:dispatchEventToParent( {
			name = "open_drc_popup",
			popupName = "DrcOutputDevicePopup",
			controller = 0
		} )
		element.buttonUpTimer = nil
	end )
	local f11_local2 = CoD.Menu.TitleFont
	local f11_local3, f11_local4, f11_local5, f11_local6 = GetTextDimensions( f11_local1, f11_local2, f11_local2 )
	f11_local0.label:setFont( f11_local2 )
	f11_local0.label:setLeftRight( false, false, -f11_local5 / 2, f11_local5 / 2 )
	f11_local0.label:setTopBottom( false, false, -CoD.DrcPopup.ButtonHeight / 10, CoD.DrcPopup.ButtonHeight / 10 )
	f11_local0.button.animDownTime = f11_local0.button.animDownTime * 0.5
	f11_local0.button.animUpTime = f11_local0.button.animUpTime * 0.5
	return f11_local0
end

