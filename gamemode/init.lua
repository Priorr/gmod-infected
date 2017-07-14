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
        if killersteam == TEAM_INIT_INFECTED or killerteam == TEAM_INFECTED then
            ply:SetTeam(TEAM_INFECTED)
            return -- Whats the return for?? ~ Prior
        elseif killersteam != TEAM_INIT_INFECTED or killerteam != TEAM_INFECTED and plyteam == TEAM_SURVIVOR then
            ply:SetTeam(TEAM_SPECTATOR)
            return -- ^^^^
        end

        if killersteam == TEAM_INIT_INFECTED then
            ply:SetTeam(TEAM_INFECTED) 						
            killer:SetTeam(TEAM_INFECTED) -- Isnt this stuff already done on line 85 to 87???? ~ Prior	
            return
        end
    
        if plyteam == TEAM_INFECTED then
            if killersteam == TEAM_SURVIVOR then 
                local ammobox = ents.Create("item_ammobox") -- We need to add/make a ammobox for this to work remember. Can just be universal ammo box (Like in CW2.0)
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
 

function GM:PlayerSpawn( ply )
	if timer.Exists( "RoundLength" ) == true or timer.Exists( "PostRound" ) then GAMEMODE:PlayerSpawnAsSpectator( ply ) else -- If the round is active or the round had just finished, set the player as spectator when they join.
      	return end
end
