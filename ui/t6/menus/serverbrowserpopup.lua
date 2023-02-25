require( "T6.ServerList" )

CoD.ServerBrowser = {}
CoD.ServerBrowser.DoNothing = function ( f1_arg0, f1_arg1 )
	
end

CoD.ServerBrowser.JoinMatch = function ( f2_arg0, f2_arg1 )
	Engine.ServerListStopRefresh()
	f2_arg0.occludedMenu:processEvent( {
		name = "rebuild_button_panel"
	} )
	f2_arg0:registerEventHandler( "party_joined", CoD.ServerBrowser.DoNothing )
	f2_arg0:registerEventHandler( "button_prompt_back", CoD.ServerBrowser.DoNothing )
end

CoD.ServerBrowser.close = function ( f3_arg0, f3_arg1 )
	Engine.ServerListStopRefresh()
	f3_arg0.occludedMenu:processEvent( {
		name = "rebuild_button_panel"
	} )
	CoD.Menu.close( f3_arg0, f3_arg1 )
end

CoD.ServerBrowser.AddRefreshButton = function ( f4_arg0, f4_arg1 )
	f4_arg0.refreshButton = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_REFRESH" ), f4_arg1, "button_prompt_refresh", false, false, false, false, "R" )
	f4_arg0:addRightButtonPrompt( f4_arg0.refreshButton )
end

CoD.ServerBrowser.SignedOut = function ( f5_arg0, f5_arg1 )
	if f5_arg0.m_ownerController == f5_arg1.controller then
		Engine.ServerListStopRefresh()
		CoD.Menu.SignedOut( f5_arg0, f5_arg1 )
	end
end

LUI.createMenu.ServerBrowser = function ( f6_arg0 )
	local f6_local0 = CoD.Menu.New( "ServerBrowser" )
	f6_local0:addLargePopupBackground()
	f6_local0.m_ownerController = f6_arg0
	f6_local0:addTitle( Engine.Localize( "PLATFORM_SYSTEM_LINK_GAMES_CAPS" ) )
	f6_local0:registerEventHandler( "party_joined", CoD.ServerBrowser.JoinMatch )
	local f6_local1 = CoD.Menu.TitleHeight
	local f6_local2 = f6_local0.height - f6_local1
	local f6_local3 = f6_local1 + CoD.CoD9Button.Height
	f6_local0.header = LUI.UIHorizontalList.new( {
		left = 0,
		top = f6_local1,
		right = 0,
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = CoD.ServerList.ColumnSpacing
	} )
	f6_local0:addElement( f6_local0.header )
	f6_local0.backgroundGroup = LUI.UIHorizontalList.new( {
		left = 0,
		top = f6_local3,
		right = 0,
		bottom = -CoD.CoD9Button.Height - 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.ServerList.ColumnSpacing,
		alpha = 0.03
	} )
	f6_local0:addElement( f6_local0.backgroundGroup )
	local f6_local4 = {
		LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[1],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		} ),
		LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[2],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		} ),
		LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[3],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		} ),
		LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[4],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		} ),
		LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = CoD.ServerList.ColumnWidth[5],
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		} )
	}
	f6_local0.backgroundGroup:addElement( f6_local4[1] )
	f6_local0.backgroundGroup:addElement( f6_local4[2] )
	f6_local0.backgroundGroup:addElement( f6_local4[3] )
	f6_local0.backgroundGroup:addElement( f6_local4[4] )
	f6_local0.backgroundGroup:addElement( f6_local4[5] )
	f6_local0.serverList = CoD.ServerList.new( {
		left = 0,
		top = f6_local3,
		right = 0,
		bottom = -CoD.CoD9Button.Height - 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 10
	} )
	f6_local0:addElement( f6_local0.serverList )
	local f6_local5 = LUI.UIText.new( {
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[1],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	local f6_local6 = LUI.UIText.new( {
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[2],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	local f6_local7 = LUI.UIText.new( {
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[4],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	local f6_local8 = LUI.UIText.new( {
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[5],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	local f6_local9 = LUI.UIText.new( {
		left = 0,
		top = 0,
		right = CoD.ServerList.ColumnWidth[3],
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	} )
	f6_local5:setText( Engine.Localize( "MENU_HOST_CAPS" ) )
	f6_local6:setText( Engine.Localize( "MENU_MAP_NAME_CAPS" ) )
	f6_local9:setText( Engine.Localize( "MENU_NUMPLAYERS_CAPS" ) )
	f6_local7:setText( Engine.Localize( "MENU_GAME_MODE_CAPS" ) )
	f6_local8:setText( Engine.Localize( "MENU_STATUS_CAPS" ) )
	f6_local0.header:addSpacer( CoD.ServerListButton.TextOffset )
	f6_local0.header:addElement( f6_local5 )
	f6_local0.header:addElement( f6_local6 )
	f6_local0.header:addElement( f6_local9 )
	f6_local0.header:addElement( f6_local7 )
	f6_local0.header:addElement( f6_local8 )
	f6_local0:addSelectButton()
	f6_local0:addBackButton()
	CoD.ServerBrowser.AddRefreshButton( f6_local0, f6_local0.serverList )
	f6_local0:registerEventHandler( "signed_out", CoD.ServerBrowser.SignedOut )
	return f6_local0
end

