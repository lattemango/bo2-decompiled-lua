CoD.ServerListButton = {}
CoD.ServerListButton.Height = 30
CoD.ServerListButton.TextOffset = 5
CoD.ServerListButton.TextHeight = CoD.textSize.Default
CoD.ServerListButton.Font = CoD.fonts.Default
CoD.ServerListButton.BackgroundColor = {
	r = 1,
	g = 1,
	b = 1,
	a = 0
}
local f0_local0 = function ( f1_arg0, f1_arg1 )
	Engine.PlaySound( "uin_navigation_click" )
end

CoD.ServerListButton.new = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3 )
	local self = LUI.UIButton.new( f2_arg2, f2_arg3 )
	self.id = "ServerListButton." .. f2_arg1.hostname
	self.serverIndex = f2_arg1.serverIndex
	local f2_local1 = LUI.UIHorizontalList.new( {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.ServerList.ColumnSpacing
	} )
	local f2_local2 = LUI.UIText.new( {
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[1],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	} )
	local f2_local3 = LUI.UIText.new( {
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[2],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	} )
	local f2_local4 = LUI.UIText.new( {
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[3],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	} )
	local f2_local5 = LUI.UIText.new( {
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[4],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	} )
	local f2_local6 = LUI.UIText.new( {
		left = 0,
		top = -CoD.ServerListButton.TextHeight / 2,
		right = CoD.ServerList.ColumnWidth[5],
		bottom = CoD.ServerListButton.TextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.ServerListButton.Font
	} )
	f2_local2:setText( f2_arg1.hostname )
	f2_local3:setText( f2_arg1.mapname )
	f2_local4:setText( f2_arg1.clients )
	f2_local5:setText( f2_arg1.gametype )
	if f2_arg1.isInGame == "1" then
		f2_local6:setText( Engine.Localize( "MENU_PLAYING" ) )
		f2_local2:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
		f2_local3:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
		f2_local4:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
		f2_local5:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
		f2_local6:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
	else
		f2_local6:setText( Engine.Localize( "MENU_LOBBY" ) )
	end
	f2_local1:addSpacer( CoD.ServerListButton.TextOffset )
	f2_local1:addElement( f2_local2 )
	f2_local1:addElement( f2_local3 )
	f2_local1:addElement( f2_local4 )
	f2_local1:addElement( f2_local5 )
	f2_local1:addElement( f2_local6 )
	self:addElement( f2_local1 )
	local f2_local7 = CoD.Border.new( 2 )
	f2_local7:hide()
	f2_local7:registerEventHandler( "button_over", f2_local7.show )
	f2_local7:registerEventHandler( "button_up", f2_local7.hide )
	self:addElement( f2_local7 )
	local f2_local8 = LUI.UIElement.new()
	self:addElement( f2_local8 )
	f2_local8:registerEventHandler( "gain_focus", f0_local0 )
	return self
end

