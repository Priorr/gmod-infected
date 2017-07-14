util.AddNetworkString("DisconnectText", ply )
util.AddNetworkString("InfectedText", ply )
util.AddNetworkString("PlayerConnectText", ply )
util.AddNetworkString("PlayerSpawnText", ply )

function ChatDisconnectText()
  	net.Recieve("PlayerDisconnectText")
	chat.AddText( Color(255, 0, 0), ply:Nick(), Color(0, 255, 0), "has left the server.") -- When player leaves, print a message in chat. ~Prior
end

function PlayerConnectText()
  	net.Recieve("PlayerConnectText")
	chat.AddText( Color(0, 255, 0), ply:Nick(), Color(255, 0, 0), "has connected to the server.") -- When a player connects, print a message in chat. ~Prior
end

function PlayerSpawnText()
  	net.Recieve("PlayerSpawnText")
	chat.AddText( Color(0, 255, 0), ply:Nick(), Color(255, 0, 0), "has joined the server.") -- When player joins, print a message in chat. ~Prior
end

function PlayerInfectedText()
  	net.Recieve("PlayerInfectedText")
  	chat.AddText(Color(0, 255, 0) victim:Nick(), Color(243, 255, 0), "has been infected by", Color(255, 0, 0), attacker:Nick(), Color(243, 255, 0), "and is now part of the infected team.")
end
