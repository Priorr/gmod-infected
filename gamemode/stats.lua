WIN_SURVIVOR = TEAM_SURVIVOR
WIN_INFECTED = TEAM_INFECTED
-- tables
local AttTableTeamSet = {
 	TEAM_SURVIVOR = "skills", 
    TEAM_INFECTED = "ikills"
}
      
local VicTableTeamSet = {
 	TEAM_SURVIVOR = "skills", 
    TEAM_INFECTED = "ikills"
}
  
function RoundWin( winningteam )
    local attteam = ""
    local victeam = ""
	
    hook.Add("PlayerDeath", "InfectorStats", function(vic, inf, att )
    	if att:Team() == TEAM_SURVIVOR then attteam = "skills" elseif att:Team() == TEAM_INFECTED then attteam = "ikills"
    		data1 = sql.Query( "SELECT ".. attteam .. " FROM infected_stats WHERE sid64 = '" .. att:SteamID64().."'")
        	local kills = data1[1][attteam]
        	res = sql.Query( "UPDATE infected_stats SET "..attteam.." = "..tostring(kills+1).." WHERE sid64 = '"..att:SteamID64()"'")
        end
        
        if vic:Team() == TEAM_SURVIVOR then victeam = "ideaths" elseif vic:Team() == TEAM_INFECTED then victeam = "ideaths"
        	data2 = sql.Query( "SELECT "..victeam.." FROM infected_stats WHERE sid64 = '"..vic:SteamID64().."'")
        	local deaths = data2[1][victeam]
          	res = sql.Query( "UPDATE infected_stats SET "..victeam.." = "..tostring(deaths+1).." WHERE sid64 = '"..vic:SteamID64()"'")
        end
    end)
end
