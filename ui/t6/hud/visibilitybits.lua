CoD.BIT_HUD_VISIBLE = 0
CoD.BIT_G_COMPASS_SHOW_ENEMIES = 1
CoD.BIT_RADAR_CLIENT = 2
CoD.BIT_NEMESIS_KILLCAM = 3
CoD.BIT_FINAL_KILLCAM = 4
CoD.BIT_ROUND_END_KILLCAM = 5
CoD.BIT_RADAR_ALLIES = 6
CoD.BIT_RADAR_AXIS = 7
CoD.BIT_ENABLE_POPUPS = 8
CoD.BIT_BOMB_TIMER = 9
CoD.BIT_BOMB_TIMER_A = 10
CoD.BIT_BOMB_TIMER_B = 11
CoD.BIT_AMMO_COUNTER_HIDE = 12
CoD.BIT_HUD_HARDCORE = 13
CoD.BIT_PREGAME = 14
CoD.BIT_DRAW_SPECTATOR_MESSAGES = 15
CoD.BIT_DISABLE_INGAME_MENU = 16
CoD.BIT_GAME_ENDED = 17
CoD.BIT_OVERTIME = 18
CoD.BIT_DEMO_CAMERA_MODE_THIRDPERSON = 19
CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM = 20
CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN = 21
CoD.BIT_DEMO_HUD_HIDDEN = 22
CoD.BIT_IN_KILLCAM = 23
CoD.BIT_SELECTING_LOCATION = 24
CoD.BIT_IS_FLASH_BANGED = 25
CoD.BIT_UI_ACTIVE = 26
CoD.BIT_SPECTATING_CLIENT = 27
CoD.BIT_IS_SCOPED = 28
CoD.BIT_IN_VEHICLE = 29
CoD.BIT_IN_GUIDED_MISSILE = 30
CoD.BIT_IS_FUEL_WEAPON = 31
CoD.BIT_SELECTING_LOCATIONAL_KILLSTREAK = 32
CoD.BIT_IS_DEMO_PLAYING = 33
CoD.BIT_IS_DEMO_MOVIE_RENDERING = 34
CoD.BIT_ADS_JAVELIN = 35
CoD.BIT_EXTRACAM_ON = 36
CoD.BIT_EXTRACAM_ACTIVE = 37
CoD.BIT_EXTRACAM_STATIC = 38
CoD.BIT_TACTICAL_MASK_OVERLAY = 39
CoD.BIT_TEAM_FREE = 40
CoD.BIT_TEAM_ALLIES = 41
CoD.BIT_TEAM_AXIS = 42
CoD.BIT_TEAM_SPECTATOR = 43
CoD.BIT_COMPASS_VISIBLE = 44
CoD.BIT_HUD_SHOWOBJICONS = 45
CoD.BIT_SCOREBOARD_OPEN = 46
CoD.BIT_POPUPS_VISIBLE = 47
CoD.BIT_HUD_OBITUARIES = 48
CoD.BIT_POF_SPEC_ALLOW_FREELOOK = 49
CoD.BIT_POF_FOLLOW = 50
CoD.BIT_IS_WAGER_MATCH = 51
CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC = 52
CoD.BIT_DRAW_DPAD_COMPASS = 53
CoD.BIT_IS_ZOMBIE_GAME = 54
CoD.BIT_EMP_ACTIVE = 55
CoD.BIT_IS_THIRD_PERSON = 56
CoD.BIT_CAROUSEL_ACTIVE = 57
CoD.BIT_PLAYER_DEAD = 58
CoD.BIT_IN_REMOTE_MISSILE = 59
CoD.BIT_OLD_DRAW_SORT_HACK = 60
CoD.BIT_OLD_CINEMATIC_SUBTITLES_HACK = 61
CoD.BIT_IS_PLAYER_ZOMBIE = 62
CoD.BIT_IS_PLAYER_IN_AFTERLIFE = 63
CoD.FSM_VISIBILITY = function ( f1_arg0 )
	if UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_SELECTING_LOCATION ) == 1 and UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_SPECTATING_CLIENT ) == 0 and UIExpression.IsVisibilityBitSet( f1_arg0, CoD.BIT_SCOREBOARD_OPEN ) == 0 then
		return 1
	else
		return 0
	end
end

CoD.IS_KILLCAM_OR_SPECTATE = function ( f2_arg0 )
	if f2_arg0 == nil then
		return 0
	elseif UIExpression.IsVisibilityBitSet( f2_arg0, CoD.BIT_TEAM_SPECTATOR ) == 1 or UIExpression.IsVisibilityBitSet( f2_arg0, CoD.BIT_SPECTATING_CLIENT ) == 1 or Engine.InKillcam( f2_arg0 ) == true or UIExpression.IsVisibilityBitSet( f2_arg0, CoD.BIT_FINAL_KILLCAM ) == 1 then
		return 1
	else
		return 0
	end
end
