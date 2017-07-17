AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sv_round.lua" )
AddCSLuaFile( "sv_player.lua" )
AddCSLuaFile( "xp.lua" )
AddCSLuaFile( "sv_lang.lua" )

include( "xp.lua" )
include( "sv_lang.lua" )
include( "sv_player.lua" )

local TEAM_INIT_INFECTED, TEAM_INFECTED, TEAM_SURVIVOR, TEAM_DEAD, TEAM_SPECTATOR = 1, 2, 3, 4, 5

function GM:PlayerInitialSpawn( ply )
    PlayerSpawn(ply)
    LoadingStats()
end

function GM:PlayerShouldTakeDamage( ply )
    return true
end

function GM:CanPlayerSuicide( ply )
    if ply:Team() ~= ply:Team(TEAM_SURVIVOR) then
        return true
    end
    return false
end

-- Use tables for this
function GM:PlayerDeath( victim, inflictor, killer ) -- wep wont work, you'll need to use inflictor ~ Prior
    local killersteam = killer:Team()
    local plyteam = ply:Team() -- Call it once, not 50+ times
    local victimsteam = victim:Team()
  
    if plyteam == TEAM_SURVIVOR then
        if killersteam == TEAM_INIT_INFECTED or killerteam == TEAM_INFECTED then
            ply:SetTeam(TEAM_INFECTED)
            Statsgive(ply, 25)
            Lang:Broadcast("Print", "General", Lang:Get("GotInfected", {victim:Nick(), attacker:Nick()}) )
            return 
        elseif killersteam ~= TEAM_INIT_INFECTED or killerteam ~= TEAM_INFECTED and plyteam == TEAM_SURVIVOR then
            ply:SetTeam(TEAM_SPECTATOR)
            return
        end

        if killersteam == TEAM_INIT_INFECTED then
            ply:SetTeam(TEAM_INFECTED)                      
            killer:SetTeam(TEAM_INFECTED)
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
    
    if killersteam == TEAM_INFECTED then
        net.Start("PlayerInfectedText", victim, attacker)
    end
    
end

function GM:PlayerSpawn( ply )
    if timer.Exists( "RoundLength" ) == true or timer.Exists( "PostRound" ) then
        GAMEMODE:PlayerSpawnAsSpectator( ply )
    end
end

function PlayerSpawn(ply)
    Lang:Broadcast( "Print", { "General", Lang:Get("Connect", {ply:Nick()})})
    print("nigger")
end
