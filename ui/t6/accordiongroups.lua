require( "T6.CoD9Button" )
require( "T6.ButtonList" )
require( "T6.MFSlide" )

CoD.AccordionGroups = {}
CoD.AccordionGroups.RowHeight = CoD.CoD9Button.Height
CoD.AccordionGroups.Spacing = 2
CoD.AccordionGroups.ExpandTime = 150
CoD.AccordionGroups.SectionHeight = 90
CoD.AccordionGroups.TextLeft = 20
CoD.AccordionGroups.new = function ()
	local self = LUI.UIVerticalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 100,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	} )
	self.rowHeight = CoD.AccordionGroups.RowHeight
	self.textLeft = CoD.AccordionGroups.TextLeft
	self.textHeight = CoD.CoD9Button.TextHeight
	self.spacing = CoD.AccordionGroups.Spacing
	self.sectionHeight = CoD.AccordionGroups.SectionHeight
	self.addGroup = CoD.AccordionGroups.AddGroup
	self.getMaxHeight = CoD.AccordionGroups.GetMaxHeight
	self.handleGamepadButton = CoD.AccordionGroups.HandleGamepadButton
	return self
end

CoD.AccordionGroups.GetMaxHeight = function ( f2_arg0 )
	return f2_arg0.m_numGroups * f2_arg0.rowHeight + (f2_arg0.m_numGroups - 1) * f2_arg0.spacing + f2_arg0.sectionHeight
end

CoD.AccordionGroups.AddGroup = function ( f3_arg0, f3_arg1 )
	if f3_arg0.m_groups == nil then
		f3_arg0.m_groups = {}
	end
	local self = LUI.UIElement.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = f3_arg0.rowHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	} )
	f3_arg0:addElement( self )
	self.background = LUI.UIImage.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.CoD9Button.BackgroundColor.r,
		green = CoD.CoD9Button.BackgroundColor.g,
		blue = CoD.CoD9Button.BackgroundColor.b,
		alpha = CoD.CoD9Button.BackgroundColor.a
	} )
	self:addElement( self.background )
	self.label = LUI.UIText.new( {
		left = f3_arg0.textLeft,
		top = -f3_arg0.textHeight / 2,
		right = 0,
		bottom = f3_arg0.textHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	self:addElement( self.label )
	self.label:setText( f3_arg1 )
	local f3_local1 = LUI.UIElement.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	} )
	f3_local1:setUseStencil( true )
	f3_local1.m_inputDisabled = true
	f3_local1:registerAnimationState( "expanded", {
		top = -f3_arg0.sectionHeight / 2,
		bottom = f3_arg0.sectionHeight / 2,
		topAnchor = false,
		bottomAnchor = false
	} )
	f3_arg0:addElement( f3_local1 )
	f3_local1.background = LUI.UIImage.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.MFSlide.SlideColor.r,
		green = CoD.MFSlide.SlideColor.g,
		blue = CoD.MFSlide.SlideColor.b,
		alpha = CoD.MFSlide.SlideColor.a
	} )
	f3_local1:addElement( f3_local1.background )
	f3_local1.topShadow = CoD.EdgeShadow.new( "top", true )
	f3_local1.topShadow:setPriority( 100 )
	f3_local1:addElement( f3_local1.topShadow )
	f3_local1.bottomShadow = CoD.EdgeShadow.new( "bottom", true )
	f3_local1.bottomShadow:setPriority( 100 )
	f3_local1:addElement( f3_local1.bottomShadow )
	if f3_arg0.m_numGroups == nil then
		f3_arg0.m_numGroups = 0
		f3_arg0.m_currentGroup = 1
		f3_local1:animateToState( "expanded" )
		f3_local1.m_inputDisabled = nil
	end
	f3_arg0.m_numGroups = f3_arg0.m_numGroups + 1
	f3_arg0:addSpacer( f3_arg0.spacing )
	table.insert( f3_arg0.m_groups, {
		rowHeader = self,
		section = f3_local1
	} )
	return f3_local1
end

CoD.AccordionGroups.HandleGamepadButton = function ( f4_arg0, f4_arg1 )
	if LUI.UIElement.handleGamepadButton( f4_arg0, f4_arg1 ) == true then
		return true
	end
	local f4_local0 = nil
	if f4_arg1.down == true then
		if f4_arg1.button == "up" then
			f4_local0 = -1
		elseif f4_arg1.button == "down" then
			f4_local0 = 1
		end
	end
	if f4_local0 ~= nil and f4_arg0.m_currentGroup ~= nil then
		local f4_local1 = f4_arg0.m_currentGroup
		f4_arg0.m_currentGroup = LUI.clamp( f4_arg0.m_currentGroup + f4_local0, 1, f4_arg0.m_numGroups )
		if f4_local1 ~= f4_arg0.m_currentGroup then
			f4_arg0.m_groups[f4_local1].section:animateToState( "default", CoD.AccordionGroups.ExpandTime, true, true )
			f4_arg0.m_groups[f4_local1].section.m_inputDisabled = true
			f4_arg0.m_groups[f4_arg0.m_currentGroup].section:animateToState( "expanded", CoD.AccordionGroups.ExpandTime, true, true )
			f4_arg0.m_groups[f4_arg0.m_currentGroup].section.m_inputDisabled = nil
		end
	end
end

