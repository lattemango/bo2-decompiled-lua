CoD.LeaderboardPreviewList = {}
CoD.LeaderboardPreviewList.RowHeight = CoD.textSize.ExtraSmall
CoD.LeaderboardPreviewList.ColumnSpacing = 3
CoD.LeaderboardPreviewList.RowSpacing = 5
CoD.LeaderboardPreviewList.MaxItems = 5
CoD.LeaderboardPreviewList.RankIconColumn = 2
CoD.LeaderboardPreviewList.RankColumn = 3
CoD.LeaderboardPreviewList.GamertagColumn = 4
local f0_local0 = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3 )
	local f1_local0, f1_local1, f1_local2, f1_local3 = false
	if not f1_arg1 then
		return 
	elseif f1_arg1 and #f1_arg1 < f1_arg0.maxItems then
		f1_local2 = 1
		f1_local3 = #f1_arg1
	end
	for f1_local12, f1_local13 in ipairs( f1_arg1 ) do
		if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) == true and f1_arg2 == f1_local13.teamName then
			f1_local0 = true
			f1_local1 = f1_local12
		else
			for f1_local10, f1_local11 in ipairs( f1_local13 ) do
				if f1_local10 == CoD.LeaderboardPreviewList.GamertagColumn and f1_arg2 == f1_local11.col then
					f1_local0 = true
					f1_local1 = f1_local12
					break
				end
			end
		end
		if f1_local0 == true then
			break
		end
	end
	if f1_local2 == nil then
		if f1_local1 == nil then
			f1_local2 = 1
			f1_local3 = f1_local2 + 4
		else
			f1_local2 = f1_local1 - 2
			if f1_local2 <= 0 then
				f1_local2 = 1
			end
			f1_local3 = f1_local2 + 4
			if #f1_arg1 < f1_local3 then
				f1_local2 = #f1_arg1 - 4
				f1_local3 = #f1_arg1
				if f1_local2 <= 0 then
					f1_local2 = 1
				end
			end
		end
	end
	f1_arg3.startIndex = f1_local2
	f1_arg3.endIndex = f1_local3
	f1_arg3.selfGamertagIndex = f1_local1
end

local f0_local1 = function ( f2_arg0, f2_arg1 )
	local f2_local0 = Engine.GetLeagueLbData( f2_arg1 )
	local f2_local1 = Engine.GetLeagueTeamName( f2_arg1 )
	local f2_local2 = {}
	f2_arg0:removeAllChildren()
	f0_local0( f2_arg0, f2_local0, f2_local1, f2_local2 )
	local f2_local3 = f2_arg0.elementHeight
	if not f2_local2.startIndex or not f2_local2.endIndex then
		return 
	end
	for f2_local4 = f2_local2.startIndex, f2_local2.endIndex, 1 do
		local f2_local7 = CoD.offWhite.r
		local f2_local8 = CoD.offWhite.g
		local f2_local9 = CoD.offWhite.b
		local f2_local10 = 10
		local f2_local11 = 40
		local f2_local12 = 8
		local f2_local13 = 60
		local f2_local14 = 60
		if f2_local2.selfGamertagIndex and f2_local4 == f2_local2.selfGamertagIndex then
			f2_local7 = CoD.yellowGlow.r
			f2_local8 = CoD.yellowGlow.g
			f2_local9 = CoD.yellowGlow.b
		end
		local f2_local15 = f2_local0[f2_local4]
		local self = LUI.UIElement.new()
		self:setLeftRight( true, true, 0, 0 )
		self:setTopBottom( true, false, 0, f2_local3 )
		local f2_local17 = LUI.UIElement.new( {
			left = f2_local10,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		} )
		f2_local17.rankText = LUI.UITightText.new()
		f2_local17.rankText:setLeftRight( true, false, f2_local12, 0 )
		f2_local17.rankText:setTopBottom( false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2 )
		f2_local17.rankText:setFont( CoD.fonts.Default )
		f2_local17.rankText:setRGB( f2_local7, f2_local8, f2_local9 )
		f2_local17.rankText:setText( f2_local15.rank )
		local f2_local18 = 46
		f2_local17.icon = LUI.UIImage.new()
		f2_local17.icon:setLeftRight( true, false, f2_local14, f2_local14 + f2_local18 )
		f2_local17.icon:setTopBottom( false, false, -f2_local18 / 2, f2_local18 / 2 )
		f2_local17.icon:setupLeagueEmblem( f2_local15.teamID )
		f2_local17.gamerTag = LUI.UIText.new()
		f2_local17.gamerTag:setLeftRight( true, false, f2_local13, 0 )
		f2_local17.gamerTag:setTopBottom( false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2 )
		f2_local17.gamerTag:setFont( CoD.fonts.Default )
		f2_local17.gamerTag:setRGB( f2_local7, f2_local8, f2_local9 )
		f2_local17.gamerTag:setText( f2_local15.teamName )
		self.dataText = LUI.UIText.new()
		self.dataText:setLeftRight( true, true, 0, -f2_local10 )
		self.dataText:setTopBottom( false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2 )
		self.dataText:setFont( CoD.fonts.Default )
		self.dataText:setAlignment( LUI.Alignment.Right )
		self.dataText:setRGB( f2_local7, f2_local8, f2_local9 )
		self.dataText:setText( f2_local15.rating )
		f2_local17:addElement( f2_local17.rankText )
		f2_local17:addElement( f2_local17.gamerTag )
		self:addElement( CoD.GetInformationContainer() )
		self:addElement( f2_local17 )
		self:addElement( self.dataText )
		f2_arg0:addElement( self )
	end
end

local f0_local2 = function ( f3_arg0, f3_arg1 )
	local f3_local0 = Engine.GetLeaderboardData( event.controller )
	if f3_local0 == nil or #f3_local0 == 0 then
		DebugPrint( "No leaderboard data." )
		return 
	end
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, 0, CoD.LeaderboardPreviewList.RowHeight )
	self.titleText = LUI.UITightText.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	} )
	self.titleText:setText( Engine.Localize( "MENU_FRIEND" ) )
	self:addElement( self.titleText )
	self.dataTitleText = LUI.UITightText.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Right
	} )
	self.dataTitleText:setText( Engine.Localize( "MENU_KILLS_CAPS" ) )
	self:addElement( self.dataTitleText )
	f3_arg0:addElement( self )
	f3_arg0:addSpacer( CoD.LeaderboardPreviewList.RowSpacing )
	local f3_local2 = UIExpression.GetSelfGamertag()
	local f3_local3 = {}
	f0_local0( f3_arg0, f3_local0, f3_local2, f3_local3 )
	for f3_local4 = f3_local3.startIndex, f3_local3.endIndex, 1 do
		local f3_local7 = f3_local0[f3_local4]
		local f3_local8 = LUI.UIElement.new()
		f3_local8:setLeftRight( true, true, 0, 0 )
		f3_local8:setTopBottom( true, false, 0, CoD.LeaderboardPreviewList.RowHeight )
		local f3_local9 = LUI.UIHorizontalList.new( {
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		} )
		for f3_local13, f3_local14 in ipairs( f3_local7 ) do
			if f3_local13 == CoD.LeaderboardPreviewList.RankIconColumn then
				f3_local9.rankIcon = LUI.UIImage.new( {
					left = 0,
					top = 0,
					right = 30,
					bottom = 0,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = false,
					bottomAnchor = true,
					alpha = 1,
					material = RegisterMaterial( f3_local14.col )
				} )
			end
			if f3_local13 == CoD.LeaderboardPreviewList.RankColumn then
				f3_local9.rankText = LUI.UITightText.new( {
					left = 0,
					top = 0,
					right = 0,
					bottom = 0,
					red = 1,
					green = 1,
					blue = 1,
					alpha = 1,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = false,
					bottomAnchor = true,
					font = CoD.fonts.Default
				} )
				f3_local9.rankText:setText( f3_local14.col )
			end
			if f3_local13 == CoD.LeaderboardPreviewList.GamertagColumn then
				f3_local9.gamerTag = LUI.UITightText.new( {
					left = 0,
					top = 0,
					right = 0,
					bottom = 0,
					red = 1,
					green = 1,
					blue = 1,
					alpha = 1,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = false,
					bottomAnchor = true,
					font = CoD.fonts.Default
				} )
				f3_local9.gamerTag:setText( f3_local14.col )
			end
			if f3_local13 == f3_arg0.leaderBoardColumn then
				f3_local8.dataText = LUI.UIText.new( {
					left = 0,
					top = 0,
					right = 0,
					bottom = 0,
					red = 1,
					green = 1,
					blue = 1,
					alpha = 1,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = true,
					bottomAnchor = true,
					font = CoD.fonts.Default,
					alignment = LUI.Alignment.Right
				} )
				f3_local8.dataText:setText( f3_local14.col )
			end
		end
		f3_local9:addElement( f3_local9.rankText )
		f3_local9:addSpacer( CoD.LeaderboardPreviewList.ColumnSpacing )
		f3_local9:addElement( f3_local9.rankIcon )
		f3_local9:addSpacer( CoD.LeaderboardPreviewList.ColumnSpacing )
		f3_local9:addElement( f3_local9.gamerTag )
		f3_local9:addSpacer( CoD.LeaderboardPreviewList.ColumnSpacing )
		f3_local8:addElement( f3_local9 )
		f3_local8:addElement( f3_local8.dataText )
		f3_arg0:addElement( f3_local8 )
		f3_arg0:addElement( LUI.UIImage.new( {
			left = 0,
			top = 0,
			right = 0,
			bottom = 2,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 0.5,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		} ) )
		f3_arg0:addSpacer( CoD.LeaderboardPreviewList.RowSpacing )
	end
end

local f0_local3 = function ( f4_arg0, f4_arg1 )
	if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) == true then
		f0_local1( f4_arg0, f4_arg1.controller )
	else
		f0_local2( f4_arg0, f4_arg1.controller )
	end
end

local f0_local4 = function ( f5_arg0, f5_arg1 )
	local f5_local0 = 10
	if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) == true then
		local f5_local1 = Engine.GetLeagueStats( f5_arg1.controller )
		if f5_local1.teamID ~= nil then
			Engine.Exec( f5_arg1.controller, "leagueFetchLbData " .. f5_local1.subdivisionID .. " " .. f5_local0 .. " " .. f5_local1.teamID )
		end
	end
end

CoD.LeaderboardPreviewList.new = function ( f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6 )
	local self = LUI.UIVerticalList.new( f6_arg1 )
	self.maxItems = CoD.LeaderboardPreviewList.MaxItems
	if f6_arg2 ~= nil then
		self.maxItems = f6_arg2
	end
	if f6_arg3 ~= nil then
		self.elementHeight = f6_arg3
	end
	self.id = "LeaderboardPreviewList"
	self:registerEventHandler( "leaderboardlist_update", f0_local3 )
	self:registerEventHandler( "league_lb_data_fetched", f0_local3 )
	self:registerEventHandler( "league_changed", f0_local4 )
	local f6_local1 = 10
	if Engine.GameModeIsMode( CoD.GAMEMODE_LEAGUE_MATCH ) and not f6_arg6 then
		local f6_local2, f6_local3 = nil
		if f6_arg5 then
			f6_local2 = f6_arg5
		end
		if f6_arg4 then
			f6_local3 = f6_arg4
		end
		local f6_local4 = Engine.GetLeagueStats( f6_arg0 )
		if f6_local4 and not f6_local2 and not f6_local3 then
			f6_local2 = f6_local4.teamID
			f6_local3 = f6_local4.subdivisionID
		end
		if f6_local4.teamID ~= nil then
			Engine.Exec( f6_arg0, "leagueFetchLbData " .. f6_local4.subdivisionID .. " " .. f6_local1 .. " " .. f6_local4.teamID )
		end
	end
	return self
end

