require( "T6.CardCarouselList" )
require( "T6.Menus.FileActionPopup" )
require( "T6.Menus.FileshareManager" )

if CoD.isZombie == false then
	require( "T6.Menus.FileshareReport" )
end
require( "T6.Menus.FileshareSave" )
require( "T6.Menus.FileshareVote" )
require( "T6.Menus.FilesharePopup" )
require( "T6.ScrollableTextContainer" )
CoD.Codtv = {}
CoD.Codtv.WebMPlayback = nil
CoD.Codtv.WebMPlaybackMaterial = "webm_720p_10"
CoD.Codtv.ItemWidth = 192
CoD.Codtv.ItemHeight = 146
CoD.Codtv.HighlightedItemWidth = 345.6
CoD.Codtv.HighligtedItemHeight = 230.4
CoD.Codtv.AutoPlayRetryDelay = 3000
CoD.Codtv.ThumbnailDownloadCheckInterval = 200
CoD.Codtv.ThumbnailsDownloaded = false
CoD.Codtv.DWContentLoadDelay = 100
CoD.Codtv.CardContentAnimDelay = 100
CoD.Codtv.InfoPanelTop = 250
CoD.Codtv.InfoPanelLeft = 350
CoD.Codtv.InfoPanelHeight = 300
CoD.Codtv.InfoPanelWidth = 520
CoD.Codtv.InfoPanelMovement = 30
CoD.Codtv.InfoPanelOutDelay = 50
CoD.Codtv.InfoPanelInDelay = 200
CoD.Codtv.EmblemLarge = 210
CoD.Codtv.EmblemSmall = 128
CoD.Codtv.CardsPerPage = 10
CoD.Codtv.MaxWebMMaterials = 8
CoD.Codtv.StoreDescriptionContainerWidth = CoD.Codtv.InfoPanelWidth - 25
CoD.Codtv.StoreDescriptionContainerHeight = 125
CoD.Codtv.ScrollableTextPauseTime = 5000
CoD.Codtv.ScrollableTextPerLineScrollTime = 2000
CoD.Codtv.INVALID_MTX_ID = -1
CoD.Codtv.CardSelected = function ( f1_arg0, f1_arg1 )
	Engine.PlaySound( "cac_grid_equip_item" )
	if f1_arg0.type == "dwcontent" then
		CoD.Codtv.DWContentCardSelected( f1_arg0, f1_arg1 )
	elseif f1_arg0.type == "video" then
		CoD.Codtv.VideoCardSelected( f1_arg0, f1_arg1 )
	elseif f1_arg0.type == "folder" then
		CoD.Codtv.FolderCardSelected( f1_arg0, f1_arg1 )
	elseif f1_arg0.type == "dwfolder" then
		CoD.Codtv.DWFolderCardSelected( f1_arg0, f1_arg1 )
	elseif f1_arg0.type == "dwfolder_next" or f1_arg0.type == "dwfolder_prev" then
		CoD.Codtv.DWFolderCardNextPrevSelected( f1_arg0, f1_arg1 )
	elseif f1_arg0.type == "custombutton" then
		CoD.Codtv.CustomButtonCardSelected( f1_arg0, f1_arg1 )
	end
end

CoD.Codtv.CardGainFocus = function ( f2_arg0, f2_arg1 )
	if f2_arg0.codtv ~= nil then
		f2_arg0.codtv.hintText:updateHintText( "" )
		f2_arg0.codtv.infoPanel:removeAllChildren()
		if f2_arg0.codtv.codtvIcon ~= nil and CoD.Codtv.ShowCODTVIcon( f2_arg0.codtv ) then
			f2_arg0.codtv.codtvIcon:setAlpha( 1 )
		end
	end
	if f2_arg0.type == "dwcontent" then
		CoD.Codtv.DWContentCardGainFocus( f2_arg0, f2_arg1 )
	elseif f2_arg0.type == "video" then
		CoD.Codtv.VideoCardGainFocus( f2_arg0, f2_arg1 )
	elseif f2_arg0.type == "folder" then
		CoD.Codtv.FolderCardGainFocus( f2_arg0, f2_arg1 )
	elseif f2_arg0.type == "dwfolder" then
		CoD.Codtv.DWFolderCardGainFocus( f2_arg0, f2_arg1 )
	elseif f2_arg0.type == "dwfolder_next" or f2_arg0.type == "dwfolder_prev" then
		CoD.Codtv.DWFolderCardNextPrevGainFocus( f2_arg0, f2_arg1 )
	elseif f2_arg0.type == "custombutton" then
		CoD.Codtv.CustomButtonGainFocus( f2_arg0, f2_arg1 )
	end
	CoD.CardCarousel.Card_GainFocus( f2_arg0, f2_arg1 )
end

CoD.Codtv.CardLoseFocus = function ( f3_arg0, f3_arg1 )
	if f3_arg0.type == "dwcontent" then
		CoD.Codtv.DWContentCardLoseFocus( f3_arg0, f3_arg1 )
	elseif f3_arg0.type == "video" then
		CoD.Codtv.VideoCardLoseFocus( f3_arg0, f3_arg1 )
	elseif f3_arg0.type == "folder" then
		CoD.Codtv.FolderCardLoseFocus( f3_arg0, f3_arg1 )
	elseif f3_arg0.type == "dwfolder" then
		CoD.Codtv.DWFolderCardLoseFocus( f3_arg0, f3_arg1 )
	elseif f3_arg0.type == "dwfolder_next" or f3_arg0.type == "dwfolder_prev" then
		CoD.Codtv.DWFolderCardNextPrevLoseFocus( f3_arg0, f3_arg1 )
	end
	if f3_arg0.codtv ~= nil then
		f3_arg0.codtv.hintText:updateHintText( "" )
		f3_arg0.codtv.infoPanel:removeAllChildren()
	end
	CoD.CardCarousel.Card_LoseFocus( f3_arg0, f3_arg1 )
end

CoD.Codtv.GetGenericCard = function ( f4_arg0 )
	local f4_local0 = f4_arg0:addNewCard()
	f4_local0.codtv = f4_arg0.codtv
	f4_local0.container = LUI.UIElement.new()
	f4_local0.container:setLeftRight( true, true, 0, 0 )
	f4_local0.container:setTopBottom( true, true, 0, 0 )
	f4_local0:addElement( f4_local0.container )
	f4_local0.bg = LUI.UIImage.new()
	f4_local0.bg:setLeftRight( true, true, 2, -2 )
	f4_local0.bg:setTopBottom( false, true, -CoD.textSize.Default - 3, -3 )
	f4_local0.bg:setRGB( 0, 0, 0 )
	f4_local0.container:addElement( f4_local0.bg )
	f4_local0.text = LUI.UIText.new()
	f4_local0.text:setLeftRight( true, true, 5, 0 )
	f4_local0.text:setTopBottom( false, true, -CoD.textSize.Default - 3, -3 )
	f4_local0.text:setFont( CoD.fonts.Default )
	f4_local0.text:setAlignment( LUI.Alignment.Left )
	f4_local0.container:addElement( f4_local0.text )
	f4_local0:registerEventHandler( "button_action", CoD.Codtv.CardSelected )
	f4_local0:registerEventHandler( "gain_focus", CoD.Codtv.CardGainFocus )
	f4_local0:registerEventHandler( "lose_focus", CoD.Codtv.CardLoseFocus )
	return f4_local0
end

CoD.Codtv.FolderCardSelected = function ( f5_arg0, f5_arg1 )
	f5_arg0.codtv.m_carouselContext = CoD.CardCarousel.GetCurrentCarouselInfo( f5_arg0 )
	f5_arg0.codtv.m_carouselContext.folderIndex = f5_arg0.codtv.m_currentFolderIndex
	f5_arg0.codtv:reload( f5_arg0.folderIndex )
end

CoD.Codtv.FolderCardGainFocus = function ( f6_arg0, f6_arg1 )
	f6_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f6_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f6_arg0.codtv:addBackButton()
	f6_arg0.codtv:addSelectButton()
end

CoD.Codtv.FolderCardLoseFocus = function ( f7_arg0, f7_arg1 )
	
end

CoD.Codtv.CustomButtonBuyStorageLoad = function ( f8_arg0, f8_arg1 )
	f8_arg0.centerImageContainer:close()
	f8_arg0:setupCenterImage( f8_arg1.imageName, 72, 72, 2, false )
end

CoD.Codtv.CustomButtonNewEmblemLoad = function ( f9_arg0, f9_arg1 )
	f9_arg0.centerImageContainer:close()
	f9_arg0:setupCenterImage( f9_arg1.imageName, 72, 72, 2, false )
end

CoD.Codtv.ShouldLoadCard = function ( f10_arg0, f10_arg1 )
	if f10_arg1.type == "custombutton" and f10_arg1.action == "buystorage" then
		return CoD.FileshareManager.ShouldShowMtx( f10_arg0 )
	else
		return true
	end
end

CoD.Codtv.FolderCardsLoad = function ( f11_arg0, f11_arg1, f11_arg2 )
	for f11_local0 = 1, f11_arg2.subfolderCount, 1 do
		if CoD.Codtv.ShouldLoadCard( f11_arg0, f11_arg2[f11_local0] ) then
			local f11_local3 = CoD.Codtv.GetGenericCard( f11_arg1 )
			f11_local3.text:setText( f11_arg2[f11_local0].name )
			if f11_arg2[f11_local0].imageName ~= nil and f11_arg2[f11_local0].imageType ~= nil and f11_arg2[f11_local0].imageType == "material" then
				f11_local3:setupCenterImage( f11_arg2[f11_local0].imageName, 128, 128, 2, false )
			end
			f11_local3.type = f11_arg2[f11_local0].type
			f11_local3.customAction = f11_arg2[f11_local0].action
			f11_local3.folderIndex = f11_arg2[f11_local0].folderIndex
			f11_local3.parentFolderIndex = f11_arg2[f11_local0].parentFolderIndex
			if f11_local3.type == "custombutton" and f11_local3.customAction ~= nil then
				if f11_local3.customAction == "buystorage" then
					CoD.Codtv.CustomButtonBuyStorageLoad( f11_local3, f11_arg2[f11_local0] )
				end
				if f11_local3.customAction == "newemblem" then
					CoD.Codtv.CustomButtonNewEmblemLoad( f11_local3, f11_arg2[f11_local0] )
				end
			end
		end
	end
end

CoD.Codtv.DWContentCardCanSave = function ( f12_arg0 )
	if f12_arg0.fileData == nil then
		return false
	elseif f12_arg0.fileData.category == "clip" or f12_arg0.fileData.category == "screenshot" or f12_arg0.fileData.category == "film" then
		return true
	else
		return false
	end
end

CoD.Codtv.DWContentCardSave = function ( f13_arg0, f13_arg1 )
	if f13_arg0 ~= nil and f13_arg0.fileData ~= nil and f13_arg0:isInFocus() then
		CoD.perController[f13_arg1.controller].fileshareSaveCategory = f13_arg0.fileData.category
		CoD.perController[f13_arg1.controller].fileshareSaveName = f13_arg0.fileData.name
		CoD.perController[f13_arg1.controller].fileshareSaveDescription = f13_arg0.fileData.description
		CoD.perController[f13_arg1.controller].fileshareSaveIsCopy = true
		CoD.perController[f13_arg1.controller].fileshareSaveFileID = f13_arg0.fileData.fileID
		CoD.perController[f13_arg1.controller].fileshareSaveIsPooled = f13_arg0.fileData.isPooled
		CoD.perController[f13_arg1.controller].fileshareSaveMap = f13_arg0.fileData.map
		CoD.perController[f13_arg1.controller].fileshareZmMapStartLocation = f13_arg0.fileData.zmMapStartLoc
		CoD.perController[f13_arg1.controller].fileshareZmMapStartLocationName = f13_arg0.fileData.zmMapStartLocName
		CoD.perController[f13_arg1.controller].fileshareGameType = f13_arg0.fileData.gameType
		f13_arg0.codtv:openPopup( "FileshareSave", f13_arg1.controller )
	end
end

CoD.Codtv.DWContentCardCanVote = function ( f14_arg0, f14_arg1 )
	local f14_local0 = UIExpression.GetXUID_ull( f14_arg1.controller )
	if f14_local0 ~= nil and f14_local0 == f14_arg0.fileData.authorXuid then
		return false
	elseif f14_arg0.fileData == nil or f14_arg0.fileData.isPooled == true or f14_arg0.fileData.category == "ingamestore" then
		return false
	else
		return true
	end
end

CoD.Codtv.DWContentCardVote = function ( f15_arg0, f15_arg1 )
	if f15_arg0 ~= nil and f15_arg0.fileData ~= nil and f15_arg0.fileData.fileID ~= "0" and f15_arg0:isInFocus() then
		CoD.perController[f15_arg1.controller].voteData = f15_arg0.fileData
		CoD.perController[f15_arg1.controller].voteUpdateTarget = f15_arg0.codtv
		local f15_local0 = f15_arg0.codtv:openPopup( "FileshareVote", f15_arg0.codtv.m_ownerController )
	end
end

CoD.Codtv.DWContentCardCanReport = function ( f16_arg0, f16_arg1 )
	local f16_local0 = UIExpression.GetXUID_ull( f16_arg1.controller )
	if f16_local0 ~= nil and f16_local0 == f16_arg0.fileData.authorXuid then
		return false
	elseif f16_arg0.fileData == nil or f16_arg0.fileData.isPooled == true or f16_arg0.fileData.category ~= "emblem" then
		return false
	else
		return true
	end
end

CoD.Codtv.DWContentCardReport = function ( f17_arg0, f17_arg1 )
	if f17_arg0 ~= nil and f17_arg0.fileData ~= nil and f17_arg0.fileData.fileID ~= "0" and f17_arg0:isInFocus() then
		CoD.perController[f17_arg1.controller].reportData = f17_arg0.fileData
		local f17_local0 = f17_arg0.codtv:openPopup( "FileshareReport", f17_arg0.codtv.m_ownerController )
	end
end

CoD.Codtv.DWFolderCardEmblemSelected = function ( f18_arg0, f18_arg1 )
	if f18_arg0.fileData == nil or f18_arg0.fileData.fileID == nil then
		return 
	else
		f18_arg0.codtv.m_previousFolderIndex = nil
		if Engine.IsFeatureBanned( CoD.FEATURE_BAN_EMBLEM_EDITOR ) then
			Engine.ExecNow( f18_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_EMBLEM_EDITOR )
			return 
		else
			CoD.perController[f18_arg1.controller].emblemSaveSlot = f18_arg0.fileData.slot
			CoD.perController[f18_arg1.controller].emblemFileID = f18_arg0.fileData.fileID
			Engine.ExecNow( controller, "emblemLoadFromFile " .. f18_arg0.fileData.fileID )
			f18_arg0.codtv:openMenu( "EmblemEditor", f18_arg1.controller )
			CoD.Codtv.Shutdown()
			f18_arg0.codtv:close()
		end
	end
end

CoD.Codtv.DWFolderCardLeagueIDSelected = function ( f19_arg0, f19_arg1 )
	if f19_arg0.fileData == nil or f19_arg0.fileData.fileID == nil then
		return 
	else
		Engine.Exec( controller, "emblemSetLeagueIdentity " .. f19_arg0.fileData.fileID .. " " .. CoD.LeaguesData.CurrentTeamInfo.teamID )
		CoD.Codtv.Shutdown()
		f19_arg0.codtv:goBack( f19_arg1.controller )
	end
end

CoD.EmblemOptions = {}
LUI.createMenu.EmblemSetIdentityConfirmation = function ( f20_arg0 )
	local f20_local0 = CoD.Popup.SetupPopup( "popup_chatrestricted", f20_arg0 )
	f20_local0.title:setText( Engine.Localize( "MENU_NOTICE" ) )
	f20_local0.msg:setText( Engine.Localize( "MENU_EMBLEM_IDENTITY_SET" ) )
	f20_local0.anyControllerAllowed = true
	f20_local0.primaryButton = CoD.ButtonPrompt.new( "primary", Engine.Localize( "MENU_OK" ), f20_local0, "emblem_set_identity_accept" )
	f20_local0:addLeftButtonPrompt( f20_local0.primaryButton )
	f20_local0:registerEventHandler( "emblem_set_identity_accept", CoD.EmblemOptions.SetIdentityAccept )
	return f20_local0
end

CoD.EmblemOptions.SetIdentityAccept = function ( f21_arg0, f21_arg1 )
	local f21_local0 = f21_arg0.occludedMenu
	f21_arg0:goBack( f21_arg1.controller )
	f21_local0:goBack( f21_arg1.controller )
end

CoD.EmblemOptions.SetIdentity = function ( f22_arg0, f22_arg1 )
	Engine.Exec( f22_arg1.controller, "emblemSetIdentity " .. f22_arg0.m_fileID )
	f22_arg0:openPopup( "EmblemSetIdentityConfirmation", f22_arg1.controller )
end

CoD.EmblemOptions.CreateCopy = function ( f23_arg0, f23_arg1 )
	if f23_arg0.m_fileID ~= nil and f23_arg0.m_fileID ~= "0" and f23_arg0.m_nextSlot ~= nil then
		f23_arg0:openPopup( "Fileshare_BusyPopup", f23_arg1.controller, {
			title = Engine.Localize( "MENU_EMBLEM_COPY" ),
			message = Engine.Localize( "MENU_EMBLEM_COPY_WAIT" ),
			successNotice = Engine.Localize( "MENU_EMBLEM_COPY_SUCCESS" ),
			failureNotice = Engine.Localize( "MENU_EMBLEM_COPY_FAILURE" ),
			actionCommand = "fileshareCopy " .. f23_arg0.m_fileID .. " 0 " .. f23_arg0.m_nextSlot,
			completionEvent = "fileshare_upload_complete",
			completionNotification = "delete_done"
		} )
	end
end

CoD.EmblemOptions.Delete = function ( f24_arg0, f24_arg1 )
	f24_arg0:openPopup( "Fileshare_ConfirmationPopup", f24_arg1.controller, {
		title = Engine.Localize( "MENU_EMBLEM_DELETE" ),
		message = Engine.Localize( "MENU_EMBLEM_DELETE_WAIT" ),
		confirmationTitle = Engine.Localize( "MENU_EMBLEM_DELETE" ),
		confirmationMessage = Engine.Localize( "MENU_EMBLEM_DELETE_CONFIRMATION" ),
		successNotice = Engine.Localize( "MENU_EMBLEM_DELETE_SUCCESS" ),
		failureNotice = Engine.Localize( "MENU_EMBLEM_DELETE_FAILURE" ),
		actionCommand = "fileshareDelete " .. f24_arg0.m_fileID,
		completionEvent = "fileshare_delete_slot_done",
		completionNotification = "delete_done"
	} )
end

CoD.EmblemOptions.DeleteDone = function ( f25_arg0, f25_arg1 )
	f25_arg0:goBack( f25_arg1.controller )
end

LUI.createMenu.EmblemOptions = function ( f26_arg0 )
	local f26_local0 = CoD.Menu.NewMediumPopup( "EmblemOptions" )
	f26_local0:setOwner( f26_arg0 )
	f26_local0.m_fileID = CoD.perController[f26_arg0].emblemOptionsFileID
	f26_local0.m_slotsRemaining = CoD.perController[f26_arg0].emblemOptionsSlotsRemaining
	f26_local0.m_nextSlot = CoD.perController[f26_arg0].emblemOptionsNextSlot
	f26_local0:addSelectButton()
	f26_local0:addBackButton()
	f26_local0:registerEventHandler( "emblem_set_identity", CoD.EmblemOptions.SetIdentity )
	f26_local0:registerEventHandler( "emblem_create_copy", CoD.EmblemOptions.CreateCopy )
	f26_local0:registerEventHandler( "emblem_delete", CoD.EmblemOptions.Delete )
	f26_local0:registerEventHandler( "delete_done", CoD.EmblemOptions.DeleteDone )
	local f26_local1 = 5
	local self = LUI.UIText.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, f26_local1, f26_local1 + CoD.textSize.Big )
	self:setFont( CoD.fonts.Big )
	self:setAlignment( LUI.Alignment.Left )
	self:setText( Engine.Localize( "MENU_EMBLEM_OPTIONS_CAPS" ) )
	f26_local0:addElement( self )
	f26_local1 = f26_local1 + CoD.textSize.Big + 70
	local f26_local3 = CoD.ButtonList.new( {} )
	f26_local3:setLeftRight( true, false, 0, 500 )
	f26_local3:setTopBottom( true, true, f26_local1, 0 )
	f26_local0:addElement( f26_local3 )
	local f26_local4 = f26_local3:addButton( Engine.Localize( "MENU_EMBLEM_SET_IDENTITY" ), Engine.Localize( "MENU_EMBLEM_SET_IDENTITY_HINT" ) )
	f26_local4:setActionEventName( "emblem_set_identity" )
	f26_local4:processEvent( {
		name = "gain_focus"
	} )
	if f26_local0.m_slotsRemaining == 0 then
		local f26_local5 = f26_local3:addButton( Engine.Localize( "MENU_EMBLEM_CREATE_COPY" ), Engine.Localize( "MENU_EMBLEM_COPY_NOT_ALLOWED_HINT" ) )
		f26_local5:disable()
	else
		local f26_local5 = f26_local3:addButton( Engine.Localize( "MENU_EMBLEM_CREATE_COPY" ), Engine.Localize( "MENU_EMBLEM_COPY_ALLOWED_HINT" ) )
		f26_local5:setActionEventName( "emblem_create_copy" )
	end
	local f26_local5 = f26_local3:addButton( Engine.Localize( "MENU_DELETE_CAPS" ), Engine.Localize( "MENU_EMBLEM_DELETE_HINT" ) )
	f26_local5:setActionEventName( "emblem_delete" )
	f26_local3:addSpacer( CoD.CoD9Button.Height * 2 )
	local f26_local6 = LUI.UIImage.new()
	f26_local6:setLeftRight( false, true, -306, -50 )
	f26_local6:setTopBottom( true, false, 70, 326 )
	f26_local6:setupImageViewer( CoD.UI_SCREENSHOT_TYPE_EMBLEM, f26_local0.m_fileID )
	f26_local0:addElement( f26_local6 )
	return f26_local0
end

CoD.StorePurchaseConfirmation = {}
CoD.StorePurchaseConfirmation.AButtonText = function ( f27_arg0 )
	if f27_arg0.isOfferPurchased ~= nil and f27_arg0.isOfferPurchased == 1 then
		f27_arg0.selectButton:setText( Engine.Localize( "MENU_STORE_DOWNLOAD" ) )
	else
		f27_arg0.selectButton:setText( Engine.Localize( "MENU_STORE_BUY" ) )
	end
end

CoD.StorePurchaseConfirmation.AButtonPressed = function ( f28_arg0, f28_arg1 )
	if f28_arg0.isOfferPurchased == 1 then
		Engine.ExecNow( f28_arg1.controller, "downloadSelectedOffer " .. f28_arg0.offerid .. " " .. f28_arg0.storeContentType )
	else
		Engine.ExecNow( f28_arg1.controller, "purchaseSelectedOffer " .. f28_arg0.offerid .. " " .. f28_arg0.storeContentType )
	end
	f28_arg0:goBack( f28_arg1.controller )
end

LUI.createMenu.StorePurchaseConfirmation = function ( f29_arg0 )
	local f29_local0 = CoD.Menu.New( "StorePurchaseConfirmation" )
	f29_local0:setOwner( f29_arg0 )
	f29_local0.unusedControllerAllowed = true
	f29_local0:registerEventHandler( "button_select_prompt", CoD.StorePurchaseConfirmation.AButtonPressed )
	f29_local0:addLargePopupBackground()
	f29_local0.isOfferPurchased = CoD.perController[f29_arg0].isofferpurchased
	f29_local0.folderIndex = CoD.perController[f29_arg0].folderIndex
	f29_local0.startIndex = CoD.perController[f29_arg0].startIndex
	f29_local0.offerid = CoD.perController[f29_arg0].offerid
	f29_local0.storeContentType = CoD.perController[f29_arg0].storeContentType
	f29_local0:addSelectButton( nil, nil, "button_select_prompt" )
	f29_local0:addBackButton()
	CoD.StorePurchaseConfirmation.AButtonText( f29_local0 )
	local f29_local1 = 0
	local self = LUI.UIText.new()
	self:setLeftRight( true, true, 0, 0 )
	self:setTopBottom( true, false, f29_local1, f29_local1 + CoD.textSize.Big )
	self:setFont( CoD.fonts.Big )
	self:setAlignment( LUI.Alignment.Left )
	self:setText( Engine.Localize( "MENU_PURCHASE_CONFIRMAITON" ) )
	f29_local0:addElement( self )
	f29_local1 = f29_local1 + CoD.textSize.Big + 20
	local f29_local3 = LUI.UIText.new()
	f29_local3:setLeftRight( true, true, 0, 0 )
	f29_local3:setTopBottom( true, false, f29_local1, f29_local1 + CoD.textSize.ExtraSmall )
	f29_local3:setFont( CoD.fonts.ExtraSmall )
	f29_local3:setAlignment( LUI.Alignment.Left )
	f29_local3:setupUITextUncached()
	f29_local3:setText( CoD.perController[f29_arg0].longDescription )
	f29_local0:addElement( f29_local3 )
	local f29_local4 = LUI.UIImage.new()
	f29_local4:setLeftRight( false, true, -128, 0 )
	f29_local4:setTopBottom( false, true, -62, -30 )
	f29_local4:setImage( RegisterMaterial( "playstation_store_ingame_logo" ) )
	f29_local0:addElement( f29_local4 )
	return f29_local0
end

CoD.Codtv.GetSelectedCard = function ( f30_arg0 )
	local f30_local0 = f30_arg0.m_cardCarouselList.cardCarousels[f30_arg0.m_cardCarouselList.m_currentCardCarouselIndex]
	if f30_local0 ~= nil then
		return f30_local0.horizontalList.cards[f30_local0.horizontalList.m_currentCardIndex]
	else
		return nil
	end
end

CoD.Codtv.EmblemOptions = function ( f31_arg0, f31_arg1 )
	local f31_local0 = CoD.Codtv.GetSelectedCard( f31_arg0 )
	if f31_local0 ~= nil and f31_local0.fileData ~= nil and f31_local0.fileData.category == "emblem" then
		CoD.perController[f31_arg1.controller].emblemOptionsFileID = f31_local0.fileData.fileID
		CoD.perController[f31_arg1.controller].emblemOptionsSlotsRemaining = f31_arg0.m_emblemSlotsRemaining
		CoD.perController[f31_arg1.controller].emblemOptionsNextSlot = f31_arg0.m_embemNextSlot
		f31_arg0:openMenu( "EmblemOptions", f31_arg1.controller )
		f31_arg0:close()
	end
end

CoD.Codtv.StorePurchaseConfirmation = function ( f32_arg0, f32_arg1 )
	local f32_local0 = CoD.Codtv.GetSelectedCard( f32_arg0 )
	if f32_local0 ~= nil and f32_local0.fileData ~= nil and f32_local0.fileData.category == "ingamestore" then
		CoD.perController[f32_arg1.controller].isofferpurchased = f32_local0.fileData.isOfferPurchased
		CoD.perController[f32_arg1.controller].longDescription = f32_local0.fileData.longDescription
		CoD.perController[f32_arg1.controller].folderIndex = f32_local0.fileData.folderIndex
		CoD.perController[f32_arg1.controller].startIndex = f32_local0.fileData.startIndex
		CoD.perController[f32_arg1.controller].offerid = f32_local0.fileData.offerid
		CoD.perController[f32_arg1.controller].storeContentType = f32_local0.fileData.storeContentType
		f32_arg0:openPopup( "StorePurchaseConfirmation", f32_arg1.controller )
	end
end

CoD.Codtv.IngameStoreSelectButtonPressed = function ( f33_arg0, f33_arg1 )
	if CoD.isPS3 then
		f33_arg0.codtv:processEvent( {
			name = "store_purchase_confirmation",
			controller = f33_arg1.controller
		} )
	else
		Engine.ExecNow( f33_arg1.controller, "downloadSelectedOffer " .. f33_arg0.fileData.offerid .. " " .. f33_arg0.fileData.storeContentType )
	end
end

CoD.Codtv.DWContentCardSelected = function ( f34_arg0, f34_arg1 )
	if f34_arg0.codtv.m_rootRef == "ingamestore" then
		CoD.Codtv.IngameStoreSelectButtonPressed( f34_arg0, f34_arg1 )
	elseif f34_arg0.codtv.m_rootRef == "emblems" and f34_arg0.emblemDownloaded == true then
		CoD.Codtv.DWFolderCardEmblemSelected( f34_arg0, f34_arg1 )
	elseif f34_arg0.codtv.m_rootRef == "leagueidentity" then
		CoD.Codtv.DWFolderCardLeagueIDSelected( f34_arg0, f34_arg1 )
	elseif f34_arg0.codtv.m_rootRef == "combatrecord" then
		Engine.SetCombatRecordScreenshotInfo( f34_arg1.controller, f34_arg0.fileData.fileID, f34_arg0.fileData.summarySize, f34_arg0.fileData.name )
		f34_arg0:dispatchEventToParent( {
			name = "button_prompt_back",
			controller = f34_arg1.controller
		} )
	elseif f34_arg0.fileData.category == "customgame" then
		if UIExpression.GameMode_IsMode( f34_arg1.controller, CoD.GAMEMODE_PRIVATE_MATCH ) == 1 then
			if UIExpression.GameHost() == 1 then
				Engine.Exec( f34_arg1.controller, "gamesettings_download " .. f34_arg0.fileData.fileID .. " " .. f34_arg0.fileData.gameType )
				Dvar.fshCustomGameName:set( f34_arg0.fileData.name )
				f34_arg0.codtv:setPreviousMenu( nil )
				f34_arg0.codtv:goBack( f34_arg1.controller )
			else
				Dvar.ui_errorTitle:set( Engine.Localize( "MENU_NOTICE_CAPS" ) )
				Dvar.ui_errorMessage:set( Engine.Localize( "MENU_FILESHARE_ONLY_HOST_ALLOWED_TO_LOAD" ) )
				CoD.Menu.OpenErrorPopup( f34_arg0.codtv, f34_arg1 )
			end
		else
			f34_arg0.codtv:openPopup( "LoadCustomGames", f34_arg1.controller, {
				fileID = f34_arg0.fileData.fileID,
				gameType = f34_arg0.fileData.gameType,
				fileName = f34_arg0.fileData.name
			} )
		end
	elseif f34_arg0.fileData.category ~= "emblem" and f34_arg0 ~= nil and f34_arg0.fileData ~= nil and f34_arg0.fileData.fileID ~= nil and f34_arg0.fileData.fileID ~= "0" then
		local f34_local0 = f34_arg0.cardCarousel.cardCarouselList:getParent()
		local f34_local1 = {
			controller = f34_arg1.controller,
			fileid = f34_arg0.fileData.fileID,
			category = f34_arg0.fileData.category,
			filesize = f34_arg0.fileData.fileSize,
			map = f34_arg0.fileData.map,
			matchID = f34_arg0.fileData.matchID,
			zmmapstartloc = f34_arg0.fileData.zmMapStartLoc,
			gametype = f34_arg0.fileData.gameType,
			authorXUID = f34_arg0.fileData.authorXUID,
			duration = f34_arg0.fileData.durationInt,
			isPooled = f34_arg0.fileData.isPooled,
			name = f34_arg0.fileData.name,
			description = f34_arg0.fileData.description,
			targetCarousel = f34_arg0.cardCarousel.cardCarouselList
		}
		CoD.perController[f34_arg1.controller].fileActionInfo = f34_arg0.fileData
		CoD.FileAction.Open( f34_local0, f34_local1 )
	end
end

CoD.Codtv.InGameStoreUpdateAButtonPromptString = function ( f35_arg0, f35_arg1 )
	if f35_arg0.fileData.category == "ingamestore" and not CoD.isPS3 then
		local f35_local0 = Engine.IsOfferPurchased( f35_arg1.controller, f35_arg0.fileData.offerid, f35_arg0.fileData.storeContentType )
		if f35_local0 ~= nil and f35_local0 == 1 then
			f35_arg0.codtv.selectButton:setText( Engine.Localize( "MENU_STORE_DOWNLOAD" ) )
		else
			f35_arg0.codtv.selectButton:setText( Engine.Localize( "MENU_STORE_BUY" ) )
		end
	end
end

CoD.Codtv.DWContentCardGainFocus = function ( f36_arg0, f36_arg1 )
	if f36_arg0.cardName ~= nil then
		f36_arg0.cardName:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
	end
	if f36_arg0.durationText ~= nil then
		f36_arg0.durationText:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
	end
	if f36_arg0.codtv ~= nil and f36_arg0.fileData ~= nil then
		CoD.Codtv.ShowFileInfoPanel( f36_arg0 )
	end
	f36_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f36_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f36_arg0.codtv:addBackButton()
	if CoD.Codtv.DWContentCardCanVote( f36_arg0, f36_arg1 ) and f36_arg0.codtv.voteButtonPrompt then
		f36_arg0.codtv:addRightButtonPrompt( f36_arg0.codtv.voteButtonPrompt )
	end
	if CoD.Codtv.DWContentCardCanSave( f36_arg0 ) and f36_arg0.codtv.saveButtonPrompt then
		f36_arg0.codtv:addRightButtonPrompt( f36_arg0.codtv.saveButtonPrompt )
	end
	if CoD.Codtv.DWContentCardCanReport( f36_arg0, f36_arg1 ) and f36_arg0.codtv.reportButtonPrompt then
		f36_arg0.codtv:addRightButtonPrompt( f36_arg0.codtv.reportButtonPrompt )
	end
	if f36_arg0.fileData ~= nil then
		if f36_arg0.codtv.m_rootRef == "emblems" or f36_arg0.codtv.m_rootRef == "leagueidentity" or f36_arg0.fileData.category ~= "emblem" then
			f36_arg0.codtv:addSelectButton()
		end
		CoD.Codtv.InGameStoreUpdateAButtonPromptString( f36_arg0, f36_arg1 )
		if f36_arg0.fileData.category == "customgame" and f36_arg0.fileData.gameType ~= nil then
			f36_arg0.mapImage:setLeftRight( false, false, -80, 80 )
			f36_arg0.mapImage:setTopBottom( false, false, -80, 80 )
		end
		if f36_arg0.fileData.category == "emblem" and f36_arg0.codtv.m_rootRef == "emblems" then
			f36_arg0.codtv:addRightButtonPrompt( f36_arg0.codtv.emblemOptionsPrompt )
			f36_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_DEFAULT_EMBLEM_DESCRIPTION" ) )
		end
	end
end

CoD.Codtv.DWContentCardLoseFocus = function ( f37_arg0, f37_arg1 )
	if f37_arg0.cardName ~= nil then
		f37_arg0.cardName:setRGB( 1, 1, 1 )
	end
	if f37_arg0.durationText ~= nil then
		f37_arg0.durationText:setRGB( 1, 1, 1 )
	end
	f37_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f37_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f37_arg0.codtv:addBackButton()
	if f37_arg0.fileData ~= nil and f37_arg0.fileData.category == "customgame" and f37_arg0.fileData.gameType ~= nil then
		f37_arg0.mapImage:setLeftRight( false, false, -50, 50 )
		f37_arg0.mapImage:setTopBottom( false, false, -50, 50 )
	end
end

CoD.Codtv.DWContentCardSummaryDownloaded = function ( f38_arg0, f38_arg1 )
	if not f38_arg0:isInFocus() then
		return 
	elseif f38_arg0.fileData.category == "film" then
		f38_arg0.codtv.infoPanel:showSummary( f38_arg1 )
		return 
	elseif f38_arg0.fileData.category ~= "clip" and f38_arg0.fileData.category ~= "screenshot" then
		return 
	elseif not f38_arg1.isValid then
		f38_arg0.mapImage:setupUIImage()
	end
end

CoD.Codtv.IngameStoreContentCardLoad = function ( f39_arg0, f39_arg1, f39_arg2 )
	if f39_arg0.fileData.fileID ~= "0" then
		f39_arg0.mapImage = LUI.UIImage.new()
		f39_arg0.mapImage:setLeftRight( true, true, 2, -2 )
		f39_arg0.mapImage:setTopBottom( true, true, 2, -CoD.textSize.ExtraSmall - 4 )
		f39_arg0:addElement( f39_arg0.mapImage )
	end
	f39_arg0.cardNameContainer = LUI.UIElement.new()
	f39_arg0.cardNameContainer:setUseStencil( true )
	f39_arg0.cardNameContainer:setLeftRight( true, true, 5, 0 )
	f39_arg0.cardNameContainer:setTopBottom( false, true, -CoD.textSize.ExtraSmall - 2, -2 )
	f39_arg0:addElement( f39_arg0.cardNameContainer )
	f39_arg0.cardName = LUI.UIText.new()
	f39_arg0.cardName:setLeftRight( true, true, 0, 0 )
	f39_arg0.cardName:setTopBottom( true, true, 0, 0 )
	f39_arg0.cardName:setFont( CoD.fonts.ExtraSmall )
	f39_arg0.cardName:setAlignment( LUI.Alignment.Left )
	f39_arg0.cardName:setText( f39_arg0.fileData.name )
	f39_arg0.cardName:setRGB( CoD.orange.r, CoD.orange.g, CoD.orange.b )
	f39_arg0.cardNameContainer:addElement( f39_arg0.cardName )
	if not f39_arg0:isInFocus() then
		f39_arg0.cardName:setRGB( 1, 1, 1 )
	end
end

CoD.Codtv.DWContentCardLoad = function ( f40_arg0, f40_arg1, f40_arg2 )
	if f40_arg1 == nil then
		f40_arg1 = {}
	end
	f40_arg0.text:setText( "" )
	f40_arg0.fileData = f40_arg1
	if (f40_arg0.fileData.fileID == nil or f40_arg0.fileData.fileID == "0") and f40_arg0.fileData.category ~= "ingamestore" then
		f40_arg0.fileData.fileID = "0"
		f40_arg0.fileData.name = Engine.Localize( "MENU_ERROR" )
		f40_arg0.fileData.description = Engine.Localize( "MENU_ERROR" )
	end
	if f40_arg0.fileData.durationInt == nil then
		f40_arg0.fileData.durationInt = 0
	end
	if f40_arg0.fileData.matchID == nil then
		f40_arg0.fileData.matchID = "0"
	end
	if f40_arg0.fileData.name == nil or f40_arg0.fileData.name == "" then
		if f40_arg1.gameTypeName ~= nil then
			f40_arg0.fileData.name = f40_arg1.gameTypeName
		else
			f40_arg0.fileData.name = ""
		end
	end
	if f40_arg0.fileData.category ~= nil and f40_arg0.fileData.category == "ingamestore" then
		CoD.Codtv.IngameStoreContentCardLoad( f40_arg0, f40_arg1, f40_arg2 )
		return 
	elseif f40_arg0.fileData.description == nil or f40_arg0.fileData.description == "" then
		if f40_arg0.fileData.category == "customgame" then
			f40_arg0.fileData.description = ""
		elseif f40_arg0.fileData.category ~= "emblem" then
			if not CoD.isZombie then
				f40_arg0.fileData.description = Engine.Localize( "MENU_FILESHARE_GAMEONMAP", f40_arg1.gameTypeName, Engine.Localize( f40_arg1.mapName ) )
			elseif CoD.isZombie == true and f40_arg0.fileData.gameType == CoD.Zombie.GAMETYPE_ZCLASSIC then
				f40_arg0.fileData.description = ""
			else
				f40_arg0.fileData.description = f40_arg1.gameTypeName
				f40_arg0.fileData.description = Engine.Localize( "MENU_FILESHARE_GAMEONMAP", f40_arg0.fileData.description, f40_arg1.zmMapStartLocName )
			end
		else
			f40_arg0.fileData.description = ""
		end
	end
	if f40_arg0.fileData.fileID ~= "0" then
		local self = LUI.UIElement.new()
		self:setLeftRight( true, true, 2, -2 )
		self:setTopBottom( true, true, 2, -CoD.textSize.ExtraSmall - 4 )
		f40_arg0:addElement( self )
		f40_arg0.mapImage = LUI.UIImage.new()
		if f40_arg0.fileData.category == "emblem" then
			f40_arg0.mapImage:close()
			f40_arg0:setupCenterImage( nil, 100, 100, 1.9 )
			f40_arg0.mapImage = f40_arg0.centerImageContainer.centerImage
		else
			f40_arg0.mapImage:setLeftRight( true, true, 2, -2 )
			f40_arg0.mapImage:setTopBottom( true, true, 2, -CoD.textSize.ExtraSmall - 4 )
		end
		local f40_local1 = nil
		if not CoD.isZombie then
			if f40_arg0.fileData.category == "customgame" and f40_arg0.fileData.gameType ~= nil then
				f40_local1 = RegisterMaterial( UIExpression.TableLookup( f40_arg0.codtv.m_ownerController, CoD.gametypesTable, 0, 0, 1, f40_arg0.fileData.gameType, 4 ) )
				f40_arg0.mapImage:setLeftRight( false, false, -50, 50 )
				f40_arg0.mapImage:setTopBottom( false, false, -50, 50 )
			elseif f40_arg0.fileData.map ~= nil then
				f40_local1 = RegisterMaterial( "menu_" .. f40_arg0.fileData.map .. "_map_select_final" )
			end
		elseif f40_arg0.fileData.zmMapStartLoc and f40_arg0.fileData.zmMapStartLoc ~= "default" then
			f40_local1 = RegisterMaterial( "menu_" .. CoD.Zombie.GetMapName( f40_arg0.fileData.map ) .. "_" .. UIExpression.TableLookup( nil, CoD.gametypesTable, 0, 0, 1, f40_arg0.fileData.gameType, 9 ) .. "_" .. f40_arg0.fileData.zmMapStartLoc )
			f40_arg0.mapImage:setRGB( 1, 1, 1 )
		else
			f40_arg0.mapImage:setRGB( 0, 0, 0 )
			f40_arg0.mapImage:setAlpha( 0.1 )
		end
		if f40_local1 ~= nil then
			f40_arg0.mapImage:setImage( f40_local1 )
		end
		if not f40_arg0.mapImage:getParent() then
			f40_arg0:addElement( f40_arg0.mapImage )
		end
		if f40_arg0.fileData.category ~= "screenshot" and f40_arg0.fileData.category ~= "emblem" and f40_arg0.fileData.category ~= "customgame" then
			local f40_local2 = LUI.UIImage.new()
			f40_local2:setLeftRight( false, true, -55, -8 )
			f40_local2:setTopBottom( true, false, 5, 5 + CoD.textSize.ExtraSmall )
			f40_local2:setRGB( 0, 0, 0 )
			f40_local2:setAlpha( 0.8 )
			f40_arg0:addElement( f40_local2 )
			f40_arg0.durationText = LUI.UIText.new()
			f40_arg0.durationText:setLeftRight( false, true, -55, -8 )
			f40_arg0.durationText:setTopBottom( true, false, 5, 5 + CoD.textSize.ExtraSmall )
			f40_arg0.durationText:setFont( CoD.fonts.ExtraSmall )
			f40_arg0.durationText:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
			f40_arg0.durationText:setAlignment( LUI.Alignment.Center )
			f40_arg0:addElement( f40_arg0.durationText )
			if f40_arg0.fileData.duration ~= nil then
				f40_arg0.durationText:setText( f40_arg0.fileData.duration )
			end
		end
		local f40_local2, f40_local3, f40_local4 = Engine.GetCombatRecordScreenshotInfo( f40_arg2, UIExpression.GetXUID( f40_arg2 ) )
		if not (f40_arg0.fileData.category ~= "film" or f40_arg0.fileData.bookmarked ~= true) or f40_arg0.fileData.category == "screenshot" and f40_arg0.fileData.fileID == f40_local2 then
			f40_arg0.bookmark = LUI.UIImage.new()
			f40_arg0.bookmark:setLeftRight( true, false, 5, 37 )
			f40_arg0.bookmark:setTopBottom( true, false, 5, 37 )
			f40_arg0.bookmark:setImage( RegisterMaterial( "menu_mp_star_rating" ) )
			f40_arg0.bookmark:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
			f40_arg0.bookmark:setAlpha( 1 )
			f40_arg0:addElement( f40_arg0.bookmark )
		end
	end
	f40_arg0.cardNameContainer = LUI.UIElement.new()
	f40_arg0.cardNameContainer:setUseStencil( true )
	f40_arg0.cardNameContainer:setLeftRight( true, true, 5, 0 )
	f40_arg0.cardNameContainer:setTopBottom( false, true, -CoD.textSize.ExtraSmall - 2, -2 )
	f40_arg0:addElement( f40_arg0.cardNameContainer )
	f40_arg0.cardName = LUI.UIText.new()
	f40_arg0.cardName:setLeftRight( true, true, 0, 0 )
	f40_arg0.cardName:setTopBottom( true, true, 0, 0 )
	f40_arg0.cardName:setFont( CoD.fonts.ExtraSmall )
	f40_arg0.cardName:setAlignment( LUI.Alignment.Left )
	if true == Dvar.fshFileDebug:get() then
		local self = f40_arg0.fileData.fileID
		if f40_arg0.fileData.originID ~= nil then
			self = self .. " / " .. f40_arg0.fileData.originID
		end
		f40_arg0.cardName:setText( self )
	else
		f40_arg0.cardName:setText( f40_arg0.fileData.name )
	end
	f40_arg0.cardName:setRGB( CoD.orange.r, CoD.orange.g, CoD.orange.b )
	f40_arg0.cardNameContainer:addElement( f40_arg0.cardName )
	if not f40_arg0:isInFocus() then
		f40_arg0.cardName:setRGB( 1, 1, 1 )
		if f40_arg0.durationText ~= nil then
			f40_arg0.durationText:setRGB( 1, 1, 1 )
		end
	end
end

CoD.Codtv.UpdateIngameStorePurchaseElement = function ( f41_arg0, f41_arg1 )
	local f41_local0 = Engine.IsOfferPurchased( f41_arg1.controller, f41_arg0.fileData.offerid, f41_arg0.fileData.storeContentType )
	if f41_local0 ~= nil then
		f41_arg0.fileData.isOfferPurchased = f41_local0
		if f41_arg0:isInFocus() then
			CoD.Codtv.ShowIngameStorePanel( f41_arg0 )
			CoD.Codtv.InGameStoreUpdateAButtonPromptString( f41_arg0, f41_arg1 )
		end
	end
end

CoD.Codtv.ReloadInGameStoreMenu = function ( f42_arg0, f42_arg1 )
	if f42_arg0:isInFocus() then
		f42_arg0.codtv:reload( f42_arg0.codtv.m_rootFolderIndex )
	end
end

CoD.Codtv.EmblemDownloaded = function ( f43_arg0, f43_arg1 )
	if f43_arg0.fileData.fileID == f43_arg1.fileID then
		f43_arg0.emblemDownloaded = true
	end
end

CoD.Codtv.DWContentCardsCreate = function ( f44_arg0, f44_arg1, f44_arg2 )
	if f44_arg0 ~= nil then
		if f44_arg1.numresults > CoD.Codtv.CardsPerPage then
			f44_arg1.numresults = CoD.Codtv.CardsPerPage
		end
		for f44_local0 = 1, f44_arg1.numresults, 1 do
			local f44_local3 = CoD.Codtv.GetGenericCard( f44_arg0 )
			f44_local3.type = "dwcontent"
			f44_local3.folderIndex = f44_arg2
			CoD.Codtv.DWContentCardLoad( f44_local3, f44_arg1[f44_local0], f44_arg1.controller )
			if f44_local3.fileData.category == "ingamestore" then
				f44_local3:registerEventHandler( "refresh_offers_data", CoD.Codtv.UpdateIngameStorePurchaseElement )
				f44_local3:registerEventHandler( "reload_store_menu", CoD.Codtv.ReloadInGameStoreMenu )
			end
			if f44_local3.fileData.category == "emblem" then
				f44_local3:registerEventHandler( "emblemDownloaded", CoD.Codtv.EmblemDownloaded )
				f44_local3.text:setText( Engine.Localize( "MENU_EMBLEM_DEFAULT_TITLE" ) )
			end
			f44_local3:registerEventHandler( "card_load_content", CoD.Codtv.DWContentCardLoad )
			f44_local3:registerEventHandler( "card_vote", CoD.Codtv.DWContentCardVote )
			f44_local3:registerEventHandler( "card_report", CoD.Codtv.DWContentCardReport )
			f44_local3:registerEventHandler( "card_save", CoD.Codtv.DWContentCardSave )
			f44_local3:registerEventHandler( "fileshare_summary_downloaded", CoD.Codtv.DWContentCardSummaryDownloaded )
		end
	end
end

CoD.Codtv.DWFolderCardAddNextPrev = function ( f45_arg0, f45_arg1, f45_arg2, f45_arg3, f45_arg4, f45_arg5 )
	local f45_local0 = CoD.Codtv.GetGenericCard( f45_arg0 )
	f45_local0.bg:close()
	f45_local0.text:close()
	f45_local0.border:close()
	f45_local0.disableGrowShrink = true
	local self = LUI.UIElement.new()
	self:setTopBottom( true, false, 12, 72 )
	self:setUseStencil( true )
	f45_local0:addElement( self )
	local f45_local2 = LUI.UIImage.new()
	f45_local2:setImage( RegisterMaterial( "menu_next_prev_arrow" ) )
	f45_local2:setTopBottom( true, true, 0, 0 )
	f45_local2:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
	f45_local2:setAlpha( 0 )
	f45_local0.arrowBg = f45_local2
	self:addElement( f45_local2 )
	local f45_local3 = LUI.UIImage.new()
	f45_local3:setImage( RegisterMaterial( "menu_next_prev_arrow_black" ) )
	f45_local3:setTopBottom( true, true, 2, -2 )
	f45_local0.arrow = f45_local3
	self:addElement( f45_local3 )
	local f45_local4 = LUI.UIText.new()
	f45_local4:setLeftRight( true, true, 10, -10 )
	f45_local4:setTopBottom( true, false, 22, 22 + CoD.textSize.Default )
	f45_local4:setText( f45_arg5 )
	f45_local4:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	f45_local0.arrowText = f45_local4
	self:addElement( f45_local4 )
	f45_local0.spinner = LUI.UIImage.new( {
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	} )
	f45_local0.spinner:setTopBottom( true, false, 80, 144 )
	f45_local0.spinner:setImage( RegisterMaterial( "lui_loader" ) )
	f45_local0.spinner:setAlpha( 0 )
	f45_local0:addElement( f45_local0.spinner )
	if f45_arg4 == "dwfolder_prev" then
		self:setLeftRight( false, true, -146, -20 )
		f45_local0.spinner:setLeftRight( false, true, -89, -25 )
		f45_local4:setAlignment( LUI.Alignment.Right )
		f45_local3:setLeftRight( false, true, 0, -128 )
		f45_local2:setLeftRight( false, true, 0, -128 )
	else
		self:setLeftRight( true, false, 10, 136 )
		f45_local0.spinner:setLeftRight( true, false, 25, 89 )
		f45_local4:setAlignment( LUI.Alignment.Left )
		f45_local3:setLeftRight( true, false, 0, 128 )
		f45_local2:setLeftRight( true, false, 0, 128 )
	end
	f45_local0.type = f45_arg4
	f45_local0.folderIndex = f45_arg2
	f45_local0.startIndex = f45_arg3
	f45_local0:registerEventHandler( "fileshare_search_complete", CoD.Codtv.DWFolderCardSearchCompleted )
end

CoD.Codtv.DWFolderCardNextPrevSelected = function ( f46_arg0, f46_arg1 )
	f46_arg0.spinner:setAlpha( 1 )
	f46_arg0.m_dataRequested = true
	Engine.LoadCodtvDWContent( f46_arg0.codtv.m_ownerController, f46_arg0.folderIndex, f46_arg0.startIndex, f46_arg0.codtv.userData )
end

CoD.Codtv.DWFolderCardNextPrevGainFocus = function ( f47_arg0, f47_arg1 )
	f47_arg0.arrowBg:setAlpha( 1 )
	f47_arg0.arrowText:setRGB( CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b )
	if f47_arg0.type == "dwfolder_prev" then
		f47_arg0.arrow:setLeftRight( false, true, -2, -126 )
	else
		f47_arg0.arrow:setLeftRight( true, false, 2, 126 )
	end
	f47_arg0.disableGrowShrink = true
end

CoD.Codtv.DWFolderCardNextPrevLoseFocus = function ( f48_arg0, f48_arg1 )
	f48_arg0.arrowBg:setAlpha( 0 )
	f48_arg0.arrowText:setRGB( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b )
	if f48_arg0.type == "dwfolder_prev" then
		f48_arg0.arrow:setLeftRight( false, true, 0, -128 )
	else
		f48_arg0.arrow:setLeftRight( true, false, 0, 128 )
	end
	f48_arg0.disableGrowShrink = true
end

CoD.Codtv.SetupDWCardNoData = function ( f49_arg0 )
	if f49_arg0 == nil then
		return 
	elseif f49_arg0.text ~= nil then
		f49_arg0.text:setText( Engine.Localize( "MENU_NO_DATA" ) )
	end
	if f49_arg0.spinner ~= nil then
		f49_arg0.spinner:setAlpha( 0 )
	end
	if f49_arg0.codtv ~= nil and f49_arg0.codtv.hintText ~= nil then
		if f49_arg0.codtv.m_rootRef == "ingamestore" then
			f49_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_STORE_EMPTY" ) )
		else
			f49_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_CODTV_FOLDER_EMPTY_HINT" ) )
		end
	end
	if f49_arg0.textBackground ~= nil then
		f49_arg0.textBackground:show()
	end
end

CoD.Codtv.SetCardIndexForMTXCarousel = function ( f50_arg0, f50_arg1 )
	if CoD.isPS3 == true and f50_arg0.codtv.m_rootRef == "ingamestore" then
		local f50_local0 = UIExpression.DvarInt( nil, "ui_mtxid" )
		if f50_local0 ~= CoD.Codtv.INVALID_MTX_ID then
			local f50_local1 = Engine.GetPS3MTXProductIndex( f50_local0 )
			if CoD.Codtv.CardsPerPage <= f50_arg1.startIndex + f50_local1 then
				f50_arg0.startIndex = f50_local1
				f50_arg1.startIndex = f50_local1
				f50_arg0.isItemOnFirstPage = false
				Engine.LoadCodtvDWContent( f50_arg0.codtv.m_ownerController, f50_arg0.folderIndex, f50_arg0.startIndex, f50_arg0.codtv.userData )
				Engine.SetDvar( "ui_mtxid", CoD.Codtv.INVALID_MTX_ID )
				return false
			end
			f50_arg0.cardCarousel.horizontalList.m_currentCardIndex = f50_local1 + 1
			Engine.SetDvar( "ui_mtxid", CoD.Codtv.INVALID_MTX_ID )
		end
	end
	return true
end

CoD.Codtv.DWFolderCardSearchCompleted = function ( f51_arg0, f51_arg1 )
	if f51_arg0.folderIndex == f51_arg1.contextid and f51_arg0.m_dataRequested == true then
		if f51_arg1.numresults == 0 then
			CoD.Codtv.SetupDWCardNoData( f51_arg0 )
		else
			if CoD.Codtv.SetCardIndexForMTXCarousel( f51_arg0, f51_arg1 ) == false then
				return 
			end
			local f51_local0 = f51_arg0.cardCarousel
			local f51_local1 = f51_arg0.folderIndex
			f51_local0:clearAllItems()
			Engine.Exec( f51_arg0.codtv.m_ownerController, "resetThumbnailViewer" )
			if f51_arg1.startIndex > 0 then
				local f51_local2 = f51_arg1.startIndex - CoD.Codtv.CardsPerPage
				if f51_local2 < 0 then
					f51_local2 = 0
				end
				CoD.Codtv.DWFolderCardAddNextPrev( f51_local0, f51_arg0.src, f51_arg0.folderIndex, f51_local2, "dwfolder_prev", Engine.Localize( "MENU_PREVIOUS" ) )
			end
			if f51_arg1.numresults > 0 then
				CoD.Codtv.DWContentCardsCreate( f51_local0, f51_arg1, f51_local1 )
			end
			local f51_local2 = f51_arg1.startIndex + f51_arg1.numresults
			if f51_arg1.totalFiles - f51_local2 > 0 then
				CoD.Codtv.DWFolderCardAddNextPrev( f51_local0, f51_arg0.src, f51_arg0.folderIndex, f51_local2, "dwfolder_next", Engine.Localize( "MENU_NEXT" ) )
			end
			if f51_arg0.type == "dwfolder_next" then
				f51_local0.horizontalList.m_currentCardIndex = 1
			elseif f51_arg0.type == "dwfolder_prev" then
				f51_local0.horizontalList.m_currentCardIndex = #f51_local0.horizontalList.cards
			elseif f51_arg0.type == "dwfolder" and f51_arg0.isItemOnFirstPage ~= nil and f51_arg0.isItemOnFirstPage == false then
				f51_local0.horizontalList.m_currentCardIndex = 2
				f51_arg0.isItemOnFirstPage = nil
			end
			f51_local0.cardCarouselList:focusCurrentCardCarousel( f51_arg1.controller )
		end
	end
end

CoD.Codtv.DWFolderCardSelected = function ( f52_arg0, f52_arg1 )
	
end

CoD.Codtv.DWFolderCardGainFocus = function ( f53_arg0, f53_arg1 )
	f53_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f53_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f53_arg0.codtv:addBackButton()
	f53_arg0.text:setText( "" )
	f53_arg0.spinner:setAlpha( 1 )
	f53_arg0.textBackground:hide()
end

CoD.Codtv.DWFolderCardLoseFocus = function ( f54_arg0, f54_arg1 )
	
end

CoD.Codtv.DWFolderCardsLoad = function ( f55_arg0, f55_arg1, f55_arg2 )
	local f55_local0 = CoD.Codtv.GetGenericCard( f55_arg0 )
	f55_local0.text:setText( "" )
	f55_local0.spinner = LUI.UIImage.new( {
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	} )
	f55_local0.spinner:setLeftRight( false, false, -32, 32 )
	f55_local0.spinner:setTopBottom( false, false, -32, 32 )
	f55_local0.spinner:setImage( RegisterMaterial( "lui_loader" ) )
	f55_local0.spinner:setAlpha( 1 )
	f55_local0:addElement( f55_local0.spinner )
	f55_local0.textBackground = LUI.UIImage.new( {
		material = RegisterMaterial( "menu_theater_nodata" )
	} )
	f55_local0.textBackground:setLeftRight( false, false, -64, 64 )
	f55_local0.textBackground:setTopBottom( false, false, -64, 64 )
	f55_local0.textBackground:setAlpha( 1 )
	f55_local0.textBackground:setPriority( -100 )
	f55_local0:addElement( f55_local0.textBackground )
	f55_local0.textBackground:hide()
	f55_local0.type = "dwfolder"
	f55_local0.folderIndex = f55_arg2
	f55_local0:registerEventHandler( "fileshare_search_complete", CoD.Codtv.DWFolderCardSearchCompleted )
end

CoD.Codtv.CustomButtonFileManagerSelected = function ( f56_arg0, f56_arg1 )
	f56_arg0.codtv:openPopup( "FileshareManager", f56_arg1.controller )
end

CoD.Codtv.CustomButtonNewEmblemSelected = function ( f57_arg0, f57_arg1 )
	if f57_arg0.codtv.m_emblemSlotsRemaining > 0 and f57_arg0.codtv.m_embemNextSlot ~= nil then
		f57_arg0.codtv.m_previousFolderIndex = nil
		if Engine.IsFeatureBanned( CoD.FEATURE_BAN_EMBLEM_EDITOR ) then
			Engine.ExecNow( f57_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_EMBLEM_EDITOR )
			return 
		end
		CoD.perController[f57_arg1.controller].emblemSaveSlot = f57_arg0.codtv.m_embemNextSlot
		CoD.perController[f57_arg1.controller].emblemFileID = nil
		Engine.ExecNow( f57_arg1.controller, "emblemclearall" )
		f57_arg0.codtv:openMenu( "EmblemEditor", f57_arg1.controller )
		CoD.Codtv.Shutdown()
		f57_arg0.codtv:close()
	end
end

CoD.Codtv.CustomButtonBuyStorageSelected = function ( f58_arg0, f58_arg1 )
	if UIExpression.IsGuest( f58_arg1.controller ) == 1 then
		f58_arg0:dispatchEventToParent( {
			name = "open_no_guest_mtx",
			controller = f58_arg1.controller
		} )
	elseif CoD.isPS3 then
		f58_arg0:dispatchEventToParent( {
			name = "open_mtx_purchase",
			controller = f58_arg1.controller,
			userData = {
				mtxName = Dvar.fshMtxName:get(),
				openingMenuName = "codtv"
			}
		} )
	else
		Engine.SetStartCheckoutTimestampUTC()
		Engine.PurchaseMTX( f58_arg1.controller, Dvar.fshMtxName:get(), "codtv" )
	end
end

CoD.Codtv.CustomButtonCardSelected = function ( f59_arg0, f59_arg1 )
	if f59_arg0.customAction ~= nil then
		if f59_arg0.customAction == "filemanager" then
			CoD.Codtv.CustomButtonFileManagerSelected( f59_arg0, f59_arg1 )
		elseif f59_arg0.customAction == "newemblem" then
			CoD.Codtv.CustomButtonNewEmblemSelected( f59_arg0, f59_arg1 )
		elseif f59_arg0.customAction == "buystorage" then
			CoD.Codtv.CustomButtonBuyStorageSelected( f59_arg0, f59_arg1 )
		end
	end
end

CoD.Codtv.CustomButtonNewEmblemGainFocus = function ( f60_arg0, f60_arg1 )
	f60_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f60_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f60_arg0.codtv:addBackButton()
	if f60_arg0.codtv.m_emblemSlotsOccupied ~= nil and f60_arg0.codtv.m_emblemSlotsRemaining ~= nil then
		local f60_local0 = f60_arg0.codtv.m_emblemSlotsOccupied + f60_arg0.codtv.m_emblemSlotsRemaining
		if f60_arg0.codtv.m_emblemSlotsRemaining > 0 then
			f60_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_NEW_EMBLEM_HINT_SLOTS", f60_arg0.codtv.m_emblemSlotsOccupied, f60_local0 ) )
			f60_arg0.codtv:addSelectButton()
		elseif CoD.FileshareManager.ShouldShowMtx( f60_arg1.controller ) then
			f60_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_NEW_EMBLEM_HINT_FULL_MTX", f60_arg0.codtv.m_emblemSlotsOccupied, f60_local0 ) )
			f60_arg0.codtv.hintText:updateHintColor( {
				r = CoD.red.r,
				g = CoD.red.g,
				b = CoD.red.b,
				a = 1
			} )
		else
			f60_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_NEW_EMBLEM_HINT_FULL", f60_arg0.codtv.m_emblemSlotsOccupied, f60_local0 ) )
			f60_arg0.codtv.hintText:updateHintColor( {
				r = CoD.red.r,
				g = CoD.red.g,
				b = CoD.red.b,
				a = 1
			} )
		end
	else
		f60_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_NEW_EMBLEM_HINT" ) )
		f60_arg0.codtv:addSelectButton()
	end
end

CoD.Codtv.CustomButtonBuyStorageGainFocus = function ( f61_arg0, f61_arg1 )
	f61_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_MTX_MEDIA_STORAGE_DESC" ) )
	f61_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f61_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f61_arg0.codtv:addBackButton()
	f61_arg0.codtv:addSelectButton()
end

CoD.Codtv.CustomButtonGainFocus = function ( f62_arg0, f62_arg1 )
	if f62_arg0.customAction ~= nil then
		if f62_arg0.customAction == "newemblem" then
			CoD.Codtv.CustomButtonNewEmblemGainFocus( f62_arg0, f62_arg1 )
		elseif f62_arg0.customAction == "buystorage" then
			CoD.Codtv.CustomButtonBuyStorageGainFocus( f62_arg0, f62_arg1 )
		end
	end
end

CoD.Codtv.PlayTimer = nil
CoD.Codtv.VideoCardPlay = function ( f63_arg0, f63_arg1 )
	if CoD.Codtv.WebMPlayback ~= nil and Engine.WebM_IsBuffered( CoD.Codtv.WebMPlayback ) then
		Engine.WebM_Play( CoD.Codtv.WebMPlayback )
		f63_arg0.webmVideo:setAlpha( 1 )
		if f63_arg0.webmImage ~= nil then
			f63_arg0.webmImage:setAlpha( 0 )
		end
		Engine.PlayMenuMusic( "" )
	else
		if CoD.Codtv.PlayTimer ~= nil then
			CoD.Codtv.PlayTimer:close()
			CoD.Codtv.PlayTimer = nil
		end
		f63_arg0:registerEventHandler( "webm_video_play", CoD.Codtv.VideoCardPlay )
		CoD.Codtv.PlayTimer = LUI.UITimer.new( 250, "webm_video_play", true )
		f63_arg0:addElement( CoD.Codtv.PlayTimer )
	end
end

CoD.Codtv.VideoCardClearPlayback = function ( f64_arg0 )
	if f64_arg0 ~= nil then
		f64_arg0.webmVideo:setAlpha( 0 )
		if f64_arg0.webmImage ~= nil then
			f64_arg0.webmImage:setAlpha( 1 )
		end
	end
	if nil ~= CoD.Codtv.WebMPlayback then
		Engine.WebM_Close( CoD.Codtv.WebMPlayback )
		CoD.Codtv.WebMPlayback = nil
	end
	if nil ~= CoD.Codtv.PlayTimer then
		CoD.Codtv.PlayTimer:close()
		CoD.Codtv.PlayTimer = nil
	end
	Engine.WebM_Clear( CoD.Codtv.WebMPlaybackMaterial )
	Engine.PlayMenuMusic( "mus_mp_frontend" )
end

CoD.Codtv.VideoCardAutoPlay = function ( f65_arg0, f65_arg1 )
	if f65_arg0:isInFocus() and f65_arg0.url ~= "" and f65_arg0.m_thumbnailReady == true then
		CoD.Codtv.VideoCardClearPlayback()
		CoD.Codtv.WebMPlayback = Engine.WebM_Open( f65_arg0.url .. "_low.webm", CoD.Codtv.WebMPlaybackMaterial )
		CoD.Codtv.VideoCardPlay( f65_arg0 )
	end
end

CoD.Codtv.VideoCardDownloadThumbnailCheck = function ( f66_arg0, f66_arg1 )
	if f66_arg0.thumbnailDownloadTimer then
		f66_arg0.thumbnailDownloadTimer:close()
		f66_arg0.thumbnailDownloadTimer = nil
	end
	if f66_arg0.m_webmThumbIndex ~= nil and Engine.Url_Load_IsDone( f66_arg0.m_webmThumbIndex ) then
		f66_arg0.spinner:setAlpha( 0 )
		f66_arg0.webmImage:setAlpha( 1 )
		f66_arg0.m_thumbnailReady = true
	else
		f66_arg0.thumbnailDownloadTimer = LUI.UITimer.new( CoD.Codtv.ThumbnailDownloadCheckInterval, "download_thumbnail_check", true )
		f66_arg0:addElement( f66_arg0.thumbnailDownloadTimer )
	end
end

CoD.Codtv.VideoCardSelected = function ( f67_arg0, f67_arg1 )
	local f67_local0 = Engine.Url_Load_MeasureDownloadBandwidth( "akamai://rand.bin" )
	if string.sub( f67_arg0.url, -2, -2 ) == "_" or f67_local0 ~= -1 then
		if f67_arg0.autoPlayTimer ~= nil then
			f67_arg0.autoPlayTimer:close()
			f67_arg0.autoPlayTimer = nil
		end
		CoD.Codtv.VideoCardClearPlayback()
		f67_arg0.webmVideo:setAlpha( 0 )
		f67_arg0.webmImage:setAlpha( 1 )
		local f67_local1 = f67_arg0.url .. "_low.webm"
		local f67_local2 = "ps3"
		if CoD.isXBOX then
			f67_local2 = "xbox"
		end
		if f67_local0 > 524288 then
			f67_local1 = f67_arg0.url .. "_" .. f67_local2 .. "_4.webm"
		elseif f67_local0 > 393216 then
			f67_local1 = f67_arg0.url .. "_" .. f67_local2 .. "_3.webm"
		elseif f67_local0 > 262144 then
			f67_local1 = f67_arg0.url .. "_" .. f67_local2 .. "_2.webm"
		elseif f67_local0 > 131072 then
			f67_local1 = f67_arg0.url .. "_" .. f67_local2 .. "_1.webm"
		end
		if string.sub( f67_arg0.url, -2, -2 ) == "_" then
			f67_local1 = f67_arg0.url .. ".webm"
		end
		CoD.Codtv.WebMPlayback = Engine.WebM_Open( f67_local1, CoD.Codtv.WebMPlaybackMaterial )
		CoD.Codtv.VideoCardPlay( f67_arg0.codtv:openPopup( "Video_Player", f67_arg1.controller ) )
	end
end

CoD.Codtv.VideoCardGainFocus = function ( f68_arg0, f68_arg1 )
	f68_arg0.codtv.rightButtonPromptBar:removeAllChildren()
	f68_arg0.codtv.leftButtonPromptBar:removeAllChildren()
	f68_arg0.codtv:addBackButton()
	f68_arg0.codtv:addSelectButton()
	f68_arg0.autoPlayTimer = LUI.UITimer.new( CoD.Codtv.AutoPlayRetryDelay, "auto_play", true )
	f68_arg0:addElement( f68_arg0.autoPlayTimer )
end

CoD.Codtv.VideoCardLoseFocus = function ( f69_arg0, f69_arg1 )
	if f69_arg0.autoPlayTimer ~= nil then
		f69_arg0.autoPlayTimer:close()
	end
	CoD.Codtv.VideoCardClearPlayback()
	f69_arg0.webmVideo:setAlpha( 0 )
	if f69_arg0.m_thumbnailReady then
		f69_arg0.webmImage:setAlpha( 1 )
	else
		f69_arg0.webmImage:setAlpha( 0 )
	end
	Engine.PlayMenuMusic( "mus_mp_frontend" )
end

CoD.Codtv.VideoCardsLoad = function ( f70_arg0, f70_arg1 )
	if f70_arg1.videoCount > CoD.Codtv.MaxWebMMaterials then
		f70_arg1.videoCount = CoD.Codtv.MaxWebMMaterials
	end
	Engine.Url_Load_Init()
	Engine.Url_Load_MeasureDownloadBandwidth( "akamai://rand.bin" )
	Engine.Url_Load_Jpeg( "dummy://none", CoD.Codtv.WebMPlaybackMaterial )
	for f70_local0 = 1, f70_arg1.videoCount, 1 do
		local f70_local3 = CoD.Codtv.GetGenericCard( f70_arg0 )
		f70_local3.text:setText( f70_arg1[f70_local0].name )
		f70_local3.type = "video"
		f70_local3.url = f70_arg1[f70_local0].url
		f70_local3.webmVideo = LUI.UIImage.new()
		f70_local3.webmVideo:setLeftRight( true, true, 2, -2 )
		f70_local3.webmVideo:setTopBottom( true, true, 2, -28 )
		f70_local3.webmVideo:setAlpha( 0 )
		f70_local3.webmVideo:setImage( RegisterMaterial( CoD.Codtv.WebMPlaybackMaterial ) )
		f70_local3:addElement( f70_local3.webmVideo )
		f70_local3.webmImage = LUI.UIImage.new()
		f70_local3.webmImage:setLeftRight( true, true, 2, -2 )
		f70_local3.webmImage:setTopBottom( true, true, 2, -28 )
		f70_local3.webmImage:setAlpha( 0 )
		f70_local3.spinner = LUI.UIImage.new( {
			shaderVector0 = {
				0,
				0,
				0,
				0
			}
		} )
		f70_local3.spinner:setLeftRight( false, false, -32, 32 )
		f70_local3.spinner:setTopBottom( false, false, -32, 32 )
		f70_local3.spinner:setImage( RegisterMaterial( "lui_loader" ) )
		f70_local3.spinner:setAlpha( 0 )
		f70_local3:addElement( f70_local3.spinner )
		f70_local3.spinner:setAlpha( 1 )
		local f70_local4 = CoD.Codtv.WebMGetMaterial( f70_local0 )
		if f70_local4 ~= nil then
			f70_local3.webmImage:setImage( RegisterMaterial( f70_local4 ) )
		end
		f70_local3:addElement( f70_local3.webmImage )
		f70_local3.m_webmThumbIndex = nil
		f70_local3.m_thumbnailReady = false
		f70_local3:registerEventHandler( "download_thumbnail_check", CoD.Codtv.VideoCardDownloadThumbnailCheck )
		f70_local3:registerEventHandler( "auto_play", CoD.Codtv.VideoCardAutoPlay )
	end
end

CoD.Codtv.IsStoreContentFetching = function ( f71_arg0, f71_arg1 )
	if Engine.LoadCodtvDWContent( f71_arg0.codtv.m_ownerController, f71_arg0.folderIndex, f71_arg0.offset, f71_arg0.codtv.userData ) then
		f71_arg1.timer:close()
	end
end

CoD.Codtv.GetStoreContent = function ( f72_arg0, f72_arg1 )
	f72_arg0:registerEventHandler( "fetching_store_content_done", CoD.Codtv.IsStoreContentFetching )
	f72_arg0.offset = f72_arg1
	f72_arg0:addElement( LUI.UITimer.new( 1000, "fetching_store_content_done", false ) )
end

CoD.Codtv.CarouselGainFocus = function ( f73_arg0, f73_arg1 )
	local f73_local0 = f73_arg0.cards[1]
	if f73_local0 ~= nil then
		if f73_local0.type == "video" then
			for f73_local1 = 1, #f73_arg0.cards, 1 do
				local f73_local4 = f73_arg0.cards[f73_local1]
				local f73_local5 = CoD.Codtv.WebMGetMaterial( f73_local4.cardIndex )
				f73_local4.webmImage:setAlpha( 0 )
				f73_local4.m_thumbnailReady = false
				f73_local4.spinner:setAlpha( 1 )
				if f73_local5 ~= nil then
					Engine.WebM_Clear( f73_local5 )
					if f73_local4.url ~= "" then
						f73_local4.m_webmThumbIndex = Engine.Url_Load_Jpeg( f73_local4.url .. "_thumb.jpg", f73_local5 )
						if f73_local4.thumbnailDownloadTimer ~= nil then
							f73_local4.thumbnailDownloadTimer:close()
						end
						f73_local4.thumbnailDownloadTimer = LUI.UITimer.new( CoD.Codtv.ThumbnailDownloadCheckInterval, "download_thumbnail_check", true )
						f73_local4:addElement( f73_local4.thumbnailDownloadTimer )
					end
				end
			end
		elseif f73_local0.type == "dwfolder" then
			if f73_local0.codtv.m_rootRef == "ingamestore" then
				CoD.Codtv.GetStoreContent( f73_local0, 0 )
			else
				Engine.LoadCodtvDWContent( f73_local0.codtv.m_ownerController, f73_local0.folderIndex, 0, f73_local0.codtv.userData )
			end
			f73_local0.m_dataRequested = true
		else
			for f73_local1 = 1, #f73_arg0.cards, 1 do
				local f73_local4 = f73_arg0.cards[f73_local1]
				if f73_local4.type == "dwcontent" and f73_local4.fileData ~= nil and f73_local4.fileData.fileID ~= "0" then
					if f73_local4.fileData.category == "ingamestore" then
						f73_local4.mapImage:setupImageViewer( CoD.UI_SCREENSHOT_TYPE_MOTD, f73_local4.fileData.fileID )
						Engine.Exec( f73_local4.codtv.m_ownerController, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_MOTD .. " " .. f73_local4.fileData.fileID .. " 1" )
					end
					if f73_local4.fileData.summarySize > 0 and (f73_local4.fileData.category == "clip" or f73_local4.fileData.category == "screenshot") then
						f73_local4.mapImage:setupImageViewer( CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, f73_local4.fileData.fileID )
						Engine.Exec( f73_local4.codtv.m_ownerController, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_THUMBNAIL .. " " .. f73_local4.fileData.fileID .. " " .. f73_local4.fileData.summarySize )
					end
					if f73_local4.fileData.fileSize > 0 and f73_local4.fileData.category == "emblem" then
						f73_local4.mapImage:setupImageViewer( CoD.UI_SCREENSHOT_TYPE_EMBLEM, f73_local4.fileData.fileID )
						if 0 ~= UIExpression.DvarBool( nil, "checkEmblemForRank" ) then
							Engine.Exec( f73_local4.codtv.m_ownerController, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_EMBLEM .. " " .. f73_local4.fileData.fileID .. " " .. f73_local4.fileData.fileSize .. " " .. f73_local4.fileData.authorXuid )
						else
							Engine.Exec( f73_local4.codtv.m_ownerController, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_EMBLEM .. " " .. f73_local4.fileData.fileID .. " " .. f73_local4.fileData.fileSize )
						end
					end
					if f73_local4.mapImage ~= nil then
						f73_local4.mapImage:setupUIImage()
					end
				end
			end
		end
	end
	CoD.CardCarousel.HorizontalListGainFocus( f73_arg0, f73_arg1 )
end

CoD.Codtv.CarouselLoseFocus = function ( f74_arg0, f74_arg1 )
	local f74_local0 = f74_arg0.cards[1]
	local f74_local1 = f74_arg0.cards[#f74_arg0.cards]
	if f74_local0.type == "video" then
		for f74_local2 = 1, #f74_arg0.cards, 1 do
			local f74_local5 = f74_arg0.cards[f74_local2]
			f74_local5.webmImage:setAlpha( 0 )
			f74_local5.m_thumbnailReady = false
			f74_local5.spinner:setAlpha( 1 )
			if f74_local5.thumbnailDownloadTimer ~= nil then
				f74_local5.thumbnailDownloadTimer:close()
			end
			local f74_local6 = CoD.Codtv.WebMGetMaterial( f74_local5.cardIndex )
			if f74_local6 ~= nil then
				Engine.WebM_Clear( f74_local6 )
			end
		end
	end
	if f74_local0.type == "dwfolder_prev" then
		f74_local0.m_dataRequested = false
		f74_local0.spinner:setAlpha( 0 )
	end
	if f74_local1.type == "dwfolder_next" then
		f74_local1.m_dataRequested = false
		f74_local1.spinner:setAlpha( 0 )
	end
	if f74_local0.codtv.m_rootRef == "ingamestore" and CoD.isPS3 == true then
		local f74_local2 = f74_local0.codtv
		local f74_local3 = f74_local2.m_cardCarouselList.cardCarousels[f74_local2.m_cardCarouselList.m_currentCardCarouselIndex]
		local f74_local4 = f74_local0.folderIndex
		f74_local3:clearAllItems()
		local f74_local7 = Engine.GetCodtvContent( f74_local4 )
		if f74_local7 ~= nil and f74_local7.type == "dwfolder" then
			CoD.Codtv.DWFolderCardsLoad( f74_local3, f74_local7, f74_local4 )
		end
	end
	CoD.CardCarousel.HorizontalListLoseFocus( f74_arg0, f74_arg1 )
	Engine.Exec( f74_arg1.controller, "fileshareAbortSummary" )
	Engine.Exec( f74_arg1.controller, "resetThumbnailViewer" )
	Engine.PlayMenuMusic( "mus_mp_frontend" )
end

CoD.Codtv.CarouselSimulateMove = function ( f75_arg0, f75_arg1, f75_arg2 )
	local f75_local0 = f75_arg0.cardCarousels[f75_arg0.m_currentCardCarouselIndex]
	local f75_local1 = f75_local0.horizontalList.cards[f75_local0.horizontalList.m_currentCardIndex]
	f75_arg0:processEvent( {
		name = "gamepad_button",
		button = f75_arg1,
		controller = f75_arg2,
		down = true,
		immediate = true
	} )
	f75_arg0:processEvent( {
		name = "gamepad_button",
		button = f75_arg1,
		controller = f75_arg2,
		down = false,
		immediate = true
	} )
	CoD.perController[f75_arg2].fileActionInfo = f75_local0.horizontalList.cards[f75_local0.horizontalList.m_currentCardIndex].fileData
end

CoD.Codtv.CarouselMoveNext = function ( f76_arg0, f76_arg1 )
	CoD.Codtv.CarouselSimulateMove( f76_arg0, "right", f76_arg1.controller )
end

CoD.Codtv.CarouselMovePrev = function ( f77_arg0, f77_arg1 )
	CoD.Codtv.CarouselSimulateMove( f77_arg0, "left", f77_arg1.controller )
end

CoD.Codtv.GetCarouselList = function ( f78_arg0, f78_arg1 )
	local f78_local0 = nil
	if f78_arg0 ~= nil then
		f78_local0 = f78_arg0.m_ownerController
	end
	local f78_local1 = CoD.CardCarouselList.new( nil, f78_local0, CoD.Codtv.ItemWidth, CoD.Codtv.ItemHeight, CoD.Codtv.HighlightedItemWidth, CoD.Codtv.HighligtedItemHeight, {
		hintTextLeft = 353,
		hintTextWidth = 510,
		hintTextTop = -32
	} )
	local f78_local2 = CoD.textSize.Big + 10
	f78_local1:setLeftRight( true, true, 0, 0 )
	f78_local1:setTopBottom( true, true, f78_local2, 0 )
	f78_local1.titleListContainer.spacing = 0
	f78_local1.titleListContainer:registerAnimationState( "default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.CoD9Button.Height,
		topAnchor = true,
		bottomAnchor = false,
		top = f78_local1.cardCarouselSize + 90,
		bottom = 0
	} )
	f78_local1.titleListContainer:animateToState( "default" )
	f78_local1:registerEventHandler( "move_next", CoD.Codtv.CarouselMoveNext )
	f78_local1:registerEventHandler( "move_prev", CoD.Codtv.CarouselMovePrev )
	if f78_arg0 ~= nil then
		for f78_local3 = 1, f78_arg1.subfolderCount, 1 do
			if f78_arg1[f78_local3] ~= nil then
				local f78_local6 = f78_arg1[f78_local3].name
				local f78_local7 = f78_arg1[f78_local3].folderIndex
				local f78_local8 = Engine.GetCodtvContent( f78_local7 )
				local f78_local9 = f78_local1:addCardCarousel( UIExpression.ToUpper( nil, f78_local6 ) )
				f78_local9.codtv = f78_arg0
				if f78_local8 ~= nil then
					if f78_local8.type == "folder" then
						CoD.Codtv.FolderCardsLoad( f78_local0, f78_local9, f78_local8 )
					elseif f78_local8.type == "videofolder" then
						CoD.Codtv.VideoCardsLoad( f78_local9, f78_local8 )
					elseif f78_local8.type == "dwfolder" then
						CoD.Codtv.DWFolderCardsLoad( f78_local9, f78_local8, f78_local7 )
					end
				end
				f78_local9.horizontalList:registerEventHandler( "gain_focus", CoD.Codtv.CarouselGainFocus )
				f78_local9.horizontalList:registerEventHandler( "lose_focus", CoD.Codtv.CarouselLoseFocus )
				local f78_local10 = f78_local1.cardCarouselSize + 50
				f78_local9.title:registerAnimationState( "default", {
					leftAnchor = true,
					rightAnchor = false,
					left = 0,
					right = 0,
					topAnchor = true,
					bottomAnchor = false,
					top = f78_local10,
					bottom = f78_local10 + CoD.CardCarousel.TitleSize,
					font = CoD.fonts.Big
				} )
				f78_local9.title:animateToState( "default" )
			end
		end
	end
	return f78_local1
end

CoD.Codtv.Shutdown = function ()
	CoD.Codtv.WebMShutdown()
	Engine.Url_Load_Destroy()
end

CoD.Codtv.ReloadMenu = function ( f80_arg0, f80_arg1 )
	CoD.Codtv.Shutdown()
	local f80_local0 = Engine.GetCodtvContent( f80_arg1 )
	if f80_arg1 == f80_arg0.m_rootFolderIndex then
		f80_arg0.m_previousFolderIndex = nil
	else
		f80_arg0.m_previousFolderIndex = f80_arg0.m_currentFolderIndex
	end
	f80_arg0.m_currentFolderIndex = f80_arg1
	f80_arg0:setTitle( UIExpression.ToUpper( nil, f80_local0.name ) )
	if f80_arg0.m_rootRef == "emblems" then
		local f80_local1 = UIExpression.TableLookup( nil, "mp/filesharecategories.csv", 0, "emblem", 2 )
		local f80_local2 = Engine.GetFileshareCategories( f80_arg0.m_ownerController, "emblem" )
		f80_arg0.m_emblemSlotsOccupied = f80_local2[1].occupied
		f80_arg0.m_emblemSlotsRemaining = f80_local2[1].remaining
		f80_arg0.m_embemNextSlot = Engine.GetFileshareNextSlot( f80_arg0.m_ownerController, f80_local1 )
	end
	f80_arg0.m_cardCarouselList:close()
	f80_arg0.m_cardCarouselList = CoD.Codtv.GetCarouselList( f80_arg0, f80_local0 )
	if f80_arg0.m_carouselContext ~= nil and f80_arg1 == f80_arg0.m_carouselContext.folderIndex then
		f80_arg0.m_cardCarouselList:setInitialCarousel( f80_arg0.m_carouselContext.carouselIndex, f80_arg0.m_carouselContext.cardIndex )
		f80_arg0.m_cardCarouselList:focusCurrentCardCarousel()
		f80_arg0.m_carouselContext = nil
	end
	f80_arg0.m_cardCarouselList:focusCurrentCardCarousel()
	f80_arg0.rightButtonPromptBar:removeAllChildren()
	f80_arg0:addElement( f80_arg0.m_cardCarouselList )
end

CoD.Codtv.AnimateOutAndGoBack = function ( f81_arg0 )
	CoD.Codtv.Shutdown()
	if f81_arg0.m_previousFolderIndex == nil then
		CoD.Menu.animateOutAndGoBack( f81_arg0 )
		Engine.PlayMenuMusic( "mus_mp_frontend" )
	else
		f81_arg0:reload( f81_arg0.m_previousFolderIndex )
		Engine.PlaySound( "cac_cmn_backout" )
	end
end

CoD.Codtv.GoBack = function ( f82_arg0, f82_arg1 )
	CoD.Codtv.Shutdown()
	Engine.PartyHostClearUIState()
	Engine.Exec( f82_arg1, "fileshareAbortSummary" )
	Engine.Exec( f82_arg1, "resetThumbnailViewer" )
	if UIExpression.DvarBool( nil, "tu5_checkStoreButtonPressed" ) == 1 then
		Dvar.ui_storeButtonPressed:set( false )
	end
	if f82_arg0.m_rootRef == "ingamestore" then
		Engine.SetDvar( "ui_contextualMenuLocation", "store" )
		if CoD.isPS3 == true then
			Engine.SetDvar( "ui_mtxid", CoD.Codtv.INVALID_MTX_ID )
			Engine.Exec( f82_arg1, "terminateStore" )
		end
	end
	CoD.Menu.goBack( f82_arg0, f82_arg1 )
end

CoD.Codtv.WebMGetMaterial = function ( f83_arg0 )
	if 1 <= f83_arg0 and f83_arg0 <= CoD.Codtv.MaxWebMMaterials then
		return "webm_720p_" .. f83_arg0 + 1
	else
		return nil
	end
end

CoD.Codtv.WebMShutdown = function ()
	if CoD.Codtv.WebMPlayback ~= nil then
		Engine.WebM_Close( CoD.Codtv.WebMPlayback )
		CoD.Codtv.WebMPlayback = nil
	end
end

CoD.Codtv.SetInfoPanelGameMode = {}
CoD.Codtv.UpdateVotesEvent = function ( f85_arg0, f85_arg1 )
	CoD.Codtv.UpdateVotes( CoD.Codtv.GetSelectedCard( f85_arg0 ), f85_arg0.infoPanel.customFilePanel )
end

CoD.Codtv.UpdateVotes = function ( f86_arg0, f86_arg1 )
	if f86_arg0 ~= nil and f86_arg0.fileData ~= nil and f86_arg0.fileData.isPooled == false then
		local f86_local0 = 0
		local f86_local1 = 0
		local f86_local2 = 0
		local f86_local3 = CoD.white
		local f86_local4 = CoD.white
		if f86_arg0.fileData.views ~= nil then
			f86_local0 = f86_arg0.fileData.views
			f86_arg1.viewPanel:setAlpha( 1 )
		else
			f86_arg1.viewPanel:setAlpha( 0 )
		end
		if f86_arg0.fileData.likes ~= nil then
			f86_local1 = f86_arg0.fileData.likes
		end
		if f86_arg0.fileData.dislikes ~= nil then
			f86_local2 = f86_arg0.fileData.dislikes
		end
		local f86_local5 = CoD.FileshareVote.GetVoteCategory( f86_arg0.fileData.category )
		local f86_local6 = nil
		if f86_arg0.fileData.originID ~= nil and f86_arg0.fileData.originID ~= "0" then
			f86_local6 = Engine.GetVote( f86_arg0.codtv.m_ownerController, f86_arg0.fileData.originID, f86_local5 )
		else
			f86_local6 = Engine.GetVote( f86_arg0.codtv.m_ownerController, f86_arg0.fileData.fileID, f86_local5 )
		end
		if f86_local6 ~= nil then
			if f86_local6 == "like" then
				f86_local3 = CoD.green
			elseif f86_local6 == "dislike" then
				f86_local4 = CoD.brightRed
			end
		end
		f86_arg1.viewPanel:update( f86_local0 )
		f86_arg1.likePanel:update( f86_local1, f86_local3 )
		f86_arg1.dislikePanel:update( f86_local2, f86_local4 )
	end
end

CoD.Codtv.SetInfoPanelGameModeDetails = function ( f87_arg0, f87_arg1, f87_arg2, f87_arg3, f87_arg4 )
	if f87_arg1 ~= nil and f87_arg2 ~= nil then
		f87_arg0.gameModeStat1Header:setText( f87_arg1 )
		f87_arg0.gameModeStat1:setText( f87_arg2 )
	else
		f87_arg0.gameModeStat1Header:setText( "" )
		f87_arg0.gameModeStat1:setText( "" )
	end
	if f87_arg3 ~= nil and f87_arg4 ~= nil then
		f87_arg0.gameModeStat2Header:setText( f87_arg3 )
		f87_arg0.gameModeStat2:setText( f87_arg4 )
	else
		f87_arg0.gameModeStat2Header:setText( "" )
		f87_arg0.gameModeStat2:setText( "" )
	end
end

CoD.Codtv.ResetInfoPanelGameModeDetails = function ( f88_arg0 )
	f88_arg0.gameModeStat1Header:setText( "" )
	f88_arg0.gameModeStat1:setText( "" )
	f88_arg0.gameModeStat2Header:setText( "" )
	f88_arg0.gameModeStat2:setText( "" )
end

CoD.Codtv.GetKDRatio = function ( f89_arg0, f89_arg1 )
	local f89_local0 = 0
	if f89_arg1 <= 0 then
		return f89_arg0
	else
		local f89_local1, f89_local2 = math.modf( f89_arg0 / f89_arg1 )
		return f89_local1 .. "." .. math.floor( f89_local2 * 100 )
	end
end

CoD.Codtv.SetInfoPanelGameMode.dom = function ( f90_arg0, f90_arg1, f90_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f90_arg0, Engine.Localize( "MPUI_CAPTURES_CAPS" ), f90_arg2.captures, Engine.Localize( "MPUI_DEFENDS_CAPS" ), f90_arg2.returns )
end

CoD.Codtv.SetInfoPanelGameMode.tdm = function ( f91_arg0, f91_arg1, f91_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f91_arg0, Engine.Localize( "MPUI_RATIO_CAPS" ), CoD.Codtv.GetKDRatio( f91_arg1.kills:get(), f91_arg1.deaths:get() ), Engine.Localize( "MPUI_ASSISTS_CAPS" ), f91_arg1.assists:get() )
end

CoD.Codtv.SetInfoPanelGameMode.dm = function ( f92_arg0, f92_arg1, f92_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f92_arg0, Engine.Localize( "MPUI_RATIO_CAPS" ), CoD.Codtv.GetKDRatio( f92_arg1.kills:get(), f92_arg1.deaths:get() ), Engine.Localize( "MPUI_HEADSHOTS_CAPS" ), f92_arg1.headshots:get() )
end

CoD.Codtv.SetInfoPanelGameMode.ctf = function ( f93_arg0, f93_arg1, f93_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f93_arg0, Engine.Localize( "MPUI_CAPTURES_CAPS" ), f93_arg2.captures, Engine.Localize( "MPUI_RETURNS_CAPS" ), f93_arg2.returns )
end

CoD.Codtv.SetInfoPanelGameMode.dem = function ( f94_arg0, f94_arg1, f94_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f94_arg0, Engine.Localize( "MPUI_PLANTS_CAPS" ), f94_arg2.plants, Engine.Localize( "MPUI_DEFUSES_CAPS" ), f94_arg2.defuses )
end

CoD.Codtv.SetInfoPanelGameMode.sab = function ( f95_arg0, f95_arg1, f95_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f95_arg0, Engine.Localize( "MPUI_PLANTS_CAPS" ), f95_arg2.plants, Engine.Localize( "MPUI_DEFUSES_CAPS" ), f95_arg2.defuses )
end

CoD.Codtv.SetInfoPanelGameMode.sd = function ( f96_arg0, f96_arg1, f96_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f96_arg0, Engine.Localize( "MPUI_PLANTS_CAPS" ), f96_arg2.plants, Engine.Localize( "MPUI_DEFUSES_CAPS" ), f96_arg2.defuses )
end

CoD.Codtv.SetInfoPanelGameMode.hq = function ( f97_arg0, f97_arg1, f97_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f97_arg0, Engine.Localize( "MPUI_CAPTURES_CAPS" ), f97_arg2.captures, Engine.Localize( "MPUI_DEFENDS_CAPS" ), f97_arg2.returns )
end

CoD.Codtv.SetInfoPanelGameMode.koth = function ( f98_arg0, f98_arg1, f98_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f98_arg0, Engine.Localize( "MPUI_CAPTURES_CAPS" ), f98_arg2.captures, Engine.Localize( "MPUI_DEFENDS_CAPS" ), f98_arg2.returns )
end

CoD.Codtv.SetInfoPanelGameMode.conf = function ( f99_arg0, f99_arg1, f99_arg2 )
	CoD.Codtv.SetInfoPanelGameModeDetails( f99_arg0, Engine.Localize( "MPUI_KILLS_CONFIRMED_CAPS" ), f99_arg2.captures, Engine.Localize( "MPUI_KILLS_DENIED_CAPS" ), f99_arg2.returns )
end

CoD.Codtv.CreateHintText = function ( f100_arg0, f100_arg1, f100_arg2, f100_arg3, f100_arg4 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, f100_arg1, f100_arg1 + f100_arg3 )
	self:setTopBottom( true, false, f100_arg2, f100_arg2 + f100_arg4 )
	self:setUseStencil( true )
	self.hintTextElement = CoD.HintText.new( hintTextParams )
	self.hintTextElement:setLeftRight( true, true, 0, 0 )
	self.hintTextElement:setTopBottom( true, false, 0, CoD.textSize.Default )
	self.hintTextElement:setColor( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4 )
	self:addElement( self.hintTextElement )
	self.updateHintColor = function ( f101_arg0, f101_arg1 )
		if f101_arg1 == nil then
			f101_arg0.hintTextElement:setColor( CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4 )
		else
			f101_arg0.hintTextElement:setColor( f101_arg1.r, f101_arg1.g, f101_arg1.b, f101_arg1.a )
		end
	end
	
	self.updateHintText = function ( f102_arg0, f102_arg1 )
		if f102_arg1 == "" then
			f102_arg0.hintTextElement:setAlpha( 0 )
		else
			f102_arg0.hintTextElement:setAlpha( 1 )
		end
		f102_arg0:updateHintColor( nil )
		f102_arg0.hintTextElement:updateText( f102_arg1 )
	end
	
	return self
end

CoD.Codtv.ShowPooledFilePanelSummary = function ( f103_arg0, f103_arg1 )
	if f103_arg0 == nil then
		return 
	end
	local f103_local0 = f103_arg0.pooledFilePanel
	if f103_local0 == nil then
		return 
	end
	f103_local0.loader:setAlpha( 0 )
	if f103_arg1.isValid == nil or f103_arg1.isValid == false then
		return 
	end
	local f103_local1 = f103_arg1.xuid
	if f103_arg0.codtv.m_rootRef == "playerchannel" and f103_arg0.codtv.m_playerChannelXuid ~= nil then
		f103_local1 = f103_arg0.codtv.m_playerChannelXuid
	end
	if f103_local1 == nil or f103_local1 == "" then
		return 
	end
	local f103_local2 = Engine.GetMatchRecordStats( f103_arg1.controller )
	local f103_local3, f103_local4, f103_local5, f103_local6, f103_local7, f103_local8, f103_local9 = nil
	local f103_local10 = 0
	local f103_local11 = 0
	if f103_local2 == nil then
		return 
	end
	local f103_local12 = f103_local2.header
	local f103_local13 = f103_local2.playerBuffer
	local f103_local14 = nil
	if false == CoD.isZombie then
		if f103_local12 ~= nil then
			f103_local3 = f103_local12.isDraw:get()
			f103_local4 = f103_local12.winningTeam:get()
			f103_local5 = f103_local12.teamCount:get()
			f103_local6 = f103_local12.gameModeID:get()
		end
		for f103_local15 = 1, #f103_local13, 1 do
			local f103_local18 = f103_local13[f103_local15 - 1]
			if f103_local18.xuid:get() == f103_local1 then
				f103_local14 = f103_local15 - 1
				f103_local7 = f103_local18.team:get()
				f103_local8 = f103_local18.position:get()
				f103_local9 = f103_local18.partyID:get()
				f103_local10 = f103_local18.score:get()
				f103_local0.kd:setText( f103_local18.kills:get() .. "/" .. f103_local18.deaths:get() )
			end
			local f103_local19 = f103_local18.score:get()
			if f103_local11 < f103_local19 then
				f103_local11 = f103_local19
			end
		end
		if f103_local12 ~= nil and f103_local5 > 1 then
			f103_local10 = 0
			f103_local11 = 0
			for f103_local15 = 1, f103_local5, 1 do
				if f103_local15 == f103_local7 then
					f103_local10 = f103_local12.teamScores[f103_local15]:get()
				end
				local f103_local18 = f103_local12.teamScores[f103_local15]:get()
				if f103_local11 < f103_local18 then
					f103_local11 = f103_local18
				end
			end
		end
	end
	local f103_local15 = {}
	if f103_local9 ~= nil and f103_local9 > 0 then
		for f103_local16 = 1, #f103_local13, 1 do
			local f103_local19 = f103_local13[f103_local16 - 1]
			if f103_local19.partyID:get() == f103_local9 then
				table.insert( f103_local15, f103_local19.gamertag:get() )
			end
		end
		table.sort( f103_local15 )
	end
	if #f103_local15 > 5 and f103_arg0.codtv.codtvIcon ~= nil and f103_arg0.codtv.codtvIcon ~= nil and CoD.Codtv.ShowCODTVIcon( f103_arg0.codtv ) then
		f103_arg0.codtv.codtvIcon:setAlpha( 0 )
	end
	if false == CoD.isZombie then
		local f103_local16 = {
			captures = 0,
			returns = 0,
			destroys = 0,
			plants = 0,
			defuses = 0
		}
		if f103_local14 ~= nil then
			local f103_local17 = f103_local2.gameEvents
			for f103_local20 = 1, #f103_local17, 1 do
				local f103_local21 = f103_local17[f103_local20 - 1]
				if f103_local14 == f103_local21.player:get() then
					local f103_local22 = f103_local21.eventType
					f103_local16.captures = f103_local16.captures + f103_local22.capture:get()
					f103_local16.returns = f103_local16.returns + f103_local22["return"]:get()
					f103_local16.destroys = f103_local16.destroys + f103_local22.destroy:get()
					f103_local16.plants = f103_local16.plants + f103_local22.plant:get()
					f103_local16.defuses = f103_local16.defuses + f103_local22.defuse:get()
				end
			end
		end
		CoD.Codtv.ResetInfoPanelGameModeDetails( f103_local0 )
		if f103_local6 ~= nil and f103_local14 ~= nil and f103_local13 ~= nil and CoD.Codtv.SetInfoPanelGameMode[f103_local6] ~= nil then
			CoD.Codtv.SetInfoPanelGameMode[f103_local6]( f103_local0, f103_local13[f103_local14], f103_local16 )
		end
		if f103_local5 == 1 then
			if f103_local8 == nil then
				f103_local0.gameResult:setText( "" )
			elseif f103_local3 == 1 then
				f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_DRAW" ) )
				f103_local0.gameResult:setRGB( CoD.lightBlue.r, CoD.lightBlue.g, CoD.lightBlue.b )
			elseif f103_local8 < 3 then
				f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_VICTORY" ) )
				f103_local0.gameResult:setRGB( CoD.brightGreen.r, CoD.brightGreen.g, CoD.brightGreen.b )
			else
				f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_DEFEAT" ) )
				f103_local0.gameResult:setRGB( CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b )
			end
		elseif f103_local3 == 1 then
			f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_DRAW" ) .. " " .. f103_local10 .. "-" .. f103_local11 )
			f103_local0.gameResult:setRGB( CoD.lightBlue.r, CoD.lightBlue.g, CoD.lightBlue.b )
		elseif f103_local7 == f103_local4 then
			f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_VICTORY" ) .. " " .. f103_local10 .. "-" .. f103_local11 )
			f103_local0.gameResult:setRGB( CoD.brightGreen.r, CoD.brightGreen.g, CoD.brightGreen.b )
		else
			f103_local0.gameResult:setText( Engine.Localize( "MENU_FILESHARE_DEFEAT" ) .. " " .. f103_local10 .. "-" .. f103_local11 )
			f103_local0.gameResult:setRGB( CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b )
		end
	end
	if #f103_local15 > 0 then
		f103_local0.partyPanel:setAlpha( 1 )
		f103_local0.partyHeader:setAlpha( 1 )
		for f103_local16 = 1, 10, 1 do
			if f103_local16 <= #f103_local15 then
				f103_local0.teammates[f103_local16]:setText( f103_local15[f103_local16] )
			else
				f103_local0.teammates[f103_local16]:setText( "" )
			end
		end
	else
		f103_local0.partyHeader:setAlpha( 0 )
		f103_local0.partyPanel:setAlpha( 0 )
	end
	if false == CoD.isZombie then
		f103_local0.statsPanel:completeAnimation()
		f103_local0.statsPanel:beginAnimation( "fade_in", 250 )
		f103_local0.statsPanel:setAlpha( 1 )
	end
end

CoD.Codtv.ShowPooledFilePanel = function ( f104_arg0 )
	local f104_local0 = f104_arg0.codtv.infoPanel
	local f104_local1 = f104_local0.pooledFilePanel
	f104_local1.playlist:setText( "" )
	f104_local1.time:setText( "" )
	f104_local1.partyHeader:setAlpha( 0 )
	f104_local1.partyPanel:setAlpha( 0 )
	f104_local1.bookmarked:setAlpha( 0 )
	f104_local1.kd:setText( "" )
	f104_local1.gameResult:setText( "" )
	CoD.Codtv.ResetInfoPanelGameModeDetails( f104_local1 )
	if CoD.isZombie == false then
		f104_local1.playlist:setText( Engine.Localize( CoD.FileshareManager.GetPlaylistString( f104_arg0.fileData ) ) )
	end
	if f104_arg0.fileData.bookmarked == true then
		f104_local1.bookmarked:setAlpha( 1 )
	end
	f104_local1.time:setText( f104_arg0.fileData.time )
	f104_arg0.codtv.hintText:updateHintText( f104_arg0.fileData.description )
	Engine.Exec( f104_arg0.codtv.m_ownerController, "fileshareGetSummary " .. f104_arg0.fileData.fileID .. " " .. f104_arg0.fileData.summarySize )
	f104_local0:addElement( f104_local1 )
	f104_local1.loader:setAlpha( 1 )
	f104_local1.statsPanel:setAlpha( 0 )
end

CoD.Codtv.ShowCustomFilePanel = function ( f105_arg0 )
	local f105_local0 = f105_arg0.codtv.infoPanel
	local f105_local1 = f105_local0.customFilePanel
	f105_local1.optInfo:setText( "" )
	f105_local1.optInfo:setAlpha( 0 )
	f105_local1.profileShot:setAlpha( 0 )
	f105_arg0.codtv.hintText:updateHintText( f105_arg0.fileData.description )
	if f105_arg0.fileData.fileID ~= nil and f105_arg0.fileData.fileID ~= "0" then
		local f105_local2 = CoD.FileshareManager.GetGametypeString( f105_arg0.fileData )
		local f105_local3 = Engine.Localize( "MP_UNKNOWN" )
		if f105_arg0.fileData.author ~= nil then
			f105_local3 = f105_arg0.fileData.author
		end
		if f105_arg0.fileData.category == "film" then
			f105_local1.author:setText( Engine.Localize( "MENU_FILESHARE_SAVED_BY" ) .. " " .. f105_local3 )
			f105_local1.optInfo:setText( f105_local2 )
		else
			f105_local1.author:setText( Engine.Localize( "MENU_FILESHARE_AUTHOR" ) .. " " .. f105_local3 )
		end
		if f105_arg0.fileData.category == "customgame" then
			f105_local1.optInfo:setText( f105_local2 )
		end
		if f105_arg0.fileData.category == "screenshot" then
			local f105_local4, f105_local5, f105_local6 = Engine.GetCombatRecordScreenshotInfo( f105_arg0.codtv.m_ownerController, UIExpression.GetXUID( f105_arg0.codtv.m_ownerController ) )
			if f105_local4 == f105_arg0.fileData.fileID then
				f105_local1.profileShot:setAlpha( 1 )
			end
		end
		f105_local1.time:setText( f105_arg0.fileData.time )
		CoD.Codtv.UpdateVotes( f105_arg0, f105_local1 )
		f105_local0:addElement( f105_local1 )
	end
end

CoD.Codtv.ShowIngameStorePanel = function ( f106_arg0 )
	local f106_local0 = f106_arg0.codtv.infoPanel
	local f106_local1 = f106_local0.ingameStorePanel
	local f106_local2 = f106_arg0.fileData.description
	local f106_local3 = f106_arg0.fileData.itemCostString
	local f106_local4 = f106_arg0.fileData.isOfferPurchased
	if f106_local2 ~= nil then
		CoD.ScrollableTextContainer.SetupScrollingText( f106_local1.storeDescContainer, f106_local2, CoD.Codtv.StoreDescriptionContainerWidth, CoD.Codtv.StoreDescriptionContainerHeight, nil, CoD.fonts.Default, CoD.textSize.Default, CoD.Codtv.ScrollableTextPauseTime, CoD.Codtv.ScrollableTextPerLineScrollTime )
	else
		f106_local1.storeDescription:setText( "" )
	end
	if f106_local3 ~= nil then
		f106_local1.offerCost:setText( f106_local3 )
	else
		f106_local1.offerCost:setText( "" )
	end
	if f106_local4 ~= nil and f106_local4 == 1 then
		f106_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_PACKAGE_DOWNLOAD_DESCRIPTION" ) )
		f106_local1.purchasedElement:show()
	else
		f106_arg0.codtv.hintText:updateHintText( Engine.Localize( "MENU_PACKAGE_SELECTION_DESCRIPTION" ) )
		f106_local1.purchasedElement:hide()
	end
	f106_local0:addElement( f106_local1 )
end

CoD.Codtv.ShowFileInfoPanel = function ( f107_arg0 )
	if f107_arg0 ~= nil and f107_arg0.codtv ~= nil and f107_arg0.codtv.infoPanel ~= nil then
		if f107_arg0.fileData ~= nil then
			if f107_arg0.fileData.isPooled == true then
				CoD.Codtv.ShowPooledFilePanel( f107_arg0 )
			elseif f107_arg0.fileData.category == "ingamestore" then
				CoD.Codtv.ShowIngameStorePanel( f107_arg0 )
			else
				CoD.Codtv.ShowCustomFilePanel( f107_arg0 )
			end
		end
		f107_arg0.codtv.infoPanel:completeAnimation()
		f107_arg0.codtv.infoPanel:setAlpha( 0 )
		f107_arg0.codtv.infoPanel:beginAnimation( "fade_in", 250 )
		f107_arg0.codtv.infoPanel:setAlpha( 1 )
	end
end

CoD.Codtv.GetBacking = function ( f108_arg0, f108_arg1, f108_arg2, f108_arg3 )
	local self = LUI.UIElement.new()
	self:setLeftRight( true, false, f108_arg1, f108_arg1 + f108_arg2 )
	self:setTopBottom( true, false, f108_arg0, f108_arg0 + f108_arg3 )
	local f108_local1 = LUI.UIImage.new()
	f108_local1:setLeftRight( true, true, 0, 0 )
	f108_local1:setTopBottom( true, false, 0, 1 )
	f108_local1:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f108_local1:setAlpha( 0.5 )
	self:addElement( f108_local1 )
	local f108_local2 = LUI.UIImage.new()
	f108_local2:setLeftRight( true, true, 0, 0 )
	f108_local2:setTopBottom( false, true, -8, 0 )
	f108_local2:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f108_local2:setImage( RegisterMaterial( "menu_sp_cac_single_dip" ) )
	f108_local2:setAlpha( 0.5 )
	self:addElement( f108_local2 )
	local f108_local3 = LUI.UIImage.new()
	f108_local3:setLeftRight( true, false, 0, 1 )
	f108_local3:setTopBottom( true, true, 0, 0 )
	f108_local3:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f108_local3:setAlpha( 0.5 )
	self:addElement( f108_local3 )
	local f108_local4 = LUI.UIImage.new()
	f108_local4:setLeftRight( false, true, -1, 0 )
	f108_local4:setTopBottom( true, true, 0, 0 )
	f108_local4:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f108_local4:setAlpha( 0.5 )
	self:addElement( f108_local4 )
	return self
end

CoD.Codtv.CreatePooledFilePanel = function ()
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 15, 0 )
	self:setTopBottom( true, true, 0, 0 )
	local f109_local1 = 20
	self.gameResult = LUI.UIText.new()
	self.gameResult:setLeftRight( true, true, 0, 0 )
	self.gameResult:setTopBottom( true, false, f109_local1, f109_local1 + CoD.textSize.Condensed )
	self.gameResult:setAlignment( LUI.Alignment.Left )
	self.gameResult:setFont( CoD.fonts.Condensed )
	self:addElement( self.gameResult )
	local f109_local2 = LUI.UIElement.new()
	f109_local2:setLeftRight( true, true, 0, 0 )
	f109_local2:setTopBottom( true, false, f109_local1, f109_local1 + CoD.textSize.Condensed )
	local f109_local3 = Engine.Localize( "MENU_BOOKMARKED" )
	local f109_local4 = {}
	f109_local4 = GetTextDimensions( f109_local3, CoD.fonts.Default, CoD.textSize.Default )
	local f109_local5 = f109_local4[3]
	local f109_local6 = LUI.UIText.new()
	f109_local6:setLeftRight( false, true, -f109_local5, 0 )
	f109_local6:setTopBottom( false, true, -CoD.textSize.Default, 0 )
	f109_local6:setAlignment( LUI.Alignment.Right )
	f109_local6:setFont( CoD.fonts.Default )
	f109_local6:setText( f109_local3 )
	f109_local6:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
	f109_local2:addElement( f109_local6 )
	local f109_local7 = LUI.UIImage.new()
	f109_local7:setLeftRight( false, true, -f109_local5 - CoD.textSize.Default - 5, -f109_local5 - 5 )
	f109_local7:setTopBottom( false, true, -CoD.textSize.Default, 0 )
	f109_local7:setImage( RegisterMaterial( "menu_mp_star_rating" ) )
	f109_local7:setRGB( CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b )
	f109_local2:addElement( f109_local7 )
	self.bookmarked = f109_local2
	self.bookmarked:setAlpha( 0 )
	self:addElement( self.bookmarked )
	if CoD.isZombie then
		self.gameResult:setAlpha( 0 )
	end
	f109_local1 = f109_local1 + CoD.textSize.Condensed + 10
	self.loader = LUI.UIImage.new()
	self.loader:setLeftRight( false, false, -32, 32 )
	self.loader:setTopBottom( true, false, f109_local1, f109_local1 + 64 )
	self.loader:setImage( RegisterMaterial( "lui_loader" ) )
	self.loader:setShaderVector( 0, 0, 0, 0, 0 )
	self.loader:setAlpha( 0 )
	self:addElement( self.loader )
	local f109_local8 = 15
	local f109_local9 = 110
	local f109_local10 = 45
	local f109_local11 = f109_local8
	local f109_local12 = f109_local11 + f109_local9 + f109_local8
	local f109_local13 = f109_local12 + f109_local9 + f109_local8
	local f109_local14 = 74
	local f109_local15 = f109_local9 * 3 + f109_local8 * 4
	local f109_local16 = LUI.UIElement.new()
	f109_local16:setLeftRight( true, false, 0, f109_local15 )
	f109_local16:setTopBottom( true, false, f109_local1, f109_local1 + f109_local14 )
	self.statsPanel = f109_local16
	self:addElement( f109_local16 )
	if CoD.isZombie then
		f109_local16:setAlpha( 0 )
	end
	f109_local16:addElement( CoD.Border.new( 1, CoD.offGray.r, CoD.offGray.g, CoD.offGray.b, 0.5 ) )
	local f109_local17 = 3
	local f109_local18 = LUI.UIText.new()
	f109_local18:setLeftRight( true, false, f109_local11, f109_local11 + f109_local9 )
	f109_local18:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.ExtraSmall )
	f109_local18:setAlignment( LUI.Alignment.Center )
	f109_local18:setFont( CoD.fonts.ExtraSmall )
	f109_local18:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f109_local18:setText( Engine.Localize( "MENU_KILLS_CAPS" ) .. "/" .. Engine.Localize( "MENU_DEATHS_CAPS" ) )
	f109_local16:addElement( f109_local18 )
	self.gameModeStat1Header = LUI.UIText.new()
	self.gameModeStat1Header:setLeftRight( true, false, f109_local12, f109_local12 + f109_local9 )
	self.gameModeStat1Header:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.ExtraSmall )
	self.gameModeStat1Header:setAlignment( LUI.Alignment.Center )
	self.gameModeStat1Header:setFont( CoD.fonts.ExtraSmall )
	self.gameModeStat1Header:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f109_local16:addElement( self.gameModeStat1Header )
	self.gameModeStat2Header = LUI.UIText.new()
	self.gameModeStat2Header:setLeftRight( true, false, f109_local13, f109_local13 + f109_local9 )
	self.gameModeStat2Header:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.ExtraSmall )
	self.gameModeStat2Header:setAlignment( LUI.Alignment.Center )
	self.gameModeStat2Header:setFont( CoD.fonts.ExtraSmall )
	self.gameModeStat2Header:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	f109_local16:addElement( self.gameModeStat2Header )
	f109_local17 = f109_local17 + CoD.textSize.ExtraSmall
	f109_local16:addElement( CoD.Codtv.GetBacking( f109_local17, f109_local11, f109_local9, f109_local10 ) )
	f109_local16:addElement( CoD.Codtv.GetBacking( f109_local17, f109_local12, f109_local9, f109_local10 ) )
	f109_local16:addElement( CoD.Codtv.GetBacking( f109_local17, f109_local13, f109_local9, f109_local10 ) )
	f109_local17 = f109_local17 + 5
	self.kd = LUI.UIText.new()
	self.kd:setLeftRight( true, false, f109_local11, f109_local11 + f109_local9 )
	self.kd:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.Condensed )
	self.kd:setAlignment( LUI.Alignment.Center )
	self.kd:setFont( CoD.fonts.Condensed )
	f109_local16:addElement( self.kd )
	self.gameModeStat1 = LUI.UIText.new()
	self.gameModeStat1:setLeftRight( true, false, f109_local12, f109_local12 + f109_local9 )
	self.gameModeStat1:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.Condensed )
	self.gameModeStat1:setAlignment( LUI.Alignment.Center )
	self.gameModeStat1:setFont( CoD.fonts.Condensed )
	f109_local16:addElement( self.gameModeStat1 )
	self.gameModeStat2 = LUI.UIText.new()
	self.gameModeStat2:setLeftRight( true, false, f109_local13, f109_local13 + f109_local9 )
	self.gameModeStat2:setTopBottom( true, false, f109_local17, f109_local17 + CoD.textSize.Condensed )
	self.gameModeStat2:setAlignment( LUI.Alignment.Center )
	self.gameModeStat2:setFont( CoD.fonts.Condensed )
	f109_local16:addElement( self.gameModeStat2 )
	f109_local1 = f109_local1 + f109_local14 + 15
	self.time = LUI.UIText.new()
	self.time:setLeftRight( true, true, 0, 0 )
	self.time:setTopBottom( true, false, f109_local1, f109_local1 + CoD.textSize.Default )
	self.time:setAlignment( LUI.Alignment.Left )
	self.time:setFont( CoD.fonts.Default )
	self.time:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	self:addElement( self.time )
	f109_local1 = f109_local1 + CoD.textSize.Default
	self.playlist = LUI.UIText.new()
	self.playlist:setLeftRight( true, true, 0, 0 )
	self.playlist:setTopBottom( true, false, f109_local1, f109_local1 + CoD.textSize.Default )
	self.playlist:setAlignment( LUI.Alignment.Left )
	self.playlist:setFont( CoD.fonts.Default )
	self.playlist:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	self:addElement( self.playlist )
	f109_local1 = f109_local1 + CoD.textSize.Default + 15
	self.partyHeader = LUI.UIText.new()
	self.partyHeader:setLeftRight( true, true, 0, 0 )
	self.partyHeader:setTopBottom( true, false, f109_local1, f109_local1 + CoD.textSize.ExtraSmall )
	self.partyHeader:setAlignment( LUI.Alignment.Left )
	self.partyHeader:setFont( CoD.fonts.ExtraSmall )
	self.partyHeader:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	self.partyHeader:setText( Engine.Localize( "MENU_PARTY_CAPS" ) )
	self:addElement( self.partyHeader )
	f109_local1 = f109_local1 + CoD.textSize.ExtraSmall
	
	local partyPanel = LUI.UIElement.new()
	partyPanel:setLeftRight( true, false, 0, 455 )
	partyPanel:setTopBottom( true, false, f109_local1, f109_local1 + 130 )
	self:addElement( partyPanel )
	self.partyPanel = partyPanel
	
	self.teammates = {}
	local f109_local20 = 0
	local f109_local21 = 220
	for f109_local22 = 1, 2, 1 do
		for f109_local25 = 1, 5, 1 do
			local f109_local28 = CoD.textSize.Default * (f109_local25 - 1)
			local f109_local29 = f109_local21 * (f109_local22 - 1)
			f109_local20 = f109_local20 + 1
			self.teammates[f109_local20] = LUI.UIText.new()
			self.teammates[f109_local20]:setLeftRight( true, false, f109_local29, f109_local29 + f109_local21 )
			self.teammates[f109_local20]:setTopBottom( true, false, f109_local28, f109_local28 + CoD.textSize.Default )
			self.teammates[f109_local20]:setAlignment( LUI.Alignment.Left )
			self.teammates[f109_local20]:setFont( CoD.fonts.Default )
			partyPanel:addElement( self.teammates[f109_local20] )
		end
	end
	return self
end

CoD.Codtv.CreateCustomFilePanel = function ()
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 15, 0 )
	self:setTopBottom( true, true, 0, 0 )
	local f110_local1 = 50
	self.likePanel = CoD.FileshareManager.StatPanel( 0, f110_local1, "likes" )
	self:addElement( self.likePanel )
	self.dislikePanel = CoD.FileshareManager.StatPanel( 145, f110_local1, "dislikes" )
	self:addElement( self.dislikePanel )
	self.viewPanel = CoD.FileshareManager.StatPanel( 290, f110_local1, "views" )
	self:addElement( self.viewPanel )
	f110_local1 = f110_local1 + 60
	self.author = LUI.UIText.new()
	self.author:setLeftRight( true, true, 0, 0 )
	self.author:setTopBottom( true, false, f110_local1, f110_local1 + CoD.textSize.Default )
	self.author:setAlignment( LUI.Alignment.Left )
	self.author:setRGB( 0.8, 0.8, 0.8 )
	self:addElement( self.author )
	f110_local1 = f110_local1 + CoD.textSize.Default
	self.time = LUI.UIText.new()
	self.time:setLeftRight( true, true, 0, 0 )
	self.time:setTopBottom( true, false, f110_local1, f110_local1 + CoD.textSize.Default )
	self.time:setAlignment( LUI.Alignment.Left )
	self.time:setFont( CoD.fonts.Default )
	self.time:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	self:addElement( self.time )
	f110_local1 = f110_local1 + CoD.textSize.Default
	self.optInfo = LUI.UIText.new()
	self.optInfo:setLeftRight( true, true, 0, 0 )
	self.optInfo:setTopBottom( true, false, f110_local1, f110_local1 + CoD.textSize.Default )
	self.optInfo:setAlignment( LUI.Alignment.Left )
	self.optInfo:setFont( CoD.fonts.Default )
	self.optInfo:setRGB( CoD.offGray.r, CoD.offGray.g, CoD.offGray.b )
	self:addElement( self.optInfo )
	self.profileShot = CoD.FileshareManager.GetProfileShot( f110_local1, CoD.fonts.Default, CoD.textSize.Default )
	self.profileShot:setAlpha( 0 )
	self:addElement( self.profileShot )
	return self
end

CoD.Codtv.CreateIngameStorePanel = function ()
	local self = LUI.UIElement.new()
	self:setLeftRight( true, true, 25, 0 )
	self:setTopBottom( true, true, 0, 0 )
	local f111_local1 = 27
	self.purchasedElement = LUI.UIElement.new()
	self.purchasedElement:setLeftRight( true, true, 0, 250 )
	self.purchasedElement:setTopBottom( true, false, f111_local1, f111_local1 + CoD.textSize.Default )
	self:addElement( self.purchasedElement )
	self.purchasedChecker = LUI.UIImage.new()
	self.purchasedChecker:setLeftRight( true, false, 0, CoD.textSize.ExtraSmall )
	self.purchasedChecker:setTopBottom( false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2 )
	self.purchasedChecker:setImage( RegisterMaterial( "menu_mp_killstreak_select" ) )
	self.purchasedElement:addElement( self.purchasedChecker )
	self.purchasedText = LUI.UIText.new()
	self.purchasedText:setLeftRight( true, true, CoD.textSize.Default + 5, 0 )
	self.purchasedText:setTopBottom( true, true, 0, 0 )
	self.purchasedText:setFont( CoD.fonts.Default )
	self.purchasedText:setRGB( 0.6, 0.6, 0.6 )
	self.purchasedText:setText( Engine.Localize( "MENU_STORE_OFFER_PURCHASED" ) )
	self.purchasedText:setAlignment( LUI.Alignment.Left )
	self.purchasedElement:addElement( self.purchasedText )
	f111_local1 = f111_local1 + CoD.textSize.Default + 10
	self.costString = LUI.UIText.new()
	self.costString:setLeftRight( true, true, 0, 300 )
	self.costString:setTopBottom( true, false, f111_local1, f111_local1 + CoD.textSize.Default )
	self.costString:setFont( CoD.fonts.Default )
	self.costString:setRGB( 0.3, 0.3, 0.3 )
	self.costString:setText( Engine.Localize( "MENU_COST" ) )
	self.costString:setAlignment( LUI.Alignment.Left )
	self:addElement( self.costString )
	local f111_local2 = {}
	f111_local2 = GetTextDimensions( Engine.Localize( "MENU_COST" ), CoD.fonts.Default, CoD.textSize.Default )
	self.offerCost = LUI.UIText.new()
	self.offerCost:setLeftRight( true, true, f111_local2[3] + 10, 0 )
	self.offerCost:setTopBottom( true, false, f111_local1, f111_local1 + CoD.textSize.Default )
	self.offerCost:setFont( CoD.fonts.Default )
	self.offerCost:setRGB( 0.6, 0.6, 0.6 )
	self.offerCost:setAlignment( LUI.Alignment.Left )
	self:addElement( self.offerCost )
	f111_local1 = f111_local1 + CoD.textSize.Default + 10
	self.descriptionHeader = LUI.UIText.new()
	self.descriptionHeader:setLeftRight( true, true, 0, 0 )
	self.descriptionHeader:setTopBottom( true, false, f111_local1, f111_local1 + CoD.textSize.Default )
	self.descriptionHeader:setFont( CoD.fonts.Default )
	self.descriptionHeader:setRGB( 0.3, 0.3, 0.3 )
	self.descriptionHeader:setText( Engine.Localize( "MENU_DESCRIPTION" ) )
	self.descriptionHeader:setAlignment( LUI.Alignment.Left )
	self:addElement( self.descriptionHeader )
	f111_local1 = f111_local1 + CoD.textSize.Default + 5
	self.storeDescContainer = LUI.UIElement.new()
	self.storeDescContainer:setUseStencil( true )
	self.storeDescContainer:setLeftRight( false, true, -CoD.Codtv.StoreDescriptionContainerWidth, 0 )
	self.storeDescContainer:setTopBottom( true, false, f111_local1, f111_local1 + CoD.Codtv.StoreDescriptionContainerHeight )
	self:addElement( self.storeDescContainer )
	return self
end

CoD.Codtv.CreateInfoPanel = function ( f112_arg0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( false, true, -CoD.Codtv.InfoPanelWidth, 0 )
	self:setTopBottom( true, false, CoD.Codtv.InfoPanelTop, CoD.Codtv.InfoPanelTop + CoD.Codtv.InfoPanelHeight )
	self.m_ownerController = controller
	self.codtv = f112_arg0
	self.customFilePanel = CoD.Codtv.CreateCustomFilePanel()
	self.pooledFilePanel = CoD.Codtv.CreatePooledFilePanel()
	self.ingameStorePanel = CoD.Codtv.CreateIngameStorePanel()
	self.showSummary = CoD.Codtv.ShowPooledFilePanelSummary
	return self
end

CoD.Codtv.SavedState = nil
CoD.Codtv.OpenFileManager = function ( f113_arg0, f113_arg1 )
	CoD.Codtv.SavedState = {}
	CoD.Codtv.SavedState.rootRef = f113_arg0.m_rootRef
	CoD.Codtv.SavedState.rootFolderIndex = f113_arg0.m_rootFolderIndex
	CoD.Codtv.SavedState.currentFolderIndex = f113_arg0.m_currentFolderIndex
	CoD.Codtv.SavedState.previousFolderIndex = f113_arg0.m_previousFolderIndex
	CoD.Codtv.SavedState.carouselContext = f113_arg0.m_carouselContext
	local f113_local0 = f113_arg0:openPopup( "FileshareManager", f113_arg1.controller )
end

CoD.Codtv.ShowCODTVIcon = function ( f114_arg0 )
	if f114_arg0 ~= nil and f114_arg0.m_rootRef == "community" then
		return true
	else
		return false
	end
end

CoD.Codtv.ShowPS3StoreLogo = function ( f115_arg0 )
	if f115_arg0 ~= nil and f115_arg0.m_rootRef == "ingamestore" and CoD.isPS3 == true then
		return true
	else
		return false
	end
end

CoD.Codtv.SlotsAvailable = function ( f116_arg0, f116_arg1 )
	local f116_local0 = f116_arg1.controller
	if f116_arg0.m_loaded == true then
		return 
	end
	f116_arg0.m_loaded = true
	f116_arg0.spinner:setAlpha( 0 )
	if f116_arg1.valid == false then
		f116_arg0.occludedMenu:openPopup( "FileshareManager_Error", f116_arg1.controller )
		f116_arg0:close()
		return 
	elseif f116_arg0.m_rootRef ~= nil and f116_arg0.m_rootRef ~= "" then
		local f116_local1 = Engine.GetCodtvRoot( f116_arg0.m_rootRef )
		if f116_local1 == nil then
			f116_arg0.occludedMenu:openPopup( "FileshareManager_Error", f116_arg1.controller )
			f116_arg0:close()
			return 
		end
		local f116_local2 = Engine.GetCodtvContent( f116_local1 )
		f116_arg0.m_rootFolderIndex = f116_local1
		f116_arg0.m_previousFolderIndex = nil
		f116_arg0.m_currentFolderIndex = f116_local1
		f116_arg0.hintText = CoD.Codtv.CreateHintText( f116_local0, 0, 312, 350, 80 )
		f116_arg0:addElement( f116_arg0.hintText )
		f116_arg0.infoPanel = CoD.Codtv.CreateInfoPanel( f116_arg0 )
		f116_arg0:addElement( f116_arg0.infoPanel )
		if CoD.Codtv.ShowCODTVIcon( f116_arg0 ) == true or CoD.Codtv.ShowPS3StoreLogo( f116_arg0 ) == true then
			if f116_arg0.codtvIcon == nil and f116_arg0.m_rootRef ~= "ingamestore" then
				f116_arg0.codtvIcon = LUI.UIImage.new()
				f116_arg0.codtvIcon:setLeftRight( false, true, -256, 0 )
				f116_arg0.codtvIcon:setTopBottom( false, true, -109, -45 )
				f116_arg0.codtvIcon:setImage( RegisterMaterial( "menu_codtv_logo" ) )
				f116_arg0:addElement( f116_arg0.codtvIcon )
			elseif CoD.Codtv.ShowPS3StoreLogo( f116_arg0 ) == true then
				f116_arg0.codtvIcon = LUI.UIImage.new()
				f116_arg0.codtvIcon:setLeftRight( false, true, -128, 0 )
				f116_arg0.codtvIcon:setTopBottom( false, true, -62, -30 )
				f116_arg0.codtvIcon:setImage( RegisterMaterial( "playstation_store_ingame_logo" ) )
				f116_arg0:addElement( f116_arg0.codtvIcon )
			else
				f116_arg0.codtvIcon:setAlpha( 1 )
			end
		elseif f116_arg0.codtvIcon ~= nil then
			f116_arg0.codtvIcon:setAlpha( 1 )
		end
		if f116_local2 ~= nil then
			f116_arg0:addTitle( UIExpression.ToUpper( nil, f116_local2.name ) )
			local f116_local3 = 454
			local f116_local4 = LUI.UIImage.new()
			f116_local4:setLeftRight( true, false, 0, CoD.Menu.Width / 2 - 85 )
			f116_local4:setTopBottom( true, false, f116_local3, f116_local3 + 1 )
			f116_local4:setAlpha( 0.05 )
			f116_arg0:addElement( f116_local4 )
			f116_arg0.m_cardCarouselList = CoD.Codtv.GetCarouselList( f116_arg0, f116_local2 )
			f116_arg0:addElement( f116_arg0.m_cardCarouselList )
			if f116_arg0.m_rootRef == "ingamestore" and true == CoD.isPS3 then
				f116_arg0.m_cardCarouselList:setInitialCarousel( UIExpression.DvarInt( nil, "ui_storeCategory" ), 0 )
				Engine.SetDvar( "ui_storeCategory", 1 )
			end
			f116_arg0.m_cardCarouselList:focusCurrentCardCarousel( f116_local0 )
		end
		if f116_arg0.m_rootRef == "emblems" then
			local f116_local3 = UIExpression.TableLookup( nil, "mp/filesharecategories.csv", 0, "emblem", 2 )
			local f116_local4 = Engine.GetFileshareCategories( f116_arg1.controller, "emblem" )
			f116_arg0.m_emblemSlotsOccupied = f116_local4[1].occupied
			f116_arg0.m_emblemSlotsRemaining = f116_local4[1].remaining
			f116_arg0.m_embemNextSlot = Engine.GetFileshareNextSlot( f116_arg1.controller, f116_local3 )
		end
	end
end

CoD.Codtv.InputSourceChanged = function ( f117_arg0, f117_arg1 )
	f117_arg0.saveButtonPrompt:processEvent( f117_arg1 )
	f117_arg0.voteButtonPrompt:processEvent( f117_arg1 )
	f117_arg0.emblemOptionsPrompt:processEvent( f117_arg1 )
	f117_arg0:dispatchEventToChildren( f117_arg1 )
end

CoD.Codtv.MTXChanged = function ( f118_arg0, f118_arg1 )
	if f118_arg1.controller ~= f118_arg0.m_ownerController then
		return 
	elseif f118_arg0.m_rootRef ~= "ingamestore" then
		f118_arg0:reload( f118_arg0.m_rootFolderIndex )
	end
end

CoD.Codtv.OpenMTXPurchase = function ( f119_arg0, f119_arg1 )
	f119_arg0:openPopup( "MTXPurchase", f119_arg1.controller, f119_arg1.userData )
end

CoD.Codtv.OpenNoGuestMTX = function ( f120_arg0, f120_arg1 )
	local f120_local0 = f120_arg0:openPopup( "Error", controller )
	f120_local0:setMessage( Engine.Localize( "XBOXLIVE_NOGUESTACCOUNTS" ) )
end

LUI.createMenu.CODTv = function ( f121_arg0 )
	local f121_local0 = CoD.perController[f121_arg0].codtvRoot
	local f121_local1 = CoD.Menu.New( "CODTv", nil, nil, f121_local0 )
	Engine.Exec( f121_arg0, "vote_getHistory" )
	f121_local1.m_rootRef = f121_local0
	f121_local1.m_loaded = false
	CoD.Codtv.WebMShutdown()
	f121_local1:addLargePopupBackground()
	f121_local1:setOwner( f121_arg0 )
	if f121_local0 == "ingamestore" then
		if CoD.Codtv.INVALID_MTX_ID == UIExpression.DvarInt( nil, "ui_mtxid" ) then
			Engine.SetStartCheckoutTimestampUTC()
		end
		Engine.SendDLCMenusViewedRecordEvent( f121_arg0, CoD.INGAMESTORE_MENU_VIEWED, "ingamestore" )
		f121_local1.unusedControllerAllowed = true
	end
	if f121_local0 == "playerchannel" then
		f121_local1.m_playerChannelXuid = CoD.perController[f121_arg0].playerChannelXuid
		f121_local1.userData = f121_local1.m_playerChannelXuid
		if CoD.isMultiplayer and not CoD.isZombie and f121_local1.m_playerChannelXuid ~= nil and f121_local1.m_playerChannelXuid ~= "" then
			f121_local1:addElement( CoD.MiniIdentity.GetMiniIdentity( f121_arg0, f121_local1.m_playerChannelXuid ) )
		end
	end
	if f121_local0 == "emblems" then
		f121_local1:setPreviousMenu( "Barracks" )
	end
	if f121_local0 == "leagueidentity" then
		f121_local1:setPreviousMenu( "LeagueTeamNamePopup" )
	end
	f121_local1:addBackButton()
	f121_local1:registerEventHandler( "fileshare_slots_available", CoD.Codtv.SlotsAvailable )
	if f121_local0 == "combatrecord" then
		f121_local1:setPreviousMenu( "CRCareer" )
	else
		f121_local1.saveButtonPrompt = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_FILESHARE_SAVE" ), f121_local1, "card_save", false, false, false, false, "S" )
		f121_local1.reportButtonPrompt = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_FILESHARE_REPORT_EMBLEM" ), f121_local1, "card_report", false, false, false, false, "R" )
		f121_local1.voteButtonPrompt = CoD.ButtonPrompt.new( "alt2", Engine.Localize( "MENU_FILESHARE_LIKEDISLIKE" ), f121_local1, "card_vote", false, false, false, false, "L" )
		f121_local1.emblemOptionsPrompt = CoD.ButtonPrompt.new( "alt1", Engine.Localize( "MENU_EMBLEM_OPTIONS" ), f121_local1, "fileshare_emblem_options", false, false, false, false, "O" )
	end
	f121_local1.reload = CoD.Codtv.ReloadMenu
	f121_local1.goBack = CoD.Codtv.GoBack
	f121_local1.animateOutAndGoBack = CoD.Codtv.AnimateOutAndGoBack
	f121_local1:registerEventHandler( "fileshare_open_manager", CoD.Codtv.OpenFileManager )
	f121_local1:registerEventHandler( "infopanel_update_votes", CoD.Codtv.UpdateVotesEvent )
	f121_local1:registerEventHandler( "fileshare_emblem_options", CoD.Codtv.EmblemOptions )
	f121_local1:registerEventHandler( "store_purchase_confirmation", CoD.Codtv.StorePurchaseConfirmation )
	f121_local1:registerEventHandler( "signed_out", CoD.Menu.SignedOut )
	f121_local1:registerEventHandler( "mtx_changed", CoD.Codtv.MTXChanged )
	f121_local1:registerEventHandler( "open_mtx_purchase", CoD.Codtv.OpenMTXPurchase )
	f121_local1:registerEventHandler( "open_no_guest_mtx", CoD.Codtv.OpenNoGuestMTX )
	f121_local1:registerEventHandler( "input_source_changed", CoD.Codtv.InputSourceChanged )
	local self = LUI.UIImage.new( {
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	} )
	self:setImage( RegisterMaterial( "lui_loader" ) )
	self:setTopBottom( false, false, -32, 32 )
	self:setLeftRight( false, false, -32, 32 )
	f121_local1.spinner = self
	f121_local1:addElement( self )
	Engine.Exec( f121_arg0, "fileshareGetSlots" )
	return f121_local1
end

LUI.createMenu.CODTv_Error = function ( f122_arg0 )
	local f122_local0 = CoD.Popup.SetupPopup( "CODTv_Error", f122_arg0 )
	f122_local0.title:setText( Engine.Localize( "MENU_NOTICE" ) )
	f122_local0.msg:setText( Engine.Localize( "MENU_COD_TV_DISABLED_DUE_TO_LIVE_STREAM" ) )
	f122_local0:addSelectButton( Engine.Localize( "MPUI_OK" ), 100, "button_prompt_back" )
	return f122_local0
end

