require( "T6.CoD9Button" )
require( "T6.LeaderboardPreviewList" )

if CoD.isZombie == false then
	require( "T6.XPBar" )
	require( "T6.Menus.ChallengesAssignments" )
	require( "T6.Menus.ChallengesCareer" )
	require( "T6.Menus.ChallengesGamemodes" )
	require( "T6.Menus.ChallengesOptics" )
	require( "T6.Menus.ChallengesPrestige" )
	require( "T6.Menus.ChallengesScorestreaks" )
	require( "T6.Menus.ChallengesWeapons" )
	require( "T6.Menus.ConfirmPrestige" )
	require( "T6.Menus.EmblemEditorCarousel" )
	require( "T6.Menus.EmblemBackgroundSelector" )
	require( "T6.Menus.LeagueTeams" )
	require( "T6.Menus.CRCareer" )
	require( "T6.Menus.CRGamemodes" )
	require( "T6.Menus.CRWeapons" )
	require( "T6.Menus.CREquipment" )
	require( "T6.Menus.CRScorestreaks" )
	require( "T6.Menus.CRSummary" )
	require( "T6.Menus.CRMedals" )
	require( "T6.Menus.BarracksPrestigeAwards" )
else
	require( "T6.Zombie.LeaderboardCarouselZombie" )
	require( "T6.Zombie.LeaderboardZombie" )
end
CoD.Barracks = {}
CoD.Barracks.NumLeagueTeamsToFetch = 19
CoD.Barracks.ItemWidth = 192
CoD.Barracks.ItemHeight = 146
CoD.Barracks.HighlightedItemWidth = 345.6
CoD.Barracks.HighlightedItemHeight = 217.8
CoD.Barracks.SubdivisionInfoFetchTimer = 750
CoD.Barracks.glowBackColor = {}
CoD.Barracks.glowBackColor.r = 1
CoD.Barracks.glowBackColor.g = 1
CoD.Barracks.glowBackColor.b = 1
CoD.Barracks.glowFrontColor = {}
CoD.Barracks.glowFrontColor.r = 1
CoD.Barracks.glowFrontColor.g = 1
CoD.Barracks.glowFrontColor.b = 1
CoD.Barracks.HintTextParams = {}
CoD.Barracks.HintTextParams.hintTextLeft = 0
CoD.Barracks.HintTextParams.hintTextWidth = 350
CoD.Barracks.HintTextParams.hintTextTop = -5
CoD.Barracks.RightSideHintTextParams = {}
CoD.Barracks.RightSideHintTextParams.hintTextLeft = 433
CoD.Barracks.RightSideHintTextParams.hintTextWidth = 510
CoD.Barracks.RightSideHintTextParams.hintTextTop = 238
CoD.Barracks.MiniLeaderboardSideOffset = 4
CoD.Barracks.EmblemEditorIconOffset = 10
CoD.Barracks.BackgroundCardIconOffset = 20
CoD.Barracks.LeagueTeamsPageSize = 10
LUI.createMenu.Barracks = function ( f1_arg0 )
	local f1_local0 = CoD.Menu.New( "Barracks" )
	Engine.ExecNow( f1_arg0, "fshSearchClear" )
	if CoD.isPC and not CoD.isZombie and CoD.LeaderboardMP.RemoveUnreleasedLBs ~= nil then
		CoD.LeaderboardMP.RemoveUnreleasedLBs()
	end
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner( f1_arg0 )
	f1_local0.goBack = CoD.Barracks.GoBack
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle( Engine.Localize( "MENU_BARRACKS_CAPS" ) )
	f1_local0:registerEventHandler( "open_league_teams", CoD.Barracks.OpenLeagueTeams )
	f1_local0:registerEventHandler( "open_emblemeditor_carousel", CoD.Barracks.OpenEmblemEditorCarousel )
	f1_local0:registerEventHandler( "open_challenges_menu", CoD.Barracks.OpenChallengesMenu )
	f1_local0:registerEventHandler( "open_clan_tag", CoD.Barracks.OpenClanTag )
	f1_local0:registerEventHandler( "open_leaderboard", CoD.Barracks.OpenLeaderboard )
	f1_local0:registerEventHandler( "open_emblembackgroundselector", CoD.Barracks.OpenEmblemBackgroundSelector )
	f1_local0:registerEventHandler( "remove_select_button", CoD.Barracks.RemoveSelectButton )
	f1_local0:registerEventHandler( "add_select_button", CoD.Barracks.AddSelectButton )
	f1_local0:registerEventHandler( "multi_read_update", CoD.Barracks.MiniLeaderboardUpdate )
	f1_local0:registerEventHandler( "open_combat_record", CoD.Barracks.OpenCombatRecord )
	f1_local0:registerEventHandler( "open_prestige_awards", CoD.Barracks.OpenPrestigeAwards )
	f1_local0:registerEventHandler( "open_prestige_popup", CoD.Barracks.PrestigeButtonAction )
	f1_local0:registerEventHandler( "prestige_action_complete", CoD.Barracks.UpdateCarouselList )
	f1_local0:registerEventHandler( "card_gain_focus", CoD.Barracks.CardGainFocus )
	Engine.ExecNow( f1_arg0, "emblemgetprofile" )
	if UIExpression.DvarBool( nil, "ui_hideMiniLeaderboards" ) == 0 then
		CoD.Barracks.SetMiniLeaderboardCache( f1_arg0 )
	end
	CoD.Barracks.AddCardCarouselList( f1_local0, f1_arg0 )
	if CoD.isZombie == false and UIExpression.IsGuest( f1_arg0 ) == 0 and CoD.CRCommon.OtherPlayerCRMode ~= true and not CoD.Barracks.ShowLeagueTeamsOnly and CoD.CanRankUp( f1_arg0 ) == true then
		local f1_local1 = 150
		local f1_local2 = CoD.Menu.Width - f1_local1 - 150
		local f1_local3 = 40
		local f1_local4 = -10 - CoD.ButtonPrompt.Height
		local self = LUI.UIElement.new()
		self:setLeftRight( true, false, f1_local1, f1_local1 + f1_local2 )
		self:setTopBottom( false, true, f1_local4 - f1_local3, f1_local4 )
		f1_local0:addElement( self )
		local f1_local6 = LUI.UIImage.new()
		f1_local6:setLeftRight( true, true, 1, -1 )
		f1_local6:setTopBottom( true, true, 1, -1 )
		f1_local6:setRGB( 0, 0, 0 )
		f1_local6:setAlpha( 0.6 )
		self:addElement( f1_local6 )
		self.border = CoD.Border.new( 1, 1, 1, 1, 0.1 )
		self:addElement( self.border )
		local f1_local7 = 10
		local f1_local8 = CoD.XPBar.New( nil, f1_arg0, f1_local2 - f1_local7 * 2 )
		f1_local8:setLeftRight( true, true, f1_local7, -f1_local7 )
		f1_local8:setTopBottom( true, true, 0, 0 )
		self:addElement( f1_local8 )
		f1_local8:processEvent( {
			name = "animate_xp_bar",
			duration = 0
		} )
	end
	return f1_local0
end

CoD.Barracks.AddCardCarouselList = function ( f2_arg0, f2_arg1 )
	local f2_local0 = CoD.textSize.Big + 10
	local f2_local1 = CoD.CardCarouselList.new( nil, f2_arg1, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams )
	f2_local1:setLeftRight( true, true, 0, 0 )
	f2_local1:setTopBottom( true, true, f2_local0, -CoD.ButtonPrompt.Height )
	f2_local1.popup = f2_arg0
	f2_arg0:addElement( f2_local1 )
	f2_local1.titleListContainer.spacing = 0
	f2_local1.titleListContainer:registerAnimationState( "default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.CoD9Button.Height,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local1.cardCarouselSize + 70,
		bottom = 0
	} )
	f2_local1.titleListContainer:animateToState( "default" )
	f2_local0 = f2_local0 + f2_local1.cardCarouselSize - 7
	CoD.Barracks.AddCarousels( f2_arg0, f2_local1, f2_arg1 )
	if CoD.Barracks.CurrentCarouselInfo then
		f2_local1:setInitialCarousel( CoD.Barracks.CurrentCarouselInfo.carouselIndex, CoD.Barracks.CurrentCarouselInfo.cardIndex )
	end
	CoD.Barracks.AddDecorativeLine( f2_arg0, f2_local0 )
	f2_local1:focusCurrentCardCarousel( f2_arg1 )
	f2_arg0.cardCarouselList = f2_local1
end

CoD.Barracks.AddDecorativeLine = function ( f3_arg0, f3_arg1 )
	local f3_local0 = f3_arg1 + 97
	local self = LUI.UIImage.new()
	self:setLeftRight( true, false, 0, CoD.Menu.Width / 2 - 85 )
	self:setTopBottom( true, false, f3_local0, f3_local0 + 1 )
	self:setAlpha( 0.05 )
	f3_arg0:addElement( self )
end

CoD.Barracks.SetMiniLeaderboardCache = function ( f4_arg0 )
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 1
		CoD.Barracks.MiniRead( f4_arg0, 1 )
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 2
		CoD.Barracks.MiniRead( f4_arg0, 6 )
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 3
		CoD.Barracks.MiniRead( f4_arg0, 11 )
	end
end

local f0_local0 = function ()
	CoD.LeagueTeams.CurrentCarouselInfo = nil
	CoD.Barracks.LeagueTeamsDataFetched = false
	CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus = {}
	CoD.LeaguesData.TeamSubdivisionInfo.data = {}
	CoD.LeaguesData.teamsData = nil
	CoD.Barracks.LeagueTeamsCurrOffset = nil
	if not CoD.FriendPopup.LeagueLeaderboardMemberSelected then
		CoD.Barracks.CurrentLeaguePlayerXuid = nil
		CoD.Barracks.ShowLeagueTeamsOnly = nil
	end
end

local f0_local1 = function ()
	CoD.CRCommon.OtherPlayerCRMode = false
	CoD.CRCommon.CurrentXuid = ""
	CoD.CRCommon.ComparisonModeOn = false
end

CoD.Barracks.GoBack = function ( f7_arg0, f7_arg1 )
	f0_local0()
	f0_local1()
	CoD.Barracks.CurrentCarouselInfo = nil
	Engine.PartyHostClearUIState()
	if f7_arg0.occludedMenu then
		f7_arg0.occludedMenu:processEvent( {
			name = "barracks_closed",
			controller = f7_arg1
		} )
	end
	CoD.Menu.goBack( f7_arg0, f7_arg1 )
end

CoD.Barracks.RemoveSelectButton = function ( f8_arg0, f8_arg1 )
	if f8_arg0.selectButton then
		f8_arg0.selectButton:close()
	end
end

CoD.Barracks.AddSelectButton = function ( f9_arg0, f9_arg1 )
	f9_arg0.backButton:close()
	if f9_arg0.selectButton then
		f9_arg0.selectButton:close()
	end
	f9_arg0:addBackButton()
	f9_arg0:addSelectButton()
end

CoD.Barracks.CardGainFocus = function ( f10_arg0, f10_arg1 )
	if f10_arg1.card then
		if f10_arg1.card.isLocked == true then
			CoD.Barracks.RemoveSelectButton( f10_arg0 )
		else
			CoD.Barracks.AddSelectButton( f10_arg0 )
		end
	end
end

CoD.Barracks.SetupCardCarouselTitleTextPosition = function ( f11_arg0, f11_arg1 )
	local f11_local0 = f11_arg1.cardCarouselSize + 40
	f11_arg0.title:registerAnimationState( "default", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f11_local0,
		bottom = f11_local0 + CoD.CardCarousel.TitleSize,
		font = CoD.fonts.Big
	} )
	f11_arg0.title:animateToState( "default" )
end

local f0_local2 = function ( f12_arg0, f12_arg1 )
	local f12_local0 = f12_arg0:getParent()
	f12_arg0:setRGB( CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b )
	if f12_local0 and (f12_local0.isLocked or f12_local0.lockImage) then
		f12_arg0:setRGB( CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g )
	end
end

local f0_local3 = function ( f13_arg0, f13_arg1 )
	f13_arg0:setRGB( CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g )
end

CoD.Barracks.SetupCarouselCard = function ( f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5 )
	if f14_arg5 == nil then
		f14_arg5 = 0
	end
	if f14_arg2 then
		f14_arg0.iconMaterial = RegisterMaterial( f14_arg2 )
		f14_arg0.icon = LUI.UIImage.new()
		f14_arg0.icon:setLeftRight( false, false, -f14_arg3 / 2, f14_arg3 / 2 )
		f14_arg0.icon:setTopBottom( false, false, -f14_arg4 / 2 + f14_arg5, f14_arg4 / 2 + f14_arg5 )
		f14_arg0.icon:setImage( f14_arg0.iconMaterial )
		f14_arg0:addElement( f14_arg0.icon )
	end
	f14_arg0.title = LUI.UIText.new()
	f14_arg0.title:setLeftRight( true, true, 5, 0 )
	f14_arg0.title:setTopBottom( false, true, -CoD.textSize.Default - 3, -3 )
	f14_arg0.title:setFont( CoD.fonts.Default )
	f14_arg0.title:setRGB( CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g )
	f14_arg0.title:setAlignment( LUI.Alignment.Left )
	f14_arg0.titleText = f14_arg1
	if f14_arg0.titleText then
		f14_arg0.title:setText( f14_arg0.titleText )
	end
	f14_arg0.title:registerEventHandler( "button_over", f0_local2 )
	f14_arg0.title:registerEventHandler( "button_up", f0_local3 )
	f14_arg0:addElement( f14_arg0.title )
	if f14_arg0.border then
		f14_arg0.border:close()
	end
	if f14_arg0.highlightedborder then
		f14_arg0.highlightedborder:close()
	end
	CoD.ContentGridButton.SetupButtonImages( f14_arg0, CoD.Barracks.glowBackColor, CoD.Barracks.glowFrontColor )
end

local f0_local4 = function ( f15_arg0, f15_arg1, f15_arg2 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, 0, CoD.textSize[f15_arg0] )
	local f15_local1 = LUI.UIText.new()
	f15_local1:setLeftRight( true, true, 0, 0 )
	f15_local1:setTopBottom( true, true, 0, 0 )
	f15_local1:setAlignment( LUI.UIElement.Left )
	f15_local1:setFont( CoD.fonts[f15_arg0] )
	f15_local1:setText( f15_arg1 )
	if f15_arg2 then
		f15_local1:setRGB( f15_arg2.r, f15_arg2.g, f15_arg2.b )
	end
	self.textElem = f15_local1
	self:addElement( f15_local1 )
	return self
end

CoD.Barracks.OpenEmblemBackgroundSelector = function ( f16_arg0, f16_arg1 )
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f16_arg1.button )
	f16_arg0:openMenu( "EmblemBackgroundSelector", f16_arg1.controller )
	f16_arg0:close()
end

CoD.Barracks.OpenLeagueTeams = function ( f17_arg0, f17_arg1 )
	local f17_local0 = CoD.LeaguesData.TeamSubdivisionInfo.data
	local f17_local1 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
	local f17_local2 = CoD.LeaguesData.CurrentTeamInfo.teamID
	CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo = Engine.GetLeagueTeamMemberInfo( f17_arg1.controller, f17_local2 )
	if f17_local1[f17_local2] ~= "fetched" then
		f17_local1[f17_local2], f17_local0[f17_local2] = Engine.GetLeagueTeamSubdivisionInfos( f17_arg1.controller, f17_local2 )
	end
	f17_arg0:openMenu( "LeagueTeams", f17_arg1.controller )
	f17_arg0:close()
end

CoD.Barracks.OpenEmblemEditorCarousel = function ( f18_arg0, f18_arg1 )
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f18_arg1.button )
	if Engine.IsFeatureBanned( CoD.FEATURE_BAN_EMBLEM_EDITOR ) then
		Engine.ExecNow( f18_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_EMBLEM_EDITOR )
		return 
	elseif Engine.CanViewContent() == false then
		f18_arg0:openPopup( "popup_contentrestricted", f18_arg1.controller )
		return 
	else
		CoD.perController[f18_arg1.controller].codtvRoot = "emblems"
		f18_arg0:openMenu( "CODTv", f18_arg1.controller )
		f18_arg0:close()
	end
end

CoD.Barracks.OpenChallengesMenu = function ( f19_arg0, f19_arg1 )
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f19_arg1.button )
	if f19_arg1.button and f19_arg1.button.menuName then
		if f19_arg1.button.weaponSlot then
			CoD.perController[f19_arg1.controller].weaponSlot = f19_arg1.button.weaponSlot
		end
		f19_arg0:openMenu( f19_arg1.button.menuName, f19_arg1.controller )
		f19_arg0:close()
	end
end

CoD.Barracks.OpenClanTag = function ( f20_arg0, f20_arg1 )
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f20_arg1.button )
	if CoD.isPC or CoD.isWIIU then
		Engine.Exec( f20_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_CLAN_TAG )
	else
		Engine.Exec( f20_arg1.controller, "editclanname" )
	end
end

CoD.Barracks.OpenCombatRecord = function ( f21_arg0, f21_arg1 )
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f21_arg1.button )
	if f21_arg1.button and f21_arg1.button.menuName then
		f21_arg0:openMenu( f21_arg1.button.menuName, f21_arg1.controller )
		f21_arg0:close()
	end
end

CoD.Barracks.OpenPrestigeAwards = function ( f22_arg0, f22_arg1 )
	if Engine.IsFeatureBanned( CoD.FEATURE_BAN_PRESTIGE ) then
		Engine.ExecNow( f22_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE )
		return 
	elseif Engine.IsFeatureBanned( CoD.FEATURE_BAN_PRESTIGE_EXTRAS ) then
		Engine.ExecNow( f22_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS )
		return 
	else
		CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f22_arg1.button )
		f22_arg0:openMenu( "BarracksPrestigeAwards", f22_arg1.controller )
		f22_arg0:close()
	end
end

local f0_local5 = function ( f23_arg0, f23_arg1 )
	local f23_local0 = "Default"
	if f23_arg0 then
		f23_local0 = f23_arg0
	end
	local f23_local1 = CoD.fonts[f23_local0]
	local f23_local2 = CoD.textSize[f23_local0]
	local self = LUI.UIText.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, 0, f23_local2 )
	self:setFont( f23_local1 )
	self:setAlignment( LUI.Alignment.Left )
	if f23_arg1 then
		self:setAlignment( LUI.Alignment[f23_arg1] )
	end
	return self
end

local f0_local6 = function ( f24_arg0, f24_arg1 )
	local f24_local0 = "ExtraSmall"
	local f24_local1 = CoD.textSize[f24_local0] + 40
	local f24_local2 = 100
	local self = LUI.UIVerticalList.new()
	self:setLeftRight( true, false, 0, f24_local2 )
	self:setTopBottom( true, false, 0, f24_local1 )
	self.titleTextElem = f0_local5( f24_local0, "Center" )
	self:addElement( self.titleTextElem )
	if f24_arg0 then
		self.titleTextElem:setText( f24_arg0 )
		self.titleTextElem:setRGB( CoD.gray.r, CoD.gray.g, CoD.gray.b )
	end
	local f24_local4 = LUI.UIElement.new()
	f24_local4:setLeftRight( true, true, 0, 0 )
	f24_local4:setTopBottom( true, true, 0, 0 )
	f24_local4:addElement( CoD.Border.new( 1, 1, 1, 1, 0.1, nil, nil, true ) )
	local f24_local5 = "Condensed"
	local f24_local6 = CoD.fonts[f24_local5]
	local f24_local7 = CoD.textSize[f24_local5]
	local f24_local8 = LUI.UIText.new()
	f24_local8:setLeftRight( true, true, 0, 0 )
	f24_local8:setTopBottom( false, false, -f24_local7 / 2, f24_local7 / 2 )
	if f24_arg1 then
		f24_local8:setText( f24_arg1 )
	end
	f24_local4:addElement( f24_local8 )
	self:addElement( f24_local4 )
	return self
end

CoD.Barracks.SetupCRCareerCardHintTextArea = function ( f25_arg0, f25_arg1, f25_arg2 )
	if f25_arg0.hintTextContainer.hintTextArea then
		f25_arg0.hintTextContainer.hintTextArea:close()
		f25_arg0.hintTextContainer.hintTextArea = nil
	end
	local f25_local0 = CoD.Barracks.HintTextParams.hintTextLeft + CoD.Barracks.HintTextParams.hintTextWidth + 80
	local f25_local1 = CoD.Barracks.RightSideHintTextParams.hintTextWidth
	local f25_local2 = -20
	f25_arg0.hintTextContainer.hintTextArea = LUI.UIElement.new()
	f25_arg0.hintTextContainer.hintTextArea:setLeftRight( true, false, f25_local0, f25_local0 + f25_local1 )
	f25_arg0.hintTextContainer.hintTextArea:setTopBottom( true, false, f25_local2, f25_local2 + CoD.CardCarousel.HintTextHeight )
	f25_arg0.hintTextContainer:addElement( f25_arg0.hintTextContainer.hintTextArea )
	f25_arg0.hintTextContainer.hintTextAreaCommon = LUI.UIElement.new()
	f25_arg0.hintTextContainer.hintTextAreaCommon:setLeftRight( true, false, f25_local0, f25_local0 + f25_local1 )
	f25_arg0.hintTextContainer.hintTextAreaCommon:setTopBottom( true, false, f25_local2, f25_local2 + CoD.CardCarousel.HintTextHeight )
	f25_arg0.hintTextContainer:addElement( f25_arg0.hintTextContainer.hintTextAreaCommon )
	local f25_local3 = LUI.UIVerticalList.new()
	f25_local3:setLeftRight( true, true, 0, 0 )
	f25_local3:setTopBottom( true, true, 0, 0 )
	local f25_local4 = f0_local5()
	local f25_local5 = f25_arg2.PlayerStatsList.PLEVEL.StatValue:get()
	local f25_local6 = f25_arg2.PlayerStatsList.RANK.StatValue:get()
	local f25_local7 = f25_arg2.PlayerStatsList.KILLS.StatValue:get()
	local f25_local8 = f25_arg2.PlayerStatsList.WINS.StatValue:get()
	local f25_local9 = f25_local7 / math.max( 1, f25_arg2.PlayerStatsList.DEATHS.StatValue:get() )
	local f25_local10 = Engine.GetRankName( f25_local6 )
	local f25_local11 = nil
	if f25_local5 == tonumber( CoD.MAX_PRESTIGE ) then
		f25_local11 = Engine.Localize( "MENU_MASTER" )
	elseif f25_local5 > 0 then
		f25_local11 = Engine.Localize( "MENU_RANK_NAME_FULL", Engine.Localize( "MPUI_PRESTIGE_N", f25_local5 ), f25_local6 + 1 )
	elseif f25_local6 and f25_local10 then
		f25_local11 = Engine.Localize( "MENU_RANK_NAME_FULL", f25_local10, f25_local6 + 1 )
	end
	if f25_local11 then
		f25_local4:setText( f25_local11 )
		f25_local3:addElement( f25_local4 )
	end
	local f25_local12 = f0_local5()
	f25_arg0.hintTextContainer.hintTextArea:addElement( f25_local3 )
	f25_arg0.hintTextContainer.hintTextAreaCommon.commonHintText = f25_local12
	f25_arg0.hintTextContainer.hintTextAreaCommon:addElement( f25_local12 )
	local f25_local13 = LUI.UIHorizontalList.new()
	f25_local13:setLeftRight( true, true, 0, 0 )
	f25_local13:setTopBottom( true, false, 0, 50 )
	f25_local3:addSpacer( 8 )
	f25_local3:addElement( f25_local13 )
	if f25_local7 then
		f25_local13:addElement( f0_local6( Engine.Localize( "MENU_KILLS" ), f25_local7 ) )
		f25_local13:addSpacer( 5 )
	end
	if f25_local8 then
		f25_local13:addElement( f0_local6( Engine.Localize( "MENU_WINS" ), f25_local8 ) )
		f25_local13:addSpacer( 5 )
	end
	if f25_local9 then
		f25_local13:addElement( f0_local6( Engine.Localize( "MENU_KDRATIO_ABBR" ), string.format( "%.2f", f25_local9 ) ) )
	end
end

CoD.Barracks.AddCombatRecordCareerCard = function ( f26_arg0, f26_arg1, f26_arg2 )
	local f26_local0 = CoD.CRCommon.GetStats( f26_arg1, f26_arg2 )
	local f26_local1 = UIExpression.TableLookup( nil, CoD.rankIconTable, 0, f26_local0.PlayerStatsList.RANK.StatValue:get(), f26_local0.PlayerStatsList.PLEVEL.StatValue:get() + 1 )
	local f26_local2 = f26_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f26_local2, Engine.Localize( "MENU_CHALLENGES_CAREER" ) )
	if f26_local1 then
		local f26_local3 = 100
		f26_local2:setupCenterImage( f26_local1 .. "_128", f26_local3, f26_local3, 1.5, true )
	end
	f26_local2:setActionEventName( "open_combat_record" )
	f26_local2.menuName = "CRCareer"
	f26_local2.hintText = Engine.Localize( "MENU_CR_CAREER_HINT" )
	CoD.Barracks.SetupCRCareerCardHintTextArea( f26_arg0, f26_arg1, f26_local0 )
end

CoD.Barracks.AddCombatRecordGamemodesCard = function ( f27_arg0, f27_arg1, f27_arg2 )
	local f27_local0 = f27_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f27_local0, Engine.Localize( "MENU_CHALLENGES_GAME_MODES" ) )
	Engine.SortItemsForCombatRecord( f27_arg1, CoD.CRCommon.SortTypes.GAMEMODES, f27_arg2 == true )
	local f27_local1 = Engine.GetCombatRecordSortedItemInfo( 0 )
	if f27_local1 and f27_local1.itemIndex then
		local f27_local2 = Engine.GetGametypeName( f27_local1.itemIndex )
		if f27_local2 then
			local f27_local3 = CoD.CRCommon.GameTypeImageNames[f27_local2]
			local f27_local4 = 100
			f27_local0:setupCenterImage( f27_local3, f27_local4, f27_local4, 1.8, true )
		end
	end
	f27_local0.hintText = Engine.Localize( "MENU_CR_GAMEMODES_HINT" )
	if f27_local1 and f27_local1.itemIndex and Engine.GetGametypeName( f27_local1.itemIndex ) then
		f27_local0.specialHintText = Engine.Localize( "MENU_CR_GAMEMODES_SPECIAL_HINT", Engine.Localize( "MPUI_" .. Engine.GetGametypeName( f27_local1.itemIndex ) ) )
	end
	f27_local0:setActionEventName( "open_combat_record" )
	f27_local0.menuName = "CRGamemodes"
end

CoD.Barracks.AddCombatRecordWeaponsCard = function ( f28_arg0, f28_arg1, f28_arg2 )
	local f28_local0 = f28_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f28_local0, Engine.Localize( "MENU_WEAPONS_PRE" ) )
	Engine.SortItemsForCombatRecord( f28_arg1, CoD.CRCommon.SortTypes.WEAPONS, f28_arg2 == true )
	local f28_local1 = Engine.GetCombatRecordSortedItemInfo( 0 )
	if f28_local1 and f28_local1.itemIndex then
		f28_local0:setupCenterImage( UIExpression.GetItemImage( nil, f28_local1.itemIndex ) .. "_big", 150, 75, 1.8, true )
	end
	f28_local0.hintText = Engine.Localize( "MENU_CR_WEAPONS_HINT" )
	f28_local0.specialHintText = Engine.Localize( "MENU_CR_WEAPONS_SPECIAL_HINT", UIExpression.GetItemName( nil, f28_local1.itemIndex ) )
	f28_local0:setActionEventName( "open_combat_record" )
	f28_local0.menuName = "CRWeapons"
end

CoD.Barracks.AddCombatRecordEquipmentCard = function ( f29_arg0, f29_arg1, f29_arg2 )
	local f29_local0 = f29_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f29_local0, Engine.Localize( "MENU_EQUIPMENT" ) )
	Engine.SortItemsForCombatRecord( f29_arg1, CoD.CRCommon.SortTypes.EQUIPMENT, f29_arg2 == true )
	local f29_local1 = Engine.GetCombatRecordSortedItemInfo( 0 )
	if f29_local1 and f29_local1.itemIndex then
		f29_local0:setupCenterImage( UIExpression.GetItemImage( nil, f29_local1.itemIndex ) .. "_256", 100, 100, 1.8, true )
	end
	f29_local0.hintText = Engine.Localize( "MENU_CR_EQUIPMENT_HINT" )
	f29_local0.specialHintText = Engine.Localize( "MENU_CR_EQUIPMENT_SPECIAL_HINT", UIExpression.GetItemName( nil, f29_local1.itemIndex ) )
	f29_local0:setActionEventName( "open_combat_record" )
	f29_local0.menuName = "CREquipment"
end

CoD.Barracks.HideMedalsCard = function ()
	return false
end

CoD.Barracks.HideSummaryCard = function ()
	return false
end

CoD.Barracks.AddCombatRecordMedalsCard = function ( f32_arg0, f32_arg1, f32_arg2 )
	if CoD.Barracks.HideMedalsCard() then
		return 
	end
	local f32_local0 = f32_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f32_local0, Engine.Localize( "MENU_MEDALS" ) )
	Engine.SortItemsForCombatRecord( f32_arg1, CoD.CRCommon.SortTypes.MEDALS, f32_arg2 == true )
	local f32_local1 = Engine.GetCombatRecordSortedItemInfo( 0 )
	if f32_local1 and f32_local1.itemIndex and f32_local1.itemValue > 0 then
		f32_local0:setupCenterImage( UIExpression.TableLookupGetColumnValueForRow( f32_arg1, CoD.scoreInfoTable, f32_local1.itemIndex, CoD.AfterActionReport.medalImageMaterialNameCol ), 100, 100, 1.8, true )
	end
	f32_local0.hintText = Engine.Localize( "MENU_CR_MEDALS_HINT" )
	f32_local0.specialHintText = ""
	if f32_local1.itemValue > 0 then
		f32_local0.specialHintText = Engine.Localize( "MENU_CR_MEDALS_SPECIAL_HINT", UIExpression.TableLookupGetColumnValueForRow( f32_arg1, CoD.scoreInfoTable, f32_local1.itemIndex, CoD.AfterActionReport.medalStringCol ) )
	end
	f32_local0:setActionEventName( "open_combat_record" )
	f32_local0.menuName = "CRMedals"
end

CoD.Barracks.AddCombatRecordScorestreaksCard = function ( f33_arg0, f33_arg1, f33_arg2 )
	local f33_local0 = f33_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f33_local0, Engine.Localize( "MENU_SCORESTREAKS" ) )
	Engine.SortItemsForCombatRecord( f33_arg1, CoD.CRCommon.SortTypes.SCORESTREAKS, f33_arg2 == true )
	local f33_local1 = Engine.GetCombatRecordSortedItemInfo( 0 )
	if f33_local1 and f33_local1.itemIndex then
		f33_local0:setupCenterImage( UIExpression.GetItemImage( nil, f33_local1.itemIndex ) .. "_256", 100, 100, 1.8, true )
	end
	f33_local0.hintText = Engine.Localize( "MENU_CR_SCORESTREAKS_HINT" )
	f33_local0.specialHintText = Engine.Localize( "MENU_CR_SCORESTREAKS_SPECIAL_HINT", UIExpression.GetItemName( nil, f33_local1.itemIndex ) )
	f33_local0:setActionEventName( "open_combat_record" )
	f33_local0.menuName = "CRScorestreaks"
end

CoD.Barracks.AddCombatRecordSummaryCard = function ( f34_arg0, f34_arg1, f34_arg2 )
	if CoD.Barracks.HideSummaryCard() then
		return 
	end
	local f34_local0 = f34_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f34_local0, Engine.Localize( "MENU_COMBAT_SUMMARY" ) )
	f34_local0:setupCenterImage( "hud_medals_headshot", 100, 100, 1.5, true )
	local f34_local1 = Engine.GetPlayerStats( f34_arg1 )
	if f34_arg2 then
		f34_local1 = Engine.GetPlayerStats( f34_arg1, CoD.STATS_LOCATION_OTHERPLAYER )
	end
	local f34_local2 = f34_local1.PlayerStatsList.HEADSHOTS.statValue:get()
	f34_local0.hintText = Engine.Localize( "MENU_CR_SUMMARY_HINT" )
	f34_local0.specialHintText = Engine.Localize( "MENU_CR_SUMMARY_SPECIAL_HINT", f34_local2 )
	f34_local0:setActionEventName( "open_combat_record" )
	f34_local0.menuName = "CRSummary"
end

CoD.Barracks.SetupLockedImage = function ( f35_arg0 )
	local f35_local0 = 80
	local f35_local1 = 80
	local f35_local2 = 1.5
	f35_arg0:setAlpha( 0.5 )
	f35_arg0:setupCenterImage( CoD.CACUtility.LockImageBigMaterial, f35_local0, f35_local1, f35_local2 )
	f35_arg0.isLocked = true
end

CoD.Barracks.SetupLockedCard = function ( f36_arg0, f36_arg1, f36_arg2 )
	local f36_local0 = f36_arg1:addNewCard()
	CoD.Barracks.SetupLockedImage( f36_local0 )
	CoD.Barracks.SetupCarouselCard( f36_local0, "" )
	f36_local0.hintText = CoD.GetUnlockLevelString( f36_arg0, f36_arg2 )
	return f36_local0
end

CoD.Barracks.AddCombatRecordCarousel = function ( f37_arg0, f37_arg1, f37_arg2, f37_arg3 )
	local f37_local0 = f37_arg1:addCardCarousel( f37_arg0 )
	CoD.Barracks.SetupCardCarouselTitleTextPosition( f37_local0, f37_arg1 )
	f37_local0:registerEventHandler( "card_gain_focus", CoD.Barracks.CombatRecordCarouselCardGainFocus )
	local f37_local1 = UIExpression.GetItemIndex( f37_arg2, "FEATURE_COMBAT_RECORD" )
	local f37_local2
	if (f37_arg2 or UIExpression.IsItemLockedForAll( f37_arg2, f37_local1 ) ~= 1) and UIExpression.GetStatByName( f37_arg2, "RANK" ) >= UIExpression.GetItemUnlockLevel( f37_arg2, f37_local1 ) then
		f37_local2 = false
	else
		f37_local2 = true
	end
	if CoD.CRCommon.OtherPlayerCRMode ~= true and f37_local2 and UIExpression.GetStatByName( f37_arg2, "PLEVEL" ) < 1 then
		CoD.Barracks.SetupLockedCard( f37_arg2, f37_local0, "FEATURE_COMBAT_RECORD" )
		return 
	else
		CoD.Barracks.AddCombatRecordCareerCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordSummaryCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordGamemodesCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordMedalsCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordWeaponsCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordEquipmentCard( f37_local0, f37_arg2, f37_arg3 )
		CoD.Barracks.AddCombatRecordScorestreaksCard( f37_local0, f37_arg2, f37_arg3 )
	end
end

CoD.Barracks.CombatRecordCarouselCardGainFocus = function ( f38_arg0, f38_arg1 )
	CoD.CardCarousel.CardGainFocus( f38_arg0, f38_arg1 )
	if not f38_arg0.hintTextContainer or not f38_arg0.hintTextContainer.hintTextArea then
		return 
	end
	f38_arg0.hintTextContainer.hintTextArea:hide()
	f38_arg0.hintTextContainer.hintTextAreaCommon:hide()
	local f38_local0 = f38_arg1.card.menuName
	local f38_local1 = f38_arg1.card
	if f38_local0 == "CRCareer" then
		f38_arg0.hintTextContainer.hintTextArea:show()
	elseif f38_arg0.hintTextContainer.hintTextAreaCommon.commonHintText and f38_local1.specialHintText then
		f38_arg0.hintTextContainer.hintTextAreaCommon:show()
		f38_arg0.hintTextContainer.hintTextAreaCommon.commonHintText:setText( f38_local1.specialHintText )
	end
end

CoD.Barracks.AddCarousels = function ( f39_arg0, f39_arg1, f39_arg2 )
	if CoD.CRCommon.OtherPlayerCRMode == true then
		f39_arg0:addElement( CoD.MiniIdentity.GetMiniIdentity( f39_arg0:getOwner(), CoD.CRCommon.CurrentXuid ) )
		CoD.Barracks.AddCombatRecordCarousel( "", f39_arg1, f39_arg2, true )
		f39_arg0:setTitle( Engine.Localize( "MENU_COMBAT_RECORD_CAPS" ) )
		return 
	else
		CoD.CRCommon.CurrentXuid = UIExpression.GetXUID( f39_arg2 )
		if CoD.Barracks.ShowLeagueTeamsOnly == true then
			f39_arg0:addElement( CoD.MiniIdentity.GetMiniIdentity( f39_arg0:getOwner(), CoD.Barracks.CurrentLeaguePlayerXuid ) )
			CoD.Barracks.AddTeamsCarousel( "", f39_arg1, f39_arg2 )
			f39_arg0:setTitle( UIExpression.ToUpper( nil, Engine.Localize( "MENU_LEAGUE_TEAMS" ) ) )
			return 
		else
			CoD.Barracks.AddPlayerIDCarousel( "MENU_ID_CARD", f39_arg1, f39_arg2 )
			CoD.Barracks.AddChallengesCarousel( Engine.Localize( "MENU_CHALLENGES_CAPS" ), f39_arg1, f39_arg2 )
			CoD.Barracks.CurrentLeaguePlayerXuid = UIExpression.GetXUID( f39_arg2 )
			CoD.Barracks.AddTeamsCarousel( UIExpression.ToUpper( nil, Engine.Localize( "MENU_LEAGUE_TEAMS" ) ), f39_arg1, f39_arg2 )
			CoD.Barracks.AddCombatRecordCarousel( Engine.Localize( "MENU_COMBAT_RECORD_CAPS" ), f39_arg1, f39_arg2 )
			CoD.Barracks.AddLeaderboardCarousel( "MENU_LEADERBOARDS_CAPS", f39_arg1, f39_arg2 )
			CoD.Barracks.AddPrestigeCarousel( Engine.Localize( "MPUI_PRESTIGE_MODE_CAPS" ), f39_arg1, f39_arg2 )
			f39_arg0:addElement( CoD.MiniIdentity.GetMiniIdentity( f39_arg0:getOwner(), UIExpression.GetXUID( f39_arg0:getOwner() ) ) )
		end
	end
end

CoD.Barracks.AddPlayerIDCarousel = function ( f40_arg0, f40_arg1, f40_arg2 )
	local f40_local0 = f40_arg1:addCardCarousel( Engine.Localize( f40_arg0 ), nil, function ( f41_arg0 )
		local f41_local0 = Engine.IsAnyEmblemIconNew( f40_arg2 )
		if not f41_local0 then
			f41_local0 = Engine.IsAnyEmblemBackgroundNew( f40_arg2 )
		end
		return f41_local0
	end )
	CoD.Barracks.SetupCardCarouselTitleTextPosition( f40_local0, f40_arg1 )
	if not Engine.IsChatRestricted( f40_arg2 ) then
		local f40_local1 = f40_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard( f40_local1, Engine.Localize( "MENU_EMBLEM_EDITOR" ) )
		f40_local1.popup = f40_arg1.popup
		f40_local1:setActionEventName( "open_emblemeditor_carousel" )
		f40_local1.hintText = Engine.Localize( "MENU_EMBLEM_EDITOR_HINT" )
		if Engine.IsAnyEmblemIconNew( f40_arg2 ) then
			CoD.CAC.SetNewIcon( f40_local1, true )
		end
		if not Engine.IsEmblemEmpty( f40_arg2 ) then
			f40_local1:setupCenterImage( nil, 100, 100, 1.9 )
			f40_local1.centerImageContainer.centerImage:close()
			f40_local1.centerImageContainer:setupEmblem()
		end
	end
	local f40_local1 = f40_local0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f40_local1, Engine.Localize( "MENU_PLAYERID_BACKGROUNDS_CAPS" ) )
	f40_local1.popup = f40_arg1.popup
	f40_local1:setActionEventName( "open_emblembackgroundselector" )
	f40_local1.hintText = Engine.Localize( "MENU_PLAYERID_BACKGROUNDS_HINT" )
	if Engine.IsAnyEmblemBackgroundNew( f40_arg2 ) then
		CoD.CAC.SetNewIcon( f40_local1, true )
	end
	local f40_local2 = CoD.Barracks.ItemWidth - CoD.Barracks.BackgroundCardIconOffset
	f40_local1:setupCenterImage( UIExpression.EmblemBackgroundMaterial( f40_arg2, Engine.GetEmblemBackgroundId() ), f40_local2, f40_local2 / 4, 1.5, true )
	local f40_local3 = UIExpression.GetItemIndex( f40_arg2, "FEATURE_CLAN_TAG" )
	local f40_local4
	if (f40_arg2 or UIExpression.IsItemLockedForAll( f40_arg2, f40_local3 ) ~= 1) and UIExpression.GetStatByName( f40_arg2, "RANK" ) >= UIExpression.GetItemUnlockLevel( f40_arg2, f40_local3 ) then
		f40_local4 = false
	else
		f40_local4 = true
	end
	local f40_local5 = UIExpression.GetStatByName( f40_arg2, "PLEVEL" )
	local f40_local6 = nil
	if f40_local4 and f40_local5 < 1 then
		CoD.Barracks.SetupCarouselCard( CoD.Barracks.SetupLockedCard( f40_arg2, f40_local0, "FEATURE_CLAN_TAG" ), Engine.Localize( "FEATURE_CLAN_TAG" ), nil, 0, 0, 0 )
		return 
	end
	f40_local6 = f40_local0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f40_local6, Engine.Localize( "FEATURE_CLAN_TAG" ) )
	f40_local6.popup = f40_arg1.popup
	f40_local6:setActionEventName( "open_clan_tag" )
	f40_local6.hintText = Engine.Localize( "MENU_PLAYERID_CLANTAGS_HINT" )
	f40_local6:registerEventHandler( "refresh_clantag", CoD.Barracks.RefreshClanTag )
	local f40_local7 = -10
	local f40_local8 = UIExpression.GetClanName( f40_arg2 )
	local f40_local9 = 1
	if f40_local8 == nil or f40_local8 == "" then
		f40_local8 = "[" .. Engine.Localize( "MENU_TAB_CLAN_CAPS" ) .. "]"
		f40_local9 = 0.5
	end
	f40_local6.clanTag = LUI.UIText.new()
	f40_local6.clanTag:setLeftRight( true, true, 0, 0 )
	f40_local6.clanTag:setTopBottom( true, true, 0, 0 )
	f40_local6:setupCenterImage( nil, CoD.Barracks.ItemWidth, CoD.textSize.Big, 1.5 )
	f40_local6.centerImageContainer.centerImage:close()
	f40_local6.clanTag:setFont( CoD.fonts.Big )
	f40_local6.clanTag:setAlignment( LUI.Alignment.Center )
	f40_local6.clanTag:setAlpha( f40_local9 )
	f40_local6.centerImageContainer:addElement( f40_local6.clanTag )
	f40_local6.clanTag:setText( f40_local8 )
end

CoD.Barracks.RefreshClanTag = function ( f42_arg0, f42_arg1 )
	local f42_local0 = UIExpression.GetClanName( f42_arg1.controller )
	local f42_local1 = 1
	if f42_local0 == nil or f42_local0 == "" then
		f42_local0 = "[" .. Engine.Localize( "MENU_TAB_CLAN_CAPS" ) .. "]"
		f42_local1 = 0.5
	end
	f42_arg0.clanTag:setText( f42_local0 )
	f42_arg0.clanTag:setAlpha( f42_local1 )
end

CoD.Barracks.LeaderboardCardGainFocus = function ( f43_arg0, f43_arg1 )
	CoD.Barracks.LeaderboardCardSetupHintTextArea( f43_arg0.lbIndex, f43_arg0.cardCarousel )
	CoD.CardCarousel.Card_GainFocus( f43_arg0, f43_arg1 )
end

CoD.Barracks.AddLeaderboardCarousel = function ( f44_arg0, f44_arg1, f44_arg2 )
	if Dvar.ui_hideLeaderboards:get() == true then
		return 
	end
	local f44_local0 = f44_arg1:addCardCarousel( Engine.Localize( f44_arg0 ) )
	CoD.Barracks.SetupCardCarouselTitleTextPosition( f44_local0, f44_arg1 )
	local f44_local1 = #CoD.LeaderboardMP.Leaderboards
	for f44_local2 = 1, f44_local1, 1 do
		local f44_local5 = CoD.LeaderboardMP.Leaderboards[f44_local2]
		local f44_local6 = f44_local5[CoD.LeaderboardMP.LB_ICON]
		local f44_local7 = f44_local5[CoD.LeaderboardMP.LB_GAMEMODE]
		if f44_local7 == "" then
			f44_local7 = "LB_CAREER"
		end
		local f44_local8 = "MPUI_" .. f44_local7
		local f44_local9 = f44_local0:addNewCard()
		local f44_local10 = CoD.Barracks.ItemHeight - CoD.textSize.Default
		local f44_local11 = f44_local10
		local f44_local12 = 1.5
		CoD.Barracks.SetupCarouselCard( f44_local9, Engine.Localize( f44_local8 ) )
		f44_local9:setupCenterImage( f44_local6, f44_local11, f44_local10, f44_local12 )
		f44_local9.lbIndex = f44_local2
		f44_local9:setActionEventName( "open_leaderboard" )
		f44_local9.hintText = Engine.Localize( CoD.LeaderboardMP.Leaderboards[f44_local2][CoD.LeaderboardMP.LB_CARD_TEXT] )
		f44_local9:registerEventHandler( "gain_focus", CoD.Barracks.LeaderboardCardGainFocus )
	end
end

CoD.Barracks.OpenLeaderboard = function ( f45_arg0, f45_arg1 )
	if f45_arg1.button.lbIndex == nil then
		return 
	elseif UIExpression.IsGuest( f45_arg1.controller ) == 1 then
		return 
	else
		local f45_local0 = f45_arg0:openMenu( "LeaderboardMP", f45_arg1.controller )
		local f45_local1 = CoD.LeaderboardMP.Leaderboards[f45_arg1.button.lbIndex][CoD.LeaderboardMP.LB_NAME_CORE]
		f45_local0:processEvent( {
			name = "leaderboard_loadnew",
			controller = f45_arg1.controller,
			lbIndex = f45_arg1.button.lbIndex
		} )
		f45_arg0:close()
		CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f45_arg1.button )
	end
end

CoD.Barracks.MiniRead = function ( f46_arg0, f46_arg1 )
	local f46_local0 = {}
	local f46_local1 = f46_arg1
	local f46_local2 = math.min( f46_local1 + 4, #CoD.LeaderboardMP.Leaderboards )
	for f46_local3 = f46_local1, f46_local2, 1 do
		table.insert( f46_local0, {
			lbDef = CoD.LeaderboardMP.Leaderboards[f46_local3][CoD.LeaderboardMP.LB_LIST_CORE][CoD.LeaderboardMP.FILTER_DURATION_ALLTIME],
			lbFilter = "TRK_ALLTIME"
		} )
	end
	Engine.RequestMultiLeaderboardData( f46_arg0, CoD.REQUEST_MULTI_LB_READ_MINI_LBS, CoD.LB_FILTER_FRIENDS, f46_local0 )
end

CoD.Barracks.MiniLeaderboardUpdate = function ( f47_arg0, f47_arg1 )
	local f47_local0 = CoD.LeaderboardMP.CACHE_NOT_FOUND
	local f47_local1 = nil
	if f47_arg1.error == false then
		f47_local0 = CoD.LeaderboardMP.CACHE_FOUND
	end
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 1 then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A = f47_local0
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 2 then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B = f47_local0
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 3 then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C = f47_local0
	end
	if f47_local0 == CoD.LeaderboardMP.CACHE_FOUND and f47_arg1.leaderboards ~= nil then
		if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 1 then
			CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A_DATA = f47_arg1.leaderboards
		elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 2 then
			CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B_DATA = f47_arg1.leaderboards
		elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE == 3 then
			CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C_DATA = f47_arg1.leaderboards
		end
	end
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 1
		CoD.Barracks.MiniRead( f47_arg1.controller, 1 )
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 2
		CoD.Barracks.MiniRead( f47_arg1.controller, 6 )
	elseif CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C == CoD.LeaderboardMP.CACHE_EMPTY then
		CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE = 3
		CoD.Barracks.MiniRead( f47_arg1.controller, 11 )
	end
end

CoD.Barracks.AddMiniLeaderboardRow = function ( f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4 )
	local f48_local0 = CoD.black
	local f48_local1 = 0.7
	local f48_local2 = CoD.offWhite
	if f48_arg1 % 2 == 1 then
		f48_local0 = CoD.black
		f48_local1 = 0.4
	end
	if f48_arg2 == true then
		f48_local2 = CoD.yellowGlow
	end
	local f48_local3 = CoD.LeaderboardMP.AddUIImage( true, true, 0, 0, true, false, 25 * f48_arg1, 25 * f48_arg1 + 25, f48_local0.r, f48_local0.b, f48_local0.g, f48_local1 )
	local f48_local4 = CoD.LeaderboardMP.AddUIText( true, true, CoD.Barracks.MiniLeaderboardSideOffset, -CoD.Barracks.MiniLeaderboardSideOffset, true, false, 25 * f48_arg1, 25 * f48_arg1 + CoD.textSize.Default * 0.9, LUI.Alignment.Left )
	f48_local4:setRGB( f48_local2.r, f48_local2.g, f48_local2.b )
	f48_local4:setText( f48_arg3 )
	local f48_local5 = CoD.LeaderboardMP.AddUIText( true, true, CoD.Barracks.MiniLeaderboardSideOffset, -CoD.Barracks.MiniLeaderboardSideOffset, true, false, 25 * f48_arg1, 25 * f48_arg1 + CoD.textSize.Default * 0.9, LUI.Alignment.Right )
	f48_local5:setRGB( f48_local2.r, f48_local2.g, f48_local2.b )
	f48_local5:setText( f48_arg4 )
	f48_arg0:addElement( f48_local3 )
	f48_arg0:addElement( f48_local4 )
	f48_arg0:addElement( f48_local5 )
	return f48_arg0
end

CoD.Barracks.AddMiniLeaderboard = function ( f49_arg0, f49_arg1 )
	local f49_local0 = CoD.LeaderboardMP.Leaderboards[f49_arg0][CoD.LeaderboardMP.LB_LIST_CORE][CoD.LeaderboardMP.FILTER_DURATION_ALLTIME]
	local f49_local1 = nil
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A == CoD.LeaderboardMP.CACHE_FOUND then
		for f49_local2 = 1, #CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A_DATA, 1 do
			if f49_local0 == CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A_DATA[f49_local2].def then
				f49_local1 = CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_A_DATA[f49_local2]
				break
			end
		end
	end
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B == CoD.LeaderboardMP.CACHE_FOUND and f49_local1 == nil then
		for f49_local2 = 1, #CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B_DATA, 1 do
			if f49_local0 == CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B_DATA[f49_local2].def then
				f49_local1 = CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_B_DATA[f49_local2]
				break
			end
		end
	end
	if CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C == CoD.LeaderboardMP.CACHE_FOUND and f49_local1 == nil then
		for f49_local2 = 1, #CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C_DATA, 1 do
			if f49_local0 == CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C_DATA[f49_local2].def then
				f49_local1 = CoD.LeaderboardMP.MINI_LEADERBOARD_CACHE_C_DATA[f49_local2]
				break
			end
		end
	end
	local f49_local2 = CoD.LeaderboardMP.AddUIElement( true, false, 0, 350, true, false, 0, 80 )
	local f49_local3 = CoD.LeaderboardMP.AddUIText( true, true, CoD.Barracks.MiniLeaderboardSideOffset, -CoD.Barracks.MiniLeaderboardSideOffset, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left, nil, 0.6 )
	f49_local3:setText( Engine.Localize( "MENU_LB_MINI_GAMERTAG" ) )
	local f49_local4 = CoD.LeaderboardMP.AddUIText( true, true, CoD.Barracks.MiniLeaderboardSideOffset, -CoD.Barracks.MiniLeaderboardSideOffset, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Right, nil, 0.6 )
	if f49_arg0 == 1 then
		f49_local4:setText( Engine.Localize( "MENU_LB_SCORE" ) )
	elseif f49_arg0 > 1 and f49_arg0 <= 10 then
		f49_local4:setText( Engine.Localize( "MENU_LB_SCORE_PER_MINUTE" ) )
	elseif f49_arg0 >= 11 then
		f49_local4:setText( Engine.Localize( "MENU_LB_POINTS_PER_GAME" ) )
	end
	f49_local2:addElement( f49_local3 )
	f49_local2:addElement( f49_local4 )
	local f49_local5 = 1
	local f49_local6 = 1
	if f49_local1 ~= nil then
		for f49_local7 = 1, #f49_local1.lbrowheaders, 1 do
			if f49_local1.lbrowheaders[f49_local7] == "Gamertag" then
				f49_local5 = f49_local7
			end
			if f49_arg0 == 1 and f49_local1.lbrowheaders[f49_local7] == "Score" then
				f49_local6 = f49_local7
			end
			if f49_arg0 > 1 and f49_local1.lbrowheaders[f49_local7] == "Score Per Minute" then
				f49_local6 = f49_local7
			end
			if f49_arg0 > 1 and f49_local1.lbrowheaders[f49_local7] == "Points Per Game" then
				f49_local6 = f49_local7
			end
		end
	end
	local f49_local7 = UIExpression.GetXUID( controller )
	for f49_local8 = 1, 3, 1 do
		local f49_local11 = nil
		if f49_local1 ~= nil and f49_local8 <= #f49_local1.lbrows then
			f49_local11 = f49_local1.lbrows[f49_local8]
		end
		local f49_local12 = false
		local f49_local13 = "--"
		local f49_local14 = "--"
		if f49_local11 ~= nil then
			if f49_local11.xuid == f49_local7 then
				f49_local12 = true
			end
			f49_local13 = f49_local11[f49_local5]
			f49_local14 = f49_local11[f49_local6]
		end
		CoD.Barracks.AddMiniLeaderboardRow( f49_local2, f49_local8, f49_local12, f49_local13, f49_local14 )
	end
	return f49_local2
end

CoD.Barracks.LeaderboardCardSetupHintTextArea = function ( f50_arg0, f50_arg1 )
	if f50_arg1.hintTextContainer.hintTextArea then
		f50_arg1.hintTextContainer.hintTextArea:close()
		f50_arg1.hintTextContainer.hintTextArea = nil
	end
	local f50_local0 = CoD.Barracks.HintTextParams.hintTextLeft + CoD.Barracks.HintTextParams.hintTextWidth + 80
	local f50_local1 = CoD.Barracks.RightSideHintTextParams.hintTextWidth
	local f50_local2 = 0
	f50_arg1.hintTextContainer.hintTextArea = LUI.UIElement.new()
	f50_arg1.hintTextContainer.hintTextArea:setLeftRight( true, false, f50_local0, f50_local0 + f50_local1 )
	f50_arg1.hintTextContainer.hintTextArea:setTopBottom( true, false, f50_local2, f50_local2 + CoD.CardCarousel.HintTextHeight )
	f50_arg1.hintTextContainer:addElement( f50_arg1.hintTextContainer.hintTextArea )
	if f50_arg1.hintTextContainer.hintTextArea.hintTextList then
		f50_arg1.hintTextContainer.hintTextArea.hintTextList:close()
	end
	if f50_arg1.hintTextContainer.hintTextArea.spinner then
		f50_arg1.hintTextContainer.hintTextArea.spinner:close()
	end
	local f50_local3 = LUI.UIVerticalList.new()
	f50_local3:setLeftRight( true, false, 0, 510 )
	f50_local3:setTopBottom( true, true, -19, 0 )
	if 0 == UIExpression.DvarBool( nil, "ui_hideMiniLeaderboards" ) then
		f50_local3.miniLeaderboard = CoD.Barracks.AddMiniLeaderboard( f50_arg0, f50_arg1 )
		f50_local3:addElement( f50_local3.miniLeaderboard )
	end
	f50_arg1.hintTextContainer.hintTextArea.hintTextList = f50_local3
	f50_arg1.hintTextContainer.hintTextArea:addElement( f50_arg1.hintTextContainer.hintTextArea.hintTextList )
	f50_arg1.hintTextContainer:setAlpha( 0 )
	f50_arg1.hintTextContainer:beginAnimation( "fade_in", 1000 )
	f50_arg1.hintTextContainer:setAlpha( 1 )
end

CoD.Barracks.AddChallengesCarouselCard = function ( f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4, f51_arg5, f51_arg6 )
	local f51_local0 = f51_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f51_local0, f51_arg2 )
	local f51_local1 = CoD.Barracks.ItemHeight - CoD.textSize.Default
	f51_local0:setupCenterImage( f51_arg3, f51_local1, f51_local1, 1.5 )
	f51_local0:setActionEventName( "open_challenges_menu" )
	f51_local0.weaponSlot = f51_arg6
	f51_local0.menuName = f51_arg4
	f51_local0.hintText = f51_arg5
	return f51_local0
end

CoD.Barracks.AddChallengesCarousel = function ( f52_arg0, f52_arg1, f52_arg2 )
	local f52_local0 = f52_arg1:addCardCarousel( f52_arg0 )
	CoD.Barracks.SetupCardCarouselTitleTextPosition( f52_local0, f52_arg1 )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_PRIMARY_WEAPON" ), "barrack_primary_icon", "ChallengesWeapons", Engine.Localize( "MENU_CHALLENGES_PRIMARY_WEAPON_HINT" ), "primary" )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_SECONDARY_WEAPON" ), "barrack_secondary_icon", "ChallengesWeapons", Engine.Localize( "MENU_CHALLENGES_SECONDARY_WEAPON_HINT" ), "secondary" )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_OPTICS" ), "barrack_optics_icon", "ChallengesOptics", Engine.Localize( "MENU_CHALLENGES_OPTICS_HINT" ) )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MPUI_SCORE_STREAKS" ), "barrack_scorestreaks_icon", "ChallengesScorestreaks", Engine.Localize( "MENU_SCORE_STREAKS_HINT" ) )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_ASSIGNMENTS" ), "barrack_assignments_icon", "ChallengesAssignments", Engine.Localize( "MENU_CHALLENGES_ASSIGNMENTS_HINT" ) )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_GAME_MODES" ), "barrack_gamemode_icon", "ChallengesGamemodes", Engine.Localize( "MENU_CHALLENGES_GAME_MODES_HINT" ) )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MENU_CHALLENGES_CAREER" ), "barrack_career_icon", "ChallengesCareer", Engine.Localize( "MENU_CHALLENGES_CAREER_HINT" ) )
	CoD.Barracks.AddChallengesCarouselCard( f52_local0, f52_arg2, Engine.Localize( "MPUI_PRESTIGE" ), "barrack_prestige_icon", "ChallengesPrestige", Engine.Localize( "MENU_PRESTIGE_HINT" ) )
end

CoD.Barracks.PrestigeButtonAction = function ( f53_arg0, f53_arg1 )
	local f53_local0 = f53_arg1.controller
	if Engine.IsFeatureBanned( CoD.FEATURE_BAN_PRESTIGE ) then
		Engine.ExecNow( f53_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE )
		return 
	else
		f53_arg0:openPopup( "ConfirmPrestige", f53_arg1.controller, {
			action = "prestige_confirm",
			title = "MPUI_PRESTIGE_MODE_CAPS",
			message = "MENU_PRESTIGE_MODE_DESC_1",
			choiceAText = Engine.Localize( "MENU_LEARN_MORE" ),
			choiceBText = Engine.Localize( "MENU_NOT_NOW" ),
			image = f53_arg1.button.prestigeImageHiRes
		} )
		CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f53_arg1.button )
	end
end

CoD.Barracks.UpdateCarouselList = function ( f54_arg0, f54_arg1 )
	f54_arg0.occludedMenu:processEvent( {
		name = "update_button_pane"
	} )
	f54_arg0.cardCarouselList:close()
	CoD.Barracks.AddCardCarouselList( f54_arg0, f54_arg1.controller )
end

CoD.Barracks.AddPrestigeCarouselCards = function ( f55_arg0, f55_arg1 )
	local f55_local0 = CoD.MAX_RANK
	local f55_local1 = UIExpression.GetStatByName( f55_arg1, "PLEVEL" )
	local f55_local2 = UIExpression.TableLookup( nil, CoD.rankIconTable, 0, f55_local0, f55_local1 + 2 )
	local f55_local3 = CoD.PrestigeAvail( f55_arg1 )
	local f55_local4 = CoD.PrestigeFinish( f55_arg1 )
	local f55_local5 = 110
	local f55_local6 = f55_local5
	local f55_local7 = 1.5
	if not f55_local4 then
		local f55_local8 = f55_arg0:addNewCard()
		if f55_local3 then
			local f55_local9 = f55_local2 .. "_128"
			f55_local8.hintText = Engine.Localize( "MENU_PRESTIGE_MODE_UNLOCKED_HINT", f55_local1 + 1 )
			f55_local8:setActionEventName( "open_prestige_popup" )
			f55_local8:setupCenterImage( f55_local9, f55_local6, f55_local5, f55_local7, true )
			f55_local8.prestigeImageHiRes = f55_local9
			CoD.Barracks.SetupCarouselCard( f55_local8, Engine.Localize( "MPUI_PRESTIGE_MODE" ) )
		else
			CoD.Barracks.SetupLockedImage( f55_local8 )
			CoD.Barracks.SetupCarouselCard( f55_local8, Engine.Localize( "MPUI_PRESTIGE_MODE" ) )
			f55_local8.hintText = Engine.Localize( "MENU_PRESTIGE_MODE_LOCKED_HINT" )
		end
	end
	local f55_local8 = f55_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard( f55_local8, Engine.Localize( "MENU_PRESTIGE_AWARDS" ) )
	if UIExpression.GetStatByName( f55_arg1, "PLEVEL" ) > 0 and not Engine.IsPrestigeTokenSpent( f55_arg1 ) then
		f55_local8:setupCenterImage( "menu_prestige_icon_awards", f55_local6, f55_local5, 1.8 )
		f55_local8:setActionEventName( "open_prestige_awards" )
	else
		CoD.Barracks.SetupLockedImage( f55_local8 )
		f55_local8.hintText = Engine.Localize( "MENU_PRESTIGE_AWARDS_LOCKED_HINT" )
	end
end

CoD.Barracks.AddPrestigeCarousel = function ( f56_arg0, f56_arg1, f56_arg2 )
	if CoD.IsLeagueOrCustomMatch() then
		return 
	elseif CoD.PrestigeFinish( f56_arg2 ) and Engine.IsPrestigeTokenSpent( f56_arg2 ) then
		return 
	else
		local f56_local0 = f56_arg1:addCardCarousel( f56_arg0 )
		CoD.Barracks.SetupCardCarouselTitleTextPosition( f56_local0, f56_arg1 )
		CoD.Barracks.AddPrestigeCarouselCards( f56_local0, f56_arg2 )
	end
end

function GetLeagueInfoBox( f57_arg0, f57_arg1, f57_arg2, f57_arg3 )
	local f57_local0 = f57_arg1 + f57_arg2 + f57_arg3 * 3
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, 0, f57_local0 )
	self:setTopBottom( true, true, 0, 0 )
	self:addElement( CoD.Border.new( 1, 1, 1, 1, 0.1, nil, nil, true ) )
	local f57_local2 = f57_arg3
	local f57_local3 = LUI.UIImage.new()
	local f57_local4 = 2
	f57_local3:setLeftRight( true, false, f57_local2, f57_local2 + f57_arg1 )
	f57_local3:setTopBottom( false, false, -f57_arg1 / 2 - f57_local4, f57_arg1 / 2 - f57_local4 )
	f57_local3:setImage( RegisterMaterial( f57_arg0.leagueIconName .. "_64" ) )
	self.leagueIcon = f57_local3
	self:addElement( f57_local3 )
	f57_local2 = f57_local2 + f57_arg1 + f57_arg3
	local f57_local5 = LUI.UIImage.new()
	f57_local5:setLeftRight( true, false, f57_local2, f57_local2 + f57_arg2 )
	f57_local5:setTopBottom( false, false, -f57_arg2 / 2 - f57_local4, f57_arg2 / 2 - f57_local4 )
	f57_local5:setImage( f57_arg0.divisionIcon )
	self.divisionIcon = f57_local5
	self:addElement( f57_local5 )
	f57_local2 = f57_local2 + f57_arg2 + f57_arg3
	local f57_local6 = LUI.UIText.new()
	f57_local6:setLeftRight( true, false, f57_local2, f57_local2 + 5 )
	f57_local6:setTopBottom( false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2 )
	self.divisionRank = f57_local6
	f57_local6:setFont( CoD.fonts.ExtraSmall )
	f57_local6:setText( "999" )
	return self
end

CoD.Barracks.SetupTeamHintTextArea = function ( f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4 )
	if f58_arg0.hintTextContainer.hintTextArea then
		f58_arg0.hintTextContainer.hintTextArea:close()
		f58_arg0.hintTextContainer.hintTextArea = nil
	end
	local f58_local0 = CoD.Barracks.HintTextParams.hintTextLeft + CoD.Barracks.HintTextParams.hintTextWidth + 80
	local f58_local1 = CoD.Barracks.RightSideHintTextParams.hintTextWidth
	local f58_local2 = -20
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, f58_local0, f58_local0 + f58_local1 )
	self:setTopBottom( true, false, f58_local2, f58_local2 + CoD.CardCarousel.HintTextHeight )
	f58_arg0.hintTextContainer.hintTextArea = self
	f58_arg0.hintTextContainer:addElement( f58_arg0.hintTextContainer.hintTextArea )
	if f58_arg0.hintTextContainer.hintTextList then
		f58_arg0.hintTextContainer.hintTextList:close()
	end
	if f58_arg0.hintTextContainer.spinner and f58_arg0.hintTextContainer.spinner:getParent() then
		f58_arg0.hintTextContainer.spinner:close()
	end
	if f58_arg1 == "fetching_failed" or f58_arg4 then
		return 
	elseif not f58_arg1 or f58_arg1 == "fetching" then
		f58_arg0.hintTextContainer.spinner = CoD.Barracks.GetSpinner( 30, 20 )
		if not f58_arg0.hintTextContainer.spinner:getParent() then
			f58_arg0.hintTextContainer.hintTextArea:addElement( f58_arg0.hintTextContainer.spinner )
		end
		return 
	end
	local f58_local4 = LUI.UIVerticalList.new()
	f58_local4:setLeftRight( true, true, 0, 0 )
	f58_local4:setTopBottom( true, true, -18, 0 )
	if f58_arg3 and f58_arg3.members and #f58_arg3.members > 0 then
		local f58_local5 = Engine.Localize( "MENU_TEAM_MEMBERS" )
		if f58_arg3.numMembers == 1 then
			f58_local5 = Engine.Localize( "LEAGUE_SOLO_COMPETITOR" )
		end
		f58_local4.teamLabel = f0_local4( "ExtraSmall", UIExpression.ToUpper( nil, f58_local5 ), CoD.gray )
		f58_local4:addElement( f58_local4.teamLabel )
		f58_local4:addSpacer( 5 )
		local f58_local6 = 2
		local f58_local7 = math.ceil( #f58_arg3.members / f58_local6 )
		local f58_local8 = nil
		for f58_local9 = 1, f58_local7, 1 do
			local f58_local12 = ""
			local f58_local13 = ""
			f58_local8 = (f58_local9 - 1) * f58_local6 + 1
			if f58_arg3.members[f58_local8] then
				f58_local12 = f58_arg3.members[f58_local8].userName
			end
			f58_local8 = (f58_local9 - 1) * f58_local6 + 2
			if f58_arg3.members[f58_local8] then
				f58_local13 = f58_arg3.members[f58_local8].userName
			end
			f58_local4:addElement( f0_local4( "ExtraSmall", f58_local12 .. "      " .. f58_local13 ) )
		end
	end
	f58_local4:addSpacer( CoD.textSize.ExtraSmall )
	if CoD.LeaguesData.CurrentTeamInfo.timeLastPlayed then
		f58_local4.lastPlayed = f0_local4( "ExtraSmall", Engine.Localize( "MENU_LAST_PLAYED_ARG", CoD.LeaguesData.CurrentTeamInfo.timeLastPlayed ) )
		f58_local4:addElement( f58_local4.lastPlayed )
	end
	f58_local4:addSpacer( 5 )
	local f58_local5 = #f58_arg2
	if f58_local5 == 0 then
		f58_local4.awaitingPlacement = f0_local4( "ExtraSmall", Engine.Localize( "MENU_AWAITING_PLACEMENT" ) )
		f58_local4:addElement( f58_local4.awaitingPlacement )
	else
		local f58_local6 = 2
		local f58_local7 = 1
		local f58_local8 = math.ceil( f58_local5 / f58_local6 )
		for f58_local9 = 1, f58_local8, 1 do
			local f58_local12 = LUI.UIHorizontalList.new()
			local f58_local13 = 64
			local f58_local14 = 64
			local f58_local15 = 15
			local f58_local16 = f58_local13 + f58_local15 * 2
			f58_local12:setLeftRight( true, true, 0, 0 )
			f58_local12:setTopBottom( true, false, 0, f58_local16 )
			for f58_local17 = 1, f58_local6, 1 do
				local f58_local20 = (f58_local9 - 1) * f58_local6 + f58_local17
				if f58_local20 <= f58_local5 then
					local f58_local21 = f58_arg2[f58_local20]
					if f58_local21 then
						f58_local12:addElement( GetLeagueInfoBox( f58_local21, f58_local13, f58_local14, f58_local15 ) )
						f58_local12:addSpacer( 10 )
					end
				end
			end
			f58_local4:addElement( f58_local12 )
			f58_local4:addSpacer( 10 )
		end
	end
	f58_arg0.hintTextContainer.hintTextList = f58_local4
	f58_arg0.hintTextContainer.hintTextArea:addElement( f58_arg0.hintTextContainer.hintTextList )
	f58_arg0.hintTextContainer:setAlpha( 0 )
	f58_arg0.hintTextContainer:beginAnimation( "fade_in", 1000 )
	f58_arg0.hintTextContainer:setAlpha( 1 )
end

CoD.Barracks.TeamsCardButtonAction = function ( f59_arg0, f59_arg1 )
	if f59_arg0.actionSFX ~= nil then
		Engine.PlaySound( f59_arg0.actionSFX )
	end
	f59_arg0:dispatchEventToParent( {
		name = "open_league_teams",
		controller = f59_arg1.controller
	} )
end

CoD.Barracks.TeamsCard_GainFocus = function ( f60_arg0, f60_arg1 )
	CoD.LeaguesData.CurrentTeamInfo = f60_arg0.teamInfo
	CoD.Barracks.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo( f60_arg0 )
	if f60_arg0.isPrevNavCard or f60_arg0.isNextNavCard then
		f60_arg0.disableGrowShrink = true
		CoD.CardCarousel.Card_GainFocus( f60_arg0, f60_arg1 )
		CoD.Barracks.SetupTeamHintTextArea( f60_arg0.cardCarousel, nil, nil, nil, true )
		return 
	elseif f60_arg0.teamInfo then
		local f60_local0 = CoD.LeaguesData.TeamSubdivisionInfo.data
		local f60_local1 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
		local f60_local2 = f60_arg0.teamInfo.teamID
		local f60_local3 = f60_local1[f60_local2]
		local f60_local4 = Engine.GetLeagueTeamMemberInfo( f60_arg1.controller, f60_local2 )
		if not f60_arg0.fetchTimer:getParent() and not f60_local3 then
			f60_arg0:addElement( f60_arg0.fetchTimer )
		else
			f60_local1[f60_local2], f60_local0[f60_local2] = Engine.GetLeagueTeamSubdivisionInfos( f60_arg1.controller, f60_local2 )
			f60_local3 = f60_local1[f60_local2]
		end
		CoD.Barracks.SetupTeamHintTextArea( f60_arg0.cardCarousel, f60_local3, f60_local0[f60_local2], f60_local4 )
	end
	CoD.CardCarousel.Card_GainFocus( f60_arg0, f60_arg1 )
end

CoD.Barracks.TeamsCard_LoseFocus = function ( f61_arg0, f61_arg1 )
	f61_arg0.fetchTimer:close()
	CoD.CardCarousel.Card_LoseFocus( f61_arg0, f61_arg1 )
end

CoD.Barracks.TeamsCardFetchSubdivisionInfo = function ( f62_arg0, f62_arg1 )
	if f62_arg0.teamInfo then
		local f62_local0 = CoD.LeaguesData.TeamSubdivisionInfo.data
		local f62_local1 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
		local f62_local2 = f62_arg0.teamInfo.teamID
		local f62_local3 = Engine.GetLeagueTeamMemberInfo( f62_arg1.controller, f62_local2 )
		f62_local1[f62_local2], f62_local0[f62_local2] = Engine.GetLeagueTeamSubdivisionInfos( f62_arg1.controller, f62_local2 )
		CoD.Barracks.SetupTeamHintTextArea( f62_arg0.cardCarousel, f62_local1[f62_local2], f62_local0[f62_local2], f62_local3 )
	end
end

CoD.Barracks.PopulateHintTextData = function ( f63_arg0, f63_arg1 )
	local f63_local0 = CoD.LeaguesData.TeamSubdivisionInfo.data
	local f63_local1 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
	if not CoD.LeaguesData.CurrentTeamInfo then
		return 
	end
	local f63_local2 = CoD.LeaguesData.CurrentTeamInfo.teamID
	if f63_arg1.success then
		f63_local1[f63_arg1.teamID], f63_local0[f63_arg1.teamID] = Engine.GetLeagueTeamSubdivisionInfos( f63_arg1.controller, f63_arg1.teamID )
		local f63_local3 = Engine.GetLeagueTeamMemberInfo( f63_arg1.controller, f63_arg1.teamID )
		if f63_arg1.teamID == f63_local2 and REG6 then
			CoD.Barracks.SetupTeamHintTextArea( f63_arg0, f63_local1[f63_local2], f63_local0[f63_local2], f63_local3 )
		end
	end
end

local f0_local7 = function ( f64_arg0, f64_arg1, f64_arg2, f64_arg3 )
	local f64_local0 = f64_arg0:addNewCard()
	f64_local0.teamInfo = f64_arg1
	f64_local0.hintText = Engine.Localize( "MENU_LEAGUE_BARRACKS_TEAM_DESC" )
	if f64_arg3 then
		f64_local0.hintText = Engine.Localize( "MENU_LEAGUE_BARRACKS_SOLO_DESC" )
	end
	CoD.Barracks.SetupCarouselCard( f64_local0, f64_arg1.teamName )
	f64_local0:setupCenterImage( nil, 100, 100, 1.5 )
	f64_local0.centerImageContainer.centerImage:setupLeagueEmblem( f64_arg1.teamID )
	f64_local0:registerEventHandler( "gain_focus", CoD.Barracks.TeamsCard_GainFocus )
	f64_local0:registerEventHandler( "lose_focus", CoD.Barracks.TeamsCard_LoseFocus )
	f64_local0:registerEventHandler( "button_action", CoD.Barracks.TeamsCardButtonAction )
	f64_local0:registerEventHandler( "fetch_subdivision_info", CoD.Barracks.TeamsCardFetchSubdivisionInfo )
	f64_local0.fetchTimer = LUI.UITimer.new( CoD.Barracks.SubdivisionInfoFetchTimer, {
		name = "fetch_subdivision_info",
		controller = f64_arg2
	}, true )
end

local f0_local8 = function ( f65_arg0, f65_arg1, f65_arg2 )
	local f65_local0 = f65_arg0:addNewCard()
	f65_local0.border:close()
	f65_local0:setupCenterImage( "menu_next_prev_arrow_black", 128, 84, 1.5 )
	f65_local0.centerImageContainer:setUseStencil( true )
	f65_local0.centerImageContainer.centerImage:setLeftRight( true, true, -2, 2 )
	f65_local0.centerImageContainer.centerImage:setTopBottom( true, true, -2, 2 )
	local f65_local1 = "Default"
	local f65_local2 = CoD.GetTextElem( f65_local1, "Center", f65_arg1 )
	f65_local2:setLeftRight( true, true, 5, -5 )
	f65_local2:setTopBottom( false, false, -CoD.textSize[f65_local1] / 2 + 5, CoD.textSize[f65_local1] / 2 + 5 )
	f65_local2:registerAnimationState( "button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	} )
	LUI.UIButton.SetupElement( f65_local2 )
	f65_local0.centerImageContainer:addElement( f65_local2 )
	if f65_arg2 then
		f65_local0.isNextNavCard = true
		f65_local2:setAlignment( LUI.Alignment.Left )
		f65_local0:setActionEventName( "next_nav_button_pressed" )
	else
		f65_local0.centerImageContainer.centerImage:setYRot( 180 )
		f65_local2:setAlignment( LUI.Alignment.Right )
		f65_local0.isPrevNavCard = true
		f65_local0:setActionEventName( "prev_nav_button_pressed" )
	end
	f65_local0:registerEventHandler( "gain_focus", CoD.Barracks.TeamsCard_GainFocus )
end

local f0_local9 = function ( f66_arg0, f66_arg1, f66_arg2, f66_arg3 )
	if CoD.Barracks.LeagueTeamsCurrOffset > 0 then
		f0_local8( f66_arg0, Engine.Localize( "MENU_PREVIOUS" ) )
	end
	if CoD.Barracks.LeagueTeamsCurrOffset == 0 then
		f0_local7( f66_arg0, {
			teamID = f66_arg1.soloTeamID,
			teamName = Engine.Localize( "MENU_SOLO" )
		}, f66_arg2, true )
	end
	for f66_local0 = 1, CoD.Barracks.LeagueTeamsPageSize, 1 do
		local f66_local3 = f66_arg1[f66_local0]
		if f66_local3 and f66_local3.teamID ~= f66_arg1.soloTeamID then
			f0_local7( f66_arg0, f66_local3, f66_arg2 )
		end
	end
	if CoD.Barracks.LeagueTeamsPageSize < f66_arg1.numTeams then
		f0_local8( f66_arg0, Engine.Localize( "MENU_NEXT" ), true )
	end
end

CoD.Barracks.SetupNoTeamsCard = function ( f67_arg0 )
	f67_arg0.hintText = Engine.Localize( "MENU_LEAGUE_NO_TEAMS_DESC" )
	CoD.Barracks.SetupCarouselCard( f67_arg0, Engine.Localize( "MENU_NO_TEAMS" ) )
	local f67_local0 = (CoD.Barracks.ItemHeight - CoD.textSize.Default) * 0.75
	f67_arg0:setupCenterImage( "menu_theater_nodata", f67_local0, f67_local0, 1.5 )
end

CoD.Barracks.SetupTeamsCarousel = function ( f68_arg0, f68_arg1 )
	CoD.Barracks.LeagueTeamsDataFetched = true
	local f68_local0 = Engine.GetLeagueTeams( f68_arg1.controller )
	if f68_local0 ~= nil then
		f68_local0.numResults = f68_arg1.numResults
	end
	CoD.LeaguesData.teamsData = f68_local0
	f68_arg0:clearAllItems()
	if not f68_arg1.success or f68_arg1.success == true and (f68_local0 == nil or f68_local0 ~= nil and #f68_local0 == 0) then
		CoD.Barracks.SetupNoTeamsCard( f68_arg0:addNewCard() )
	elseif f68_arg1.success and f68_local0 ~= nil and #f68_local0 > 0 then
		f0_local9( f68_arg0, f68_local0, f68_arg1.controller, f68_arg1.numResults )
		local f68_local1 = 1
		if f68_arg0.navButtonPressed ~= "prev" then
			if CoD.Barracks.LeagueTeamsCurrOffset > 0 then
				f68_local1 = f68_local1 + 1
			end
		else
			f68_local1 = CoD.Barracks.LeagueTeamsPageSize
			if CoD.Barracks.LeagueTeamsCurrOffset > 0 then
				f68_local1 = f68_local1 + 1
			end
		end
		if CoD.Barracks.CurrentCarouselInfo and f68_arg0.id == CoD.Barracks.CurrentCarouselInfo.carouselID then
			f68_arg0.cardCarouselList:setInitialCarousel( CoD.Barracks.CurrentCarouselInfo.carouselIndex, f68_local1 )
			if f68_arg0.navButtonPressed ~= nil then
				f68_arg0.cardCarouselList:focusCurrentCardCarousel( f68_arg1.controller )
				f68_arg0.navButtonPressed = nil
			end
		else
			f68_arg0.cardCarouselList:focusCurrentCardCarousel( f68_arg1.controller )
		end
	end
end

CoD.Barracks.GetSpinner = function ( f69_arg0, f69_arg1, f69_arg2 )
	local f69_local0 = 64
	if f69_arg2 then
		f69_local0 = f69_arg2
	end
	local self = LUI.UIImage.new( {
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	} )
	self:setLeftRight( false, false, -f69_local0 / 2, f69_local0 / 2 )
	self:setTopBottom( false, false, -f69_local0 / 2, f69_local0 / 2 )
	if f69_arg0 then
		self:setLeftRight( true, false, f69_arg0, f69_arg0 + f69_local0 )
	end
	if f69_arg1 then
		self:setTopBottom( true, false, f69_arg1, f69_arg1 + f69_local0 )
	end
	self:setImage( RegisterMaterial( "lui_loader" ) )
	return self
end

CoD.Barracks.SetupCardSpinner = function ( f70_arg0 )
	f70_arg0.spinner = CoD.Barracks.GetSpinner()
	f70_arg0:addElement( f70_arg0.spinner )
end

CoD.Barracks.LeaguePrevNavButtonPressed = function ( f71_arg0, f71_arg1 )
	if f71_arg1.button then
		local f71_local0 = 32
		local f71_local1 = f71_arg1.button
		local f71_local2 = CoD.Barracks.GetSpinner( nil, nil, 32 )
		f71_local2:setTopBottom( false, false, -f71_local0 / 2 + 50, f71_local0 / 2 + 50 )
		f71_local1:addElement( f71_local2 )
	end
	CoD.Barracks.LeagueTeamsCurrOffset = CoD.Barracks.LeagueTeamsCurrOffset - CoD.Barracks.LeagueTeamsPageSize
	if CoD.Barracks.LeagueTeamsCurrOffset < 0 then
		CoD.Barracks.LeagueTeamsCurrOffset = 0
	end
	f71_arg0.navButtonPressed = "prev"
	Engine.FetchLeagueTeams( f71_arg1.controller, CoD.Barracks.LeagueTeamsCurrOffset, CoD.Barracks.LeagueTeamsPageSize + 2, CoD.Barracks.CurrentLeaguePlayerXuid )
end

CoD.Barracks.LeagueNextNavButtonPressed = function ( f72_arg0, f72_arg1 )
	if f72_arg1.button then
		local f72_local0 = 32
		local f72_local1 = f72_arg1.button
		local f72_local2 = CoD.Barracks.GetSpinner( nil, nil, f72_local0 )
		f72_local2:setTopBottom( false, false, -f72_local0 / 2 + 50, f72_local0 / 2 + 50 )
		f72_local1:addElement( f72_local2 )
	end
	f72_arg0.navButtonPressed = "next"
	CoD.Barracks.LeagueTeamsCurrOffset = CoD.Barracks.LeagueTeamsCurrOffset + CoD.Barracks.LeagueTeamsPageSize
	Engine.FetchLeagueTeams( f72_arg1.controller, CoD.Barracks.LeagueTeamsCurrOffset, CoD.Barracks.LeagueTeamsPageSize + 2, CoD.Barracks.CurrentLeaguePlayerXuid )
end

CoD.Barracks.AddTeamsCarousel = function ( f73_arg0, f73_arg1, f73_arg2 )
	local f73_local0 = f73_arg1:addCardCarousel( f73_arg0 )
	CoD.Barracks.SetupCardCarouselTitleTextPosition( f73_local0, f73_arg1 )
	if CoD.Barracks.LeagueTeamsDataFetched == true and CoD.LeaguesData.teamsData then
		local f73_local1 = CoD.LeaguesData.teamsData
		if f73_local1 == nil or f73_local1 ~= nil and #f73_local1 == 0 then
			local f73_local2 = f73_local0:addNewCard()
			CoD.Barracks.SetupCarouselCard( f73_local2, Engine.Localize( "MENU_NO_TEAMS" ) )
			CoD.Barracks.SetupNoTeamsCard( f73_local2 )
		elseif f73_local1 ~= nil and #f73_local1 > 0 then
			f0_local9( f73_local0, f73_local1, f73_arg2, f73_local1.numResults )
		end
	else
		if not CoD.Barracks.LeagueTeamsCurrOffset then
			CoD.Barracks.LeagueTeamsCurrOffset = 0
		end
		Engine.FetchLeagueTeams( f73_arg2, CoD.Barracks.LeagueTeamsCurrOffset, CoD.Barracks.LeagueTeamsPageSize + 2, CoD.Barracks.CurrentLeaguePlayerXuid )
		local f73_local1 = f73_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard( f73_local1 )
		CoD.Barracks.SetupCardSpinner( f73_local1 )
	end
	f73_local0:registerEventHandler( "league_team_info_fetched", CoD.Barracks.SetupTeamsCarousel )
	f73_local0:registerEventHandler( "league_team_subdivision_info_fetched", CoD.Barracks.PopulateHintTextData )
	f73_local0:registerEventHandler( "prev_nav_button_pressed", CoD.Barracks.LeaguePrevNavButtonPressed )
	f73_local0:registerEventHandler( "next_nav_button_pressed", CoD.Barracks.LeagueNextNavButtonPressed )
end

