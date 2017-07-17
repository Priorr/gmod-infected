local AttTableTeamSet = {
    TEAM_SURVIVOR = "skills", 
    TEAM_INFECTED = "ikills"
}
      
local VicTableTeamSet = {
    TEAM_SURVIVOR = "skills", 
    TEAM_INFECTED = "ikills"
}

local function KillCallSQL(att, atteam)
    data1 = sql.Query( "SELECT ".. attteam.. " FROM infected_stats WHERE sid64 = '".. att:SteamID64().. "'")
    local kills = data1[1][attteam]
    res = sql.Query( "UPDATE infected_stats SET ".. attteam.. " = "..tostring(kills+1).. " WHERE sid64 = '".. att:SteamID64()"'")
end

local function DeathCallSQL(vic, victeam)
    data2 = sql.Query( "SELECT ".. victeam.. " FROM infected_stats WHERE sid64 = '".. vic:SteamID64().. "'")
    local deaths = data2[1][victeam]
    res = sql.Query( "UPDATE infected_stats SET ".. victeam.. " = ".. tostring(deaths+1).. " WHERE sid64 = '".. vic:SteamID64()"'")
end

local function GenerateDeathHooks()
    hook.Add("PlayerDeath", "InfectorStats_KillerLog", function(vic, inf, att ) -- This has to be called before round win, just fyi
        if att:Team() == TEAM_SURVIVOR then 
            attteam = "skills"
            KillCallSQL(att, attteam)
            return
        end

        if att:Team() == TEAM_INFECTED then 
            attteam = "ikills"
            KillCallSQL(att, attteam)
            return
        end
    end)

    hook.Add("PlayerDeath", "InfectorStats_DeathLog", function(vic, inf, att )
        if vic:Team() == TEAM_SURVIVOR then 
            victeam = "sdeaths"
            DeathCallSQL(vic, victeam)
            return
        end

        if vic:Team() == TEAM_INFECTED then 
            victeam = "ideaths"
            DeathCallSQL(vic, victeam)
            return
        end
    end)
end
GenerateDeathHooks()

function RoundWin( winningteam )
    if winningteam == TEAM_INFECTED or TEAM_SURVIVOR then
        for k,ply in ipairs( player.GetAll() ) do
            local sid64 = ply:SteamID64()
            local data2 = sql.Query( "SELECT rounds FROM infected_stats WHERE sid64 = '" ..sid64.."'")
            local rounds = data2[1]["rounds"]
            sql.Query("UPDATE infected_stats SET rounds = "..tostring(rounds+1).." WHERE sid64 = '"..sid64.."'")
        end
    end

    players = team.GetPlayers(winningteam)
    if winningteam == TEAM_SURVIVOR then
        for k,ply in ipairs(players) do
            local sid64 = ply:SteamID64()
            local data3 = sql.Query("SELECT swin FROM infected_stats WHERE sid64 = '".. sid64.. "'")
            local swin = data3[1]["swin"]
            sql.Query("UPDATE infected_stats SET swin = ".. tostring(swin+1).. " WHERE sid64 = '".. sid64.. "'")
        end
    end

    if winningteam == TEAM_INFECTED then
        for k,ply in ipairs(players) do
            local sid64 = ply:SteamID64()
            local data4 = sql.Query("SELECT iwin FROM infected_stats WHERE sid64 = '".. sid64.. "'")
            local iwin = data4[1]["iwin"]
            sql.Query("UPDATE infected_stats SET iwin = ".. tostring(iwin+1).. " WHERE sid64 = '".. sid64.. "'")
        end
    end

    if winningteam != TEAM_INFECTED then
        for k,ply in ipairs(players) do
            local sid64 = ply:SteamID64()
            local data5 = sql.Query("SELECT iloses FROM infected_stats WHERE sid64 = '".. sid64.. "'")
            local iloses = data5[1]["iloses"]
            sql.Query("UPDATE infected_stats SET iloses = ".. tostring(iloses+1).. " WHERE sid64 = '".. sid64.. "'")
        end
    end

    if winningteam != TEAM_SURVIVOR then
        for k,ply in ipairs(players) do
            local sid64 = ply:SteamID64()
            local data6 = sql.Query("SELECT sloses FROM infected_stats WHERE sid64 = '".. sid64.. "'")
            local sloses = data6[1]["sloses"]
            sql.Query("UPDATE infected_stats SET sloses = ".. tostring(sloses+1).. " WHERE sid64 = '".. sid64.. "'")
        end
    end
end
