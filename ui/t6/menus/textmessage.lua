require( "T6.Menus.TextMessageHome" )
require( "T6.Menus.TextMessageEdit" )

CoD.TextMessage = {}
CoD.TextMessage.UpdatePromptButtonVis = function ( f1_arg0 )
	f1_arg0.parentMenu.leftButtonPromptBar:removeAllChildren()
	f1_arg0.parentMenu.rightButtonPromptBar:removeAllChildren()
	f1_arg0.mainElement:updatePromptButtonVis()
end

local f0_local0 = function ( f2_arg0, f2_arg1 )
	if f2_arg0.mainElement ~= nil then
		f2_arg0:removeElement( f2_arg0.mainElement )
	end
	if f2_arg1 == true or f2_arg0.editElement == nil then
		f2_arg0.editElement = CoD.TextMessageEdit.CreateEditElement( f2_arg0 )
	end
	f2_arg0.mainElement = f2_arg0.editElement
	f2_arg0:addElement( f2_arg0.editElement )
	f2_arg0:updatePromptButtonVis()
	return f2_arg0.mainElement
end

local f0_local1 = function ( f3_arg0 )
	if f3_arg0.mainElement ~= nil then
		f3_arg0:removeElement( f3_arg0.mainElement )
	end
	if createNew == true or f3_arg0.homeElement == nil then
		f3_arg0.homeElement = CoD.TextMessageHome.CreateHomeElement( f3_arg0 )
	end
	f3_arg0.mainElement = f3_arg0.homeElement
	f3_arg0:addElement( f3_arg0.homeElement )
	f3_arg0:updatePromptButtonVis()
	return f3_arg0.mainElement
end

local f0_local2 = function ( f4_arg0, f4_arg1 )
	if f4_arg0.homeElement ~= nil then
		f4_arg0.homeElement:updateMessages()
	end
end

CoD.TextMessage.CreateRootTextMessageElement = function ( menu, controller )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 30, -30 )
	self.parentMenu = menu
	self.updatePromptButtonVis = CoD.TextMessage.UpdatePromptButtonVis
	self.switchToHomeElement = f0_local1
	self.switchToEditElement = f0_local0
	self:registerEventHandler( "text_messages_changed", f0_local2 )
	self:switchToHomeElement()
	return self
end

