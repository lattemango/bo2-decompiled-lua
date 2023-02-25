require( "LUI.LUIHorizontalList" )

CoD.SpectateButtonBar = InheritFrom( LUI.UIElement )
CoD.SpectateButtonBar.Height = 32
CoD.SpectateButtonBar.HorizontalPadding = 50
CoD.SpectateButtonBar.MODE_DEFAULT = 1
CoD.SpectateButtonBar.MODE_MAP = 2
CoD.SpectateButtonBar.MODE_SCOREBOARD = 3
CoD.SpectateButtonBar.Mode = -1
CoD.SpectateButtonBar.ButtonEvent = function ( f1_arg0, f1_arg1 )
	f1_arg0:dispatchEventToParent( f1_arg1 )
end

CoD.SpectateButtonBar.Hide = function ( f2_arg0, f2_arg1 )
	f2_arg0:setAlpha( 0 )
end

CoD.SpectateButtonBar.Show = function ( f3_arg0, f3_arg1 )
	if Engine.IsDemoShoutcaster() then
		return 
	else
		f3_arg0:setAlpha( 1 )
	end
end

CoD.SpectateButtonBar.GetSpectatorString = function ( f4_arg0 )
	local f4_local0 = ""
	if UIExpression.IsVisibilityBitSet( f4_arg0, CoD.BIT_IS_THIRD_PERSON ) == 1 then
		f4_local0 = "MPUI_FIRST_PERSON_VIEW"
	else
		f4_local0 = "MPUI_THIRD_PERSON_VIEW"
	end
	return f4_local0
end

CoD.SpectateButtonBar.UpdateModeDefault = function ( f5_arg0, f5_arg1 )
	CoD.ButtonPrompt.SetText( f5_arg0.viewToggleBtn, Engine.Localize( CoD.SpectateButtonBar.GetSpectatorString( f5_arg0.m_ownerController ) ) )
end

CoD.SpectateButtonBar.Update = function ( f6_arg0, f6_arg1 )
	if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
		CoD.SpectateButtonBar.UpdateModeDefault( f6_arg0, f6_arg1 )
	end
end

CoD.SpectateButtonBar.SetModeInternal = function ( f7_arg0 )
	f7_arg0.leftButtonList:removeAllChildren()
	if f7_arg0.m_isFullscreen == true then
		if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
			f7_arg0.leftButtonList:addElement( f7_arg0.scoreboardBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.overheadMapBtn )
			if Engine.IsDemoShoutcaster() == false then
				f7_arg0.leftButtonList:addElement( f7_arg0.viewToggleBtn )
			end
			f7_arg0.leftButtonList:addElement( f7_arg0.hudToggleBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.spectatorControlsBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.menuBtn )
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_MAP then
			f7_arg0.leftButtonList:addElement( f7_arg0.overheadMapBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hudToggleBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.spectatorControlsBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.menuBtn )
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_SCOREBOARD then
			f7_arg0.leftButtonList:addElement( f7_arg0.scoreboardBtn )
		end
	else
		if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
			f7_arg0.leftButtonList:addElement( f7_arg0.overheadMapBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hudToggleBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hideSpectaterControlsBtn )
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_MAP then
			f7_arg0.leftButtonList:addElement( f7_arg0.overheadMapBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hudToggleBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hideSpectaterControlsBtn )
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_SCOREBOARD then
			f7_arg0.leftButtonList:addElement( f7_arg0.scoreboardBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hudToggleBtn )
			f7_arg0.leftButtonList:addElement( f7_arg0.hideSpectaterControlsBtn )
		end
		f7_arg0.rightButtonList:removeAllChildren()
		if f7_arg0.m_selectedTab == CoD.SpectateSidePanel.DisplayOptionsTabIndex then
			if not CoD.isPC then
				f7_arg0.rightButtonList:addElement( f7_arg0.changeDisplayOptions )
				f7_arg0.rightButtonList:addElement( f7_arg0.selectDisplayOptions )
			end
		elseif f7_arg0.m_selectedTab == CoD.SpectateSidePanel.PlayersTabIndex then
			f7_arg0.rightButtonList:addElement( f7_arg0.spectatePlayerBtn )
			if Engine.IsDemoShoutcaster() == false then
				if Engine.GetGametypeSetting( "teamCount" ) == 1 then
					f7_arg0.rightButtonList:addElement( f7_arg0.listenInBtnFFA )
				else
					f7_arg0.rightButtonList:addElement( f7_arg0.listenInBtn )
				end
			end
			if not CoD.isPC then
				f7_arg0.rightButtonList:addElement( f7_arg0.highlightPlayerBtn )
			end
		end
	end
end

CoD.SpectateButtonBar.SetMode = function ( f8_arg0, f8_arg1 )
	CoD.SpectateButtonBar.Mode = f8_arg1
	CoD.SpectateButtonBar.SetModeInternal( f8_arg0 )
end

CoD.SpectateButtonBar.SetFullscreen = function ( f9_arg0, f9_arg1, f9_arg2 )
	CoD.SpectateButtonBar.m_isFullscreen = f9_arg1
	CoD.SpectateButtonBar.m_selectedTab = f9_arg2
	if CoD.SpectateButtonBar.Mode ~= -1 then
		f9_arg0:setMode( CoD.SpectateButtonBar.Mode )
	end
end

CoD.SpectateButtonBar.PlayerSelected = function ( f10_arg0, f10_arg1 )
	if f10_arg0.m_waitingForPlayers == true and f10_arg1.info.teamID ~= CoD.TEAM_SPECTATOR then
		f10_arg0.m_inputDisabled = false
		CoD.SpectateButtonBar.Show( f10_arg0, f10_arg1 )
		f10_arg0.m_waitingForPlayers = false
	elseif f10_arg1.info.teamID == CoD.TEAM_SPECTATOR then
		f10_arg0.m_inputDisabled = true
		CoD.SpectateButtonBar.Hide( f10_arg0, f10_arg1 )
		f10_arg0.m_waitingForPlayers = true
	end
end

CoD.SpectateButtonBar.UpdateButtonPrompts = function ( f11_arg0, f11_arg1 )
	if f11_arg1.invalidPlayer ~= nil and f11_arg1.invalidPlayer == true then
		f11_arg0.spectatePlayerBtn:setAlpha( 0 )
	else
		f11_arg0.spectatePlayerBtn:setAlpha( 1 )
		if CoD.isPC and not Engine.LastInput_Gamepad() then
			f11_arg0.spectatePlayerBtn:setAlpha( 0 )
		end
	end
end

CoD.SpectateButtonBar.SlideLeft = function ( f12_arg0, f12_arg1, f12_arg2 )
	f12_arg0.leftButtonList:beginAnimation( "moveLeftList", 200 )
	f12_arg0.leftButtonList:setLeftRight( true, false, f12_arg1, f12_arg1 + f12_arg2 )
	f12_arg0.rightButtonList:beginAnimation( "moveRightList", 200 )
	f12_arg0.rightButtonList:setLeftRight( false, true, -CoD.SpectateButtonBar.HorizontalPadding, -20 )
	f12_arg0.rightButtonList:setAlpha( 1 )
end

CoD.SpectateButtonBar.SlideRight = function ( f13_arg0 )
	f13_arg0.leftButtonList:beginAnimation( "moveLeftList", 200 )
	f13_arg0.leftButtonList:setLeftRight( true, true, 0, 0 )
	f13_arg0.rightButtonList:beginAnimation( "moveRightList", 200 )
	f13_arg0.rightButtonList:setLeftRight( false, true, 0, CoD.SpectateButtonBar.HorizontalPadding )
	f13_arg0.rightButtonList:setAlpha( 0 )
end

CoD.SpectateButtonBar.new = function ( f14_arg0, f14_arg1, f14_arg2 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( false, true, -CoD.SpectateButtonBar.Height, 0 )
	self:setClass( CoD.SpectateButtonBar )
	self.m_ownerController = f14_arg0
	self.m_inputDisabled = false
	self.m_waitingForPlayers = true
	self.m_listening = false
	local f14_local1 = (f14_arg2 - f14_arg1) / 2
	self.bg = LUI.UIImage.new()
	self.bg:setLeftRight( true, true, -f14_local1, f14_local1 )
	self.bg:setTopBottom( true, true, 0, 0 )
	self.bg:setImage( RegisterMaterial( "hud_shoutcasting_bar_stretch" ) )
	self.bg:setAlpha( CoD.SpectateHUD.BgAlpha )
	self.leftButtonList = LUI.UIHorizontalList.new()
	self.leftButtonList:setLeftRight( true, true, 0, 0 )
	self.leftButtonList:setTopBottom( true, true, 0, 0 )
	self.leftButtonList:setSpacing( 5 )
	self.leftButtonList:setAlignment( LUI.Alignment.Center )
	self.rightButtonList = LUI.UIHorizontalList.new()
	self.rightButtonList:setLeftRight( false, true, 0, CoD.SpectateButtonBar.HorizontalPadding )
	self.rightButtonList:setTopBottom( true, true, 0, 0 )
	self.rightButtonList:setSpacing( 5 )
	self.rightButtonList:setAlignment( LUI.Alignment.Right )
	local f14_local2 = CoD.SpectateButtonBar.GetSpectatorString( f14_arg0 )
	self.scoreboardBtn = CoD.ButtonPrompt.new( "select", Engine.Localize( "MPUI_SCOREBOARD" ), self, "spectate_scoreboard", false, false, false, false, "TAB" )
	self.overheadMapBtn = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MPUI_OVERHEAD_MAP" ), self, "spectate_overhead_map", false, false, false, false, "M" )
	self.viewToggleBtn = CoD.ButtonPrompt.new( "alt2", Engine.Localize( f14_local2 ), self, "spectate_toggle_view", false, false, false, "mouse3", nil )
	self.hudToggleBtn = CoD.ButtonPrompt.new( "secondary", Engine.Localize( "MPUI_TOGGLE_TOOLBAR" ), self, "spectate_toggle_hud", false, false, false, false, "BACKSPACE" )
	self.spectatorControlsBtn = CoD.ButtonPrompt.new( "right_trigger", Engine.Localize( "MPUI_SHOUTCASTER_CONTROLS" ), self, "spectate_controls_open", false, false, false, false, "F" )
	self.hideSpectaterControlsBtn = CoD.ButtonPrompt.new( "right_trigger", Engine.Localize( "MPUI_HIDE_SHOUTCASTER_CONTROLS" ), self, "spectate_controls_close", false, false, false, false, "F" )
	self.spectatePlayerBtn = CoD.ButtonPrompt.new( "primary", Engine.Localize( "MPUI_SPECTATE_PLAYER" ) )
	self.listenInBtn = CoD.ButtonPrompt.new( "left", Engine.Localize( "MPUI_TEAM_LISTEN_IN" ), self, "spectate_listen_in", nil, "dpad", false, false, "L" )
	self.listenInBtnFFA = CoD.ButtonPrompt.new( "left", Engine.Localize( "MPUI_LISTEN_IN_ON" ), self, "spectate_listen_in_ffa", nil, "dpad", false, false, "L" )
	self.menuBtn = CoD.ButtonPrompt.new( "start", Engine.Localize( "MPUI_MENU" ), self, "spectate_menu", false, false, false, "secondary" )
	if not CoD.isPC then
		self.highlightPlayerBtn = CoD.ButtonPrompt.new( "dpad_ud", Engine.Localize( "MPUI_HIGHLIGHT_PLAYER" ), self, "spectate_highlight_player" )
		self.selectDisplayOptions = CoD.ButtonPrompt.new( "dpad_ud", Engine.Localize( "MPUI_SELECT_OPTION" ) )
		self.changeDisplayOptions = CoD.ButtonPrompt.new( "dpad_lr", Engine.Localize( "MPUI_CHANGE_SETTING" ) )
	else
		self.spectatePlayerBtn:registerEventHandler( "input_source_changed", function ( element, event )
			if event.source ~= 0 then
				element:setAlpha( 0 )
			else
				CoD.ButtonPrompt.InputSourceChanged( element, event )
			end
		end )
	end
	self.setMode = CoD.SpectateButtonBar.SetMode
	self.setFullscreen = CoD.SpectateButtonBar.SetFullscreen
	self.slideLeft = CoD.SpectateButtonBar.SlideLeft
	self.slideRight = CoD.SpectateButtonBar.SlideRight
	self:addElement( self.bg )
	self:addElement( self.leftButtonList )
	self:addElement( self.rightButtonList )
	self:setFullscreen( true )
	self:setMode( CoD.SpectateButtonBar.MODE_DEFAULT )
	self.m_inputDisabled = true
	self:setAlpha( 0 )
	return self
end

CoD.SpectateButtonBar.DisableInput = function ( f16_arg0, f16_arg1 )
	f16_arg0.m_inputDisabled = true
end

CoD.SpectateButtonBar.EnableInput = function ( f17_arg0, f17_arg1 )
	if f17_arg0.m_waitingForPlayers == false then
		f17_arg0.m_inputDisabled = false
	end
end

CoD.SpectateButtonBar.ListenInFFA = function ( f18_arg0, f18_arg1 )
	if f18_arg0.m_listening == true then
		f18_arg0.m_listening = false
		CoD.ButtonPrompt.SetText( f18_arg0.listenInBtnFFA, Engine.Localize( "MPUI_LISTEN_IN_ON" ) )
	else
		f18_arg0.m_listening = true
		CoD.ButtonPrompt.SetText( f18_arg0.listenInBtnFFA, Engine.Localize( "MPUI_LISTEN_IN_OFF" ) )
	end
	f18_arg1.name = "spectate_listen_in"
	CoD.SpectateButtonBar.ButtonEvent( f18_arg0, f18_arg1 )
end

CoD.SpectateButtonBar:registerEventHandler( "spectate_scoreboard", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_overhead_map", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_toggle_view", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_toggle_hud", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_controls_open", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_controls_close", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_listen_in", CoD.SpectateButtonBar.ButtonEvent )
CoD.SpectateButtonBar:registerEventHandler( "spectate_listen_in_ffa", CoD.SpectateButtonBar.ListenInFFA )
CoD.SpectateButtonBar:registerEventHandler( "spectate_player_selected", CoD.SpectateButtonBar.PlayerSelected )
CoD.SpectateButtonBar:registerEventHandler( "update_spectate_buttom_prompts", CoD.SpectateButtonBar.UpdateButtonPrompts )
CoD.SpectateButtonBar:registerEventHandler( "spectate_disable_input", CoD.SpectateButtonBar.DisableInput )
CoD.SpectateButtonBar:registerEventHandler( "spectate_enable_input", CoD.SpectateButtonBar.EnableInput )
CoD.SpectateButtonBar:registerEventHandler( "update_spectate_hud", CoD.SpectateButtonBar.Update )
CoD.SpectateButtonBar:registerEventHandler( "hide_spectate_hud", CoD.SpectateButtonBar.Hide )
CoD.SpectateButtonBar:registerEventHandler( "show_spectate_hud", CoD.SpectateButtonBar.Show )
