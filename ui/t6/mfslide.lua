require( "T6.ButtonPrompt" )
require( "T6.MFSlidePanelManager" )

if CoD == nil then
	CoD = {}
end
CoD.MFSlide = {}
CoD.MFSlide.SlideColor = {
	r = 0,
	g = 0,
	b = 0,
	a = 0.1
}
CoD.MFSlide.FadeInTime = 250
CoD.MFSlide.FadeOutTime = 150
CoD.MFSlide.activated = function ( f1_arg0, f1_arg1 )
	f1_arg0.m_activated = true
	f1_arg0.frame.buttonPrompts:addElement( f1_arg0.body.leftButtonBar )
	f1_arg0.frame.buttonPrompts:addElement( f1_arg0.body.rightButtonBar )
	if f1_arg0.title ~= nil and f1_arg0.frame ~= nil then
		f1_arg0.frame:fadeInTitle( f1_arg0.title, f1_arg0.fadeInTime )
	end
	if CoD.isMultiplayer then
		Engine.Exec( f1_arg1.controller, "party_updateActiveMenu" )
	end
	f1_arg0.m_inputDisabled = nil
	if f1_arg0.frame and f1_arg0.frame.buttonPrompts then
		f1_arg0.frame.buttonPrompts.m_inputDisabled = nil
	end
end

CoD.MFSlide.deactivated = function ( f2_arg0, f2_arg1 )
	if f2_arg1.removeElements ~= false then
		f2_arg0.removeSlideElementsTimer = LUI.UITimer.new( f2_arg0.fadeOutTime, "remove_slide_elements", true )
		f2_arg0:addElement( f2_arg0.removeSlideElementsTimer )
	end
	f2_arg0.body.leftButtonBar:close()
	f2_arg0.body.rightButtonBar:close()
	f2_arg0.m_inputDisabled = true
	f2_arg0.m_activated = nil
end

CoD.MFSlide.OverlayOpened = function ( f3_arg0 )
	f3_arg0:processEvent( {
		name = "slide_deactivated",
		overlay = true,
		removeElements = false
	} )
end

CoD.MFSlide.OverlayClosing = function ( f4_arg0, f4_arg1, f4_arg2 )
	if f4_arg1 ~= true then
		
	else
		
	end
end

CoD.MFSlide.OverlayClosed = function ( f5_arg0, f5_arg1 )
	if f5_arg1 == true then
		f5_arg0:processEvent( {
			name = "slide_activated"
		} )
	end
end

CoD.MFSlide.addSlideElements = function ( f6_arg0, f6_arg1 )
	if f6_arg0.removeSlideElementsTimer ~= nil then
		f6_arg0.removeSlideElementsTimer:close()
		f6_arg0.removeSlideElementsTimer = nil
	end
	f6_arg0.body = LUI.UIElement.new( {
		left = 0,
		top = 0,
		bottom = 0,
		right = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	} )
	f6_arg0.body.id = f6_arg0.id .. ".body"
	f6_arg0:addElement( f6_arg0.body )
	
	local panelManager = CoD.MFSlidePanelManager.new()
	panelManager:setSlide( f6_arg0 )
	f6_arg0:addElement( panelManager )
	f6_arg0.panelManager = panelManager
	
	f6_arg0.body.leftButtonBar = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = 10
	} )
	f6_arg0.body.leftButtonBar.m_ownerController = f6_arg0.m_ownerController
	f6_arg0.body.rightButtonBar = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = 10,
		alignment = LUI.Alignment.Right
	} )
	f6_arg0.body.rightButtonBar.m_ownerController = f6_arg0.m_ownerController
end

CoD.MFSlide.removeSlideElements = function ( f7_arg0, f7_arg1 )
	if f7_arg0.body ~= nil then
		f7_arg0.body:close()
		f7_arg0.body = nil
	end
	if f7_arg0.panelManager ~= nil then
		f7_arg0.panelManager:close()
		f7_arg0.panelManager = nil
	end
end

CoD.MFSlide.buttonPromptBack = function ( f8_arg0, f8_arg1 )
	if f8_arg0.m_previousMenuName ~= nil then
		f8_arg0.slideContainer:scrollToNamedSlide( f8_arg0.m_previousMenuName, f8_arg1.controller )
	end
end

local f0_local0 = function ( f9_arg0 )
	f9_arg0.selectButton = CoD.ButtonPrompt.new( "primary", Engine.Localize( "MENU_SELECT_CAPS" ), f9_arg0 )
	f9_arg0.body.leftButtonBar:addElement( f9_arg0.selectButton )
end

local f0_local1 = function ( f10_arg0 )
	f10_arg0.slideButton = CoD.ButtonPrompt.new( "left_stick_up", Engine.Localize( "MENU_SLIDE_CAPS" ) )
	f10_arg0.body.leftButtonBar:addElement( f10_arg0.slideButton )
end

local f0_local2 = function ( f11_arg0, f11_arg1 )
	if f11_arg1 == nil then
		f11_arg1 = Engine.Localize( "MENU_BACK_CAPS" )
	end
	f11_arg0.backButton = CoD.ButtonPrompt.new( "secondary", f11_arg1, f11_arg0, "button_prompt_back" )
	f11_arg0.body.rightButtonBar:addElement( f11_arg0.backButton )
end

local f0_local3 = function ( f12_arg0 )
	f12_arg0.friendsButton = CoD.ButtonPrompt.new( "alt2", Engine.Localize( "MENU_FRIENDS_CAPS" ), f12_arg0, "button_prompt_friends", false, false, false, false, "F" )
	f12_arg0.body.rightButtonBar:addElement( f12_arg0.friendsButton )
end

local f0_local4 = function ( f13_arg0 )
	f13_arg0.partyPrivacyButton = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MPUI_LOBBY_PRIVACY_CAPS" ), f13_arg0, "button_prompt_partyprivacy", false, false, false, false, "P" )
	f13_arg0.body.rightButtonBar:addElement( f13_arg0.partyPrivacyButton )
end

local f0_local5 = function ( f14_arg0 )
	f14_arg0.glassesToggleButton = CoD.ButtonPrompt.new( "right_trigger", Engine.Localize( "MENU_TURN_OFF_HUD_CAPS" ), f14_arg0, "button_prompt_glasses_toggle", false, false, false, "BACKSPACE", nil )
	f14_arg0.body.rightButtonBar:addElement( f14_arg0.glassesToggleButton )
end

local f0_local6 = function ( f15_arg0, f15_arg1 )
	if f15_arg0.m_inputDisabled then
		return 
	elseif f15_arg0.anyControllerAllowed == true or UIExpression.IsControllerBeingUsed( f15_arg1.controller ) == 1 then
		if f15_arg0.m_ownerController == nil or f15_arg0.m_ownerController == f15_arg1.controller then
			return f15_arg0:dispatchEventToChildren( f15_arg1 )
		else
			
		end
	else
		local f15_local0 = f15_arg1.name
		f15_arg1.name = "unused_gamepad_button"
		local f15_local1 = f15_arg0:dispatchEventToChildren( f15_arg1 )
		f15_arg1.name = f15_local0
		return f15_local1
	end
end

CoD.MFSlide.DebugReload = function ( f16_arg0, f16_arg1 )
	if f16_arg0.name == nil then
		return 
	elseif f16_arg1.menuName ~= nil and f16_arg1.menuName ~= f16_arg0.name then
		return 
	elseif f16_arg0.slideContainer == nil then
		return 
	elseif f16_arg0.slideContainer.currentSlide == f16_arg0 and not f16_arg0.m_inputDisabled then
		local f16_local0 = LUI.createMenu[f16_arg0.name]()
		if f16_local0 == nil then
			return 
		end
		f16_arg0.slideContainer:addSlide( f16_local0, f16_arg0.name )
		f16_local0.m_previousMenuName = f16_arg0.m_previousMenuName
		f16_local0.m_ownerController = f16_arg0.m_ownerController
		f16_arg0.slideContainer:scrollToNamedSlide( f16_arg0.name )
		f16_arg0:close()
	end
end

CoD.MFSlide.OcclusionChange = function ( f17_arg0, f17_arg1 )
	if f17_arg1.occluded then
		f17_arg0.m_inputDisabled = true
		f17_arg0.frame.buttonPrompts.m_inputDisabled = true
	else
		f17_arg0.m_inputDisabled = nil
		f17_arg0.frame.buttonPrompts.m_inputDisabled = nil
		f17_arg0:setBlur( false )
	end
end

CoD.MFSlide.new = function ()
	local f18_local0 = 830
	local self = LUI.UIElement.new( {
		left = -f18_local0 / 2,
		top = 60,
		right = f18_local0 / 2,
		bottom = -60,
		xRot = 0,
		yRot = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	} )
	self.id = "MFSlide"
	self:setUseStencil( true )
	self:registerEventHandler( "debug_reload", CoD.MFSlide.DebugReload )
	self:registerEventHandler( "slide_activated", CoD.MFSlide.activated )
	self:registerEventHandler( "slide_deactivated", CoD.MFSlide.deactivated )
	self:registerEventHandler( "add_slide_elements", CoD.MFSlide.addSlideElements )
	self:registerEventHandler( "remove_slide_elements", CoD.MFSlide.removeSlideElements )
	self:registerEventHandler( "button_prompt_back", CoD.MFSlide.buttonPromptBack )
	self:registerEventHandler( "gamepad_button", f0_local6 )
	self:registerEventHandler( "occlusion_change", CoD.MFSlide.OcclusionChange )
	self.addSelectButton = f0_local0
	self.addSlideButton = f0_local1
	self.addBackButton = f0_local2
	self.addFriendsButton = f0_local3
	self.addPartyPrivacyButton = f0_local4
	self.addGlassesToggleButton = f0_local5
	self.overlayOpened = CoD.MFSlide.OverlayOpened
	self.overlayClosing = CoD.MFSlide.OverlayClosing
	self.overlayClosed = CoD.MFSlide.OverlayClosed
	self.fadeInTime = CoD.MFSlide.FadeInTime
	self.fadeOutTime = CoD.MFSlide.FadeOutTime
	self.m_inputDisabled = true
	return self
end

