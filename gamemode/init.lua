AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

local ply = LocalPlayer
local TEAM_INIT_INFECTED, TEAM_INFECTED, TEAM_SURVIVOR, TEAM_DEAD, TEAM_SPECTATOR = 1, 2, 3 ,4 ,5

function GM:PlayerInitialSpawn( ply )
  
  PlayerInitiialSetup( ply )

end 


function GM:PlayerShouldTakeDamage( ply )
  return true
end

function GM:CanPlayerSuicide( ply )
  if ply:Team() != ply:Team(3)
    return true
  else
    return false
end
  
  
function GM:PlayerDeath( ply, wep, killer )
	
  if ply:Team() == ply:Team(3) then
    if killer == ply:Team(1) or ply:Team(2) then
      ply:SetTeam(2)
    elseif killer != ply:Team(1) or ply:Team(2) then
      ply:SetTeam(5)
    end
      
    if killer:Team() == ply:Team(1) then
    	ply:Team() == ply:Team(2)
      killer:Team() == ply:Team(2)
    end
    
    if ply:Team() == ply:Team(2) then
    	if killer == ply:Team(3) then
        local ammobox = ents.Create("item_ammobox")
				ammobox:SetPos( Vector( 0, 0, 10 ) )
				ammobox:Spawn()
      else
      end
      	
    end 
   
    killerteam = team.GetName( killer( 1 ):Team() ) -- THIS MAY NOT WORK, IF THIS DOESNT COME IN CHAT THEN THIS IS PROBABLY THE ERROR // SAM
    if killerteam == TEAM_INFECTED then
      chat.AddText(victim, " has been claimed by ", inflictor, " and is now part of the infected team.")
    end
end
 
function GM:PlayerDisconnected(ply)
      
end
      
end
