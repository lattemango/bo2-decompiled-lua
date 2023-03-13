require("T6.CoDBase")
require("T6.HUD.OffhandIcons")
require("T6.HUD.AmmoCounter")
require("T6.HUD.DeadSpectate")
require("T6.HUD.GameMessages")
require("T6.HUD.GameTimer")
require("T6.HUD.GrenadeEffect")
require("T6.HUD.InGameMenus")
require("T6.HUD.Killcam")
require("T6.HUD.ManageSegments")
require("T6.HUD.Migration")
require("T6.HUD.ReaperHUD")
require("T6.HUD.ScoreBoard")
require("T6.HUD.ScoreFeed")
require("T6.HUD.TurretHUD")
require("T6.HUD.Spectate")
require("T6.HUD.WeaponLabel")
require("T6.HUD.Loading")

if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
	require("T6.HUD.DemoHighlightReel")
	require("T6.HUD.DemoHUD")
	require("T6.HUD.DemoInGame")
	require("T6.HUD.DemoPopup")
end
if CoD.isZombie == true then
	require("T6.Zombie.BaseZombie")
	require("T6.Zombie.Hud3DScoreBoardZombie")
	require("T6.Zombie.HudBuildablesZombie")
	require("T6.Zombie.HudCompetitiveScoreboardZombie")
	require("T6.Zombie.HudDPadAreaZombie")
	require("T6.Zombie.HudPerksZombie")
	require("T6.Zombie.HudPowerUpsZombie")
	require("T6.Zombie.HudRoundStatusZombie")
	require("T6.Zombie.HudTimerZombie")
	require("T6.Zombie.OtherAmmoCounters")
else
	require("T6.VcsMenu")
	require("T6.HUD.AirVehicleHUD")
	require("T6.HUD.AITank")
	require("T6.HUD.AmmoArea")
	require("T6.HUD.BombTimer")
	require("T6.HUD.ChopperGunnerHUD")
	require("T6.HUD.HUDDigit")
	require("T6.HUD.IngameVoipDock")
	require("T6.HUD.NamePlate")
	require("T6.HUD.PredatorHUD")
	require("T6.HUD.QRDrone")
	require("T6.HUD.RewardSelection")
	require("T6.HUD.ScoreArea")
	require("T6.HUD.ScoreBottomLeft")
	require("T6.HUD.ScorePopup")
	require("T6.HUD.NotificationPopups")
	require("T6.HUD.Compass")
	require("T6.HUD.gametypes.GametypeBase")
	require("T6.HUD.gametypes.ctf")
	require("T6.HUD.gametypes.dem")
	require("T6.HUD.gametypes.dom")
	require("T6.HUD.gametypes.hq")
	require("T6.HUD.gametypes.koth")
	require("T6.HUD.gametypes.oic")
	require("T6.HUD.gametypes.oneflag")
	require("T6.Menus.LiveStream")
end
if CoD.isWIIU or CoD.isPC then
	require("T6.LiveNotification")
end
if CoD.isWIIU then
	require("T6.WiiUSystemServices")
end
local f0_local0,
	f0_local1,
	f0_local2,
	f0_local3,
	f0_local4,
	f0_local5,
	f0_local6,
	f0_local7,
	f0_local8,
	f0_local9,
	f0_local10,
	f0_local11,
	f0_local12,
	f0_local13 = nil
local f0_local14 = 10
local f0_local15 = nil
function HUD_IngameMenuClosed()
	f0_local15 = nil
end

LUI.createMenu.HUD = function(f2_arg0)
	local f2_local0 =
		CoD.Menu.NewFromState(
		"HUD",
		{
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		}
	)
	if not LUI.roots.UIRootFull.safeAreaOverlay then
		LUI.roots.UIRootFull.safeAreaOverlay = CoD.SetupSafeAreaOverlay()
		LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull.safeAreaOverlay)
	end
	f2_local0:setOwner(f2_arg0)
	f2_local0.controller = f2_arg0
	f0_local1(f2_local0)
	f2_local0:registerEventHandler("debug_reload", HUD_DebugReload)
	f2_local0:registerEventHandler("update_safe_area", HUD_UpdateSafeArea)
	if CoD.isWIIU then
		f2_local0:registerEventHandler("occlusion_change", HUD_OcclusionChange)
	end
	if CoD.isPC then
		Engine.Exec(f2_arg0, "ui_keyboard_cancel")
		Engine.SetForceMouseRootFull(false)
	end
	Engine.PlayMenuMusic("")
	f2_local0.loadingMenu = LUI.createMenu.Loading(f2_arg0)
	f2_local0:addElement(f2_local0.loadingMenu)
	return f2_local0
end

function HUD_UpdateSafeArea(f3_arg0, f3_arg1)
	if f3_arg0.SpectateHUD ~= nil then
		f3_arg0.SpectateHUD:processEvent(f3_arg1)
	end
	f3_arg0:dispatchEventToChildren(f3_arg1)
end

function HUD_OcclusionChange(f4_arg0, f4_arg1)
	CoD.Menu.OcclusionChange(f4_arg0, f4_arg1)
	Engine.EnableWiiURemotePointer(f4_arg1.controller, not f4_arg1.occluded)
end

f0_local1 = function(f5_arg0)
	HUD_SetupEventHandlers_Common(f5_arg0)
	if CoD.isZombie == false then
		HUD_SetupEventHandlers_Multiplayer(f5_arg0)
	else
		HUD_SetupEventHandlers_Zombie(f5_arg0)
	end
end

function HUD_Hide(f6_arg0, f6_arg1)
	f6_arg0:setAlpha(0)
end

function HUD_Show(f7_arg0, f7_arg1)
	f7_arg0:setAlpha(1)
end

local f0_local16 = function(f8_arg0, f8_arg1)
	local roots = LUI.roots
	local rootName = "UIRoot"

	if roots["UIRoot" .. f8_arg1.controller].ingameFriendsList then
		LUI.roots[rootName]:processEvent(
			{
				name = "closeFriendsList",
				controller = f8_arg1.controller
			}
		)
		LUI.roots[rootName]:processEvent(
			{
				name = "closeallpopups",
				controller = f8_arg1.controller
			}
		)
	else
		f8_arg0:openPopup("FriendsList", f8_arg1.controller)
	end
end

local f0_local17 = function(f9_arg0, f9_arg1)
	if f9_arg0.scoreBoard then
		f9_arg0.scoreBoard:processEvent(f9_arg1)
	end
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

function HUD_SetupEventHandlers_Common(f10_arg0)
	f10_arg0:registerEventHandler("first_snapshot", HUD_FirstSnapshot)
	f10_arg0:registerEventHandler("open_ingame_menu", f0_local0)
	f10_arg0:registerEventHandler("close_ingame_menu", HUD_CloseInGameMenu)
	f10_arg0:registerEventHandler("open_scoreboard_menu", HUD_OpenScoreBoard)
	f10_arg0:registerEventHandler("close_scoreboard_menu", HUD_CloseScoreBoard)
	f10_arg0:registerEventHandler("open_migration_menu", HUD_StartMigration)
	f10_arg0:registerEventHandler("spectate_hide_gamehud", HUD_Hide)
	f10_arg0:registerEventHandler("spectate_show_gamehud", HUD_Show)
	f10_arg0:registerEventHandler("fullscreen_viewport_start", HUD_FullscreenStart)
	f10_arg0:registerEventHandler("fullscreen_viewport_stop", HUD_FullscreenStop)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		f10_arg0:registerEventHandler("activate_demo_information_screen", CoD.DemoHUD.ActivateInformationScreen)
		f10_arg0:registerEventHandler("open_demo_ingame_menu", CoD.DemoInGame.Open)
		f10_arg0:registerEventHandler("open_dollycam_marker_options", CoD.DemoPopup.OpenDollyCamMarkerOptionsPopup)
		f10_arg0:registerEventHandler("open_demo_save_popup", CoD.DemoPopup.OpenSavePopup)
		f10_arg0:registerEventHandler("open_demo_manage_segments", CoD.ManageSegments.Open)
	end
	if CoD.isWIIU or CoD.isPC then
		f10_arg0:registerEventHandler("live_notification", CoD.LiveNotifications.NotifyMessage)
	end
	if CoD.isWIIU then
		f10_arg0:registerEventHandler("drc_toggle_friends", f0_local16)
	end
	if CoD.isPC then
		f10_arg0:registerEventHandler("input_source_changed", f0_local17)
	end
end

function HUD_SetupEventHandlers_Multiplayer(f11_arg0)
	f11_arg0:registerEventHandler("hud_update_killstreak_hud", f0_local3)
	f11_arg0:registerEventHandler("hud_force_kill_killstreak_hud", f0_local4)
	f11_arg0:registerEventHandler("hud_update_vehicle", f0_local8)
	f11_arg0:registerEventHandler("faction_popup", f0_local9)
	f11_arg0:registerEventHandler("hud_update_team_change", HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_TEAM_SPECTATOR, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_spectate", HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, f0_local6)
	f11_arg0:registerEventHandler("hud_update_refresh", HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_ROUND_END_KILLCAM, HUD_UpdateRefresh)
	f11_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, f0_local5)
	f11_arg0:registerEventHandler("reload_shoutcaster_hud", f0_local7)
	if CoD.isPC then
		f11_arg0:registerEventHandler("chooseclass_hotkey", HUD_Handle_ChooseClass_HotKey)
	end
end

function HUD_SetupEventHandlers_Zombie(f12_arg0)
	CoD.Zombie.IsSurvivalUsingCIAModel = false
	f12_arg0:registerEventHandler("hud_update_survival_team", HUD_UpdateSurvivalTeamZombie)
	f12_arg0:registerEventHandler("allow_round_animation", HUD_AllowRoundAnimation)
end

function HUD_AllowRoundAnimation(f13_arg0, f13_arg1)
	CoD.Zombie.AllowRoundAnimation = f13_arg1.allow
end

function HUD_UpdateSurvivalTeamZombie(f14_arg0, f14_arg1)
	CoD.Zombie.IsSurvivalUsingCIAModel = true
end

function HUD_FirstSnapshot(f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToChildren(
		{
			name = "close_all_popups",
			controller = f15_arg1.controller
		}
	)
	f15_arg0:removeAllChildren()
	f15_arg0:setOwner(f15_arg1.controller)
	f15_arg0.controller = f15_arg1.controller
	HUD_FirstSnapshot_Common(f15_arg0, f15_arg1)
	if CoD.isZombie == false then
		HUD_FirstSnapshot_Multiplayer(f15_arg0, f15_arg1)
	else
		HUD_FirstSnapshot_Zombie(f15_arg0, f15_arg1)
	end
	Engine.ForceHUDRefresh(f15_arg1.controller)
end

function HUD_StartMigration(f16_arg0, f16_arg1)
	f16_arg0:removeAllChildren()
	f16_arg0:addElement(LUI.createMenu.migration_ingame(f16_arg1.controller, f16_arg0))
end

function HUD_FirstSnapshot_Common(f17_arg0, f17_arg1)
	local safeArea = CoD.Menu.NewSafeAreaFromState("hud_safearea", f17_arg1.controller)
	f17_arg0:addElement(safeArea)
	f17_arg0.safeArea = safeArea

	local f17_local1 = CoD.GrenadeEffect.new()
	f17_local1:setLeftRight(true, true, 0, 0)
	f17_local1:setTopBottom(true, true, 0, 0)
	f17_arg0:addElement(f17_local1)
	if CoD.isZombie == true then
		CoD.Zombie.SoloQuestMode = false
		local f17_local2 = Engine.PartyGetPlayerCount()
		if f17_local2 == 1 and (CoD.isOnlineGame() == false or Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == false) then
			CoD.Zombie.SoloQuestMode = true
		end
		if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true and f17_local2 > 2 then
			CoD.Zombie.LocalSplitscreenMultiplePlayers = true
		end
	end
	HUD_CloseScoreBoard(f17_arg0, f17_arg1)
	f17_arg0.scoreBoard = LUI.createMenu.Scoreboard(f17_arg1.controller)
	f17_arg0.scoreboardUpdateTimer =
		LUI.UITimer.new(
		1000,
		{
			name = "update_scoreboard",
			controller = f17_arg1.controller
		},
		false
	)
	f17_arg0:addElement(LUI.createMenu.DeadSpectate(f17_arg1.controller))
end

function HUD_FirstSnapshot_Multiplayer(f18_arg0, f18_arg1)
	if Engine.GetGametypeSetting("loadoutKillstreaksEnabled") == 1 then
		f18_arg0:addElement(LUI.createMenu.RewardSelection(f18_arg1.controller))
	end
	f18_arg0:addElement(LUI.createMenu.ScoreBottomLeft(f18_arg1.controller))
	f18_arg0:addElement(LUI.createMenu.AmmoArea(f18_arg1.controller))
	local f18_local0 = "gametype_" .. UIExpression.DvarString(nil, "g_gametype")
	local f18_local1 = LUI.createMenu[f18_local0]
	if f18_local1 ~= nil then
		f18_arg0:addElement(f18_local1(f18_arg1.controller))
	else
		f18_arg0:addElement(CoD.GametypeBase.new(f18_local0, f18_arg1.controller))
	end
	local f18_local2 = nil
	if CoD.isZombie == true then
		f18_local2 =
			CoD.ScorePopup.new(
			{
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0
			}
		)
	else
		f18_local2 =
			CoD.ScorePopup.new(
			{
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0
			}
		)
	end
	f18_arg0:addElement(f18_local2)
	f18_arg0:addElement(LUI.createMenu.NotificationPopups(f18_arg1.controller))
	CoD.Compass.AddMinimap(f18_arg0)
	local f18_local3 = 5
	f18_arg0.ingameTalker = CoD.IngameVoipDock.New()
	f18_arg0.ingameTalker:setLeftRight(false, true, f18_local3, f18_local3 + CoD.IngameVoipDock.IconWidth)
	f18_arg0.ingameTalker:setTopBottom(true, false, 0, CoD.IngameVoipDock.IconWidth)
	f18_arg0.miniMapContainer:addElement(f18_arg0.ingameTalker)
	if not Engine.IsSplitscreen() then
		CoD.GameMessages.AddObituaryWindow(
			f18_arg0,
			{
				leftAnchor = true,
				rightAnchor = false,
				left = 13,
				right = 277,
				topAnchor = false,
				bottomAnchor = true,
				top = -249,
				bottom = -149
			}
		)
	end
	CoD.GameMessages.BoldGameMessagesWindow(
		f18_arg0,
		{
			leftAnchor = false,
			rightAnchor = false,
			left = 0,
			right = 0,
			topAnchor = false,
			bottomAnchor = false,
			top = 50,
			bottom = 70
		}
	)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		CoD.LiveStream.AddInGameStatusWidget(
			f18_arg0,
			f18_arg1.controller,
			{
				leftAnchor = false,
				rightAnchor = true,
				left = -200,
				right = 0,
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = 150
			}
		)
		CoD.DemoHUD.AddHUDWidgets(f18_arg0, f18_arg1)
	end
end

function HUD_FirstSnapshot_Zombie(menu, controller)
	local self = LUI.UIElement.new()
	self:setLeftRight(true, true, 0, 0)
	self:setTopBottom(true, true, 0, 0)
	menu:addElement(self)
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) then
		self:registerEventHandler("time_bomb_hud_toggle", HUD_ToggleZombieHudContainer)
	end
	self:addElement(LUI.createMenu.PerksArea(controller.controller))
	self:addElement(LUI.createMenu.PowerUpsArea(controller.controller))
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps) then
		if CoD.Zombie.GAMETYPE_ZCLASSIC == Dvar.ui_gametype:get() then
			require("T6.Zombie.HudCraftablesZombie")
			self:addElement(LUI.createMenu.CraftablesArea(controller.controller))
		end
		require("T6.Zombie.HudAfterlifeDisplay")
		local f19_local1 = LUI.createMenu.AfterlifeArea(controller.controller)
		f19_local1:setUseGameTime(true)
		self:addElement(f19_local1)
	elseif CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps) then
		if CoD.Zombie.GAMETYPE_ZCLASSIC == Dvar.ui_gametype:get() then
			require("T6.Zombie.HudCraftablesTombZombie")
			self:addElement(LUI.createMenu.CraftablesTombArea(controller.controller))
			require("T6.HUD.gametypes.GametypeBase")
			require("T6.Zombie.TombCaptureZoneDisplay")
			self:addElement(LUI.createMenu.TombCaptureZoneDisplay(controller.controller))
			if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
				require("T6.Zombie.HudChallengeMedals")
				self:addElement(LUI.createMenu.ChallengeMedalsArea(controller.controller))
			end
		end
	else
		self:addElement(LUI.createMenu.BuildablesArea(controller.controller))
	end
	if CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) then
		require("T6.Zombie.HudTimeBomb")
		self:addElement(LUI.createMenu.TimeBombArea(controller.controller))
	end
	local f19_local1 = LUI.createMenu.CompetitiveScoreboard(controller.controller)
	f19_local1:setUseGameTime(true)
	self:addElement(f19_local1)
	if
		CoD.Zombie.IsDLCMap(CoD.Zombie.DLC2Maps) or CoD.Zombie.IsDLCMap(CoD.Zombie.DLC3Maps) or
			CoD.Zombie.IsDLCMap(CoD.Zombie.DLC4Maps)
	 then
		require("T6.Zombie.AmmoAreaZombie")
		local f19_local2 = LUI.createMenu.AmmoAreaZombie(controller.controller)
		f19_local2:setUseGameTime(true)
		self:addElement(f19_local2)
	else
		local f19_local2 = LUI.createMenu.DPadArea(controller.controller)
		f19_local2:setUseGameTime(true)
		self:addElement(f19_local2)
	end
	if CoD.Zombie.GAMETYPE_ZCLEANSED == Dvar.ui_gametype:get() then
		local f19_local2 = LUI.createMenu.TimerAreaZM(controller.controller)
		f19_local2:setUseGameTime(true)
		self:addElement(f19_local2)
	else
		local f19_local2 = LUI.createMenu.RoundStatus(controller.controller)
		f19_local2:setUseGameTime(true)
		self:addElement(f19_local2)
	end
	if CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER == UIExpression.DvarString(nil, "ui_zm_gamemodegroup") then
		self:addElement(
			CoD.Hud3DScoreBoardZombie.new(
				{
					leftAnchor = true,
					rightAnchor = true,
					left = 0,
					right = 0,
					topAnchor = true,
					bottomAnchor = true,
					bottom = 0,
					top = 0,
					ui3DWindow = 0
				}
			)
		)
	end
	if not Engine.IsSplitscreen() then
		CoD.GameMessages.AddObituaryWindow(
			menu,
			{
				leftAnchor = true,
				rightAnchor = false,
				left = 13,
				right = 277,
				topAnchor = false,
				bottomAnchor = true,
				top = -320,
				bottom = -220
			}
		)
		CoD.GameMessages.BoldGameMessagesWindow(
			menu,
			{
				leftAnchor = false,
				rightAnchor = false,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = false,
				top = 50,
				bottom = 70
			}
		)
	end
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		CoD.DemoHUD.AddHUDWidgets(menu, controller)
	end
end

function HUD_ToggleZombieHudContainer(f20_arg0, f20_arg1)
	if f20_arg1.newValue == 0 then
		f20_arg0:beginAnimation("fade_in", 500)
		f20_arg0:setAlpha(1)
	else
		f20_arg0:beginAnimation("fade_out", 500)
		f20_arg0:setAlpha(0)
	end
end

f0_local0 = function(f21_arg0, f21_arg1)
	if f21_arg0.m_inputDisabled then
		return
	elseif f21_arg1.menuName == "class" and Engine.IsMigrating(f21_arg1.controller) == true then
		return
	elseif true == CoD.isZombie then
		if CoD.InGameMenu.m_unpauseDisabled == nil then
			CoD.InGameMenu.m_unpauseDisabled = {}
		end
		CoD.InGameMenu.m_unpauseDisabled[f21_arg1.controller + 1] = 0
		if f21_arg1.unpausable ~= nil and f21_arg1.unpausable == 0 then
			CoD.InGameMenu.m_unpauseDisabled[f21_arg1.controller + 1] = 1
		end
	end
	if f21_arg1.data ~= nil then
		f21_arg1.menuName = Engine.GetIString(f21_arg1.data[1], "CS_SCRIPT_MENUS")
	end
	if f21_arg0.SpectateHUD ~= nil and f21_arg0.SpectateHUD.m_controlsOpen then
		return
	end
	local f21_local0 = LUI.createMenu[f21_arg1.menuName]
	f21_arg0:dispatchEventToChildren(f21_arg1)
	if f21_local0 ~= nil then
		f0_local15 = true
		f21_arg0:openPopup(f21_arg1.menuName, f21_arg1.controller)
	end
	if f21_arg0.SpectateHUD ~= nil then
		f21_arg0.SpectateHUD:processEvent(
			{
				name = "spectate_ingame_menu_opened"
			}
		)
	end
end

function HUD_CloseInGameMenu(f22_arg0, f22_arg1)
	if CoD.isZombie == true then
		if CoD.InGameMenu.m_unpauseDisabled == nil then
			CoD.InGameMenu.m_unpauseDisabled = {}
		end
		CoD.InGameMenu.m_unpauseDisabled[f22_arg1.controller + 1] = 0
	end
	if f22_arg0.SpectateHUD ~= nil then
		f22_arg0.SpectateHUD:processEvent(
			{
				name = "spectate_ingame_menu_closed"
			}
		)
	end
	f0_local15 = nil
	if CoD.isZombie == true then
		Engine.SetActiveMenu(f22_arg1.controller, CoD.UIMENU_NONE)
	end
end

function HUD_OpenScoreBoard(f23_arg0, f23_arg1)
	if
		CoD.isZombie == true and CoD.InGameMenu.m_unpauseDisabled ~= nil and
			CoD.InGameMenu.m_unpauseDisabled[f23_arg1.controller + 1] ~= nil and
			CoD.InGameMenu.m_unpauseDisabled[f23_arg1.controller + 1] > 0
	 then
		return
	elseif f23_arg0.scoreBoard and (f23_arg0.SpectateHUD == nil or not f23_arg0.SpectateHUD.m_controlsOpen) then
		f23_arg0:addElement(f23_arg0.scoreBoard)
		f23_arg0.scoreBoard:processEvent(
			{
				name = "update_scoreboard",
				controller = f23_arg1.controller
			}
		)
		f23_arg0:addElement(f23_arg0.scoreboardUpdateTimer)
		if CoD.isZombie == true then
			if f23_arg0.scoreBoard.questItemDisplay then
				f23_arg0.scoreBoard.questItemDisplay:processEvent(
					{
						name = "update_quest_item_display_scoreboard",
						controller = f23_arg1.controller
					}
				)
			end
			if f23_arg0.scoreBoard.persistentItemDisplay then
				f23_arg0.scoreBoard.persistentItemDisplay:processEvent(
					{
						name = "update_persistent_item_display_scoreboard",
						controller = f23_arg1.controller
					}
				)
			end
			if f23_arg0.scoreBoard.craftableItemDisplay then
				f23_arg0.scoreBoard.craftableItemDisplay:processEvent(
					{
						name = "update_craftable_item_display_scoreboard",
						controller = f23_arg1.controller
					}
				)
			end
			if f23_arg0.scoreBoard.captureZoneWheelDisplay then
				f23_arg0.scoreBoard.captureZoneWheelDisplay:processEvent(
					{
						name = "update_capture_zone_wheel_display_scoreboard",
						controller = f23_arg1.controller
					}
				)
			end
		end
		if f23_arg0.SpectateHUD ~= nil then
			f23_arg0.SpectateHUD:processEvent(
				{
					name = "spectate_scoreboard_opened"
				}
			)
			if f23_arg0.SpectateHUD.m_selectedClientNum ~= nil then
				f23_arg0.scoreBoard:processEvent(
					{
						name = "focus_client",
						controller = f23_arg1.controller,
						clientNum = f23_arg0.SpectateHUD.m_selectedClientNum
					}
				)
			end
		end
	end
end

function HUD_CloseScoreBoard(f24_arg0, f24_arg1)
	if f24_arg0.scoreBoard then
		f24_arg0.scoreBoard:close()
		f24_arg0.scoreboardUpdateTimer:close()
		f24_arg0.scoreboardUpdateTimer:reset()
		if f24_arg0.SpectateHUD ~= nil then
			f24_arg0.SpectateHUD:processEvent(
				{
					name = "spectate_scoreboard_closed"
				}
			)
		end
	end
end

function HUD_DebugReload(f25_arg0, f25_arg1)
	if f25_arg0.m_eventHandlers.debug_reload ~= HUD_DebugReload then
		f25_arg0:registerEventHandler("debug_reload", HUD_DebugReload)
		f25_arg0:processEvent(
			{
				name = "debug_reload"
			}
		)
		return
	else
		f25_arg0.chopperGunnerHUD = nil
		f25_arg0.predatorHUD = nil
		f25_arg0.reaperHUD = nil
		f0_local1(f25_arg0)
		HUD_FirstSnapshot(
			f25_arg0,
			{
				controller = f25_arg0.controller
			}
		)
		Engine.ForceHUDRefresh(f25_arg0.controller)
	end
end

function HUD_UpdateRefresh(f26_arg0, f26_arg1)
	f0_local2(f26_arg0, f26_arg1)
	f0_local6(f26_arg0, f26_arg1)
end

function HUD_FullscreenStart(f27_arg0, f27_arg1)
	f27_arg0.scoreBoard:processEvent(f27_arg1)
	f27_arg0:dispatchEventToChildren(f27_arg1)
end

function HUD_FullscreenStop(f28_arg0, f28_arg1)
	f28_arg0.scoreBoard:processEvent(f28_arg1)
	f28_arg0:dispatchEventToChildren(f28_arg1)
end

function HUD_StartKillcamHud(f29_arg0, f29_arg1)
	if not f29_arg0.killcamHUD then
		f29_arg0.killcamHUD = LUI.createMenu.Killcam(f29_arg1.controller)
		f29_arg0:addElement(f29_arg0.killcamHUD)
		local f29_local0 = LUI.roots.UIRootDrc
		if f29_local0 then
			f29_local0:processEvent(
				{
					name = "killcam_open",
					controller = f29_arg1.controller
				}
			)
		end
	end
end

function HUD_StopKillcamHud(f30_arg0, f30_arg1)
	if f30_arg0.killcamHUD then
		f30_arg0.killcamHUD:close()
		f30_arg0.killcamHUD = nil
		local f30_local0 = LUI.roots.UIRootDrc
		if f30_local0 then
			f30_local0:processEvent(
				{
					name = "killcam_close",
					controller = f30_arg1.controller
				}
			)
		end
	end
end

f0_local2 = function(f31_arg0, f31_arg1)
	if UIExpression.IsVisibilityBitSet(f31_arg1.controller, CoD.BIT_IN_KILLCAM) == 1 then
		if f31_arg0.killcamHUD then
			if f31_arg0.killcamHUD.isFinalKillcam ~= UIExpression.IsVisibilityBitSet(f31_arg1.controller, CoD.BIT_FINAL_KILLCAM) then
				HUD_StopKillcamHud(f31_arg0, f31_arg1)
			elseif
				f31_arg0.killcamHUD.isRoundEndKillcam ~=
					UIExpression.IsVisibilityBitSet(f31_arg1.controller, CoD.BIT_ROUND_END_KILLCAM)
			 then
				HUD_StopKillcamHud(f31_arg0, f31_arg1)
			end
		end
		HUD_StartKillcamHud(f31_arg0, f31_arg1)
	else
		HUD_StopKillcamHud(f31_arg0, f31_arg1)
	end
	f31_arg0:dispatchEventToChildren(f31_arg1)
end

local f0_local18 = function(f32_arg0)
	local f32_local0
	if
		Engine.IsSplitscreen() ~= false or
			Engine.IsDemoShoutcaster() ~= true and
				(UIExpression.IsVisibilityBitSet(f32_arg0, CoD.BIT_SPECTATING_CLIENT) ~= 1 or
					UIExpression.IsVisibilityBitSet(f32_arg0, CoD.BIT_TEAM_SPECTATOR) ~= 1 or
					UIExpression.IsVisibilityBitSet(f32_arg0, CoD.BIT_GAME_ENDED) ~= 0 or
					UIExpression.IsVisibilityBitSet(f32_arg0, CoD.BIT_UI_ACTIVE) ~= 0)
	 then
		f32_local0 = false
	else
		f32_local0 = true
	end
	return f32_local0
end

f0_local6 = function(f33_arg0, f33_arg1)
	if f0_local18(f33_arg1.controller) then
		if f33_arg0.SpectateHUD == nil then
			local f33_local0 = CoD.SpectateHUD.new(f33_arg1)
			LUI.roots.UIRootFull:addElement(f33_local0)
			f33_arg0.SpectateHUD = f33_local0
			f33_arg0.SpectateHUD.m_gameHUD = f33_arg0
		end
		CoD.SpectateHUD.update(f33_arg0.SpectateHUD, f33_arg1)
	elseif f33_arg0.SpectateHUD ~= nil then
		f33_arg0.SpectateHUD:close()
		f33_arg0.SpectateHUD = nil
	end
	f33_arg0:dispatchEventToChildren(f33_arg1)
end

f0_local7 = function(f34_arg0, f34_arg1)
	if f34_arg0.SpectateHUD ~= nil then
		f34_arg0.SpectateHUD:close()
		f34_arg0.SpectateHUD = nil
	end
	f0_local6(f34_arg0, f34_arg1)
end

local f0_local19 = function(f35_arg0)
	local f35_local0
	if
		UIExpression.IsVisibilityBitSet(f35_arg0, CoD.BIT_SELECTING_LOCATION) ~= 1 or
			UIExpression.IsVisibilityBitSet(f35_arg0, CoD.BIT_SPECTATING_CLIENT) ~= 0 or
			UIExpression.IsVisibilityBitSet(f35_arg0, CoD.BIT_IS_DEMO_PLAYING) ~= 0 or
			UIExpression.IsVisibilityBitSet(f35_arg0, CoD.BIT_SCOREBOARD_OPEN) ~= 0
	 then
		f35_local0 = false
	else
		f35_local0 = true
	end
	return f35_local0
end

f0_local5 = function(f36_arg0, f36_arg1)
	if f0_local19(f36_arg1.controller) then
		if f36_arg0.locationSelectorMap == nil then
			if f36_arg0.selectorContainer == nil then
				f36_arg0.selectorContainer = CoD.SplitscreenScaler.new(nil, 1.3)
				f36_arg0.selectorContainer:setLeftRight(false, false, 0, 0)
				f36_arg0.selectorContainer:setTopBottom(false, false, 0, 0)
				f36_arg0.safeArea:addElement(f36_arg0.selectorContainer)
			end
			f36_arg0.locationSelectorMap =
				CoD.Compass.new(
				{
					leftAnchor = false,
					rightAnchor = false,
					left = -275,
					right = 275,
					topAnchor = false,
					bottomAnchor = false,
					top = -275,
					bottom = 275
				},
				CoD.COMPASS_TYPE_FULL
			)
			f36_arg0.selectorContainer:addElement(f36_arg0.locationSelectorMap)
			Engine.BlurWorld(f36_arg1.controller, 2)
		end
	elseif f36_arg0.locationSelectorMap ~= nil then
		f36_arg0.selectorContainer:close()
		f36_arg0.selectorContainer = nil
		f36_arg0.locationSelectorMap:close()
		f36_arg0.locationSelectorMap = nil
		Engine.BlurWorld(f36_arg1.controller, 0)
	end
	f36_arg0:dispatchEventToChildren(f36_arg1)
end

f0_local3 = function(f37_arg0, f37_arg1)
	if f37_arg1.chopperGunner == true then
		if f37_arg0.chopperGunnerHUD == nil then
			local predatorHUD = CoD.ChopperGunnerHUD.new(f37_arg1.controller)
			f37_arg0:addElement(predatorHUD)
			f37_arg0.chopperGunnerHUD = predatorHUD
		end
	else
		f37_arg0.chopperGunnerHUD = nil
	end
	if f37_arg1.reaper == true then
		if f37_arg0.reaperHUD == nil then
			local predatorHUD = CoD.ReaperHUD.new(f37_arg1.controller)
			f37_arg0:addElement(predatorHUD)
			f37_arg0.reaperHUD = predatorHUD
		end
	else
		f37_arg0.reaperHUD = nil
	end
	if f37_arg1.predator == true then
		if f37_arg0.predatorHUD == nil then
			local predatorHUD = CoD.PredatorHUD.new(f37_arg1.controller)
			f37_arg0:addElement(predatorHUD)
			f37_arg0.predatorHUD = predatorHUD
		end
	else
		f37_arg0.predatorHUD = nil
	end
	f37_arg0:dispatchEventToChildren(f37_arg1)
end

f0_local4 = function(f38_arg0, f38_arg1)
	Engine.DisableSceneFilter(f38_arg0:getOwner(), 4)
end

f0_local8 = function(f39_arg0, f39_arg1)
	if f39_arg0.vehicleHUD then
		if f39_arg0.vehicleHUD.vehicleType == f39_arg1.vehicleType then
			return
		end
		f39_arg0.vehicleHUD:close()
		f39_arg0.vehicleHUD = nil
		Engine.DisableSceneFilter(f39_arg0:getOwner(), 4)
	end
	if not f39_arg1.vehicleType then
		return
	end
	local f39_local0 = LUI.createMenu[f39_arg1.vehicleType]
	if f39_local0 then
		f39_arg0.vehicleHUD = f39_local0(f39_arg0:getOwner())
		f39_arg0.vehicleHUD:setPriority(-10)
		f39_arg0.vehicleHUD.vehicleType = f39_arg1.vehicleType
		f39_arg0:addElement(f39_arg0.vehicleHUD)
	end
end

f0_local9 = function(f40_arg0, f40_arg1)
	local f40_local0 = UIExpression.Team(f40_arg1.controller, "name")
	local f40_local1, f40_local2, f40_local3, f40_local4, f40_local5 = nil
	if f40_local0 == "TEAM_ALLIES" then
		f40_local1 = RegisterMaterial(UIExpression.DvarString(nil, "g_TeamIcon_Allies"))
		f40_local2 = CoD.ScoreFeed.Color1
		f40_local3 = CoD.ScoreFeed.Color2
		f40_local4 = CoD.ScoreFeed.Color3
		f40_local5 =
			UIExpression.ToUpper(
			nil,
			Engine.Localize(Engine.GetIString(f40_arg1.data[1], "CS_LOCALIZED_STRINGS"), Dvar.g_TeamName_Allies:get())
		)
	elseif f40_local0 == "TEAM_AXIS" then
		f40_local1 = RegisterMaterial(UIExpression.DvarString(nil, "g_TeamIcon_Axis"))
		f40_local2 = CoD.ScoreFeed.ScoreStreakColor1
		f40_local3 = CoD.ScoreFeed.ScoreStreakColor2
		f40_local4 = CoD.ScoreFeed.ScoreStreakColor3
		f40_local5 =
			UIExpression.ToUpper(
			nil,
			Engine.Localize(Engine.GetIString(f40_arg1.data[1], "CS_LOCALIZED_STRINGS"), Dvar.g_TeamName_Axis:get())
		)
	else
		return
	end
	local f40_local6 = 128
	local f40_local7 = 0
	local self =
		LUI.UIElement.new(
		{
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		}
	)
	f40_arg0.safeArea:addElement(self)

	local darkSplash = LUI.UIImage.new()
	darkSplash:setLeftRight(false, false, -f40_local6 / 2, f40_local6 / 2)
	darkSplash:setTopBottom(true, false, f40_local7, f40_local7 + f40_local6)
	darkSplash:setImage(RegisterMaterial("ks_menu_background"))
	darkSplash:setAlpha(0.5)
	self:addElement(darkSplash)
	self.darkSplash = darkSplash

	local f40_local10 = CoD.textSize.Condensed
	self.text =
		CoD.AdditiveTextOverlay.newWithText(
		f40_local5,
		"Condensed",
		f40_local2,
		f40_local3,
		f40_local4,
		{
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = f40_local6,
			bottom = f40_local6 + f40_local10
		}
	)
	self.text.label:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	self.image =
		LUI.UIImage.new(
		{
			leftAnchor = false,
			rightAnchor = false,
			left = -f40_local6 / 2,
			right = f40_local6 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f40_local7,
			bottom = f40_local7 + f40_local6,
			material = f40_local1
		}
	)
	self:addElement(self.image)
	local f40_local11 = f40_local6 + f40_local10
	local f40_local12 = f40_local6
	self.imageGlow =
		CoD.AdditiveTextOverlay.new(
		f40_local6,
		f40_local6,
		f40_local2,
		f40_local3,
		f40_local4,
		{
			leftAnchor = false,
			rightAnchor = false,
			left = -f40_local6 / 2,
			right = f40_local6 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f40_local6
		}
	)
	self:addElement(self.imageGlow)
	self:registerEventHandler("add_text", f0_local10)
	self:registerEventHandler("out", f0_local11)
	self:registerEventHandler("out2", f0_local12)
	self:addElement(LUI.UITimer.new(500, "add_text", true))
	self:addElement(LUI.UITimer.new(2000, "out", true))
end

f0_local10 = function(f41_arg0, f41_arg1)
	f41_arg0:addElement(f41_arg0.text)
end

f0_local11 = function(f42_arg0, f42_arg1)
	f42_arg0.text:out()
	f42_arg0:addElement(LUI.UITimer.new(CoD.AdditiveTextOverlay.PulseOutTime, "out2", true))
	f42_arg0:addElement(LUI.UITimer.new(CoD.AdditiveTextOverlay.PulseOutTime * 2, "close", true))
end

f0_local12 = function(f43_arg0, f43_arg1)
	f43_arg0.imageGlow:out()
	f43_arg0.image:close()
	f43_arg0.darkSplash:close()
end

function HUD_IsFFA()
	if f0_local13 == nil then
		if CoD.isZombie == true then
			local f44_local0 = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
			local f44_local1
			if f44_local0 ~= CoD.Zombie.GAMETYPEGROUP_ZCLASSIC and f44_local0 ~= CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL then
				f44_local1 = false
			else
				f44_local1 = true
			end
			f0_local13 = f44_local1
		else
			local f44_local0
			if
				UIExpression.DvarString(nil, "ui_gametype") ~= "dm" and UIExpression.DvarString(nil, "ui_gametype") ~= "hcdm" and
					UIExpression.DvarString(nil, "ui_gametype") ~= "hack" and
					CoD.IsWagerMode() ~= true
			 then
				f44_local0 = false
			else
				f44_local0 = true
			end
			f0_local13 = f44_local0
		end
	end
	return f0_local13
end

function HUD_Handle_ChooseClass_HotKey(f45_arg0, f45_arg1)
	if
		UIExpression.Team(f45_arg1.controller, "name") ~= "TEAM_SPECTATOR" and CoD.IsWagerMode() == false and
			not (Engine.GetGametypeSetting("disableClassSelection") == 1)
	 then
		f0_local0(
			f45_arg0,
			{
				menuName = "changeclass",
				controller = f45_arg1.controller
			}
		)
	end
end

DisableGlobals()
Engine.StopEditingPresetClass()
