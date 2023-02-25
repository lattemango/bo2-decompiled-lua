CoD.NoLeave = {}
LUI.createMenu.NoLeave = function ( f1_arg0, f1_arg1 )
	local f1_local0 = CoD.Menu.NewSmallPopup( "NoLeave" )
	f1_local0:addBackButton()
	local f1_local1 = 0
	local self = LUI.UIText.new()
	self:setLeftRight( true, false, 0, CoD.Menu.SmallPopupWidth )
	self:setTopBottom( true, false, f1_local1, f1_local1 + CoD.textSize.Big )
	self:setFont( CoD.fonts.Big )
	self:setAlignment( LUI.Alignment.Left )
	self:setText( Engine.Localize( "MENU_NOTICE" ) )
	f1_local0:addElement( self )
	f1_local1 = f1_local1 + CoD.textSize.Big
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight( true, true, 0, 0 )
	f1_local3:setTopBottom( true, false, f1_local1, f1_local1 + CoD.textSize.Default )
	f1_local3:setFont( CoD.fonts.Default )
	f1_local3:setAlignment( LUI.Alignment.Left )
	f1_local0:addElement( f1_local3 )
	f1_local3:setText( Engine.Localize( "ZMUI_NO_LEAVE_LOBBY" ) )
	Engine.PlaySound( "caC_main_exit_cac" )
	return f1_local0
end

