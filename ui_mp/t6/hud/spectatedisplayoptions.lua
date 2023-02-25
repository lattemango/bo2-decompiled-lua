require( "T6.CoD9Button" )
require( "T6.ProfileLeftRightSelector" )

CoD.SpectateDisplayOptions = InheritFrom( LUI.UIElement )
CoD.SpectateDisplayOptions.FontSize = CoD.textSize.ExtraSmall
CoD.SpectateDisplayOptions.Font = CoD.fonts.ExtraSmall
CoD.SpectateDisplayOptions.RowWidth = 310
CoD.SpectateDisplayOptions.RowHeight = CoD.SpectatePlayerInfo.FontSize + 6
CoD.SpectateDisplayOptions.RowSpacing = 3
CoD.SpectateDisplayOptions.MaxRows = 14
CoD.SpectateDisplayOptions.Top = 70
CoD.SpectateDisplayOptions.ProfileSelectorHorizontalGap = 220
local f0_local0 = function ( f1_arg0 )
	Engine.SetProfileVar( f1_arg0.parentSelectorButton.m_currentController, f1_arg0.parentSelectorButton.m_profileVarName, f1_arg0.value )
	local f1_local0 = f1_arg0.parentSelectorButton:getParent()
	if f1_local0 ~= nil then
		f1_local0.eventTarget:dispatchEventToParent( {
			name = "spectate_display_options_changed",
			controller = f1_arg0.parentSelectorButton.m_currentController,
			profileVar = f1_arg0.parentSelectorButton.m_profileVarName,
			profileValue = f1_arg0.value
		} )
	end
end

CoD.SpectateDisplayOptions.Button_AddChoices = function ( f2_arg0, f2_arg1 )
	if f2_arg0.strings == nil or #f2_arg0.strings == 0 then
		return 
	elseif f2_arg1 == nil then
		f2_arg1 = f0_local0
	end
	for f2_local0 = 1, #f2_arg0.strings, 1 do
		f2_arg0:addChoice( Engine.Localize( f2_arg0.strings[f2_local0] ), f2_arg0.values[f2_local0], nil, f2_arg1 )
	end
end

CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff = function ( f3_arg0, f3_arg1 )
	local f3_local0 = {}
	local f3_local1 = Engine.Localize( "MENU_OFF" )
	local f3_local2 = Engine.Localize( "MENU_ON" )
	f3_arg0.strings = f3_local1
	f3_arg0.values = {
		0,
		1
	}
	CoD.SpectateDisplayOptions.Button_AddChoices( f3_arg0, f3_arg1 )
end

CoD.SpectateDisplayOptions.AddProfileLeftRightSelector = function ( f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6 )
	local f4_local0 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.SpectateDisplayOptions.RowHeight
	}
	if f4_arg5 == nil then
		f4_arg5 = CoD.SpectateDisplayOptions.ProfileSelectorHorizontalGap
	end
	local f4_local1 = CoD.ProfileLeftRightSelector.new( f4_arg1, f4_arg2, f4_arg3, f4_arg5, f4_local0 )
	f4_local1.label:setFont( CoD.SpectateDisplayOptions.Font )
	f4_local1.label:setLeftRight( true, false, 20, f4_arg5 )
	f4_local1.label:setTopBottom( false, false, -CoD.SpectateDisplayOptions.FontSize / 2, CoD.SpectateDisplayOptions.FontSize / 2 )
	if f4_local1.leftArrow then
		f4_local1.leftArrow:setLeftRight( true, false, 0, CoD.SpectateDisplayOptions.FontSize )
		f4_local1.leftArrow:setTopBottom( false, false, -CoD.SpectateDisplayOptions.FontSize / 2, CoD.SpectateDisplayOptions.FontSize / 2 )
	end
	f4_local1.choiceText:setFont( CoD.SpectateDisplayOptions.Font )
	f4_local1.choiceText:setTopBottom( false, false, -CoD.SpectateDisplayOptions.FontSize / 2, CoD.SpectateDisplayOptions.FontSize / 2 )
	if f4_local1.rightArrow then
		f4_local1.rightArrow:setLeftRight( true, false, 0, CoD.SpectateDisplayOptions.FontSize )
		f4_local1.rightArrow:setTopBottom( false, false, -CoD.SpectateDisplayOptions.FontSize / 2, CoD.SpectateDisplayOptions.FontSize / 2 )
	end
	f4_local1.hintText = f4_arg4
	f4_local1:setPriority( f4_arg6 )
	local self = LUI.UIImage.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self:setRGB( 0.1, 0.1, 0.1 )
	self:setAlpha( 0.7 )
	self:setPriority( -100 )
	f4_local1:addElement( self )
	f4_arg0:addElement( f4_local1 )
	CoD.ButtonList.AssociateHintTextListenerToButton( f4_local1 )
	return f4_local1
end

CoD.SpectateDisplayOptions.new = function ( f5_arg0 )
	local self = LUI.UIVerticalList.new()
	self:setLeftRight( true, false, 0, CoD.SpectateDisplayOptions.RowWidth )
	self:setTopBottom( true, true, CoD.SpectateDisplayOptions.Top, 0 )
	self:setClass( CoD.SpectateDisplayOptions )
	local f5_local1 = CoD.SpectateDisplayOptions.Top + CoD.SpectateDisplayOptions.RowHeight
	local f5_local2 = CoD.SpectateDisplayOptions.RowSpacing
	local f5_local3 = CoD.SpectateDisplayOptions.RowHeight
	local f5_local4 = CoD.SpectateDisplayOptions.MaxRows
	local f5_local5 = f5_local3 * f5_local4 + f5_local2 * f5_local4
	local f5_local6 = 2
	self.buttonList = CoD.ButtonList.new( {
		leftAnchor = true,
		rightAnchor = false,
		left = 50,
		right = CoD.SpectatePlayerInfo.RowWidth + 90,
		topAnchor = false,
		bottomAnchor = true,
		top = -f5_local5,
		bottom = 100
	} )
	self.buttonList.id = "displayOptionsButtonList"
	self.buttonList:setSpacing( f5_local2 )
	self.buttonList.addProfileLeftRightSelector = CoD.SpectateDisplayOptions.AddProfileLeftRightSelector
	self.buttonList.hintText.hint:setTopBottom( true, false, 0, CoD.SpectateDisplayOptions.FontSize )
	self.buttonList.eventTarget = self
	self:addElement( self.buttonList )
	self.scorePanelBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_SCORE_PANEL" ), "shoutcaster_scorepanel", Engine.Localize( "MPUI_SCORE_PANEL_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.scorePanelBtn )
	local f5_local7 = nil
	if Engine.IsDemoShoutcaster() then
		f5_local7 = "demo_shoutcaster_nameplate"
	else
		f5_local7 = "shoutcaster_nameplate"
	end
	self.namePlateBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_NAME_PLATE" ), f5_local7, Engine.Localize( "MPUI_NAME_PLATE_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.namePlateBtn )
	self.mapIconColorsBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_MAP_ICON_COLORS" ), "shoutcaster_map_icon_colors", Engine.Localize( "MPUI_MAP_ICON_COLORS_DESC" ) )
	local f5_local8 = self.mapIconColorsBtn
	local f5_local9 = {}
	local f5_local10 = Engine.Localize( "MPUI_DEFAULT_TEAM_COLORS" )
	local f5_local11 = Engine.Localize( "MPUI_FACTION_TEAM_COLORS" )
	f5_local8.strings = f5_local10
	self.mapIconColorsBtn.values = {
		0,
		1
	}
	CoD.SpectateDisplayOptions.Button_AddChoices( self.mapIconColorsBtn )
	self.mapInPlayerColumnBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_MAP_IN_PLAYER_COLUMN" ), "shoutcaster_map_in_player_column", Engine.Localize( "MPUI_MAP_IN_PLAYER_COLUMN_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.mapInPlayerColumnBtn )
	f5_local8 = self.buttonList:addText( Engine.Localize( "MPUI_HUD_CAPS" ) )
	f5_local8:setTopBottom( true, false, 0, CoD.SpectateDisplayOptions.RowHeight )
	f5_local8:setFont( CoD.SpectatePlayerInfo.HeaderFont )
	self.perksBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_PERKS" ), "shoutcaster_perks", Engine.Localize( "MPUI_PERKS_DESC" ) )
	f5_local9 = self.perksBtn
	f5_local10 = {}
	f5_local11 = Engine.Localize( "MENU_ON_SPAWN" )
	local f5_local12 = Engine.Localize( "MENU_OFF" )
	local f5_local13 = Engine.Localize( "MPUI_ALWAYS_ON" )
	f5_local9.strings = f5_local11
	self.perksBtn.values = {
		1,
		0,
		2
	}
	CoD.SpectateDisplayOptions.Button_AddChoices( self.perksBtn )
	self.inventoryBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MENU_INVENTORY" ), "shoutcaster_inventory", Engine.Localize( "MPUI_INVENTORY_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.inventoryBtn )
	self.scoreStreaksBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_SCORE_STREAKS" ), "shoutcaster_scorestreaks", Engine.Localize( "MPUI_SCORE_STREAKS_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.scoreStreaksBtn )
	self.scoreStreaksNotificationBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_SCORE_STREAKS_NOTIFICATIONS" ), "shoutcaster_scorestreaksnotification", Engine.Localize( "MPUI_SCORE_STREAKS_NOTIFICATIONS_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.scoreStreaksNotificationBtn )
	self.minimapBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_MINIMAP" ), "shoutcaster_minimap", Engine.Localize( "MPUI_MINIMAP_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.minimapBtn )
	self.killfeedBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_KILLFEED" ), "shoutcaster_killfeed", Engine.Localize( "MPUI_KILLFEED_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.killfeedBtn )
	self.calloutCardsBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_CALLOUT_CARDS" ), "shoutcaster_calloutcards", Engine.Localize( "MPUI_CALLOUT_CARDS_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.calloutCardsBtn )
	self.teamScoreBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_TEAM_SCORE" ), "shoutcaster_teamscore", Engine.Localize( "MPUI_TEAM_SCORE_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.teamScoreBtn )
	self.playerNotificationsBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_PLAYER_NOTIFICATIONS" ), "shoutcaster_playernotifications", Engine.Localize( "MPUI_PLAYER_NOTIFICATIONS_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.playerNotificationsBtn )
	self.voipDockBtn = self.buttonList:addProfileLeftRightSelector( f5_arg0, Engine.Localize( "MPUI_VOICE_ICON" ), "shoutcaster_voipdock", Engine.Localize( "MPUI_VOICE_ICON_DESC" ) )
	CoD.SpectateDisplayOptions.Button_AddChoices_OnOrOff( self.voipDockBtn )
	return self
end

