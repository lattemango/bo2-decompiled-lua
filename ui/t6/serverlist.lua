require( "T6.ScrollingVerticalList" )
require( "T6.ServerListButton" )

CoD.ServerList = {}
CoD.ServerList.ColumnWidth = {}
CoD.ServerList.ColumnWidth[1] = 250
CoD.ServerList.ColumnWidth[2] = 200
CoD.ServerList.ColumnWidth[3] = 100
CoD.ServerList.ColumnWidth[4] = 200
CoD.ServerList.ColumnWidth[5] = 93
CoD.ServerList.RowHeight = CoD.CoD9Button.Height
CoD.ServerList.ColumnSpacing = 5
local f0_local0 = function ( f1_arg0, f1_arg1 )
	CoD.SwitchToSystemLinkGame( f1_arg1.controller )
	Engine.ServerListJoinServer( f1_arg1.controller, f1_arg0.serverIndex )
end

local f0_local1 = function ( f2_arg0, f2_arg1 )
	Engine.PlaySound( "cac_grid_equip_item" )
	Engine.ServerListRefreshServers( f2_arg1.controller )
end

local f0_local2 = function ( f3_arg0, f3_arg1 )
	return string.lower( f3_arg0.hostname ) < string.lower( f3_arg1.hostname )
end

local f0_local3 = function ( f4_arg0 )
	f4_arg0.verticalList:removeAllChildren()
	local f4_local0 = Engine.ServerListGetServers()
	if f4_local0 == nil or #f4_local0 == 0 then
		DebugPrint( "No available servers." )
		return 
	end
	table.sort( f4_local0, f0_local2 )
	local f4_local1 = 0
	for f4_local6, f4_local7 in ipairs( f4_local0 ) do
		if CoD.isZombie == true then
			if f4_local7.isInGame ~= "1" then
				local f4_local5 = CoD.ServerListButton.new( f4_local6, f4_local7, {
					left = 0,
					top = 0,
					right = 0,
					bottom = CoD.ServerList.RowHeight,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = true,
					bottomAnchor = false,
					spacing = CoD.ServerList.ColumnSpacing
				} )
				f4_local5:registerEventHandler( "button_action", f0_local0 )
				f4_arg0:addElementToList( f4_local5 )
				if f4_local1 == 0 then
					f4_local1 = f4_local6
				end
				if f4_local6 == f4_local1 and CoD.useController then
					f4_local5:processEvent( {
						name = "gain_focus"
					} )
				end
			end
		end
		local f4_local5 = CoD.ServerListButton.new( f4_local6, f4_local7, {
			left = 0,
			top = 0,
			right = 0,
			bottom = CoD.ServerList.RowHeight,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			spacing = CoD.ServerList.ColumnSpacing
		} )
		f4_local5:registerEventHandler( "button_action", f0_local0 )
		f4_arg0:addElementToList( f4_local5 )
		if f4_local6 == 1 and CoD.useController then
			f4_local5:processEvent( {
				name = "gain_focus"
			} )
		end
	end
end

CoD.ServerList.new = function ( f5_arg0 )
	local f5_local0 = CoD.ScrollingVerticalList.new( f5_arg0 )
	f5_local0.id = "ServerList"
	f5_local0:registerEventHandler( "server_list_refresh", f0_local3 )
	f5_local0:registerEventHandler( "button_prompt_refresh", f0_local1 )
	f0_local3( f5_local0 )
	return f5_local0
end

