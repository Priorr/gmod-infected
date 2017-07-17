Link = {}


function Link:Print( Prefix, varText )
	if not varText then return end
	if type( varText ) != "table" then varText = { varText } end
	
	chat.AddText( Color(255,255,255), "[", Prefixes[ Prefix ], Prefix, Color(255,255,255), "] ", unpack( varText ) )
end

-- Add a net clientside print if you want to send serverside to clientside, this allows shared information to be printed