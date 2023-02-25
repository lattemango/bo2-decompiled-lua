CoD.VoipImage = {}
CoD.VoipImage.new = function ( menu, controller )
	local self = LUI.UIImage.new( menu )
	self:setupVoipImage( controller )
	return self
end

