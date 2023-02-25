require( "T6.Zombie.CraftableItemDisplay" )
require( "T6.Zombie.QuestItemDisplay" )

CoD.ScoreboardCraftablesZombie = {}
CoD.ScoreboardCraftablesZombie.FontName = "ExtraSmall"
CoD.ScoreboardCraftablesZombie.BackgroundOffset = 4
CoD.ScoreboardCraftablesZombie.new = function ( menu, controller )
	local self = LUI.UIElement.new()
	if Engine.GameModeIsMode( CoD.GAMEMODE_LOCAL_SPLITSCREEN ) == false then
		self:setLeftRight( true, true, 0, 0 )
	else
		self:setLeftRight( true, true, -controller / 4 - 10, 0 )
	end
	self:setTopBottom( true, false, -150, -20 )
	menu:addElement( self )
	local f1_local1 = CoD.textSize[CoD.ScoreboardCraftablesZombie.FontName] + 12
	local f1_local2 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local2 = CoD.ScoreboardCraftablesZombie.AddHeaderContainer( self, 0, f1_local1, Engine.Localize( "ZMUI_QUEST_ITEMS" ) )
	end
	local f1_local3 = CoD.ScoreboardCraftablesZombie.BackgroundOffset
	local f1_local4 = f1_local1 + 10
	local f1_local5 = LUI.UIHorizontalList.new()
	f1_local5:setLeftRight( true, true, f1_local3, 0 )
	f1_local5:setTopBottom( true, true, f1_local4, 0 )
	local f1_local6 = true
	local f1_local7 = false
	if CoD.Zombie.IsDLCMap( CoD.Zombie.DLC2Maps ) then
		f1_local7 = true
	end
	menu.questItemDisplay = CoD.QuestItemDisplay.new( f1_local5 )
	menu.questItemDisplay:registerEventHandler( "update_quest_item_display_scoreboard", CoD.QuestItemDisplay.ScoreboardUpdate )
	self:addElement( menu.questItemDisplay )
	local f1_local8 = CoD.QuestItemDisplay.ContainerSize / 4
	local f1_local9 = CoD.QuestItemDisplay.AddQuestStatusDisplay( menu.questItemDisplay, f1_local8, f1_local7, f1_local6, f1_local3 )
	menu.questItemDisplay.questStatusContainer:setAlpha( 1 )
	menu.questItemDisplay.showPlayerHighlight = true
	if f1_local2 then
		f1_local2:setLeftRight( true, false, 0, f1_local9 + f1_local3 - f1_local8 )
	end
	local f1_local10 = f1_local9 + 20
	local f1_local11 = nil
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		f1_local11 = CoD.ScoreboardCraftablesZombie.AddHeaderContainer( self, f1_local10, f1_local1, Engine.Localize( "ZMUI_RECIPES" ) )
	end
	local f1_local12 = LUI.UIHorizontalList.new()
	f1_local12:setLeftRight( true, true, f1_local3 + f1_local10, 0 )
	f1_local12:setTopBottom( true, false, f1_local4, 0 )
	local f1_local13 = 0
	local f1_local14 = CoD.CraftableItemDisplay.ContainerSize / 4
	menu.craftableItemDisplay = CoD.CraftableItemDisplay.new( f1_local12 )
	f1_local13 = CoD.CraftableItemDisplay.AddDisplayContainer( menu.craftableItemDisplay, f1_local14, f1_local6, f1_local3 )
	menu.craftableItemDisplay:registerEventHandler( "update_craftable_item_display_scoreboard", CoD.CraftableItemDisplay.ScoreboardUpdate )
	self:addElement( menu.craftableItemDisplay )
	if f1_local11 then
		f1_local11:setLeftRight( true, false, f1_local10, f1_local10 + f1_local13 - f1_local14 )
	end
	return menu
end

CoD.ScoreboardCraftablesZombie.AddHeaderContainer = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3 )
	local f2_local0 = CoD.ScoreboardCraftablesZombie.BackgroundOffset
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
	local f2_local4 = CoD.textSize[CoD.ScoreboardCraftablesZombie.FontName]
	local f2_local5 = LUI.UIText.new()
	f2_local5:setLeftRight( true, true, f2_local0, 0 )
	f2_local5:setTopBottom( false, false, -f2_local4 / 2, f2_local4 / 2 )
	f2_local5:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f2_local5:setAlpha( 0.5 )
	f2_local5:setFont( CoD.fonts[CoD.ScoreboardCraftablesZombie.FontName] )
	f2_local5:setAlignment( LUI.Alignment.Left )
	f2_local5:setText( f2_arg3 )
	self:addElement( f2_local5 )
	return self
end

