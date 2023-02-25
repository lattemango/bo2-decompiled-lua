CoD.LowerOptionsBar = {}
CoD.LowerOptionsBar.HeightOffset = -28
CoD.LowerOptionsBar.Height = CoD.textSize.Default
CoD.LowerOptionsBar.Width = 700
CoD.LowerOptionsBar.textSize = CoD.textSize.Default
CoD.LowerOptionsBar.new = function ( f1_arg0, f1_arg1 )
	local f1_local0 = f1_arg0 + CoD.LowerOptionsBar.HeightOffset
	local f1_local1 = CoD.LowerOptionsBar.BackgroundMaterial
	local f1_local2 = CoD.LowerOptionsBar.Height
	local f1_local3 = CoD.LowerOptionsBar.textSize
	local self = LUI.UIElement.new( {
		left = -(CoD.LowerOptionsBar.Width / 2),
		top = f1_local0,
		right = CoD.LowerOptionsBar.Width / 2,
		bottom = f1_local0 + f1_local2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 1
	} )
	self:addElement( LUI.UIImage.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0.5
	} ) )
	local f1_local5 = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alignment = LUI.Alignment.Center,
		spacing = 15
	} )
	self:addElement( f1_local5 )
	f1_local5:addElement( CoD.ButtonPrompt.new( "select", Engine.Localize( "PLATFORM_SCOREBOARD" ) ) )
	
	local SpecViewToggle = CoD.ButtonPrompt.new( "alt2", Engine.Localize( CoD.SpectateHUD.getSpectatorString( controller ) ), false, false, false, "mouse3", nil )
	f1_local5:addElement( SpecViewToggle )
	f1_arg1.SpecViewToggle = SpecViewToggle
	
	if Engine.GetTeamID( f1_arg1.m_ownerController, Engine.GetClientNum( f1_arg1.m_ownerController ) ) == CoD.TEAM_SPECTATOR then
		local f1_local7 = CoD.ButtonPrompt.new( "right_trigger", Engine.Localize( "MP_PLAYER_STATUS" ), f1_arg1, "show_player_list" )
		f1_local5:addElement( f1_local7 )
		f1_arg1.showPlayerListButton = f1_local7
	end
	return self
end

