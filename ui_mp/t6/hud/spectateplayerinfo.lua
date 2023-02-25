require( "T6.CoD9Button" )

CoD.SpectatePlayerInfo = InheritFrom( LUI.UIElement )
CoD.SpectatePlayerInfo.MaxRows = 18
CoD.SpectatePlayerInfo.FontSize = CoD.textSize.ExtraSmall
CoD.SpectatePlayerInfo.Font = CoD.fonts.ExtraSmall
CoD.SpectatePlayerInfo.HeaderFontSize = CoD.textSize.Condensed
CoD.SpectatePlayerInfo.HeaderFont = CoD.fonts.Condensed
CoD.SpectatePlayerInfo.TeamWidth = 75
CoD.SpectatePlayerInfo.RowWidth = 300
CoD.SpectatePlayerInfo.HeaderHeight = 50
CoD.SpectatePlayerInfo.RowHeight = CoD.SpectatePlayerInfo.FontSize + 6
CoD.SpectatePlayerInfo.StatusIconSize = CoD.SpectatePlayerInfo.RowHeight - 8
CoD.SpectatePlayerInfo.RowSpacing = 3
CoD.SpectatePlayerInfo.RowTextWidth = 240
CoD.SpectatePlayerInfo.RowStatusWidth = 20
CoD.SpectatePlayerInfo.Top = 10
function SpectatePlayerInfo_RowGainFocus( f1_arg0, f1_arg1 )
	f1_arg0.opticalBorder:setAlpha( 1 )
	f1_arg0.highlighted = true
	LUI.UIButton.gainFocus( f1_arg0, f1_arg1 )
	Dvar.shoutcastHighlightedClient:set( f1_arg0.clientNum )
	f1_arg0.eventTarget:dispatchEventToParent( {
		name = "update_spectate_buttom_prompts",
		invalidPlayer = f1_arg0.invalidPlayer
	} )
end

function SpectatePlayerInfo_RowLoseFocus( f2_arg0, f2_arg1 )
	f2_arg0.opticalBorder:setAlpha( 0 )
	f2_arg0.highlighted = false
	LUI.UIButton.loseFocus( f2_arg0, f2_arg1 )
end

function SpectatePlayerInfo_AddBorder( f3_arg0 )
	local opticalBorder = CoD.Border.new( 1, 1, 1, 1, 2 )
	opticalBorder:setAlpha( 0 )
	f3_arg0:addElement( opticalBorder )
	f3_arg0.opticalBorder = opticalBorder
	
end

function SpectatePlayerInfo_RowSelected( f4_arg0, f4_arg1 )
	local f4_local0 = f4_arg1.button
	if f4_local0.invalidPlayer ~= nil and f4_local0.invalidPlayer == true then
		return 
	end
	f4_local0.eventTarget.m_selectedClientNum = f4_local0.clientNum
	Engine.SendMenuResponse( f4_arg1.controller, "spectate", f4_local0.clientNum )
	f4_local0.eventTarget:processEvent( {
		name = "spectate_deselect_rows"
	} )
	f4_local0.text:setRGB( 1, 1, 0 )
	Dvar.shoutcastSelectedClient:set( f4_local0.clientNum )
	if true == Engine.IsDemoShoutcaster() then
		local f4_local1 = f4_arg0:getParent()
		if f4_local1 ~= nil then
			Engine.Exec( f4_local1.m_ownerController, "demo_switchplayer 0 " .. f4_local0.clientNum )
		end
	end
	f4_local0.eventTarget:dispatchEventToParent( {
		name = "spectate_row_selected"
	} )
end

function SpectatePlayerInfo_RowDeselected( f5_arg0, f5_arg1 )
	f5_arg0.text:setRGB( 0.7, 0.7, 0.7 )
end

function SpectatePlayerInfo_UpdatePlayerObjective( f6_arg0, f6_arg1 )
	local f6_local0 = f6_arg1.controller
	if f6_arg0.objectiveIndex == nil then
		f6_arg0.objectiveIndex = f6_arg1.objectiveIndex
	end
	if f6_arg0.objectiveIndex ~= f6_arg1.objectiveIndex and Engine.ObjectiveIsPlayerUsing( f6_local0, f6_arg0.objectiveIndex, f6_arg0.clientNum ) then
		return 
	end
	f6_arg0.objectiveIndex = f6_arg1.objectiveIndex
	local f6_local1 = Engine.ObjectiveIsPlayerUsing( f6_local0, f6_arg1.objectiveIndex, f6_arg0.clientNum )
	if not f6_local1 then
		f6_local1 = f6_arg1.objectiveEntity == f6_arg0.clientNum
	end
	if f6_local1 then
		f6_arg0.currentObjectiveIcon = RegisterMaterial( f6_arg1.materialName )
	else
		f6_arg0.currentObjectiveIcon = nil
	end
end

function SpectatePlayerInfo_CreatePlayerRow( f7_arg0 )
	local self = LUI.UIButton.new( {
		left = 0,
		right = CoD.SpectatePlayerInfo.RowWidth,
		top = 0,
		bottom = CoD.SpectatePlayerInfo.RowHeight,
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false
	}, "spectate_playerinfo_row_pressed" )
	LUI.UIButton.setGainFocusSFX( self, nil )
	LUI.UIButton.setActionSFX( self, nil )
	self.eventTarget = f7_arg0
	self.bg = LUI.UIImage.new()
	self.bg:setLeftRight( true, true, 0, 0 )
	self.bg:setTopBottom( true, true, 0, 0 )
	self.bg:setRGB( 0, 0, 0 )
	self.bg:setAlpha( 0.5 )
	self.statusBg = LUI.UIImage.new()
	self.statusBg:setLeftRight( false, true, -64, -32 )
	self.statusBg:setTopBottom( false, false, -CoD.SpectatePlayerInfo.RowHeight / 2, CoD.SpectatePlayerInfo.RowHeight / 2 )
	self.statusBg:setRGB( 0, 0, 0 )
	self.statusBg:setAlpha( 0.5 )
	local f7_local1 = (CoD.SpectatePlayerInfo.RowHeight - CoD.SpectatePlayerInfo.StatusIconSize) / 2 + 3
	self.statusIcon = LUI.UIImage.new()
	self.statusIcon:setLeftRight( false, true, -32 - f7_local1 - CoD.SpectatePlayerInfo.StatusIconSize, -32 - f7_local1 )
	self.statusIcon:setTopBottom( false, false, -CoD.SpectatePlayerInfo.StatusIconSize / 2, CoD.SpectatePlayerInfo.StatusIconSize / 2 )
	self.statusIcon:setAlpha( 0 )
	self.text = LUI.UIText.new()
	self.text:setLeftRight( true, false, 5, CoD.SpectatePlayerInfo.RowWidth )
	self.text:setTopBottom( false, false, -(CoD.SpectatePlayerInfo.FontSize / 2), CoD.SpectatePlayerInfo.FontSize / 2 )
	self.text:setRGB( 0.7, 0.7, 0.7 )
	self.text:setFont( CoD.SpectatePlayerInfo.Font )
	self.text:setAlpha( 1 )
	self.currentStreak = LUI.UIText.new()
	self.currentStreak:setLeftRight( false, true, -32, 0 )
	self.currentStreak:setTopBottom( false, false, -(CoD.SpectatePlayerInfo.FontSize * 0.95 / 2), CoD.SpectatePlayerInfo.FontSize * 0.95 / 2 )
	self.currentStreak:setRGB( 0.7, 0.7, 0.7 )
	self.currentStreak:setAlpha( 1 )
	self.currentStreak:setFont( CoD.SpectatePlayerInfo.Font )
	self.currentStreak:setAlignment( LUI.Alignment.Center )
	self:addElement( self.bg )
	self:addElement( self.text )
	self:addElement( self.statusBg )
	self:addElement( self.statusIcon )
	self:addElement( self.currentStreak )
	self:registerEventHandler( "gain_focus", SpectatePlayerInfo_RowGainFocus )
	self:registerEventHandler( "lose_focus", SpectatePlayerInfo_RowLoseFocus )
	self:registerEventHandler( "spectate_deselect_rows", SpectatePlayerInfo_RowDeselected )
	self:registerEventHandler( "update_player_objective", SpectatePlayerInfo_UpdatePlayerObjective )
	self:makeFocusable()
	SpectatePlayerInfo_AddBorder( self )
	return self
end

function SpectatePlayerInfo_SetPlayerRow( f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7 )
	local f8_local0 = f8_arg0:getParent()
	if f8_local0 ~= nil and f8_local0.tabManager.tabSelected == CoD.SpectateSidePanel.DisplayOptionsTabIndex then
		return 
	end
	local f8_local1 = f8_arg1.currentObjectiveIcon
	f8_arg1.text:setText( f8_arg2 )
	if f8_arg5 ~= nil then
		f8_arg1.statusIcon:setImage( f8_arg5 )
		f8_arg1.statusIcon:setAlpha( 1 )
	elseif f8_local1 ~= nil then
		f8_arg1.statusIcon:setImage( f8_local1 )
		f8_arg1.statusIcon:setAlpha( 1 )
	else
		f8_arg1.statusIcon:setAlpha( 0 )
	end
	f8_arg1.clientNum = f8_arg3
	f8_arg1.team = f8_arg4
	f8_arg1.invalidPlayer = f8_arg7
	if f8_arg6 ~= nil then
		f8_arg1.currentStreak:setText( f8_arg6 )
	else
		f8_arg1.currentStreak:setText( "" )
	end
	if f8_arg0.m_selectedClientNum ~= nil and f8_arg0.m_selectedClientNum == f8_arg3 then
		f8_arg1.text:setRGB( 1, 1, 0 )
		if f8_arg0.m_overrideFocus == true then
			f8_arg1:processEvent( {
				name = "gain_focus",
				controller = f8_arg0.m_ownerController
			} )
			f8_arg0.m_overrideFocus = false
		end
	else
		f8_arg1.text:setRGB( 0.7, 0.7, 0.7 )
	end
end

CoD.SpectatePlayerInfo.TeamListenIn = function ( f9_arg0, f9_arg1 )
	if f9_arg0.m_team ~= nil and f9_arg0.m_team == f9_arg1.team then
		f9_arg0.isListening:setAlpha( 1 )
	else
		f9_arg0.isListening:setAlpha( 0 )
	end
end

function SpectatePlayer_CreateTeamInfo()
	local self = LUI.UIElement.new()
	self.m_team = nil
	self:setLeftRight( true, false, 0, CoD.SpectatePlayerInfo.TeamWidth )
	self:setTopBottom( true, false, 0, 0 )
	self:setAlpha( 1 )
	self.text = LUI.UIText.new()
	self.text:setLeftRight( true, true, 0, -18 )
	self.text:setTopBottom( true, false, 4, CoD.SpectatePlayerInfo.FontSize + 4 )
	self.text:setRGB( 1, 1, 1 )
	self.text:setAlpha( 1 )
	self.text:setFont( CoD.SpectatePlayerInfo.Font )
	self.text:setAlignment( LUI.Alignment.Right )
	self.textSup = LUI.UIText.new()
	self.textSup:setLeftRight( false, true, -16, -2 )
	self.textSup:setTopBottom( true, false, 4, 18 )
	self.textSup:setRGB( 1, 1, 1 )
	self.textSup:setAlpha( 1 )
	self.textSup:setFont( CoD.fonts.ExtraSmall )
	self.textSup:setAlignment( LUI.Alignment.Left )
	local f10_local1 = LUI.UIElement.new()
	f10_local1:setLeftRight( true, false, CoD.SpectatePlayerInfo.TeamWidth, CoD.SpectatePlayerInfo.TeamWidth + CoD.SpectatePlayerInfo.RowWidth )
	f10_local1:setTopBottom( true, true, 0, 0 )
	self.bg = LUI.UIImage.new()
	self.bg:setLeftRight( true, true, -40, 0 )
	self.bg:setTopBottom( true, true, 0, 0 )
	self.bg:setAlpha( 0 )
	local f10_local2 = LUI.UIImage.new()
	f10_local2:setLeftRight( true, false, -40, -3 )
	f10_local2:setTopBottom( true, true, 0, 0 )
	f10_local2:setRGB( 0, 0, 0 )
	f10_local2:setAlpha( 0.2 )
	self.icon = LUI.UIImage.new()
	self.icon:setLeftRight( false, false, -60, 60 )
	self.icon:setTopBottom( false, false, -60, 60 )
	self.icon:setAlpha( 0 )
	self.isFirst = LUI.UIImage.new()
	self.isFirst:setLeftRight( false, true, -55, -35 )
	self.isFirst:setTopBottom( true, false, 2, 22 )
	self.isFirst:setImage( RegisterMaterial( "spectator_1st_star" ) )
	self.isFirst:setRGB( 1, 1, 1 )
	self.isFirst:setAlpha( 0 )
	local f10_local3 = 32
	self.isListening = LUI.UIImage.new()
	self.isListening:setLeftRight( false, true, -55 - f10_local3, -55 )
	self.isListening:setTopBottom( true, false, -3, -3 + f10_local3 )
	self.isListening:setImage( RegisterMaterial( "listen_in" ) )
	self.isListening:setRGB( 1, 1, 1 )
	self.isListening:setAlpha( 0 )
	f10_local1:addElement( self.bg )
	f10_local1:addElement( f10_local2 )
	f10_local1:addElement( self.icon )
	self:addElement( f10_local1 )
	self:addElement( self.text )
	self:addElement( self.textSup )
	self:addElement( self.isFirst )
	self:addElement( self.isListening )
	self:registerEventHandler( "spectate_team_listen_in", CoD.SpectatePlayerInfo.TeamListenIn )
	return self
end

function SpectatePlayerInfo_SetTeamInfo( f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4 )
	f11_arg0:beginAnimation( "place", 0 )
	f11_arg0:setLeftRight( true, false, 0, CoD.SpectatePlayerInfo.TeamWidth - CoD.SpectatePlayerInfo.RowSpacing )
	f11_arg0:setTopBottom( true, false, f11_arg1, f11_arg1 + f11_arg2 )
	local f11_local0, f11_local1, f11_local2, f11_local3 = CoD.SpectateHUD.GetTeamColor( f11_arg3 )
	local f11_local4 = CoD.SpectateHUD.GetTeamIcon( f11_arg3 )
	f11_arg0.bg:setRGB( f11_local0, f11_local1, f11_local2 )
	f11_arg0.bg:setAlpha( 0.1 )
	if f11_arg4 >= 3 and f11_local4 ~= nil then
		f11_arg0.icon:setImage( f11_local4 )
		f11_arg0.icon:setAlpha( 0.4 )
	else
		f11_arg0.icon:setAlpha( 0 )
	end
end

function SpectatePlayerInfo_TeamPosToText( f12_arg0 )
	local f12_local0 = tonumber( f12_arg0 )
	if f12_local0 ~= nil and f12_local0 >= 1 and f12_local0 <= 12 then
		return Engine.Localize( "MPUI_POSITION_" .. f12_local0 )
	else
		return ""
	end
end

function SpectatePlayerInfo_TeamPosToSuperscript( f13_arg0 )
	local f13_local0 = tonumber( f13_arg0 )
	if f13_local0 ~= nil and f13_local0 >= 1 and f13_local0 <= 12 then
		if f13_local0 == 1 then
			return Engine.Localize( "MPUI_SUP_ST" )
		elseif f13_local0 == 2 then
			return Engine.Localize( "MPUI_SUP_ND" )
		elseif f13_local0 == 3 then
			return Engine.Localize( "MPUI_SUP_RD" )
		else
			return Engine.Localize( "MPUI_SUP_TH" )
		end
	else
		return ""
	end
end

function SpectatePlayerInfo_SetTeamInfoText( f14_arg0, f14_arg1, f14_arg2, f14_arg3 )
	f14_arg1.m_team = f14_arg3
	if f14_arg2 ~= nil then
		f14_arg1.text:setText( SpectatePlayerInfo_TeamPosToText( f14_arg2 ) )
		f14_arg1.textSup:setText( SpectatePlayerInfo_TeamPosToSuperscript( f14_arg2 ) )
		if f14_arg2 == 1 then
			f14_arg1.isFirst:setAlpha( 1 )
		else
			f14_arg1.isFirst:setAlpha( 0 )
		end
	end
end

function SpectatePlayerInfo_GetPlayerPosition( f15_arg0, f15_arg1 )
	for f15_local0 = 1, #f15_arg0, 1 do
		if f15_arg0[f15_local0].clientNum == f15_arg1 then
			return f15_local0
		end
	end
	return 0
end

function SpectatePlayerInfo_GetTeamPosition( f16_arg0, f16_arg1 )
	for f16_local0 = 1, #f16_arg0, 1 do
		if f16_arg0[f16_local0].team == f16_arg1 then
			return f16_local0
		end
	end
	return 0
end

CoD.SpectatePlayerInfo.SlideIn = function ( f17_arg0, f17_arg1 )
	local f17_local0 = Engine.GetSpectatingClientInfo( f17_arg0.m_ownerController )
	f17_arg0.m_selectedClientNum = f17_local0.clientNum
	f17_arg0.m_overrideFocus = true
end

CoD.SpectatePlayerInfo.UpdateSingleTeam = function ( f18_arg0, f18_arg1 )
	local f18_local0 = 0
	local f18_local1 = Engine.GetInGamePlayerList( f18_arg0.m_ownerController, CoD.TEAM_FREE, false )
	local f18_local2 = Engine.GetInGamePlayerList( f18_arg0.m_ownerController, CoD.TEAM_FREE, true )
	for f18_local3 = 1, #f18_local2, 1 do
		local f18_local6 = f18_arg0.m_rowAllocator:alloc()
		SpectatePlayerInfo_SetPlayerRow( f18_arg0, f18_local6, f18_local2[f18_local3].playerName, f18_local2[f18_local3].clientNum, CoD.TEAM_FREE, f18_local2[f18_local3].statusIcon, f18_local2[f18_local3].currentStreak, f18_local2[f18_local3].invalidPlayer )
		f18_arg0.playerList:addElement( f18_local6 )
	end
	local f18_local3 = 1
	for f18_local4 = 1, #f18_local2, 1 do
		local f18_local8 = f18_local0 * CoD.SpectatePlayerInfo.RowHeight + f18_local0 * CoD.SpectatePlayerInfo.RowSpacing
		local f18_local9 = f18_local3 * CoD.SpectatePlayerInfo.RowHeight + f18_local3 * CoD.SpectatePlayerInfo.RowSpacing - CoD.SpectatePlayerInfo.RowSpacing
		local f18_local10 = f18_arg0.m_teamAllocator:alloc()
		SpectatePlayerInfo_SetTeamInfo( f18_local10, f18_local8, f18_local9, CoD.TEAM_FREE, 1 )
		local f18_local11 = nil
		if f18_local1 ~= nil and 0 < f18_local1[1].playerScore then
			f18_local11 = SpectatePlayerInfo_GetPlayerPosition( f18_local1, f18_local2[f18_local4].clientNum )
		end
		SpectatePlayerInfo_SetTeamInfoText( f18_arg0, f18_local10, f18_local11, CoD.TEAM_FREE )
		f18_arg0.teamList:addElement( f18_local10 )
		f18_local0 = f18_local0 + f18_local3
	end
end

CoD.SpectatePlayerInfo.UpdateMultiTeam = function ( f19_arg0, f19_arg1 )
	local f19_local0 = 0
	local f19_local1 = f19_arg0.m_teamCount
	for f19_local2 = 1, f19_local1, 1 do
		local f19_local5 = Engine.GetInGamePlayerList( f19_arg0.m_ownerController, f19_local2, true )
		for f19_local6 = 1, #f19_local5, 1 do
			local f19_local9 = f19_arg0.m_rowAllocator:alloc()
			SpectatePlayerInfo_SetPlayerRow( f19_arg0, f19_local9, f19_local5[f19_local6].playerName, f19_local5[f19_local6].clientNum, f19_local2, f19_local5[f19_local6].statusIcon, f19_local5[f19_local6].currentStreak, f19_local5[f19_local6].invalidPlayer )
			f19_arg0.playerList:addElement( f19_local9 )
		end
		local f19_local6 = #f19_local5
		if 0 < f19_local6 then
			local f19_local7 = f19_local0 * CoD.SpectatePlayerInfo.RowHeight + f19_local0 * CoD.SpectatePlayerInfo.RowSpacing
			local f19_local8 = f19_local6 * CoD.SpectatePlayerInfo.RowHeight + f19_local6 * CoD.SpectatePlayerInfo.RowSpacing - CoD.SpectatePlayerInfo.RowSpacing
			local f19_local10 = f19_arg0.m_teamAllocator:alloc()
			SpectatePlayerInfo_SetTeamInfo( f19_local10, f19_local7, f19_local8, f19_local2, f19_local6 )
			local f19_local9 = nil
			if f19_arg1 ~= nil and 0 < f19_arg1[1].score then
				f19_local9 = SpectatePlayerInfo_GetTeamPosition( f19_arg1, f19_local2 )
			end
			SpectatePlayerInfo_SetTeamInfoText( f19_arg0, f19_local10, f19_local9, f19_local2 )
			f19_arg0.teamList:addElement( f19_local10 )
			f19_local0 = f19_local0 + f19_local6
		end
	end
end

CoD.SpectatePlayerInfo.Update = function ( f20_arg0, f20_arg1 )
	f20_arg0.playerList:removeAllChildren()
	f20_arg0.teamList:removeAllChildren()
	f20_arg0.m_rowAllocator:freeAll()
	f20_arg0.m_teamAllocator:freeAll()
	if f20_arg0.m_teamCount > 1 then
		CoD.SpectatePlayerInfo.UpdateMultiTeam( f20_arg0, f20_arg1 )
	else
		CoD.SpectatePlayerInfo.UpdateSingleTeam( f20_arg0, f20_arg1 )
	end
	LUI.UIVerticalList.UpdateNavigation( f20_arg0.playerList )
end

CoD.SpectatePlayerInfo.PlayerSelected = function ( f21_arg0, f21_arg1 )
	if f21_arg1.info.teamID ~= CoD.TEAM_SPECTATOR then
		f21_arg0.header:setAlpha( 1 )
	else
		f21_arg0.header:setAlpha( 0 )
	end
end

CoD.SpectatePlayerInfo.UpdateScores = function ( f22_arg0, f22_arg1 )
	CoD.SpectatePlayerInfo.Update( f22_arg0, f22_arg1.teams )
end

CoD.SpectatePlayerInfo.LoseFocus = function ( f23_arg0, f23_arg1 )
	Dvar.shoutcastHighlightedClient:set( -1 )
	f23_arg0:dispatchEventToChildren( f23_arg1 )
end

CoD.SpectatePlayerInfo.ListenIn = function ( f24_arg0, f24_arg1 )
	f24_arg0.m_listeningInTeam = f24_arg1
	if f24_arg1 ~= CoD.TEAM_FREE then
		f24_arg0.teamList:dispatchEventToChildren( {
			name = "spectate_team_listen_in",
			team = f24_arg1
		} )
	end
end

CoD.SpectatePlayerInfo.new = function ( f25_arg0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, 3, CoD.SpectatePlayerInfo.RowWidth + 3 )
	self:setTopBottom( true, true, CoD.SpectatePlayerInfo.Top, 0 )
	self.m_ownerController = f25_arg0
	self.m_selectedClientNum = nil
	self.m_listeningInTeam = nil
	self.m_overrideFocus = false
	self.m_teamCount = Engine.GetGametypeSetting( "teamCount" )
	self:setClass( CoD.SpectatePlayerInfo )
	self.header = LUI.UIElement.new()
	self.header:setLeftRight( true, false, CoD.SpectatePlayerInfo.TeamWidth, CoD.SpectatePlayerInfo.TeamWidth + CoD.SpectatePlayerInfo.RowWidth )
	self.header:setTopBottom( true, false, 0, CoD.SpectatePlayerInfo.HeaderHeight )
	local f25_local1 = LUI.UIImage.new()
	f25_local1:setLeftRight( false, true, -64, -32 )
	f25_local1:setTopBottom( false, true, -32, 0 )
	f25_local1:setImage( RegisterMaterial( "spectator_reticle_status" ) )
	local f25_local2 = LUI.UIImage.new()
	f25_local2:setLeftRight( false, true, -32, 0 )
	f25_local2:setTopBottom( false, true, -32, 0 )
	f25_local2:setImage( RegisterMaterial( "spectator_reticle_streak" ) )
	local f25_local3 = CoD.SpectatePlayerInfo.HeaderHeight + CoD.SpectatePlayerInfo.RowSpacing
	local f25_local4 = CoD.SpectatePlayerInfo.RowSpacing
	local f25_local5 = CoD.SpectatePlayerInfo.RowHeight
	local f25_local6 = CoD.SpectatePlayerInfo.MaxRows
	local f25_local7 = f25_local5 * f25_local6 + f25_local4 * f25_local6
	self.playerList = LUI.UIVerticalList.new()
	self.playerList:setLeftRight( true, false, CoD.SpectatePlayerInfo.TeamWidth, CoD.SpectatePlayerInfo.TeamWidth + CoD.SpectatePlayerInfo.RowWidth )
	self.playerList:setTopBottom( true, false, f25_local3, f25_local3 + f25_local7 )
	self.playerList:setSpacing( f25_local4 )
	self.teamList = LUI.UIVerticalList.new()
	self.teamList:setLeftRight( true, false, 0, CoD.SpectatePlayerInfo.TeamWidth )
	self.teamList:setTopBottom( true, false, f25_local3, f25_local3 + f25_local7 )
	self.teamList:setSpacing( f25_local4 )
	self.m_rowAllocator = LUI.LUIElementAllocator.new()
	self.m_teamAllocator = LUI.LUIElementAllocator.new()
	for f25_local8 = 1, CoD.SpectatePlayerInfo.MaxRows, 1 do
		local f25_local11 = f25_local8
		self.m_rowAllocator:addToPool( SpectatePlayerInfo_CreatePlayerRow( self ) )
		self.m_teamAllocator:addToPool( SpectatePlayer_CreateTeamInfo() )
	end
	self.playerList:makeFocusable()
	self.playerList:registerEventHandler( "spectate_playerinfo_row_pressed", SpectatePlayerInfo_RowSelected )
	self.header:addElement( f25_local1 )
	self.header:addElement( f25_local2 )
	self:addElement( self.header )
	self:addElement( self.playerList )
	self:addElement( self.teamList )
	self.update = CoD.SpectatePlayerInfo.Update
	self.listenIn = CoD.SpectatePlayerInfo.ListenIn
	return self
end

CoD.SpectatePlayerInfo:registerEventHandler( "spectate_player_selected", CoD.SpectatePlayerInfo.PlayerSelected )
CoD.SpectatePlayerInfo:registerEventHandler( "hud_update_scores", CoD.SpectatePlayerInfo.UpdateScores )
CoD.SpectatePlayerInfo:registerEventHandler( "slide_in", CoD.SpectatePlayerInfo.SlideIn )
CoD.SpectatePlayerInfo:registerEventHandler( "lose_focus", CoD.SpectatePlayerInfo.LoseFocus )
