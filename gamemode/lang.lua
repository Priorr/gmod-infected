Lang = {}

Lang.Default = "niggie this shit broke ask the developer why"
Lang.Generic = "1;"

function Lang:Get(  Identifier, varArgs )
  
	if not Lang[ Identifier ] then
    	varArgs = {Identifier}
    	Identifier = "Default"
    end
  
  	local Text = Lang[ Identifier ]
    for ParamID, Arg in pairs(varArgs) do
    	Text = string.gsub( Text, ParamID ..";", Arg )
    end
  
  	return Text
  
end

-- send this a list of players i'll show you how to use all of these below
function Lang:Send( ply, Action, varArgs )
	net.WriteString( szAction )
	
	if varArgs and type( varArgs ) == "table" then
		net.WriteTable( varArgs )
	end
	
	net.Send( ply )
end

-- use this for everyone and can exclude people from it
function Lang:Broadcast( Action, varArgs, varExclude )
	net.WriteString( Action )
	
	if varArgs and type( varArgs ) == "table" then
		net.WriteTable( varArgs )
	end
	
	if varExclude and (type( varExlude ) == "table" or (IsValid( varExclude ) and varExclude:IsPlayer())) then
		net.SendOmit( varExclude )
	else
		net.Broadcast()
	end
end

Lang.Connected = "1; Has joined the server." 
	
Lang.GotInfected = "1; Has been infected by 2; and is now an infected."
Lang.Infected = "You've been infected find and kill the survivors."
