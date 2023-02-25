local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10, f0_local11, f0_local12, f0_local13, f0_local14, f0_local15, f0_local16, f0_local17, f0_local18, f0_local19, f0_local20 = nil
LUI.createMenu.EditDefaultClasses = function ( f1_arg0 )
	local f1_local0 = CoD.GameOptionsMenu.New( f1_arg0, "EditDefaultClasses" )
	f1_local0:setPreviousMenu( "EditGameOptions" )
	f1_local0:addTitle( Engine.Localize( "MENU_PRESET_CLASSES_CAPS" ) )
	f1_local0.team = CoD.TEAM_FIRST_PLAYING_TEAM
	CoD.CACUtility.SetGametypeSettingsCACRoot( f1_local0:getOwner(), f1_local0.team )
	f1_local0.classOptionsButtonPrompt = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_CLASS_OPTIONS" ), f1_local0, "open_class_options", false, false, false, false, "O" )
	f1_local0.buttonList = CoD.ButtonList.new()
	f1_local0.buttonList.id = "ButtonList.EditDefaultClasses"
	f1_local0.buttonList:setLeftRight( true, false, 0, CoD.ButtonList.DefaultWidth )
	f1_local0.buttonList:setTopBottom( true, true, CoD.Menu.TitleHeight, 0 )
	f1_local0:addElement( f1_local0.buttonList )
	f1_local0.perTeamButtonList = CoD.ButtonList.new()
	f1_local0.perTeamButtonList.id = "ButtonList.EditDefaultClassesPerTeam"
	f1_local0.perTeamButtonList:setLeftRight( true, false, 0, CoD.ButtonList.DefaultWidth )
	f1_local0.perTeamButtonList:setTopBottom( true, true, CoD.Menu.TitleHeight, 0 )
	f0_local8( f1_local0 )
	f1_local0:registerEventHandler( "class_button_gained_focus", f0_local4 )
	f1_local0:registerEventHandler( "class_button_lost_focus", f0_local5 )
	f1_local0:registerEventHandler( "class_chosen", f0_local6 )
	f1_local0:registerEventHandler( "occlusion_change", f0_local13 )
	f1_local0:registerEventHandler( "open_class_options", f0_local14 )
	f1_local0:registerEventHandler( "selector_changed", f0_local18 )
	f1_local0:registerEventHandler( "team_chosen", f0_local20 )
	f0_local15( f1_local0 )
	if Engine.GetGametypeSetting( "teamCount" ) > 1 and Engine.GetGametypeSetting( "presetClassesPerTeam" ) == 1 then
		local f1_local1 = CoD.perController
		local f1_local2 = f1_local0
		if f1_local1[f1_local0:getOwner()].editingPresetClass then
			f0_local20( f1_local0 )
		end
	end
	local f1_local1 = CoD.perController
	local f1_local2 = f1_local0
	f1_local1[f1_local0:getOwner()].editingPresetClass = nil
	f1_local0.close = f0_local7
	return f1_local0
end

f0_local0 = function ( f2_arg0, f2_arg1 )
	local f2_local0 = 20
	if f2_arg0.classOptionsButton == nil then
		local f2_local1 = 200
		f2_arg0.classOptionsButton = CoD.MouseButton.new( {
			leftAnchor = true,
			rightAnchor = false,
			left = f2_local1,
			right = f2_local1 + f2_local0,
			topAnchor = false,
			bottomAnchor = false,
			top = -f2_local0 / 2,
			bottom = f2_local0 / 2
		}, "^BBUTTON_MOUSE_EDIT^", "^BBUTTON_MOUSE_EDIT_ACTIVE^" )
		f2_arg0.classOptionsButton:setExpansionScale()
		f2_arg0.classOptionsButton:setActionEventName( "open_class_options" )
	end
	f2_arg0:addElement( f2_arg0.classOptionsButton )
end

f0_local3 = function ( f3_arg0, f3_arg1 )
	if f3_arg0.classOptionsButton ~= nil then
		f3_arg0.classOptionsButton:close()
		f3_arg0:setHandleMouseButton( true )
	end
end

f0_local1 = function ( f4_arg0, f4_arg1 )
	CoD.CoD9Button.GainFocus( f4_arg0, f4_arg1 )
	if CoD.useMouse then
		f0_local0( f4_arg0 )
	end
	f4_arg0:dispatchEventToParent( {
		name = "class_button_gained_focus",
		button = f4_arg0
	} )
end

f0_local2 = function ( f5_arg0, f5_arg1 )
	CoD.CoD9Button.LoseFocus( f5_arg0, f5_arg1 )
	if CoD.useMouse then
		f0_local3( f5_arg0 )
	end
	f5_arg0:dispatchEventToParent( {
		name = "class_button_lost_focus",
		button = f5_arg0
	} )
end

f0_local4 = function ( f6_arg0, f6_arg1 )
	local f6_local0 = CoD.perController[f6_arg0:getOwner()]
	f6_local0.classNum = f6_arg1.button.classNum
	f6_local0.isPreset = true
	f6_local0.weaponSlot = nil
	f6_local0.grenadeSlot = nil
	f6_local0.perkCategory = nil
	f6_local0.slotIndex = nil
	f6_arg0:addRightButtonPrompt( f6_arg0.classOptionsButtonPrompt )
end

f0_local5 = function ( f7_arg0, f7_arg1 )
	f7_arg0.classOptionsButtonPrompt:close()
end

f0_local6 = function ( f8_arg0, f8_arg1 )
	f8_arg0.buttonList:saveState()
	f8_arg0.perTeamButtonList:saveState()
	CoD.perController[f8_arg0:getOwner()].editingPresetClass = f8_arg0.team
	Engine.BeginEditingPresetClass( f8_arg0.team )
	f8_arg0:openMenu( "CACEditClass", f8_arg1.controller )
	f8_arg0:close()
end

f0_local7 = function ( f9_arg0 )
	local f9_local0 = CoD.perController
	local f9_local1 = f9_arg0
	if not f9_local0[f9_arg0:getOwner()].editingPresetClass then
		Engine.StopEditingPresetClass()
		f9_local0 = CoD.perController
		f9_local1 = f9_arg0
		f9_local0[f9_arg0:getOwner()].isPreset = nil
	end
	CoD.Menu.close( f9_arg0 )
end

f0_local8 = function ( f10_arg0 )
	f10_arg0.presetClassesPerTeamSelector = f10_arg0:addGametypeSetting( f10_arg0:getOwner(), "presetClassesPerTeam", true )
	f0_local10( f10_arg0 )
	f0_local9( f10_arg0 )
end

f0_local9 = function ( f11_arg0 )
	f11_arg0.classButtons = {}
	local f11_local0 = CoD.CACUtility.GetLoadoutNames( f11_arg0:getOwner() )
	for f11_local1 = 0, 4, 1 do
		local f11_local4 = f11_arg0.buttonList:addButton( Engine.Localize( f11_local0[f11_local1]:get() ) )
		f11_local4.classNum = f11_local1
		f11_local4:registerEventHandler( "gain_focus", f0_local1 )
		f11_local4:registerEventHandler( "lose_focus", f0_local2 )
		f11_local4:setActionEventName( "class_chosen" )
		table.insert( f11_arg0.classButtons, f11_local4 )
	end
end

f0_local10 = function ( f12_arg0 )
	f12_arg0.teamButtons = {}
	local f12_local0 = Engine.GetGametypeSetting( "teamCount" )
	for f12_local1 = 1, f12_local0, 1 do
		local f12_local4 = Engine.Localize( "MENU_TEAM_X_CAPS", f12_local1 )
		if f12_local0 > 2 then
			f12_local4 = f12_local4 .. " - " .. Engine.Localize( "MPUI_" .. Engine.GetFactionForTeam( CoD.TEAM_FIRST_PLAYING_TEAM + f12_local1 - 1 ) .. "_SHORT_CAPS" )
		end
		local f12_local5 = f12_arg0.buttonList:addButton( f12_local4 )
		f12_local5.teamText = f12_local4
		f12_local5.index = f12_local1 - 1
		f12_local5:setActionEventName( "team_chosen" )
		table.insert( f12_arg0.teamButtons, f12_local5 )
	end
end

f0_local15 = function ( f13_arg0 )
	f13_arg0.buttonList:removeAllButtons()
	f13_arg0.buttonList.hintText:close()
	local f13_local0 = Engine.GetGametypeSetting( "teamCount" )
	if f13_local0 > 1 then
		f13_arg0.buttonList:addElement( f13_arg0.presetClassesPerTeamSelector )
		f13_arg0.buttonList:addSpacer( CoD.CoD9Button.Height / 2 )
	end
	if f13_local0 > 1 and Engine.GetGametypeSetting( "presetClassesPerTeam" ) == 1 then
		f0_local17( f13_arg0 )
		for f13_local4, f13_local5 in ipairs( f13_arg0.teamButtons ) do
			f13_arg0.buttonList:addElement( f13_local5 )
		end
	else
		f13_arg0.team = CoD.TEAM_FREE
		CoD.CACUtility.SetGametypeSettingsCACRoot( f13_arg0:getOwner(), f13_arg0.team )
		f0_local16( f13_arg0 )
		for f13_local4, f13_local5 in ipairs( f13_arg0.classButtons ) do
			f13_arg0.buttonList:addElement( f13_local5 )
		end
	end
	LUI.UIVerticalList.UpdateNavigation( f13_arg0.buttonList )
	if not f13_arg0.buttonList:restoreState() then
		f13_arg0.buttonList:processEvent( LUI.UIButton.GainFocusEvent )
	end
end

f0_local13 = function ( f14_arg0, f14_arg1 )
	CoD.Menu.OcclusionChange( f14_arg0, f14_arg1 )
	if not f14_arg1.occluded then
		Engine.StopEditingPresetClass()
		f0_local16( f14_arg0 )
		f0_local17( f14_arg0 )
	end
end

f0_local14 = function ( f15_arg0, f15_arg1 )
	Engine.BeginEditingPresetClass( f15_arg0.team )
	f15_arg0:openPopup( "ClassOptions", f15_arg1.controller )
end

f0_local18 = function ( f16_arg0 )
	f16_arg0.buttonList:saveState()
	f0_local15( f16_arg0 )
end

f0_local16 = function ( f17_arg0 )
	local f17_local0 = CoD.CACUtility.GetLoadoutNames( f17_arg0:getOwner() )
	for f17_local4, f17_local5 in ipairs( f17_arg0.classButtons ) do
		f17_local5.label:setText( Engine.Localize( f17_local0[f17_local5.classNum]:get() ) )
		f0_local11( f17_local5, f17_arg0.team )
	end
end

f0_local17 = function ( f18_arg0 )
	for f18_local3, f18_local4 in ipairs( f18_arg0.teamButtons ) do
		f0_local12( f18_local4 )
	end
end

f0_local11 = function ( f19_arg0, f19_arg1 )
	if Engine.IsPresetClassDefault( f19_arg1, f19_arg0.classNum ) then
		f19_arg0:showStarIcon( false )
	else
		f19_arg0:showStarIcon( true )
	end
end

f0_local12 = function ( f20_arg0 )
	for f20_local0 = 0, 4, 1 do
		if not Engine.IsPresetClassDefault( CoD.TEAM_FIRST_PLAYING_TEAM + f20_arg0.index, f20_local0 ) then
			f20_arg0:showStarIcon( true )
			return 
		end
	end
	f20_arg0:showStarIcon( false )
end

f0_local19 = function ( f21_arg0, f21_arg1 )
	f21_arg0.perTeamButtonList:processEvent( LUI.UIButton.LoseFocusEvent )
	f21_arg0.perTeamButtonList:processEvent( {
		name = "complete_animation"
	} )
	f21_arg0.perTeamButtonList:removeAllButtons()
	f21_arg0.perTeamButtonList:clearSavedState()
	f21_arg0.perTeamButtonList:close()
	f21_arg0:addElement( f21_arg0.buttonList )
	f21_arg0:processEvent( {
		name = "controller_backed_out"
	} )
	f21_arg0:registerEventHandler( "button_prompt_back", nil )
	f21_arg0:setTitle( Engine.Localize( "MENU_PRESET_CLASSES_CAPS" ) )
end

f0_local20 = function ( f22_arg0, f22_arg1 )
	local f22_local0, f22_local1 = nil
	if f22_arg1 then
		f22_arg0.team = CoD.TEAM_FIRST_PLAYING_TEAM + f22_arg1.button.index
		f22_local1 = f22_arg1.button.teamText
	else
		local f22_local2 = CoD.perController
		local f22_local3 = f22_arg0
		f22_arg0.team = f22_local2[f22_arg0:getOwner()].editingPresetClass
		for f22_local5, f22_local6 in ipairs( f22_arg0.teamButtons ) do
			if f22_local6.index == f22_arg0.team - CoD.TEAM_FIRST_PLAYING_TEAM then
				f22_local1 = f22_local6.teamText
				break
			end
		end
	end
	CoD.CACUtility.SetGametypeSettingsCACRoot( f22_arg0:getOwner(), f22_arg0.team )
	f22_arg0.buttonList:close()
	f0_local16( f22_arg0 )
	for f22_local5, f22_local6 in ipairs( f22_arg0.classButtons ) do
		f22_local6:close()
		f22_arg0.perTeamButtonList:addElement( f22_local6 )
	end
	f22_arg0:setTitle( f22_local1 )
	f22_arg0:addElement( f22_arg0.perTeamButtonList )
	if not f22_arg0.perTeamButtonList:restoreState() then
		f22_arg0.perTeamButtonList:processEvent( LUI.UIButton.GainFocusEvent )
		f22_arg0.perTeamButtonList:processEvent( {
			name = "complete_animation"
		} )
	end
	f22_arg0:registerEventHandler( "button_prompt_back", f0_local19 )
end

