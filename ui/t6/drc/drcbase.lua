require( "T6.CoDBase" )

CoD.DrcBase = {}
CoD.DrcBase.UpdateBlur = function ( f1_arg0, f1_arg1 )
	
end

CoD.DrcBase.DebugReload = function ( f2_arg0, f2_arg1 )
	local f2_local0 = LUI.createMenu[f2_arg0.menuName]( f2_arg0.m_ownerController, true )
	local f2_local1 = f2_arg0:getParent()
	f2_local1:addElement( f2_local0 )
	f2_arg0:close()
end

CoD.DrcBase.NewMenu = function ( f3_arg0 )
	local f3_local0 = CoD.Menu.New( f3_arg0 )
	f3_local0:setLeftRight( true, true, 0, 0 )
	f3_local0:setTopBottom( true, true, 0, 0 )
	f3_local0.updateBlur = CoD.DrcBase.UpdateBlur
	f3_local0.m_ownerController = 0
	f3_local0:registerEventHandler( "open_drc_popup", function ( element, event )
		element:openPopupOnDrc( event.popupName, event.controller )
	end )
	f3_local0:registerEventHandler( "debug_reload", CoD.DrcBase.DebugReload )
	return f3_local0
end

CoD.DrcBase.new = function ( f5_arg0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self.updateBlur = CoD.DrcBase.UpdateBlur
	self.m_ownerController = 0
	self.debugName = f5_arg0
	self.menuName = f5_arg0
	self:registerEventHandler( "debug_reload", CoD.DrcBase.DebugReload )
	if CoD.isPC and CoD.useMouse then
		self:addElement( LUI.UIMouseCursor.new( {
			material = RegisterMaterial( "ui_cursor" )
		} ) )
	end
	return self
end

