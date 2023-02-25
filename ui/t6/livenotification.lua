require( "T6.CoDBase" )

CoD.LiveNotifications = {}
CoD.LiveNotifications.NotifyInTime = 250
CoD.LiveNotifications.NotifyVisibleTime = 3500
CoD.LiveNotifications.NotifyOutTime = 250
CoD.LiveNotifications.NotifyImageHeight = 85
CoD.LiveNotifications.NotifyimageWidth = 256
CoD.LiveNotifications.NotifyimageTop = -180
CoD.LiveNotifications.NotificationFontName = "Default"
CoD.LiveNotifications.NotificationFont = CoD.fonts[CoD.LiveNotifications.NotificationFontName]
CoD.LiveNotifications.NotificationFontHeight = CoD.textSize[CoD.LiveNotifications.NotificationFontName]
CoD.LiveNotifications.backgroundImage = "black"
CoD.LiveNotifications.BorderWidth = 5
CoD.LiveNotifications.Queue = {}
CoD.LiveNotifications.QueueBusy = false
CoD.LiveNotifications.Interval = 200
CoD.LiveNotifications.DisplayNotifyMessage = function ( f1_arg0, f1_arg1 )
	Engine.PlaySound( "uin_alert_slideout" )
	local f1_local0 = CoD.LiveNotifications.NotifyimageTop
	local f1_local1 = CoD.LiveNotifications.NotifyimageWidth / 2
	local self = LUI.UIImage.new()
	self:setLeftRight( true, false, 0, CoD.LiveNotifications.NotifyimageWidth )
	self:setTopBottom( false, true, f1_local0, f1_local0 + CoD.LiveNotifications.NotifyImageHeight )
	self:setImage( RegisterMaterial( CoD.LiveNotifications.backgroundImage ) )
	self:setAlpha( 0.7 )
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight( true, false, CoD.LiveNotifications.BorderWidth, CoD.LiveNotifications.NotifyimageWidth - 2 * CoD.LiveNotifications.BorderWidth )
	f1_local3:setTopBottom( false, true, f1_local0, f1_local0 + CoD.LiveNotifications.NotificationFontHeight )
	if CoD.isPC then
		f1_local3:setAlignment( LUI.Alignment.Center )
	else
		f1_local3:setAlignment( LUI.Alignment.Left )
	end
	f1_local3:setFont( CoD.LiveNotifications.NotificationFont )
	f1_local3:setText( f1_arg1.message )
	local f1_local4 = LUI.UIElement.new()
	f1_local4:setLeftRight( false, false, -f1_local1, f1_local1 )
	f1_local4:setTopBottom( false, true, 0, CoD.LiveNotifications.NotifyImageHeight )
	f1_local4:setPriority( 50000 )
	f1_local4:addElement( self )
	f1_local4:addElement( f1_local3 )
	f1_local4:registerEventHandler( "outState", CoD.LiveNotifications.NotifyOut )
	f1_local4:registerEventHandler( "done", CoD.LiveNotifications.UpdateQueue )
	if CoD.isPC and f1_arg1.inviteXuid ~= nil and f1_arg1.shortcutKey then
		f1_local4.inviteXuid = f1_arg1.inviteXuid
		f1_local4.shortcutKey = f1_arg1.shortcutKey
		f1_local4.inviteAccepted = false
		f1_local4:registerEventHandler( "gamepad_button", CoD.LiveNotifications.AcceptInviteHotKey )
	end
	f1_local4:registerAnimationState( "in", {
		alpha = 1
	} )
	f1_local4:registerAnimationState( "out", {
		alpha = 0
	} )
	f1_local4:setPriority( 50000 )
	f1_local4:animateToState( "in", CoD.LiveNotifications.NotifyInTime )
	f1_local4:addElement( LUI.UITimer.new( CoD.LiveNotifications.NotifyVisibleTime - CoD.LiveNotifications.NotifyInTime - CoD.LiveNotifications.NotifyOutTime, "outState", true ) )
	f1_arg0:addElement( f1_local4 )
end

CoD.LiveNotifications.UpdateQueue = function ( f2_arg0, f2_arg1 )
	f2_arg0:close()
	CoD.LiveNotifications.QueueBusy = false
	CoD.LiveNotifications.ProcessQueue()
end

CoD.LiveNotifications.NotifyOut = function ( f3_arg0, f3_arg1 )
	f3_arg0:animateToState( "out", CoD.LiveNotifications.NotifyOutTime, true, false )
	f3_arg0:addElement( LUI.UITimer.new( CoD.LiveNotifications.NotifyOutTime + CoD.LiveNotifications.Interval, "done", true ) )
end

CoD.LiveNotifications.NotifyMessage = function ( f4_arg0, f4_arg1 )
	CoD.LiveNotifications.EnqueueNotifyMessage( f4_arg0, f4_arg1 )
	CoD.LiveNotifications.ProcessQueue()
end

CoD.LiveNotifications.EnqueueNotifyMessage = function ( f5_arg0, f5_arg1 )
	table.insert( CoD.LiveNotifications.Queue, {
		parent = f5_arg0,
		event = f5_arg1
	} )
end

CoD.LiveNotifications.ProcessQueue = function ()
	if not CoD.LiveNotifications.QueueBusy and #CoD.LiveNotifications.Queue > 0 then
		CoD.LiveNotifications.QueueBusy = true
		local f6_local0 = CoD.LiveNotifications.Queue[1]
		table.remove( CoD.LiveNotifications.Queue, 1 )
		if f6_local0.parent ~= nil and f6_local0.event ~= nil then
			CoD.LiveNotifications.DisplayNotifyMessage( f6_local0.parent, f6_local0.event )
		end
	end
end

CoD.LiveNotifications.AcceptInviteHotKey = function ( f7_arg0, f7_arg1 )
	if f7_arg0.inviteXuid ~= nil and not f7_arg0.inviteAccepted and f7_arg1.button == "key_shortcut" and f7_arg1.key == f7_arg0.shortcutKey then
		CoD.acceptGameInvite( f7_arg1.controller, f7_arg0.inviteXuid )
		f7_arg0.inviteAccepted = true
	end
end

