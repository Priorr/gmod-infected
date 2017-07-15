function Lang:Print( Prefix, varText )
	if not varText then return end
	if type( varText ) != "table" then varText = { varText } end
	
	chat.AddText( Color(255,255,255), "[", Prefixes[ Prefix ], Prefix, Color(255,255,255), "] ", unpack( varText ) )
end
