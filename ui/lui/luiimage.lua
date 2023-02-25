LUI.UIImage = InheritFrom( LUI.UIElement )
LUI.UIImage.addElement = function ( f1_arg0, f1_arg1 )
	DebugPrint( "WARNING: An element is being added to a UIImage element. This will cause undesired behavior!" )
	LUI.UIElement.addElement( f1_arg0, f1_arg1 )
end

LUI.UIImage.addElementBefore = function ( f2_arg0, f2_arg1 )
	DebugPrint( "WARNING: An element is being added to a UIImage element. This will cause undesired behavior!" )
	LUI.UIElement.addElementBefore( f2_arg0, f2_arg1 )
end

LUI.UIImage.addElementAfter = function ( f3_arg0, f3_arg1 )
	DebugPrint( "WARNING: An element is being added to a UIImage element. This will cause undesired behavior!" )
	LUI.UIElement.addElementAfter( f3_arg0, f3_arg1 )
end

LUI.UIImage.new = function ( f4_arg0 )
	local self = LUI.UIElement.new( f4_arg0 )
	self:setClass( LUI.UIImage )
	self:setupUIImage()
	return self
end

LUI.UIImage.id = "LUIImage"
