CoD.TabManager = {}
CoD.TabManager.DefaultSpacing = 20
CoD.TabManager.SpaceBetweenTabsAndButtons = 10
CoD.TabManager.ButtonLeftShoulder = function ( f1_arg0, f1_arg1 )
	if f1_arg0.m_enabled == false then
		return 
	elseif f1_arg0 ~= nil then
		if f1_arg0.currentTab == 1 then
			f1_arg0.currentTab = #f1_arg0.tabs
		else
			f1_arg0.currentTab = f1_arg0.currentTab - 1
		end
	end
	Engine.PlaySound( "cac_safearea" )
	CoD.TabManager.SetCurrentTabName( f1_arg0 )
	f1_arg0:dispatchEventToParent( {
		name = "tab_changed",
		controller = f1_arg1.controller,
		tabIndex = f1_arg0.currentTab,
		currentTabName = f1_arg0.currentTabName
	} )
	f1_arg0:dispatchEventToChildren( {
		name = "highlight_current_tab",
		currentTab = f1_arg0.currentTab
	} )
end

CoD.TabManager.ButtonRightShoulder = function ( f2_arg0, f2_arg1 )
	if f2_arg0.m_enabled == false then
		return 
	elseif f2_arg0 ~= nil then
		if f2_arg0.currentTab == #f2_arg0.tabs then
			f2_arg0.currentTab = 1
		else
			f2_arg0.currentTab = f2_arg0.currentTab + 1
		end
	end
	Engine.PlaySound( "cac_safearea" )
	CoD.TabManager.SetCurrentTabName( f2_arg0 )
	f2_arg0:dispatchEventToParent( {
		name = "tab_changed",
		controller = f2_arg1.controller,
		tabIndex = f2_arg0.currentTab,
		currentTabName = f2_arg0.currentTabName
	} )
	f2_arg0:dispatchEventToChildren( {
		name = "highlight_current_tab",
		currentTab = f2_arg0.currentTab
	} )
end

CoD.TabManager.SetCurrentTabName = function ( f3_arg0 )
	if f3_arg0.currentTab and f3_arg0.currentTab <= #f3_arg0.tabs then
		f3_arg0.currentTabName = f3_arg0.tabs[f3_arg0.currentTab].tabName
	end
end

CoD.TabManager.Enable = function ( f4_arg0 )
	f4_arg0.m_enabled = true
end

CoD.TabManager.Disable = function ( f5_arg0 )
	f5_arg0.m_enabled = false
end

CoD.TabManager.HighlightCurrentTab = function ( f6_arg0, f6_arg1 )
	if f6_arg0.tabIndex == f6_arg1.currentTab then
		f6_arg0.textElem:setRGB( f6_arg0.tabManager.selectionColor.r, f6_arg0.tabManager.selectionColor.g, f6_arg0.tabManager.selectionColor.b )
		f6_arg0.tabBg:setAlpha( 1 )
		f6_arg0.tabEnd:setAlpha( 1 )
	else
		f6_arg0.textElem:setRGB( CoD.gray.r, CoD.gray.g, CoD.gray.b )
		f6_arg0.tabBg:setAlpha( 0 )
		f6_arg0.tabEnd:setAlpha( 0 )
	end
end

CoD.TabManager.ResetLayout = function ( f7_arg0 )
	f7_arg0.list:removeAllChildren()
	if f7_arg0.alignment == LUI.Alignment.Right then
		f7_arg0.list:addElement( f7_arg0.rightBumperButton )
		f7_arg0.list:addSpacer( CoD.TabManager.SpaceBetweenTabsAndButtons )
		for f7_local0 = #f7_arg0.tabs, 1, -1 do
			f7_arg0.list:addElement( f7_arg0.tabs[f7_local0] )
			if f7_local0 > 1 then
				f7_arg0.list:addSpacer( f7_arg0.spacing )
			end
		end
		f7_arg0.list:addSpacer( CoD.TabManager.SpaceBetweenTabsAndButtons )
		f7_arg0.list:addElement( f7_arg0.leftBumperButton )
	else
		f7_arg0.list:addElement( f7_arg0.leftBumperButton )
		f7_arg0.list:addSpacer( CoD.TabManager.SpaceBetweenTabsAndButtons )
		for f7_local0 = 1, #f7_arg0.tabs, 1 do
			f7_arg0.list:addElement( f7_arg0.tabs[f7_local0] )
			if f7_local0 < #f7_arg0.tabs then
				f7_arg0.list:addSpacer( f7_arg0.spacing )
			end
		end
		f7_arg0.list:addSpacer( CoD.TabManager.SpaceBetweenTabsAndButtons )
		f7_arg0.list:addElement( f7_arg0.rightBumperButton )
	end
end

CoD.TabManager.AddTab = function ( f8_arg0, f8_arg1, f8_arg2 )
	if f8_arg0.tabs == nil then
		f8_arg0.tabs = {}
	end
	local f8_local0 = CoD.fonts[f8_arg0.fontAndTextSize]
	local f8_local1 = CoD.textSize[f8_arg0.fontAndTextSize]
	local f8_local2, f8_local3, f8_local4, f8_local5 = GetTextDimensions( f8_arg1, f8_local0, f8_local1 )
	local f8_local6 = f8_local4 - f8_local2
	local f8_local7 = 5
	local f8_local8 = 2
	local f8_local9 = f8_local7 * 2 + f8_local6
	local f8_local10 = f8_local8 * 2 + f8_local1
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, 0, f8_local9 )
	self:setTopBottom( false, true, -f8_local10, 0 )
	local f8_local12 = LUI.UIImage.new()
	f8_local12:setLeftRight( true, true, 0, 0 )
	f8_local12:setTopBottom( true, true, -1, 4 )
	f8_local12:setImage( RegisterMaterial( "menu_mp_tab" ) )
	self:addElement( f8_local12 )
	local f8_local13 = LUI.UIImage.new()
	f8_local13:setLeftRight( false, true, -4, 0 )
	f8_local13:setTopBottom( true, true, -1, 4 )
	f8_local13:setImage( RegisterMaterial( "menu_mp_tab_end" ) )
	self:addElement( f8_local13 )
	local f8_local14 = LUI.UIText.new()
	f8_local14:setLeftRight( true, true, 0, 0 )
	f8_local14:setTopBottom( false, false, -f8_local1 / 2, f8_local1 / 2 )
	f8_local14:setText( f8_arg1 )
	f8_local14:setFont( f8_local0 )
	f8_local14:setRGB( CoD.gray.r, CoD.gray.g, CoD.gray.b )
	self:addElement( f8_local14 )
	self.tabBg = f8_local12
	self.tabEnd = f8_local13
	self.textElem = f8_local14
	self.tabManager = f8_arg0
	table.insert( f8_arg0.tabs, self )
	self.tabIndex = table.getn( f8_arg0.tabs )
	self.tabName = f8_arg2
	CoD.TabManager.ResetLayout( f8_arg0 )
	self:registerEventHandler( "highlight_current_tab", CoD.TabManager.HighlightCurrentTab )
	if CoD.useMouse then
		self:setHandleMouse( true )
		self:registerEventHandler( "leftmousedown", CoD.NullFunction )
		self:registerEventHandler( "leftmouseup", CoD.TabManager.Tab_LeftMouseUp )
		self:registerEventHandler( "mouseenter", CoD.TabManager.Tab_MouseEnter )
		self:registerEventHandler( "mouseleave", CoD.TabManager.Tab_MouseLeave )
	end
end

CoD.TabManager.SetCurrentTab = function ( f9_arg0, f9_arg1 )
	if f9_arg1 then
		f9_arg0.currentTab = f9_arg1
	end
	CoD.TabManager.SetCurrentTabName( f9_arg0 )
	f9_arg0:dispatchEventToChildren( {
		name = "highlight_current_tab",
		currentTab = f9_arg0.currentTab
	} )
	f9_arg0:dispatchEventToParent( {
		name = "tab_changed",
		tabIndex = f9_arg0.currentTab,
		currentTabName = f9_arg0.currentTabName
	} )
end

CoD.TabManager.new = function ( f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5 )
	local self = LUI.UIElement.new( f10_arg0 )
	self.m_enabled = true
	self.currentTab = 1
	self.fontAndTextSize = "Default"
	if f10_arg4 then
		tabmanager.fontAndTextSize = f10_arg4
	end
	self.selectionColor = CoD.offWhite
	if f10_arg1 then
		self.selectionColor = f10_arg1
	end
	self.list = LUI.UIHorizontalList.new()
	self.list:setLeftRight( true, true, 0, 0 )
	self.list:setTopBottom( true, true, 0, 0 )
	self.alignment = LUI.Alignment.Center
	self.spacing = CoD.TabManager.DefaultSpacing
	if f10_arg2 then
		self.alignment = f10_arg2
	end
	self.list:setAlignment( self.alignment )
	if f10_arg3 then
		self.spacing = f10_arg3
	end
	self.leftBumperButton = CoD.ButtonPrompt.new( "shoulderl", "", self, "button_prompt_shoulder_left" )
	self:registerEventHandler( "button_prompt_shoulder_left", CoD.TabManager.ButtonLeftShoulder )
	self.rightBumperButton = CoD.ButtonPrompt.new( "shoulderr", "", self, "button_prompt_shoulder_right" )
	self:registerEventHandler( "button_prompt_shoulder_right", CoD.TabManager.ButtonRightShoulder )
	if CoD.useMouse then
		self:registerEventHandler( "tab_clicked", CoD.TabManager.TabClicked )
		self.leftBumperButton.prompt2 = "^BBUTTON_CYCLE_LEFT_ACTIVE^"
		self.leftBumperButton:registerEventHandler( "mouseenter", CoD.TabManager.ButtonPrompt_MouseEnter )
		self.leftBumperButton:registerEventHandler( "mouseleave", CoD.TabManager.ButtonPrompt_MouseLeave )
		self.rightBumperButton.prompt2 = "^BBUTTON_CYCLE_RIGHT_ACTIVE^"
		self.rightBumperButton:registerEventHandler( "mouseenter", CoD.TabManager.ButtonPrompt_MouseEnter )
		self.rightBumperButton:registerEventHandler( "mouseleave", CoD.TabManager.ButtonPrompt_MouseLeave )
	end
	self.addTab = CoD.TabManager.AddTab
	self.setCurrentTab = CoD.TabManager.SetCurrentTab
	self.enable = CoD.TabManager.Enable
	self.disable = CoD.TabManager.Disable
	if f10_arg5 then
		self.currentTab = f10_arg5
	end
	self:addElement( self.list )
	return self
end

CoD.TabManager.TabClicked = function ( f11_arg0, f11_arg1 )
	if f11_arg0.m_enabled == false then
		return 
	else
		f11_arg0.currentTab = f11_arg1.tabIndex
		CoD.TabManager.SetCurrentTabName( f11_arg0 )
		f11_arg0:dispatchEventToChildren( {
			name = "highlight_current_tab",
			currentTab = f11_arg0.currentTab
		} )
		f11_arg0:dispatchEventToParent( {
			name = "tab_changed",
			tabIndex = f11_arg0.currentTab,
			currentTabName = f11_arg0.currentTabName,
			controller = f11_arg1.controller
		} )
	end
end

CoD.TabManager.Tab_LeftMouseUp = function ( f12_arg0, f12_arg1 )
	if f12_arg0.tabManager.currentTab ~= f12_arg0.tabIndex then
		f12_arg0:dispatchEventToParent( {
			name = "tab_clicked",
			controller = f12_arg1.controller,
			tabIndex = f12_arg0.tabIndex
		} )
	end
end

CoD.TabManager.Tab_MouseEnter = function ( f13_arg0, f13_arg1 )
	if f13_arg0.tabManager.currentTab ~= f13_arg0.tabIndex then
		f13_arg0.textElem:setRGB( f13_arg0.tabManager.selectionColor.r, f13_arg0.tabManager.selectionColor.g, f13_arg0.tabManager.selectionColor.b )
	end
end

CoD.TabManager.Tab_MouseLeave = function ( f14_arg0, f14_arg1 )
	if f14_arg0.tabManager.currentTab ~= f14_arg0.tabIndex then
		f14_arg0.textElem:setRGB( CoD.gray.r, CoD.gray.g, CoD.gray.b )
	end
end

CoD.TabManager.ButtonPrompt_MouseEnter = function ( f15_arg0, f15_arg1 )
	if f15_arg0.prompt2 then
		f15_arg0.buttonImage:setText( f15_arg0.prompt2 )
	end
end

CoD.TabManager.ButtonPrompt_MouseLeave = function ( f16_arg0, f16_arg1 )
	if f16_arg0.prompt then
		f16_arg0.buttonImage:setText( f16_arg0.prompt )
	end
end

