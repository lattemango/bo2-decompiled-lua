require( "T6.Menus.TextMessageFriendsPopup" )

CoD.TextMessageEdit = {}
CoD.TextMessageEdit.ToSectionHeight = 100
CoD.TextMessageEdit.BodySectionHeight = 300
CoD.TextMessageEdit.ListWidth = 120
CoD.TextMessageEdit.WorkingWidth = 850
CoD.TextMessageEdit.Padding = 10
local f0_local0 = function ( f1_arg0, f1_arg1 )
	f1_arg0.textElement:setText( f1_arg1 )
	f1_arg0.text = f1_arg1
end

local f0_local1 = function ()
	local self = LUI.UIElement.new()
	self.background = LUI.UIImage.new( {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.2
	} )
	self.background:setLeftRight( true, true, 0, 0 )
	self.background:setTopBottom( true, true, 0, 0 )
	self.background:registerAnimationState( "show", {
		alpha = 0.6
	} )
	self.background:registerAnimationState( "hide", {
		alpha = 0.2
	} )
	self:addElement( self.background )
	self.textElement = LUI.UIText.new( {
		font = CoD.fonts.Default,
		alpha = 1
	} )
	self.textElement:setLeftRight( true, true, 10, -10 )
	self.textElement:setTopBottom( true, false, 10, 10 + CoD.textSize.Default )
	self.textElement:setAlignment( LUI.Alignment.Left )
	self:addElement( self.textElement )
	self.setText = f0_local0
	self:setTopBottom( true, true, 0, 0 )
	self:setLeftRight( true, true, 0, 0 )
	return self
end

function SelectableTextBox_GainFocusButtonOverride( f3_arg0, f3_arg1 )
	CoD.CoD9Button.GainFocus( f3_arg0, f3_arg1 )
	f3_arg0.selectableTextBoxLink.background:animateToState( "show" )
end

function SelectableTextBox_LoseFocusButtonOverride( f4_arg0, f4_arg1 )
	CoD.CoD9Button.LoseFocus( f4_arg0, f4_arg1 )
	f4_arg0.selectableTextBoxLink.background:animateToState( "hide" )
end

function SelectableTextBox_LinkCoD9Button( f5_arg0, f5_arg1 )
	f5_arg1.selectableTextBoxLink = f5_arg0
	f5_arg1:registerEventHandler( "gain_focus", SelectableTextBox_GainFocusButtonOverride )
	f5_arg1:registerEventHandler( "lose_focus", SelectableTextBox_LoseFocusButtonOverride )
end

function TextMessageEdit_GetToText( f6_arg0 )
	local f6_local0 = ""
	for f6_local4, f6_local5 in pairs( f6_arg0 ) do
		f6_local0 = f6_local0 .. f6_local4 .. "; "
	end
	return f6_local0
end

function TextMessageEdit_CustomButton( f7_arg0, f7_arg1, f7_arg2, f7_arg3 )
	local f7_local0 = CoD.CoD9Button.new( {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f7_arg3,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f7_arg2
	} )
	f7_local0.hintText = f7_arg1
	f7_local0:removeElement( f7_local0.label )
	local self = LUI.UIText.new( {
		leftAnchor = false,
		rightAnchor = true,
		left = 0,
		right = -(f7_arg3 - CoD.TextMessageEdit.ListWidth) - 10,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.TextHeight,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	} )
	f7_local0.label = self
	CoD.CoD9Button.SetupTextElement( self )
	f7_local0:addElement( self )
	f7_local0:setLabel( f7_arg0 )
	return f7_local0
end

local f0_local2 = function ( f8_arg0 )
	f8_arg0.toTextBox:setText( TextMessageEdit_GetToText( f8_arg0.selectedFriends ) )
end

CoD.TextMessageEdit.RecipientPopup = function ( f9_arg0, f9_arg1 )
	local f9_local0 = f9_arg0.ownerElement.parentMenu:openPopup( "TextMessageFriendsPopup", f9_arg1.controller )
	f9_local0:init( f9_arg0.selectedFriends, f0_local2, f9_arg0 )
end

CoD.TextMessageEdit.EditBody = function ( f10_arg0, f10_arg1 )
	Engine.WiiUKeyboardSetDefaultText( f10_arg0.bodyTextBox.text )
	Engine.Exec( f10_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_TEXT_MESSAGE )
end

CoD.TextMessageEdit.TextChanged = function ( f11_arg0, f11_arg1 )
	f11_arg0.bodyTextBox:setText( f11_arg1.input )
end

local f0_local3 = function ( f12_arg0, f12_arg1, f12_arg2 )
	f12_arg0.selectedFriends[f12_arg1] = f12_arg2
	f12_arg0.toTextBox:setText( TextMessageEdit_GetToText( f12_arg0.selectedFriends ) )
end

local f0_local4 = function ( f13_arg0 )
	local f13_local0 = f13_arg0.ownerElement.parentMenu
	f13_local0:addRightButtonPrompt( f13_arg0.backButton )
	f13_local0:addRightButtonPrompt( f13_arg0.selectButton )
	f13_local0:addRightButtonPrompt( f13_arg0.sendButton )
end

local f0_local5 = function ( f14_arg0 )
	f14_arg0.ownerElement:switchToHomeElement()
end

local f0_local6 = function ( f15_arg0 )
	local f15_local0 = f15_arg0.bodyTextBox.text
	Engine.BeginSendTextMessage( f15_arg0.controller )
	for f15_local4, f15_local5 in pairs( f15_arg0.selectedFriends ) do
		Engine.AddTextMessageRecipient( f15_arg0.controller, f15_local5 )
	end
	Engine.EndSendTextMessage( f15_arg0.controller, f15_local0 )
	f15_arg0.ownerElement:switchToHomeElement()
end

CoD.TextMessageEdit.CreateEditElement = function ( f16_arg0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, true, 0, 0 )
	self.ownerElement = f16_arg0
	self.controller = f16_arg0.parentMenu:getOwner()
	self.selectedFriends = {}
	local f16_local1 = CoD.ButtonList.new()
	self.buttonList = f16_local1
	f16_local1:setLeftRight( true, false, 0, CoD.TextMessageEdit.ListWidth )
	f16_local1:setTopBottom( true, true, CoD.TextMessageEdit.Padding, 0 )
	local f16_local2 = CoD.CoD9Button.Height
	local f16_local3 = CoD.TextMessageEdit.WorkingWidth - CoD.TextMessageEdit.ListWidth
	local f16_local4 = TextMessageEdit_CustomButton( Engine.Localize( "PLATFORM_UI_TM_TO" ), Engine.Localize( "PLATFORM_UI_TM_TO_HINT" ), CoD.TextMessageEdit.ToSectionHeight, CoD.TextMessageEdit.WorkingWidth )
	f16_local4:setActionEventName( "recipientPopup" )
	f16_local1:addCustomButton( f16_local4 )
	f16_local1:addSpacer( CoD.TextMessageEdit.Padding )
	self.toButton = f16_local4
	local f16_local5 = TextMessageEdit_CustomButton( Engine.Localize( "PLATFORM_UI_TM_MESSAGE" ), Engine.Localize( "PLATFORM_UI_TM_MESSAGE_HINT" ), CoD.TextMessageEdit.BodySectionHeight, CoD.TextMessageEdit.WorkingWidth )
	f16_local5:setActionEventName( "editBody" )
	f16_local1:addCustomButton( f16_local5 )
	f16_local1:addSpacer( CoD.TextMessageEdit.Padding )
	self.bodyButton = f16_local5
	local f16_local6 = f0_local1()
	f16_local6:setText( "Sample To Text" )
	f16_local6:setLeftRight( true, true, 0, 0 )
	f16_local6:setTopBottom( true, false, 0, CoD.TextMessageEdit.ToSectionHeight )
	SelectableTextBox_LinkCoD9Button( f16_local6, f16_local4 )
	
	local bodyTextBox = f0_local1()
	bodyTextBox:setText( "" )
	bodyTextBox:setLeftRight( true, true, 0, 0 )
	bodyTextBox:setTopBottom( true, false, 0, CoD.TextMessageEdit.BodySectionHeight )
	SelectableTextBox_LinkCoD9Button( bodyTextBox, f16_local5 )
	local f16_local8 = LUI.UIVerticalList.new()
	f16_local8:setTopBottom( true, true, CoD.TextMessageEdit.Padding, 0 )
	f16_local8:setLeftRight( true, false, CoD.TextMessageEdit.ListWidth, CoD.TextMessageEdit.ListWidth + f16_local3 )
	f16_local8:addElement( f16_local6 )
	f16_local8:addSpacer( CoD.TextMessageEdit.Padding )
	f16_local8:addElement( bodyTextBox )
	self.bodyTextBox = bodyTextBox
	
	self.toTextBox = f16_local6
	self:addElement( f16_local1 )
	self:addElement( f16_local8 )
	self.backButton = CoD.ButtonPrompt.new( "secondary", Engine.Localize( "MENU_BACK" ), f16_arg0.parentMenu, "button_prompt_tm_back" )
	self.selectButton = CoD.ButtonPrompt.new( "primary", Engine.Localize( "PLATFORM_UI_TM_SELECT" ) )
	self.sendButton = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "PLATFORM_UI_TM_SEND" ), f16_arg0.parentMenu, "button_prompt_send" )
	self:registerEventHandler( "button_prompt_tm_back", f0_local5 )
	self:registerEventHandler( "button_prompt_send", f0_local6 )
	self.updatePromptButtonVis = f0_local4
	self.setReplyRecipient = f0_local3
	f16_local1:processEvent( {
		name = "gain_focus"
	} )
	self:registerEventHandler( "recipientPopup", CoD.TextMessageEdit.RecipientPopup )
	self:registerEventHandler( "editBody", CoD.TextMessageEdit.EditBody )
	self:registerEventHandler( "ui_keyboard_input", CoD.TextMessageEdit.TextChanged )
	return self
end

