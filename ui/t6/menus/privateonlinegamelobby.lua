require( "T6.Menus.PrivateGameLobby" )

CoD.PrivateOnlineGameLobby = {}
LUI.createMenu.PrivateOnlineGameLobby = function ( f1_arg0 )
	local f1_local0 = CoD.PrivateGameLobby.New( "PrivateOnlineGameLobby", f1_arg0 )
	if CoD.isMultiplayer then
		f1_local0:setPreviousMenu( "MainLobby" )
	end
	local f1_local1 = Engine.Localize( "MPUI_CUSTOM_GAMES_CAPS" )
	f1_local0:addTitle( f1_local1 )
	f1_local0.panelManager.panels.buttonPane.titleText = f1_local1
	return f1_local0
end

