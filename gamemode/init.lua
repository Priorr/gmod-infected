AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sv_rounds.lua" )
AddCSLuaFile( "sv_players.lua" )

local TEAM_INIT_INFECTED, TEAM_INFECTED, TEAM_SURVIVOR, TEAM_DEAD, TEAM_SPECTATOR = 1, 2, 3, 4, 5

function GM:PlayerInitialSpawn( ply )
	PlayerInititialSetup( ply )
end 


function GM:PlayerShouldTakeDamage( ply )
    return true
end

function GM:CanPlayerSuicide( ply )
	if ply:Team() != ply:Team(3) then
		return true
	end
    return false
end
  
-- Use tables for this
function GM:PlayerDeath( ply, wep, killer ) 
  	local killersteam = killer:Team()
  	local plyteam = ply:Team() -- Call it once, not 50+ times
  
    if plyteam == TEAM_SURVIVOR then
        if killersteam == TEAM_INIT_INFECTED or plyteam == TEAM_INFECTED then
            ply:SetTeam(TEAM_INFECTED)
            return
        elseif killersteam != TEAM_INIT_INFECTED or plyteam == TEAM_INFECTED then
            ply:SetTeam(TEAM_SPECTATOR)
            return
        end

        if killersteam == TEAM_INIT_INFECTED then
            ply:SetTeam(TEAM_SPECTATOR)
            killer:SetTeam(TEAM_INFECTED)
            return
        end
    
    -- stops running the ENTIRE CODE
        if plyteam == TEAM_INFECTED then
            if killersteam == TEAM_SURVIVOR then 
                local ammobox = ents.Create("item_ammobox")
                ammobox:SetPos( Vector( 0, 0, 10 ) )
                ammobox:Spawn()
            end
        end 
    end
    
    killerteam = team.GetName( killer( 1 ):Team() ) -- THIS MAY NOT WORK, IF THIS DOESNT COME IN CHAT THEN THIS IS PROBABLY THE ERROR // SAM
    if killerteam == TEAM_INFECTED then
        --chat.AddText(victim, " has been claimed by ", inflictor, " and is now part of the infected team.") -- sent to client, not run serverside
    end
end
