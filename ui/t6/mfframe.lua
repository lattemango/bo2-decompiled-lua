require( "T6.Ticker" )

local f0_local0, f0_local1 = nil
local f0_local2 = function ( f1_arg0, f1_arg1, f1_arg2 )
	f1_arg0.title:setText( f1_arg1 )
	f1_arg0.title:animateToState( "fade_in", f1_arg2, false, false )
end

local f0_local3 = function ( f2_arg0, f2_arg1 )
	f2_arg0.title:animateToState( "fade_out", f2_arg1, false, false )
end

local f0_local4 = function ( f3_arg0, f3_arg1, f3_arg2 )
	local f3_local0 = LUI.createMenu[f3_arg1]( f3_arg0, f3_arg2 )
	if f3_local0 == nil then
		return 
	end
	f3_local0.name = f3_arg1
	f3_local0.m_ownerController = f3_arg2
	if f3_arg0.slideContainer ~= nil then
		f3_arg0.slideContainer:overlayOpened()
	end
	f3_arg0:addElement( LUI.UITimer.new( CoD.MFSlide.FadeOutTime, {
		name = "open_overlay_internal",
		overlay = f3_local0
	}, true ) )
	return f3_local0
end

local f0_local5 = function ( f4_arg0, f4_arg1 )
	f4_arg0.overlays:addElement( f4_arg1.overlay )
	f4_arg1.overlay:processEvent( {
		name = "overlay_opening",
		time = f4_arg0.overlayOpenTime
	} )
	f4_arg0.m_replacingOverlay = nil
end

local f0_local6 = function ( f5_arg0, f5_arg1, f5_arg2 )
	LUI.UIElement.close( f5_arg1 )
	local f5_local0 = true
	if f5_arg0.slideContainer ~= nil and f5_arg0.slideContainer.currentSlide ~= nil then
		if f5_arg0.slideContainer:overlayClosing() == true and f5_arg0.slideContainer.nextSlide.title == f5_arg1.title then
			f5_local0 = nil
		end
		f5_arg0:addElement( LUI.UITimer.new( f5_arg0.overlayCloseTime, {
			name = "close_overlay_internal",
			overlay = f5_arg1,
			nextOverlay = f5_arg2
		}, true ) )
	end
	if f5_local0 == true and f5_arg1.title ~= nil then
		f5_arg0:fadeOutTitle( f5_arg0.overlayCloseTime )
	end
end

local f0_local7 = function ( f6_arg0, f6_arg1 )
	f6_arg1.overlay:processEvent( {
		name = "overlay_closed"
	} )
	if f6_arg1.nextOverlay ~= nil then
		f6_arg0:processEvent( {
			name = "replace_overlay_internal",
			nextOverlay = f6_arg1.nextOverlay
		} )
	elseif f6_arg0.slideContainer ~= nil then
		f6_arg0.slideContainer:overlayClosed()
	end
end

local f0_local8 = function ( f7_arg0, f7_arg1, f7_arg2, f7_arg3 )
	if f7_arg0.m_replacingOverlay == true then
		return 
	else
		f7_arg0:closeOverlay( f7_arg2, {
			name = f7_arg3,
			controller = f7_arg1
		} )
		f7_arg0.m_replacingOverlay = true
	end
end

local f0_local9 = function ( f8_arg0, f8_arg1 )
	f8_arg0:openOverlay( f8_arg1.nextOverlay.name, f8_arg1.nextOverlay.controller )
end

LUI.createMenu.MFFrame = function ( f9_arg0 )
	local self = LUI.UIElement.new( {
		left = -f9_arg0 / 2,
		top = 60,
		right = f9_arg0 / 2,
		bottom = -60,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	} )
	self.width = f9_arg0
	self.overlayOpenTime = CoD.MFSlide.FadeInTime
	self.overlayCloseTime = CoD.MFSlide.FadeInTime
	local f9_local1 = 0
	self.titleContainer = LUI.UIElement.new( {
		left = -CoD.textSize.Morris - f9_local1,
		top = 0,
		right = -f9_local1,
		bottom = CoD.textSize.Morris,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = 90
	} )
	self:addElement( self.titleContainer )
	self.title = LUI.UIText.new( {
		left = -CoD.textSize.Morris,
		top = -CoD.textSize.Morris,
		bottom = 0,
		right = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Morris,
		alpha = 0.75
	} )
	self.title:registerAnimationState( "fade_in", {
		alpha = CoD.textAlpha
	} )
	self.title:registerAnimationState( "fade_out", {
		alpha = 0
	} )
	self.titleContainer:addElement( self.title )
	self.buttonPrompts = LUI.UIElement.new( {
		left = 0,
		top = -CoD.ButtonPrompt.Height,
		right = -10,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	} )
	self:addElement( self.buttonPrompts )
	self.fadeInTitle = f0_local2
	self.fadeOutTitle = f0_local3
	self.openOverlay = f0_local4
	self.closeOverlay = f0_local6
	self.replaceOverlay = f0_local8
	self.addAllocationSubtitle = f0_local0
	self.removeAllocationSubtitle = f0_local1
	self:registerEventHandler( "open_overlay_internal", f0_local5 )
	self:registerEventHandler( "close_overlay_internal", f0_local7 )
	self:registerEventHandler( "replace_overlay_internal", f0_local9 )
	return self
end

f0_local0 = function ( f10_arg0 )
	f10_arg0:removeAllocationSubtitle()
	local f10_local0 = CoD.AllocationSubtitle.new( f10_arg0.width, {
		left = 0,
		top = 0,
		bottom = CoD.frameSubtitleHeight,
		right = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alphaMultiplier = 0
	} )
	f10_arg0:addElement( f10_local0 )
	f10_local0:registerAnimationState( "fade_in", {
		alphaMultiplier = 1
	} )
	f10_arg0.allocationSubtitle = f10_local0
	return f10_local0
end

f0_local1 = function ( f11_arg0 )
	if f11_arg0.allocationSubtitle ~= nil then
		f11_arg0.allocationSubtitle:close()
		f11_arg0.allocationSubtitle = nil
	end
end

