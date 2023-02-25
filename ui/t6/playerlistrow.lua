CoD.PlayerListRow = {}
CoD.PlayerListRow.Height = CoD.CoD9Button.Height
CoD.PlayerListRow.RankFadeInTime = 500
CoD.PlayerListRow.Font = "Default"
CoD.PlayerListRow.LeagueRankAreaWidth = 92
CoD.PlayerListRow.SetStatusText = function ( f1_arg0, f1_arg1 )
	if f1_arg1 ~= nil then
		f1_arg0.status:setText( f1_arg1 )
	end
end

CoD.PlayerListRow.CreateStatusRow = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3 )
	local self = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.textSize[CoD.PlayerListRow.Font]
	} )
	self:makeNotFocusable()
	self:setPriority( 0 )
	self.status = LUI.UIText.new()
	self.status:setLeftRight( true, true, 0, 0 )
	self.status:setTopBottom( true, true, 0, 0 )
	self.status:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	self.status:setAlpha( 0.75 )
	self.status:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
	self.status:setAlignment( LUI.Alignment.Left )
	self:addElement( self.status )
	if false == CoD.isZombie and f2_arg2 then
		self:addElement( CoD.LiveStream.GetStatusWidget( f2_arg3, LUI.Alignment.Right, true, true ) )
	end
	self.playerList = f2_arg0
	self.setText = CoD.PlayerListRow.SetStatusText
	if f2_arg1 ~= nil then
		self.status:setText( f2_arg1 )
	end
	return self
end

CoD.PlayerListRow.CreateSplitscreenRow = function ( menu, controller )
	local self = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	} )
	self:makeNotFocusable()
	self:setPriority( 10 )
	self.allowJoin = controller
	self.textLabel = LUI.UIText.new()
	self.textLabel:setLeftRight( true, true, 0, 0 )
	self.textLabel:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2 - 3, CoD.textSize[CoD.PlayerListRow.Font] / 2 - 3 )
	self.textLabel:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
	self.textLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	self.textLabel:setAlignment( LUI.Alignment.Left )
	self:addElement( self.textLabel )
	self.textLabel:setText( menu )
	return self
end

CoD.PlayerListRow.CreateMissingTeamMemberRow = function ( menu, controller )
	local self = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.PlayerListRow.LeagueRankAreaWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	} )
	self:makeNotFocusable()
	local f4_local1 = 0
	local f4_local2 = 0.5
	local f4_local3 = CoD.GetTeamColor( CoD.TEAM_FREE )
	local f4_local4 = LUI.UIImage.new()
	f4_local4:setLeftRight( true, true, 0, 0 )
	f4_local4:setTopBottom( true, true, 0, 0 )
	f4_local4:setRGB( f4_local3.r, f4_local3.g, f4_local3.b )
	f4_local4:setAlpha( CoD.PlayerListRow.GetRowAlpha( menu ) )
	f4_local4:setImage( RegisterMaterial( "menu_mp_lobby_bar_name" ) )
	self:addElement( f4_local4 )
	local f4_local5 = LUI.UIText.new()
	f4_local5:setLeftRight( true, false, 5, 5 )
	f4_local5:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
	f4_local5:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f4_local5:setAlpha( f4_local2 )
	f4_local5:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
	local f4_local6 = Engine.Localize( "MENU_ADD_PLAYER_FOR_TEAM_PLAY", controller )
	if controller > 1 then
		f4_local6 = Engine.Localize( "MENU_ADD_PLAYERS_FOR_TEAM_PLAY", controller )
	end
	f4_local5:setText( f4_local6 )
	self:addElement( f4_local5 )
	return self
end

CoD.PlayerListRow.SetTextEllipses = function ( f5_arg0, f5_arg1 )
	local f5_local0 = ""
	for f5_local1 = 1, f5_arg1, 1 do
		local f5_local4 = f5_local1
		f5_local0 = f5_local0 .. "."
	end
	f5_arg0:setText( f5_arg0.text .. f5_local0 )
end

CoD.PlayerListRow.UpdateEllipses = function ( f6_arg0 )
	f6_arg0.ellipsesCount = f6_arg0.ellipsesCount + f6_arg0.ellipsesIncrement
	local f6_local0 = 4
	if Engine.PartyConnectingToDedicated() then
		f6_local0 = 5
	end
	if f6_local0 <= f6_arg0.ellipsesCount then
		f6_arg0.ellipsesIncrement = -1
	elseif f6_arg0.ellipsesCount <= 0 then
		f6_arg0.ellipsesIncrement = 1
	end
	CoD.PlayerListRow.SetTextEllipses( f6_arg0, f6_arg0.ellipsesCount )
end

CoD.PlayerListRow.CreateSearchingRow = function ( f7_arg0 )
	local f7_local0 = 0
	local f7_local1 = Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH )
	if f7_local1 then
		f7_local0 = -CoD.PlayerListRow.LeagueRankAreaWidth
	end
	local self = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = f7_local0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	} )
	self:makeNotFocusable()
	local f7_local3 = 0
	local f7_local4 = 0.5
	local f7_local5 = 0
	if f7_arg0 % 2 == 0 then
		f7_local5 = 0.05
	end
	local f7_local6 = CoD.GetTeamColor( CoD.TEAM_FREE )
	self.backgroundImage = LUI.UIImage.new()
	self.backgroundImage:setLeftRight( true, true, 0, 0 )
	self.backgroundImage:setTopBottom( true, true, 0, 0 )
	self.backgroundImage:setRGB( f7_local6.r, f7_local6.g, f7_local6.b )
	self.backgroundImage:setAlpha( f7_local3 + f7_local5 )
	self.backgroundImage:setImage( RegisterMaterial( "menu_mp_lobby_bar_name" ) )
	self:addElement( self.backgroundImage )
	self.textLabel = LUI.UIText.new()
	self.textLabel:setLeftRight( true, false, 5, 5 )
	self.textLabel:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
	self.textLabel:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
	self.textLabel:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	self.textLabel:setAlpha( f7_local4 )
	self.textLabel.text = Engine.Localize( "MENU_SEARCHING_FOR_PLAYER" )
	self.textLabel:setText( self.textLabel.text )
	self:addElement( self.textLabel )
	self.textLabel.ellipsesCount = math.random( 0, 3 )
	self.textLabel.ellipsesIncrement = 1
	self.textLabel:registerEventHandler( "update_ellipses", CoD.PlayerListRow.UpdateEllipses )
	self.ellipsesTimer = LUI.UITimer.new( 250 + math.random( 0, 100 ) - 50, "update_ellipses", false, self )
	self:addElement( self.ellipsesTimer )
	local f7_local7 = f7_arg0 / 10
	local f7_local8 = -5
	if f7_local1 then
		f7_local8 = CoD.PlayerListRow.Height
	end
	self.spinner = LUI.UIImage.new()
	self.spinner:setLeftRight( false, true, -CoD.PlayerListRow.Height + f7_local8, f7_local8 )
	self.spinner:setTopBottom( true, true, 0, 0 )
	self.spinner:setImage( RegisterMaterial( "lui_loader_32" ) )
	self.spinner:setShaderVector( 0, f7_local7, 0, 0, 0 )
	self:addElement( self.spinner )
	return self
end

CoD.PlayerListRow.GainFocus = function ( f8_arg0, f8_arg1 )
	LUI.UIButton.gainFocus( f8_arg0, f8_arg1 )
	f8_arg0:dispatchEventToParent( {
		name = "playerlist_row_selected",
		playerName = f8_arg0.name,
		playerXuid = f8_arg0.playerXuid,
		leagueTeamID = f8_arg0.leagueTeamID,
		leagueTeamMemberCount = f8_arg0.leagueTeamMemberCount,
		listId = f8_arg0.playerList.id,
		listIndex = f8_arg0.rowIndex,
		controller = f8_arg1.controller
	} )
end

CoD.PlayerListRow.LoseFocus = function ( f9_arg0, f9_arg1 )
	if f9_arg0:isInFocus() then
		f9_arg0:dispatchEventToParent( {
			name = "playerlist_row_deselected",
			playerName = f9_arg0.name,
			playerXuid = f9_arg0.playerXuid,
			listId = f9_arg0.playerList.id,
			listIndex = f9_arg0.rowIndex,
			controller = f9_arg1.controller
		} )
	end
	LUI.UIButton.loseFocus( f9_arg0, f9_arg1 )
end

CoD.PlayerListRow.FetchingDone = function ( f10_arg0, f10_arg1 )
	if Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false and UIExpression.SessionMode_IsSystemlinkGame() == 0 then
		if f10_arg0.rankNumber ~= nil then
			f10_arg0.rankNumber:beginAnimation( "fade_in", CoD.PlayerListRow.RankFadeInTime, true )
			f10_arg0.rankNumber:setAlpha( 1 )
		end
		if f10_arg0.rankIcon ~= nil then
			f10_arg0.rankIcon:beginAnimation( "fade_in", CoD.PlayerListRow.RankFadeInTime, true )
			f10_arg0.rankIcon:setAlpha( 1 )
		end
	end
end

CoD.PlayerListRow.TeamCycle = function ( f11_arg0, f11_arg1 )
	if f11_arg1.xuid ~= f11_arg0.playerXuid then
		return false
	else
		CoD.PlayerListRow.Button_AnimateToTeam( f11_arg0, f11_arg1, f11_arg1.cycleTeam, true )
		return false
	end
end

CoD.PlayerListRow.GetRowAlpha = function ( f12_arg0 )
	local f12_local0 = 0
	if f12_arg0.verticalList:getNumChildren() % 2 == 0 then
		f12_local0 = 0.05
	end
	return 0.2 + f12_local0
end

CoD.PlayerListRow.AddRightColumnIcon = function ( f13_arg0, f13_arg1, f13_arg2 )
	local self = LUI.UIImage.new()
	local f13_local1 = CoD.textSize[CoD.PlayerListRow.Font] - 1 * 2
	if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) then
		local f13_local2 = -4
		self:setLeftRight( false, true, f13_local2 - f13_local1, f13_local2 )
		self:setAlpha( 0.6 )
	else
		local f13_local2 = 1
		self:setLeftRight( false, true, f13_local2, f13_local2 + f13_local1 )
	end
	self:setTopBottom( false, false, -f13_local1 / 2, f13_local1 / 2 )
	self:setImage( RegisterMaterial( f13_arg2 ) )
	f13_arg0:addElement( self )
	return self
end

CoD.PlayerListRow.CreateRow = function ( f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5 )
	local f14_local0 = ""
	if f14_arg1.tagprefix ~= nil then
		f14_local0 = f14_local0 .. f14_arg1.tagprefix
	end
	if f14_arg1.clantag ~= nil then
		f14_local0 = f14_local0 .. CoD.getClanTag( f14_arg1.clantag )
	end
	if f14_arg1.gamertag ~= nil then
		f14_local0 = f14_local0 .. f14_arg1.gamertag
	end
	local f14_local1 = 0
	if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) then
		f14_local1 = -CoD.PlayerListRow.LeagueRankAreaWidth
	end
	local self = LUI.UIButton.new( {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = f14_local1,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	} )
	if f14_arg2 == false then
		self:makeNotFocusable()
	end
	self:registerEventHandler( "gain_focus", CoD.PlayerListRow.GainFocus )
	self:registerEventHandler( "lose_focus", CoD.PlayerListRow.LoseFocus )
	self:registerEventHandler( "fetching_done", CoD.PlayerListRow.FetchingDone )
	self:registerEventHandler( "party_member_team_cycle", CoD.PlayerListRow.TeamCycle )
	self:setActionEventName( "open_playeroptions_popup" )
	self.playerList = f14_arg0
	self.playerClientNum = f14_arg1.clientNum
	self.playerXuid = f14_arg1.xuid
	self.gamerTag = f14_arg1.clean_gamertag
	if f14_arg1.leagueTeamID then
		self.leagueTeamID = f14_arg1.leagueTeamID
	else
		self.leagueTeamID = "0"
	end
	self.leagueTeamMemberCount = f14_arg1.leagueTeamMemberCount
	local f14_local3 = CoD.PlayerListRow.GetRowAlpha( f14_arg0 )
	local f14_local4 = 1
	local f14_local5 = 0
	self.backgroundAlpha = f14_local3
	local f14_local6 = CoD.GetTeamColor( f14_arg1.team, CoD.GetFaction() )
	self.backgroundColor = LUI.UIImage.new()
	self.backgroundColor:setLeftRight( true, true, 0, 0 )
	self.backgroundColor:setTopBottom( true, true, 0, 0 )
	self.backgroundColor:setRGB( f14_local6.r, f14_local6.g, f14_local6.b )
	self.backgroundColor:setAlpha( f14_local3 )
	self.backgroundColor:setImage( RegisterMaterial( "menu_mp_lobby_bar_name" ) )
	self:addElement( self.backgroundColor )
	local f14_local7 = LUI.UIImage.new()
	f14_local7:setLeftRight( true, true, 1, -1 )
	f14_local7:setTopBottom( true, false, 1, 17 )
	f14_local7:setImage( RegisterMaterial( CoD.MPZM( "menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch" ) ) )
	f14_local7:setAlpha( 0.07 )
	self:addElement( f14_local7 )
	local f14_local8 = 30
	local f14_local9 = 32
	if f14_arg1.isLocal == 1 and not CoD.isPC and not CoD.isWIIU then
		local f14_local10 = f14_arg1.controller
		if f14_local10 == nil then
			f14_local10 = 0
		end
		f14_local10 = f14_local10 + 1
		self.controllerQuadrantIcon = LUI.UIImage.new()
		self.controllerQuadrantIcon:setImage( RegisterMaterial( "controller_icon" .. f14_local10 ) )
		self.controllerQuadrantIcon:setLeftRight( true, false, -f14_local8 - f14_local9, -f14_local9 )
		self.controllerQuadrantIcon:setTopBottom( false, true, -f14_local8, 0 )
		self:addElement( self.controllerQuadrantIcon )
	end
	local f14_local10 = 0
	if f14_arg0.showVoipIcons == true then
		self.voipIcon = CoD.VoipImage.new( nil, f14_arg1.clientNum )
		self.voipIcon:setLeftRight( true, false, -f14_local9, 0 )
		self.voipIcon:setTopBottom( true, true, 0, 0 )
		self:addElement( self.voipIcon )
	end
	local f14_local11 = Engine.PartyShowTruePlayerInfo( f14_arg1.clientNum )
	local f14_local12 = 60
	local f14_local13 = 0
	local f14_local14 = Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) == true
	local f14_local15 = nil
	if f14_local14 == true then
		f14_local15 = Engine.GetLeagueStats( f14_arg1.controller )
	end
	if Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false and 0 == UIExpression.SessionMode_IsSystemlinkGame() and 1 == UIExpression.IsDemonwareFetchingDone( nil ) and (not (not f14_local15 or f14_local15.valid ~= true) or f14_local15 == nil) then
		f14_local13 = 1
	end
	if CoD.isZombie == true then
		local f14_local16 = ""
		if f14_arg1.isReady ~= nil and 0 < UIExpression.DvarFloat( nil, "party_readyPercentRequired" ) and CoD.PlaylistCategoryFilter == "playermatch" then
			if f14_arg1.isReady == true then
				f14_local16 = "menu_lobby_ready"
			else
				f14_local16 = "menu_lobby_not_ready"
			end
			local f14_local17 = RegisterMaterial( f14_local16 )
			self.isReady = LUI.UIImage.new()
			self.isReady:setLeftRight( true, false, f14_local10 + 5, f14_local10 + f14_local12 * 0.45 )
			self.isReady:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
			self.isReady:setImage( f14_local17 )
			self:addElement( self.isReady )
		else
			f14_local12 = 30
		end
	elseif f14_arg1.prestige ~= tonumber( CoD.MAX_PRESTIGE ) then
		self.rankNumber = LUI.UIText.new()
		self.rankNumber:setLeftRight( true, false, f14_local10 + 5, f14_local10 + f14_local12 )
		self.rankNumber:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
		self.rankNumber:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
		self.rankNumber:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
		self.rankNumber:setAlpha( f14_local13 )
		self:addElement( self.rankNumber )
		if f14_arg1.rank ~= nil and f14_local11 == true then
			self.rankNumber:setText( f14_arg1.rank )
		end
	end
	f14_local10 = f14_local10 + f14_local12
	if f14_arg1.rankIcon ~= nil and f14_local11 == true then
		if f14_local14 == true then
			if f14_arg1.rank ~= 0 and f14_arg1.rankIcon ~= nil and f14_arg4 == true then
				self.rankIcon = LUI.UIImage.new()
				self.rankIcon:setLeftRight( false, true, 0, CoD.PlayerListRow.Height )
				self.rankIcon:setTopBottom( true, true, 0, 0 )
				self.rankIcon:setAlpha( f14_local13 )
				self.rankIcon:setImage( f14_arg1.rankIcon )
				self:addElement( self.rankIcon )
			elseif self.rankIcon ~= nil then
				self.rankIcon:close()
				self.rankIcon = nil
			end
		else
			self.rankIcon = LUI.UIImage.new()
			self.rankIcon:setLeftRight( true, false, f14_local10 - CoD.PlayerListRow.Height - 2, f14_local10 - 2 )
			self.rankIcon:setTopBottom( true, true, 0, 0 )
			self.rankIcon:setAlpha( f14_local13 )
			self.rankIcon:setImage( f14_arg1.rankIcon )
			self:addElement( self.rankIcon )
		end
	end
	local f14_local16 = 100
	local f14_local17 = f14_local10 + 5
	if f14_local14 == true then
		f14_local17 = 0
	end
	self.playerName = LUI.UIText.new()
	self.playerName:setLeftRight( true, false, f14_local17 + 5, f14_local17 + f14_local16 )
	self.playerName:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
	self.playerName:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
	self.playerName:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	self.playerName:setAlpha( f14_local4 )
	self:addElement( self.playerName )
	if f14_arg1.isLocal == 1 then
		self.playerName:setRGB( CoD.playerYellow.r, CoD.playerYellow.g, CoD.playerYellow.b )
	elseif f14_arg1.isInParty == true then
		self.playerName:setRGB( CoD.playerBlue.r, CoD.playerBlue.g, CoD.playerBlue.b )
	end
	if f14_local11 == false then
		self.playerName:setText( Engine.Localize( "MP_MATCHEDPLAYER" ) )
		self.name = f14_local0
	elseif f14_local0 ~= nil then
		self.playerName:setText( f14_local0 )
		self.name = f14_local0
	end
	self.border = CoD.Border.new( 1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
	self.border:hide()
	self.border:registerEventHandler( "button_up", self.border.hide )
	self.border:registerEventHandler( "button_over", self.border.show )
	self:addElement( self.border )
	if Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false then
		local f14_local18 = true
		if UIExpression.AloneInPartyIgnoreSplitscreen( nil, 0 ) == 0 then
			f14_local18 = false
		end
		if f14_local11 ~= false then
			local f14_local19 = false
			local f14_local20 = false
			if f14_arg1.xuid and CoD.isXuidPrivatePartyHost( f14_arg1.xuid ) then
				f14_local19 = true
			end
			if f14_arg5 == true and f14_arg1.missingMapPacks ~= nil and f14_arg1.missingMapPacks ~= 0 then
				f14_local20 = true
			end
			if f14_local18 == false and f14_local19 == true and f14_local20 == true and CoD.isZombie ~= true then
				CoD.PlayerListRow.AddRightColumnIcon( self, f14_arg1, "menu_host_warning" )
			elseif f14_local18 == false and f14_local19 then
				CoD.PlayerListRow.AddRightColumnIcon( self, f14_arg1, CoD.MPZM( "ui_host", "ui_host_zm" ) )
			elseif f14_local20 then
				CoD.PlayerListRow.AddRightColumnIcon( self, f14_arg1, "cac_restricted" )
			end
		end
	end
	CoD.PlayerListRow.Button_AnimateToTeam( self, f14_arg1, nil, f14_arg3 )
	return self
end

CoD.PlayerListRow.Button_CycleTeamFade = function ( f15_arg0, f15_arg1 )
	f15_arg0:animateToState( "fade", UIExpression.DvarFloat( nil, "party_teamSwitchDelay" ) * 1000 * 0.33 )
	f15_arg0.playerName:completeAnimation()
	f15_arg0.playerName:beginAnimation( "restore", 200 )
	f15_arg0.playerName:setAlpha( 1 )
end

CoD.PlayerListRow.Button_AnimateToTeam = function ( f16_arg0, f16_arg1, f16_arg2, f16_arg3 )
	local f16_local0 = 1
	if f16_arg1.background == nil then
		f16_local0 = 0.5
	end
	local f16_local1 = f16_arg2
	if f16_local1 == nil then
		f16_local1 = f16_arg1.team
	end
	if not f16_arg3 and f16_local1 ~= CoD.TEAM_SPECTATOR then
		f16_local1 = CoD.TEAM_FREE
	end
	local f16_local2 = CoD.GetTeamColor( f16_local1, CoD.GetFaction() )
	f16_arg0.backgroundColor:setRGB( f16_local2.r, f16_local2.g, f16_local2.b )
	if f16_arg0.score ~= nil then
		f16_arg0.score:close()
		f16_arg0.score = nil
	end
	if f16_arg0.cycleButtonPrompt ~= nil then
		f16_arg0.cycleButtonPrompt:close()
		f16_arg0.cycleButtonPrompt = nil
	end
	if f16_arg2 ~= nil then
		local f16_local3 = CoD.GetTeamName( f16_arg2 )
		local f16_local4 = "MPUI_" .. f16_local3
		if CoD.isZombie == true then
			f16_local4 = "ZMUI_" .. f16_local3 .. "_SHORT_CAPS"
		end
		local f16_local5 = Engine.Localize( f16_local4 )
		if f16_arg2 == CoD.TEAM_SPECTATOR or f16_arg2 == CoD.TEAM_FREE then
			f16_local5 = f16_local3
		end
		f16_arg0.cycleButtonPrompt = CoD.DualButtonPrompt.new( "shoulderl", f16_local5, "shoulderr", nil, nil, nil, nil, LUI.Alignment.Center, 130 )
		f16_arg0.cycleButtonPrompt:registerAnimationState( "static", {
			alpha = 1
		} )
		f16_arg0.cycleButtonPrompt:registerAnimationState( "fade", {
			alpha = 0
		} )
		f16_arg0.cycleButtonPrompt.playerName = f16_arg0.playerName
		f16_arg0.cycleButtonPrompt.playerName:setAlpha( 0.2 )
		f16_arg0.cycleButtonPrompt:animateToState( "static", UIExpression.DvarFloat( nil, "party_teamSwitchDelay" ) * 1000 * 0.33 )
		f16_arg0.cycleButtonPrompt:registerEventHandler( "transition_complete_static", CoD.PlayerListRow.Button_CycleTeamFade )
		f16_arg0:addElement( f16_arg0.cycleButtonPrompt )
	else
		local f16_local3 = Engine.PartyShowTruePlayerInfo( f16_arg1.clientNum )
		local f16_local4 = f16_arg1.score
		local f16_local5 = -8
		if Engine.GameModeIsMode( CoD.GAMEMODE_THEATER ) == false and Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) == false and Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false and f16_local3 ~= false and f16_local4 ~= nil and f16_local4 ~= "" then
			local f16_local6 = 50
			f16_arg0.score = LUI.UIText.new()
			f16_arg0.score:setLeftRight( false, true, f16_local5 - f16_local6, f16_local5 )
			f16_arg0.score:setTopBottom( false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2 )
			f16_arg0.score:setFont( CoD.fonts[CoD.PlayerListRow.Font] )
			f16_arg0.score:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
			f16_arg0.score:setAlpha( f16_local0 )
			f16_arg0:addElement( f16_arg0.score )
			f16_arg0.score:setText( f16_local4 )
		end
	end
end

