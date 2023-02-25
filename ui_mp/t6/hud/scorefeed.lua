CoD.ScoreFeed = {}
CoD.ScoreFeed.MaxRows = 4
CoD.ScoreFeed.RowHeight = 25
CoD.ScoreFeed.LabelOffset = -40
CoD.ScoreFeed.ExpandTime = 200
CoD.ScoreFeed.ShrinkTime = 150
CoD.ScoreFeed.RowScoreThresholds = {
	50,
	150
}
CoD.ScoreFeed.RowHeights = {
	18,
	20,
	22
}
CoD.ScoreFeed.RowFonts = {
	CoD.fonts.Dist,
	CoD.fonts.Dist,
	CoD.fonts.Dist
}
CoD.ScoreFeed.RowDurations = {
	1000,
	1000,
	1000
}
CoD.ScoreFeed.feedDuration = 1000
CoD.ScoreFeed.Spacing = 0
CoD.ScoreFeed.Height = CoD.ScoreFeed.RowHeights[#CoD.ScoreFeed.RowHeights] * CoD.ScoreFeed.MaxRows + CoD.ScoreFeed.Spacing * (CoD.ScoreFeed.MaxRows - 1)
CoD.ScoreFeed.Color1 = {
	r = CoD.blue.r * 0.25,
	g = CoD.blue.g * 0.25,
	b = CoD.blue.b * 0.25
}
CoD.ScoreFeed.Color2 = {
	r = 0.07,
	g = 0.04,
	b = 0.05
}
CoD.ScoreFeed.Color3 = {
	r = 0.06,
	g = 0,
	b = 0.12
}
CoD.ScoreFeed.ScoreStreakColor1 = {
	r = CoD.yellowGlow.r * 0.25,
	g = CoD.yellowGlow.g * 0.25,
	b = CoD.yellowGlow.b * 0.25
}
CoD.ScoreFeed.ScoreStreakColor2 = {
	r = 0.12,
	g = 0.06,
	b = 0
}
CoD.ScoreFeed.ScoreStreakColor3 = {
	r = 0.12,
	g = 0,
	b = 0
}
CoD.ScoreFeed.new = function ( f1_arg0 )
	local self = LUI.UIVerticalList.new( f1_arg0 )
	self:registerEventHandler( "time_up", CoD.ScoreFeed.Reset )
	self:registerEventHandler( "demo_jump", CoD.ScoreFeed.DemoJump )
	self.rows = {}
	self.addRow = CoD.ScoreFeed.AddRow
	return self
end

CoD.ScoreFeed.AddRow = function ( f2_arg0, f2_arg1, f2_arg2, f2_arg3 )
	local f2_local0 = CoD.ScoreFeed.LabelOffset
	local f2_local1 = f2_arg0.rows
	local f2_local2 = CoD.ScoreFeed.MaxRows
	local f2_local3 = CoD.ScoreFeed.RowScoreThresholds
	local f2_local4 = #f2_local3 + 1
	for f2_local8, f2_local9 in ipairs( f2_local3 ) do
		if f2_arg2 < f2_local9 then
			f2_local4 = f2_local8
			break
		end
	end
	f2_local5 = CoD.ScoreFeed.RowFonts[f2_local4]
	f2_local6 = CoD.textSize.Default
	f2_local7 = CoD.ScoreFeed.RowDurations[f2_local4]
	local f2_local9, f2_local10, f2_local11, f2_local12 = GetTextDimensions( f2_arg1, f2_local5, f2_local6 + 3 * 2 )
	local f2_local13 = f2_local11 + f2_local9 - f2_local0
	local self = LUI.UIElement.new( {
		left = 0,
		top = 0,
		right = 2560,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 1
	} )
	self:setPriority( -1 )
	f2_arg0:addElement( self )
	self:setPriority( 0 )
	table.insert( f2_local1, self )
	self:registerAnimationState( "expand", {
		top = 0,
		bottom = f2_local6 + CoD.ScoreFeed.Spacing,
		topAnchor = true,
		bottomAnchor = false
	} )
	self:registerAnimationState( "shrink", {
		top = 0,
		bottom = 0,
		topAnchor = true,
		bottomAnchor = false
	} )
	self:registerAnimationState( "fade", {
		alpha = 0
	} )
	self:registerEventHandler( "transition_complete_expand", CoD.ScoreFeed.Row_Expand )
	self:registerEventHandler( "shrink", CoD.ScoreFeed.Row_Shrink )
	self:registerEventHandler( "transition_complete_shrink", self.close )
	self:registerEventHandler( "transition_complete_fade", self.close )
	self:animateToState( "expand", CoD.ScoreFeed.ExpandTime, true, true )
	if f2_arg0.timer ~= nil then
		f2_arg0.timer:close()
	end
	local timer = LUI.UITimer.new( f2_local7, "time_up", true )
	f2_arg0:addElement( timer )
	f2_arg0.timer = timer
	
	local f2_local16, f2_local17, f2_local18 = nil
	if f2_arg3 == true then
		f2_local16 = CoD.ScoreFeed.ScoreStreakColor1
		f2_local17 = CoD.ScoreFeed.ScoreStreakColor2
		f2_local18 = CoD.ScoreFeed.ScoreStreakColor3
	else
		f2_local16 = CoD.ScoreFeed.Color1
		f2_local17 = CoD.ScoreFeed.Color2
		f2_local18 = CoD.ScoreFeed.Color3
	end
	local scoreText = LUI.UIText.new()
	scoreText:setLeftRight( true, false, 0, 2560 )
	scoreText:setTopBottom( true, true, 0, -CoD.ScoreFeed.Spacing )
	scoreText:setAlignment( LUI.Alignment.Left )
	scoreText:setText( f2_arg1 )
	scoreText:setRGB( 1, 1, 1 )
	self:addElement( scoreText )
	self.scoreText = scoreText
	
	if f2_local2 < #f2_local1 then
		f2_local1[1]:animateToState( "fade", CoD.ScoreFeed.ExpandTime, true, true )
		table.remove( f2_local1, 1 )
	end
end

CoD.ScoreFeed.Row_Expand = function ( f3_arg0, f3_arg1 )
	
end

CoD.ScoreFeed.Reset = function ( f4_arg0, f4_arg1 )
	f4_arg0.timer = nil
	for f4_local0 = 1, #f4_arg0.rows, 1 do
		f4_arg0.rows[f4_local0].scoreText:close()
	end
end

CoD.ScoreFeed.Row_Shrink = function ( f5_arg0, f5_arg1 )
	f5_arg0:animateToState( "shrink", CoD.ScoreFeed.ShrinkTime, true, true )
end

CoD.ScoreFeed.DemoJump = function ( f6_arg0, f6_arg1 )
	if f6_arg0.timer ~= nil then
		f6_arg0.timer:close()
		f6_arg0.timer = nil
	end
	CoD.ScoreFeed.Reset( f6_arg0, f6_arg1 )
end

