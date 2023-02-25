require( "T6.GameOptions" )

local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10, f0_local11, f0_local12 = nil
LUI.createMenu.EditGameOptions = function ( f1_arg0 )
	local f1_local0 = CoD.GameOptionsMenu.New( f1_arg0, "EditGameOptions" )
	local f1_local1 = Dvar.ui_gametype:get()
	local f1_local2 = UIExpression.TableLookup( f1_arg0, CoD.gametypesTable, 0, 0, 1, f1_local1, 2 )
	f1_local0:addTitle( Engine.Localize( "MPUI_RULES_CAPS", Engine.Localize( f1_local2 ) ) )
	f1_local0.resetToDefaultButton = CoD.ButtonPrompt.new( "select", Engine.Localize( "MENU_RESET_TO_DEFAULT" ), f1_local0, "button_prompt_reset_to_default", false, false, false, false, "R" )
	f1_local0:addRightButtonPrompt( f1_local0.resetToDefaultButton )
	f1_local0.saveButton = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_SAVE" ), f1_local0, "button_prompt_save_game_settings", false, false, false, false, "S" )
	if Engine.SessionModeIsMode( CoD.SESSIONMODE_ONLINE ) then
		f1_local0:addRightButtonPrompt( f1_local0.saveButton )
	end
	f1_local0:registerEventHandler( "button_prompt_back", f0_local1 )
	f1_local0:registerEventHandler( "button_prompt_reset_to_default", f0_local8 )
	f1_local0:registerEventHandler( "button_prompt_save_game_settings", f0_local9 )
	f1_local0:registerEventHandler( "open_game_mode_specific_settings", f0_local2 )
	f1_local0:registerEventHandler( "open_general_settings", f0_local3 )
	f1_local0:registerEventHandler( "open_health_and_damage_settings", f0_local4 )
	f1_local0:registerEventHandler( "open_spawn_settings", f0_local5 )
	f1_local0:registerEventHandler( "open_custom_classes", f0_local6 )
	f1_local0:registerEventHandler( "open_default_classes", f0_local7 )
	local f1_local3 = CoD.GameOptions.TopLevelGametypeSettings[f1_local1]
	if f1_local3 and #f1_local3 > 0 then
		for f1_local7, f1_local8 in ipairs( f1_local3 ) do
			f1_local0:addGametypeSetting( f1_arg0, f1_local8 )
		end
	end
	local f1_local4 = CoD.GameOptions.GlobalTopLevelGametypeSettings
	if f1_local4 and #f1_local4 > 0 then
		for f1_local8, f1_local9 in ipairs( f1_local4 ) do
			f1_local0:addGametypeSetting( f1_arg0, f1_local9 )
		end
	end
	if not (not f1_local3 or #f1_local3 <= 0) or f1_local4 and #f1_local4 > 0 then
		f1_local0.buttonList:addSpacer( CoD.CoD9Button.Height / 2 )
	end
	local f1_local5 = CoD.GameOptions.SubLevelGametypeSettings[f1_local1]
	if f1_local5 and #f1_local5 > 0 then
		local f1_local6 = f1_local0.buttonList:addButton( Engine.Localize( "MPUI_GAME_MODE_SETTINGS_CAPS", Engine.Localize( f1_local2 ) ) )
		f1_local6:setActionEventName( "open_game_mode_specific_settings" )
		f1_local6:registerEventHandler( "button_update", f0_local10 )
		f1_local6.gametypeSettings = f1_local5
		CoD.GameOptions.ShowStarForGametypeSettings( f1_local6, f1_local5 )
	end
	local f1_local6 = f1_local0.buttonList:addButton( Engine.Localize( "MPUI_GENERAL_SETTINGS_CAPS" ) )
	f1_local6.gametypeSettings = CoD.GameOptions.GeneralSettings
	f1_local6:setActionEventName( "open_general_settings" )
	f1_local6:registerEventHandler( "button_update", f0_local10 )
	CoD.GameOptions.ShowStarForGametypeSettings( f1_local6, CoD.GameOptions.GeneralSettings )
	local f1_local7 = f1_local0.buttonList:addButton( Engine.Localize( "MENU_SPAWN_SETTINGS_CAPS" ) )
	f1_local7.gametypeSettings = CoD.GameOptions.SpawnSettings
	f1_local7:setActionEventName( "open_spawn_settings" )
	f1_local7:registerEventHandler( "button_update", f0_local10 )
	CoD.GameOptions.ShowStarForGametypeSettings( f1_local7, CoD.GameOptions.SpawnSettings )
	local f1_local8 = f1_local0.buttonList:addButton( Engine.Localize( "MENU_HEALTH_AND_DAMAGE_SETTINGS_CAPS" ) )
	f1_local8.gametypeSettings = CoD.GameOptions.HealthAndDamageSettings
	f1_local8:setActionEventName( "open_health_and_damage_settings" )
	f1_local8:registerEventHandler( "button_update", f0_local10 )
	CoD.GameOptions.ShowStarForGametypeSettings( f1_local8, CoD.GameOptions.HealthAndDamageSettings )
	f1_local0.buttonList:addSpacer( CoD.CoD9Button.Height / 2 )
	if 0 == Engine.GetGametypeSetting( "disableClassSelection", true ) then
		local f1_local9 = f1_local0.buttonList:addButton( Engine.Localize( "MENU_CUSTOM_CLASSES_CAPS" ) )
		f1_local9:setActionEventName( "open_custom_classes" )
		f1_local9:registerEventHandler( "button_update", f0_local11 )
		f1_local9.gametypeSettings = CoD.GameOptions.CustomClassSettings
		f0_local11( f1_local9 )
		local f1_local10 = f1_local0.buttonList:addButton( Engine.Localize( "MENU_PRESET_CLASSES_CAPS" ) )
		f1_local10:setActionEventName( "open_default_classes" )
		f1_local10:registerEventHandler( "button_update", f0_local12 )
		f1_local10.gametypeSettings = CoD.GameOptions.PresetClassSettings
		f0_local12( f1_local10 )
	end
	if not f1_local0.buttonList:restoreState() then
		f1_local0.buttonList:processEvent( {
			name = "gain_focus"
		} )
	end
	return f1_local0
end

f0_local1 = function ( f2_arg0, f2_arg1 )
	Engine.PartyHostClearUIState()
	CoD.GameOptionsMenu.ButtonPromptBack( f2_arg0, f2_arg1 )
end

f0_local2 = function ( f3_arg0, f3_arg1 )
	f3_arg0.buttonList:saveState()
	f3_arg0:openMenu( "EditModeSpecificOptions", f3_arg1.controller )
	f3_arg0:close()
end

f0_local3 = function ( f4_arg0, f4_arg1 )
	f4_arg0.buttonList:saveState()
	f4_arg0:openMenu( "EditGeneralOptions", f4_arg1.controller )
	f4_arg0:close()
end

f0_local6 = function ( f5_arg0, f5_arg1 )
	f5_arg0.buttonList:saveState()
	f5_arg0:openMenu( "CustomClassGameOptions", f5_arg1.controller )
	f5_arg0:close()
end

f0_local7 = function ( f6_arg0, f6_arg1 )
	f6_arg0.buttonList:saveState()
	f6_arg0:openMenu( "EditDefaultClasses", f6_arg1.controller )
	f6_arg0:close()
end

f0_local4 = function ( f7_arg0, f7_arg1 )
	f7_arg0.buttonList:saveState()
	f7_arg0:openMenu( "HealthAndDamageSettings", f7_arg1.controller )
	f7_arg0:close()
end

f0_local5 = function ( f8_arg0, f8_arg1 )
	f8_arg0.buttonList:saveState()
	f8_arg0:openMenu( "SpawnSettings", f8_arg1.controller )
	f8_arg0:close()
end

f0_local8 = function ( f9_arg0, f9_arg1 )
	Engine.SetGametype( Dvar.ui_gametype:get() )
	f9_arg0:processEvent( {
		name = "button_update"
	} )
end

f0_local9 = function ( f10_arg0, f10_arg1 )
	if Engine.CanViewContent() == false then
		f10_arg0:openPopup( "popup_contentrestricted", f10_arg1.controller )
		return 
	else
		Engine.Exec( f10_arg1.controller, "gamesettings_clearuploadinfo" )
		local f10_local0 = UIExpression.TableLookup( controller, CoD.gametypesTable, 0, 0, 1, Dvar.ui_gametype:get(), 2 )
		CoD.perController[f10_arg1.controller].fileshareSaveCategory = "customgame"
		CoD.perController[f10_arg1.controller].fileshareSaveIsCopy = false
		CoD.perController[f10_arg1.controller].fileshareSaveIsPooled = false
		CoD.perController[f10_arg1.controller].fileshareSaveName = Engine.Localize( f10_local0 )
		CoD.perController[f10_arg1.controller].fileshareSaveDescription = ""
		f10_arg0:openPopup( "FileshareSave", f10_arg1.controller )
	end
end

LUI.createMenu.HealthAndDamageSettings = function ( f11_arg0 )
	local f11_local0 = CoD.GameOptionsMenu.New( f11_arg0, "HealthAndDamageSettings" )
	f11_local0:addTitle( Engine.Localize( "MENU_HEALTH_AND_DAMAGE_SETTINGS_CAPS" ) )
	for f11_local4, f11_local5 in ipairs( CoD.GameOptions.HealthAndDamageSettings ) do
		f11_local0:addGametypeSetting( f11_arg0, f11_local5 )
	end
	if not f11_local0.buttonList:restoreState() then
		f11_local0.buttonList:processEvent( {
			name = "gain_focus"
		} )
	end
	return f11_local0
end

LUI.createMenu.SpawnSettings = function ( f12_arg0 )
	local f12_local0 = CoD.GameOptionsMenu.New( f12_arg0, "SpawnSettings" )
	f12_local0:addTitle( Engine.Localize( "MENU_SPAWN_SETTINGS_CAPS" ) )
	for f12_local4, f12_local5 in ipairs( CoD.GameOptions.SpawnSettings ) do
		f12_local0:addGametypeSetting( f12_arg0, f12_local5 )
	end
	if not f12_local0.buttonList:restoreState() then
		f12_local0.buttonList:processEvent( {
			name = "gain_focus"
		} )
	end
	return f12_local0
end

f0_local0 = function ( f13_arg0 )
	for f13_local0 = 0, 4, 1 do
		if not Engine.IsPresetClassDefault( f13_arg0, f13_local0 ) then
			return false
		end
	end
	return true
end

f0_local10 = function ( f14_arg0, f14_arg1 )
	CoD.GameOptions.ShowStarForGametypeSettings( f14_arg0, f14_arg0.gametypeSettings )
end

f0_local11 = function ( f15_arg0, f15_arg1 )
	if CoD.GameOptions.ShowStarForGametypeSettings( f15_arg0, f15_arg0.gametypeSettings ) then
		return 
	end
	for f15_local0 = 0, 255, 1 do
		if Engine.IsItemIndexRestricted( f15_local0 ) ~= Engine.IsItemIndexRestricted( f15_local0, true ) then
			f15_arg0:showStarIcon( true )
			return 
		end
	end
	if CoD.GameOptions.AreAnyAttachmentsRestricted() then
		f15_arg0:showStarIcon( true )
		return 
	end
	f15_arg0:showStarIcon( false )
end

f0_local12 = function ( f16_arg0, f16_arg1 )
	if CoD.GameOptions.ShowStarForGametypeSettings( f16_arg0, f16_arg0.gametypeSettings ) then
		return 
	elseif Engine.GetGametypeSetting( "presetClassesPerTeam" ) == 0 then
		if not f0_local0( CoD.TEAM_FREE ) then
			f16_arg0:showStarIcon( true )
			return 
		end
	else
		local f16_local0 = Engine.GetGametypeSetting( "teamCount" )
		for f16_local1 = 0, f16_local0 - 1, 1 do
			if not f0_local0( CoD.TEAM_FIRST_PLAYING_TEAM + f16_local1 ) then
				f16_arg0:showStarIcon( true )
				return 
			end
		end
	end
	f16_arg0:showStarIcon( false )
end

