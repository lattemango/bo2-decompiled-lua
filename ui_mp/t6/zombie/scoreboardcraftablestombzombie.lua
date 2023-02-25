require( "T6.Zombie.CraftableItemTombDisplay" )
require( "T6.Zombie.QuestItemTombDisplay" )
require( "T6.Zombie.PersistentItemTombDisplay" )
require( "T6.Zombie.CaptureZoneWheelTombDisplay" )

CoD.ScoreboardCraftablesTombZombie = {}
CoD.ScoreboardCraftablesTombZombie.FontName = "ExtraSmall"
CoD.ScoreboardCraftablesTombZombie.BackgroundOffset = 4
CoD.ScoreboardCraftablesTombZombie.ContainerHeight = CoD.QuestItemTombDisplay.IconSize + CoD.textSize[CoD.QuestItemTombDisplay.FontName] + 10
CoD.ScoreboardCraftablesTombZombie.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	if Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false then
		self:setLeftRight( true, true, 0, 0 )
	else
		self:setLeftRight( true, true, -controller / 4 - 10, 0 )
	end
	self:setTopBottom( true, false, -150, -20 )
	menu:addElement( self )
	local f1_local1 = CoD.textSize[CoD.ScoreboardCraftablesTombZombie.FontName] + 12
	local f1_local2 = CoD.QuestItemTombDisplay.ContainerSize / 4
	local f1_local3 = true
	local f1_local4 = CoD.ScoreboardCraftablesTombZombie.BackgroundOffset
	local f1_local5 = f1_local1 + 10
	local f1_local6 = 0
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local6 = 22
	end
	local f1_local7 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local7 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer( self, 0, f1_local1, Engine.Localize( "ZMUI_PERSISTENT_ITEMS" ) )
	end
	local f1_local8 = LUI.UIHorizontalList.new()
	f1_local8:setLeftRight( true, true, f1_local4, 0 )
	f1_local8:setTopBottom( true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight )
	menu.persistentItemDisplay = CoD.PersistentItemTombDisplay.new( f1_local8 )
	menu.persistentItemDisplay:registerEventHandler( "update_persistent_item_display_scoreboard", CoD.PersistentItemTombDisplay.ScoreboardUpdate )
	self:addElement( menu.persistentItemDisplay )
	local f1_local9 = CoD.PersistentItemTombDisplay.AddPersistentStatusDisplay( menu.persistentItemDisplay, f1_local2, f1_local3, f1_local4, f1_local6 )
	if f1_local7 then
		f1_local7:setLeftRight( true, false, 0, f1_local9 - 10 )
	end
	local f1_local10 = f1_local9 + 5
	local f1_local11 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local11 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer( self, f1_local10, f1_local1, Engine.Localize( "ZMUI_QUEST_ITEMS" ) )
	end
	local f1_local12 = LUI.UIHorizontalList.new()
	f1_local12:setLeftRight( true, true, f1_local4 + f1_local10, 0 )
	f1_local12:setTopBottom( true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight )
	menu.questItemDisplay = CoD.QuestItemTombDisplay.new( f1_local12 )
	menu.questItemDisplay:registerEventHandler( "update_quest_item_display_scoreboard", CoD.QuestItemTombDisplay.ScoreboardUpdate )
	self:addElement( menu.questItemDisplay )
	local f1_local13 = CoD.QuestItemTombDisplay.AddQuestStatusDisplay( menu.questItemDisplay, f1_local2, f1_local3, f1_local4, f1_local6 )
	menu.questItemDisplay.questStatusContainer:setAlpha( 1 )
	menu.questItemDisplay.showPlayerHighlight = true
	if f1_local11 then
		f1_local11:setLeftRight( true, false, f1_local10, f1_local10 + f1_local13 - 10 )
	end
	local f1_local14 = f1_local10 + f1_local13 + 5
	local f1_local15 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local15 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer( self, f1_local14, f1_local1, Engine.Localize( "ZMUI_RECIPES" ) )
	end
	local f1_local16 = LUI.UIHorizontalList.new()
	f1_local16:setLeftRight( true, true, f1_local4 + f1_local14, 0 )
	f1_local16:setTopBottom( true, false, f1_local5, f1_local5 + CoD.ScoreboardCraftablesTombZombie.ContainerHeight )
	local f1_local17 = 0
	local f1_local18 = CoD.CraftableItemTombDisplay.ContainerSize / 4
	menu.craftableItemDisplay = CoD.CraftableItemTombDisplay.new( f1_local16 )
	f1_local17 = CoD.CraftableItemTombDisplay.AddDisplayContainer( menu.craftableItemDisplay, f1_local18, f1_local3, f1_local4, f1_local6 )
	menu.craftableItemDisplay:registerEventHandler( "update_craftable_item_display_scoreboard", CoD.CraftableItemTombDisplay.ScoreboardUpdate )
	self:addElement( menu.craftableItemDisplay )
	if f1_local15 then
		f1_local15:setLeftRight( true, false, f1_local14, f1_local14 + f1_local17 - f1_local18 )
	end
	local f1_local19 = f1_local14 + f1_local17 - 4
	local f1_local20 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local20 = CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer( self, f1_local19, f1_local1, Engine.Localize( "ZMUI_CAPTURES" ) )
	end
	local f1_local21 = f1_local14 + f1_local17
	local f1_local22 = 50
	local f1_local23 = 95
	local f1_local24 = LUI.UIElement.new()
	f1_local24:setLeftRight( true, false, f1_local21, f1_local23 + f1_local21 )
	f1_local24:setTopBottom( true, false, f1_local5, f1_local23 + f1_local5 )
	local f1_local25 = 0
	menu.captureZoneWheelDisplay = CoD.CaptureZoneWheelTombDisplay.new( f1_local24 )
	f1_local25 = CoD.CaptureZoneWheelTombDisplay.AddCaptureZoneWheel( menu.captureZoneWheelDisplay, f1_local23, f1_local3, f1_local4 )
	menu.captureZoneWheelDisplay:registerEventHandler( "update_capture_zone_wheel_display_scoreboard", CoD.CaptureZoneWheelTombDisplay.ScoreboardUpdate )
	self:addElement( menu.captureZoneWheelDisplay )
	if f1_local20 then
		f1_local20:setLeftRight( true, false, f1_local19, f1_local19 + f1_local25 )
	end
	return menu
end

CoD.ScoreboardCraftablesTombZombie.AddHeaderContainer = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3 )
	local f2_local0 = CoD.ScoreboardCraftablesTombZombie.BackgroundOffset
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, f2_arg1, 0 )
	self:setTopBottom( true, false, 0, f2_arg2 )
	f2_arg0:addElement( self )
	local f2_local2 = LUI.UIImage.new()
	f2_local2:setLeftRight( true, true, 0, 0 )
	f2_local2:setTopBottom( true, true, 0, 0 )
	f2_local2:setRGB( 0, 0, 0 )
	f2_local2:setAlpha( 0.7 )
	self:addElement( f2_local2 )
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight( true, true, 2, -2 )
	f2_local3:setTopBottom( true, false, 2, 7 )
	f2_local3:setImage( RegisterMaterial( "white" ) )
	f2_local3:setAlpha( 0.06 )
	self:addElement( f2_local3 )
	local f2_local4 = CoD.textSize[CoD.ScoreboardCraftablesTombZombie.FontName]
	local f2_local5 = LUI.UIText.new()
	f2_local5:setLeftRight( true, true, f2_local0, 0 )
	f2_local5:setTopBottom( false, false, -f2_local4 / 2, f2_local4 / 2 )
	f2_local5:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f2_local5:setAlpha( 0.5 )
	f2_local5:setFont( CoD.fonts[CoD.ScoreboardCraftablesTombZombie.FontName] )
	f2_local5:setAlignment( LUI.Alignment.Left )
	f2_local5:setText( f2_arg3 )
	self:addElement( f2_local5 )
	return self
end

