require( "T6.HUD.SpectateTeamCardMultiTeam" )
require( "T6.CountdownTimer" )

CoD.SpectateGameStatusMultiTeam = InheritFrom( LUI.UIElement )
CoD.SpectateGameStatusMultiTeam.MaxTeamsDisplayed = 3
CoD.SpectateGameStatusMultiTeam.GameTimerWidth = 100
CoD.SpectateGameStatusMultiTeam.GameTimerHeight = CoD.SpectateTeamCardMultiTeam.Height
CoD.SpectateGameStatusMultiTeam.Padding = 0
CoD.SpectateGameStatusMultiTeam.StatusPadding = 2
CoD.SpectateGameStatusMultiTeam.DockPadding = 20
CoD.SpectateGameStatusMultiTeam.Width = CoD.SpectateTeamCardMultiTeam.RealWidth * CoD.SpectateGameStatusMultiTeam.MaxTeamsDisplayed
CoD.SpectateGameStatusMultiTeam.Font = CoD.fonts.ExtraSmall
CoD.SpectateGameStatusMultiTeam.FontSize = CoD.textSize.ExtraSmall
CoD.SpectateGameStatusMultiTeam.GameTimerFont = CoD.SpectateGameStatusMultiTeam.Font
CoD.SpectateGameStatusMultiTeam.GameTimerFontSize = CoD.SpectateGameStatusMultiTeam.FontSize
CoD.SpectateGameStatusMultiTeam.UnlimitedGameTimerFontSize = CoD.SpectateGameStatusMultiTeam.FontSize
CoD.SpectateGameStatusMultiTeam.Height = 32 + CoD.SpectateTeamCardMultiTeam.Height
CoD.SpectateGameStatusMultiTeam.Dock = function ( f1_arg0, f1_arg1 )
	local f1_local0 = f1_arg1.safeX + f1_arg1.viewportWidth / 2 - CoD.SpectateGameStatusMultiTeam.Width / 2
	local f1_local1 = f1_arg1.safeY - CoD.SpectateGameStatusMultiTeam.Height - CoD.SpectateGameStatusMultiTeam.DockPadding
	f1_arg0:beginAnimation( "move", 200 )
	f1_arg0:setLeftRight( true, false, f1_local0, f1_local0 + CoD.SpectateGameStatusMultiTeam.Width )
	f1_arg0:setTopBottom( true, false, f1_local1, f1_local1 + CoD.SpectateGameStatusMultiTeam.Height )
end

CoD.SpectateGameStatusMultiTeam.Undock = function ( f2_arg0, f2_arg1 )
	f2_arg0:beginAnimation( "move", 200 )
	f2_arg0:setLeftRight( false, false, -(CoD.SpectateGameStatusMultiTeam.Width / 2), CoD.SpectateGameStatusMultiTeam.Width / 2 )
	f2_arg0:setTopBottom( true, false, 0, CoD.SpectateGameStatusMultiTeam.Height )
end

CoD.SpectateGameStatusMultiTeam.SetupGameTimer = function ( f3_arg0 )
	if Engine.GetGametypeSetting( "timeLimit" ) == 0 then
		local self = LUI.UIText.new()
		self:setLeftRight( true, true, 0, 0 )
		self:setTopBottom( true, false, 0, CoD.SpectateGameStatusMultiTeam.UnlimitedGameTimerFontSize )
		self:setFont( CoD.SpectateGameStatusTwoTeam.GameTimerFont )
		self:setText( Engine.Localize( "MPUI_UNLIMITED_TIME_CAPS" ) )
		return self
	else
		local self = CoD.GameTimer.new()
		self:setLeftRight( true, true, 0, 0 )
		self:setTopBottom( true, false, 0, CoD.SpectateGameStatusMultiTeam.GameTimerFontSize )
		self:setRGB( 0.7, 0.7, 0.7 )
		self:setAlpha( 1 )
		self.VSTitle = nil
		return self
	end
end

CoD.SpectateGameStatusMultiTeam.UpdateScoresSingleTeam = function ( f4_arg0, f4_arg1 )
	local f4_local0 = Engine.GetInGamePlayerList( f4_arg0.m_ownerController, CoD.TEAM_FREE )
	if #f4_local0 == 0 then
		return 
	end
	local f4_local1, f4_local2 = false
	local f4_local3 = false
	if f4_local0[1].scoreBoardColumn1 > 0 then
		f4_local3 = true
	end
	if #f4_local0 < f4_arg0.m_maxDisplayedTeams then
		local f4_local4 = #f4_local0
	end
	local f4_local5 = f4_arg0.m_maxDisplayedTeams
	if #f4_local0 < f4_local5 then
		f4_local5 = #f4_local0
	end
	for f4_local6 = 1, f4_arg0.m_maxDisplayedTeams, 1 do
		local f4_local9 = nil
		if f4_local6 <= f4_local5 then
			if f4_arg0.m_selectedTeam ~= nil then
				if f4_local0[f4_local6].clientNum == f4_arg0.m_selectedTeam then
					f4_local1 = true
					f4_local2 = f4_local6
				elseif f4_local1 == false and f4_local6 == f4_local5 then
					f4_local2 = f4_local5
					break
				end
			end
			if f4_local3 == true then
				f4_local9 = f4_local6
			end
			f4_arg0.m_teamCards[f4_local6]:populate( f4_local0[f4_local6].clientNum, f4_local9, f4_local0[f4_local6].scoreBoardColumn1, true )
		end
		f4_arg0.m_teamCards[f4_local6]:clear()
	end
	if f4_arg0.m_selectedTeam ~= nil and f4_local1 == false then
		local f4_local6 = 0
		local f4_local7 = 0
		for f4_local8 = 1, #f4_local0, 1 do
			if f4_local0[f4_local8].clientNum == f4_arg0.m_selectedTeam then
				f4_local6 = f4_local0[f4_local8].scoreBoardColumn1
				f4_local7 = f4_local8
				break
			end
		end
		local f4_local8 = nil
		if f4_local3 == true then
			f4_local8 = f4_local7
		end
		f4_arg0.m_teamCards[f4_local5]:populate( f4_arg0.m_selectedTeam, f4_local8, f4_local6, true )
	end
	if f4_arg1.shouldPulse == true and f4_local2 ~= nil then
		f4_arg0.m_teamCards[f4_local2]:processEvent( {
			name = "spectate_teamstatuscard_pulse"
		} )
	end
end

CoD.SpectateGameStatusMultiTeam.UpdateScoresMultiTeam = function ( f5_arg0, f5_arg1 )
	local f5_local0 = f5_arg1.teams
	if #f5_local0 == 0 then
		return 
	end
	local f5_local1, f5_local2 = false
	local f5_local3 = false
	if f5_local0[1].score > 0 then
		f5_local3 = true
	end
	for f5_local4 = 1, f5_arg0.m_maxDisplayedTeams, 1 do
		if f5_arg0.m_selectedTeam ~= nil then
			if f5_local0[f5_local4].team == f5_arg0.m_selectedTeam then
				f5_local1 = true
				f5_local2 = f5_local4
			else
				if f5_local1 == false and f5_local4 == f5_arg0.m_maxDisplayedTeams then
					f5_local2 = f5_arg0.m_maxDisplayedTeams
					break
				else
					local f5_local7 = nil
					if f5_local3 == true and f5_local4 <= #f5_local0 then
						f5_local7 = f5_local4
					end
				end
				f5_arg0.m_teamCards[f5_local4]:populate( f5_local0[f5_local4].team, f5_local7, f5_local0[f5_local4].score )
			end
		end
		local f5_local7 = nil
		if f5_local3 == true and f5_local4 <= #f5_local0 then
			f5_local7 = f5_local4
		end
	end
	if f5_arg0.m_selectedTeam ~= nil and f5_local1 == false then
		local f5_local4 = 0
		local f5_local5 = 0
		for f5_local6 = 1, #f5_local0, 1 do
			if f5_local0[f5_local6].team == f5_arg0.m_selectedTeam then
				f5_local4 = f5_local0[f5_local6].score
				f5_local5 = f5_local6
				break
			end
		end
		local f5_local6 = nil
		if f5_local3 == true then
			f5_local6 = f5_local5
		end
		f5_arg0.m_teamCards[f5_arg0.m_maxDisplayedTeams]:populate( f5_arg0.m_selectedTeam, f5_local6, f5_local4 )
	end
	if f5_arg1.shouldPulse == true and f5_local2 ~= nil then
		f5_arg0.m_teamCards[f5_local2]:processEvent( {
			name = "spectate_teamstatuscard_pulse"
		} )
	end
end

CoD.SpectateGameStatusMultiTeam.UpdateScores = function ( f6_arg0, f6_arg1 )
	if f6_arg0.m_teamCount == 1 then
		CoD.SpectateGameStatusMultiTeam.UpdateScoresSingleTeam( f6_arg0, f6_arg1 )
	else
		CoD.SpectateGameStatusMultiTeam.UpdateScoresMultiTeam( f6_arg0, f6_arg1 )
	end
end

CoD.SpectateGameStatusMultiTeam.PlayerSelected = function ( f7_arg0, f7_arg1 )
	if f7_arg1.info.teamID == CoD.TEAM_SPECTATOR then
		return 
	elseif f7_arg0.m_teamCount == 1 then
		f7_arg0.m_selectedTeam = f7_arg1.info.clientNum
		f7_arg0.m_selectedClient = f7_arg1.info.clientNum
	else
		f7_arg0.m_selectedTeam = f7_arg1.info.teamID
		f7_arg0.m_selectedClient = f7_arg1.info.clientNum
	end
	f7_arg1.shouldPulse = true
	CoD.SpectateGameStatusMultiTeam.UpdateScores( f7_arg0, f7_arg1 )
end

CoD.SpectateGameStatusMultiTeam.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	self:setLeftRight( false, false, -(CoD.SpectateGameStatusMultiTeam.Width / 2), CoD.SpectateGameStatusMultiTeam.Width / 2 )
	self:setTopBottom( true, false, 0, CoD.SpectateGameStatusMultiTeam.Height )
	self:setClass( CoD.SpectateGameStatusMultiTeam )
	self.m_ownerController = menu
	self.m_teamCount = controller
	self.m_selectedTeam = nil
	self.m_selectedClient = nil
	self.m_teamCards = {}
	if controller == 1 or controller >= CoD.SpectateGameStatusMultiTeam.MaxTeamsDisplayed then
		self.m_maxDisplayedTeams = CoD.SpectateGameStatusMultiTeam.MaxTeamsDisplayed
	else
		self.m_maxDisplayedTeams = controller
	end
	local f8_local1 = LUI.UIImage.new()
	f8_local1:setLeftRight( true, true, 32, -32 )
	f8_local1:setTopBottom( true, false, 0, 32 )
	f8_local1:setImage( RegisterMaterial( "hud_shoutcasting_bar_stretch" ) )
	f8_local1:setAlpha( 1 )
	local f8_local2 = LUI.UIImage.new()
	f8_local2:setLeftRight( true, false, 32, 0 )
	f8_local2:setTopBottom( true, false, 0, 32 )
	f8_local2:setImage( RegisterMaterial( "hud_shoutcasting_bar_end" ) )
	f8_local2:setAlpha( 1 )
	local f8_local3 = LUI.UIImage.new()
	f8_local3:setLeftRight( false, true, -32, 0 )
	f8_local3:setTopBottom( true, false, 0, 32 )
	f8_local3:setImage( RegisterMaterial( "hud_shoutcasting_bar_end" ) )
	f8_local3:setAlpha( 1 )
	local f8_local4 = LUI.UIText.new()
	f8_local4:setLeftRight( true, true, 0, 0 )
	f8_local4:setTopBottom( true, false, 5, CoD.SpectateGameStatusMultiTeam.FontSize + 5 )
	f8_local4:setFont( CoD.SpectateGameStatusMultiTeam.Font )
	f8_local4:setAlignment( LUI.Alignment.Center )
	f8_local4:setRGB( 0.6, 0.6, 0.6 )
	f8_local4:setAlpha( 1 )
	local f8_local5 = {}
	local f8_local6 = Engine.Localize( UIExpression.TableLookup( nil, CoD.gametypesTable, 0, 0, 1, Dvar.ui_gametype:get(), 7 ) )
	local f8_local7 = " - "
	local f8_local8 = Engine.Localize( UIExpression.TableLookup( nil, CoD.mapsTable, 0, Dvar.ui_mapname:get(), 3 ) )
	f8_local5 = f8_local6
	f8_local6 = Engine.GetGametypeSetting( "roundLimit" )
	f8_local7 = Engine.GetRoundsPlayed( menu )
	if f8_local7 ~= nil and f8_local6 ~= 1 then
		table.insert( f8_local5, " - " )
		if f8_local6 == 0 then
			table.insert( f8_local5, Engine.Localize( "MPUI_ROUND_X", f8_local7 + 1 ) )
		else
			table.insert( f8_local5, Engine.Localize( "MPUI_ROUND_X_OF_Y", f8_local7 + 1, f8_local6 ) )
		end
	end
	f8_local4:setText( table.concat( f8_local5 ) )
	f8_local8 = CoD.SpectateGameStatusMultiTeam.SetupGameTimer( menu )
	f8_local8:setFont( CoD.SpectateGameStatusMultiTeam.Font )
	f8_local8:setAlignment( LUI.Alignment.Left )
	f8_local8:setRGB( 0.6, 0.6, 0.6 )
	f8_local8:setAlpha( 1 )
	local f8_local9 = LUI.UIElement.new()
	f8_local9:setLeftRight( true, false, 25, 25 + CoD.SpectateGameStatusMultiTeam.GameTimerWidth )
	f8_local9:setTopBottom( true, false, 5, CoD.SpectateGameStatusMultiTeam.GameTimerHeight + 5 )
	f8_local9:addElement( f8_local8 )
	self.statusList = LUI.UIHorizontalList.new()
	self.statusList:setLeftRight( true, true, 0, 0 )
	self.statusList:setTopBottom( true, true, 32, 0 )
	self.statusList:setSpacing( -75 )
	self.statusList:setAlignment( LUI.Alignment.Right )
	self:addElement( f8_local2 )
	self:addElement( f8_local1 )
	self:addElement( f8_local3 )
	self:addElement( f8_local4 )
	self:addElement( f8_local9 )
	self:addElement( self.statusList )
	local f8_local10 = false
	if controller == 1 then
		f8_local10 = true
	end
	for f8_local11 = 1, self.m_maxDisplayedTeams, 1 do
		local f8_local14 = self.m_maxDisplayedTeams - f8_local11 + 1
		self.m_teamCards[f8_local14] = CoD.SpectateTeamCardMultiTeam.new( menu, f8_local10 )
		if controller == 1 then
			self.m_teamCards[f8_local14]:populate( CoD.TEAM_FREE, "", "0" )
		else
			self.m_teamCards[f8_local14]:populate( f8_local14, "", "0" )
		end
		self.statusList:addElement( self.m_teamCards[f8_local14] )
	end
	self.modeStatus = CoD.SpectateGameModeStatus.GetMenu( menu, CoD.SpectateGameStatusMultiTeam.Height - 10, CoD.SpectateTeamCardMultiTeam.Width )
	if self.modeStatus ~= nil then
		self.modeStatus.m_gameStatus = self
		self.modeStatus:processEvent( {
			name = "initialize_game_mode_status",
			controller = menu
		} )
		self:addElement( self.modeStatus )
	end
	return self
end

CoD.SpectateGameStatusMultiTeam:registerEventHandler( "hud_update_scores", CoD.SpectateGameStatusMultiTeam.UpdateScores )
CoD.SpectateGameStatusMultiTeam:registerEventHandler( "spectate_player_selected", CoD.SpectateGameStatusMultiTeam.PlayerSelected )
CoD.SpectateGameStatusMultiTeam:registerEventHandler( "spectate_dock", CoD.SpectateGameStatusMultiTeam.Dock )
CoD.SpectateGameStatusMultiTeam:registerEventHandler( "spectate_undock", CoD.SpectateGameStatusMultiTeam.Undock )
