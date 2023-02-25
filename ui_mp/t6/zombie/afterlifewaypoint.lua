CoD.AfterlifeWaypoint = {}
CoD.AfterlifeWaypoint.IconAlpha = 0.5
CoD.AfterlifeWaypoint.IconRatio = 2
CoD.AfterlifeWaypoint.IconWidth = 40
CoD.AfterlifeWaypoint.IconHeight = CoD.AfterlifeWaypoint.IconWidth / CoD.AfterlifeWaypoint.IconRatio
CoD.AfterlifeWaypoint.PULSE_DURATION = 3000
CoD.AfterlifeWaypoint.ICON_STATE_CLEAR = 0
CoD.AfterlifeWaypoint.ReviveMaterialName = "waypoint_revive_afterlife"
CoD.AfterlifeWaypoint.ArrowMaterialName = "waypoint_afterlife_blue_arrow"
CoD.AfterlifeWaypoint.RegisterMaterials = function ()
	if not CoD.AfterlifeWaypoint.ReviveIconMaterial then
		CoD.AfterlifeWaypoint.ReviveIconMaterial = RegisterMaterial( CoD.AfterlifeWaypoint.ReviveMaterialName )
	end
	if not CoD.AfterlifeWaypoint.ArrowMaterial then
		CoD.AfterlifeWaypoint.ArrowMaterial = RegisterMaterial( CoD.AfterlifeWaypoint.ArrowMaterialName )
	end
end

CoD.AfterlifeWaypoint.new = function ( f2_arg0 )
	local self = LUI.UIElement.new()
	self:setLeftRight( false, false, -CoD.AfterlifeWaypoint.IconWidth / 2, CoD.AfterlifeWaypoint.IconWidth / 2 )
	self:setTopBottom( false, false, -CoD.AfterlifeWaypoint.IconHeight / 2, CoD.AfterlifeWaypoint.IconHeight / 2 )
	self:setupEntityContainer( f2_arg0, 0, 0, 50 )
	self:setEntityContainerScale( false )
	self:setEntityContainerClamp( true )
	
	local alphaController = LUI.UIElement.new()
	alphaController:setLeftRight( true, true, 0, 0 )
	alphaController:setTopBottom( true, true, 0, 0 )
	self:addElement( alphaController )
	self.alphaController = alphaController
	
	local mainImage = LUI.UIImage.new()
	mainImage:setLeftRight( true, true, 0, 0 )
	mainImage:setTopBottom( true, true, 0, 0 )
	mainImage:setImage( CoD.AfterlifeWaypoint.ReviveIconMaterial )
	alphaController:addElement( mainImage )
	self.mainImage = mainImage
	
	local edgePointerContainer = LUI.UIElement.new()
	edgePointerContainer:setLeftRight( true, true, 0, 0 )
	edgePointerContainer:setTopBottom( true, true, 0, 0 )
	alphaController:addElement( edgePointerContainer )
	self.edgePointerContainer = edgePointerContainer
	
	local arrowImage = LUI.UIImage.new()
	arrowImage:setLeftRight( false, false, -10, 10 )
	arrowImage:setTopBottom( false, true, 10, 20 )
	arrowImage:setImage( CoD.AfterlifeWaypoint.ArrowMaterial )
	edgePointerContainer:addElement( arrowImage )
	self.arrowImage = arrowImage
	
	self:registerEventHandler( "entity_container_clamped", CoD.AfterlifeWaypoint.Clamped )
	self:registerEventHandler( "entity_container_unclamped", CoD.AfterlifeWaypoint.Unclamped )
	return self
end

CoD.AfterlifeWaypoint.Clamped = function ( f3_arg0, f3_arg1 )
	if f3_arg0.edgePointerContainer then
		f3_arg0.edgePointerContainer:setupEdgePointer( 90 )
	end
end

CoD.AfterlifeWaypoint.Unclamped = function ( f4_arg0, f4_arg1 )
	if f4_arg0.edgePointerContainer then
		f4_arg0.edgePointerContainer:setupUIElement()
		f4_arg0.edgePointerContainer:setZRot( 0 )
	end
end

