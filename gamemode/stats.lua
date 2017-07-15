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
    local sid64 = SteamID64()
	
    hook.Add("PlayerDeath", "InfectorStats", function(vic, inf, att )
    	if att:Team() == TEAM_SURVIVOR then attteam = "skills" elseif att:Team() == TEAM_INFECTED then attteam = "ikills"
    		data1 = sql.Query( "SELECT ".. attteam .. " FROM infected_stats WHERE sid64 = '" .. att:sid64.."'")
        	local kills = data1[1][attteam]
        	res = sql.Query( "UPDATE infected_stats SET "..attteam.." = "..tostring(kills+1).." WHERE sid64 = '"..att:sid64"'")
        end
        
        if vic:Team() == TEAM_SURVIVOR then victeam = "ideaths" elseif vic:Team() == TEAM_INFECTED then victeam = "ideaths"
        	data2 = sql.Query( "SELECT "..victeam.." FROM infected_stats WHERE sid64 = '"..vic:sid64.."'")
        	local deaths = data2[1][victeam]
          	res = sql.Query( "UPDATE infected_stats SET "..victeam.." = "..tostring(deaths+1).." WHERE sid64 = '"..vic:sid64"'")
        end
    end)
      
	hook.Add("InfectedRoundWin", "RoundStats", function(winningteam)
    	if winningteam == TEAM_INFECTED or TEAM_SURVIVOR then
    		for k,ply in ipairs( player.GetAll() ) do
            	local data2 = sql.Query( "SELECT rounds FROM infected_stats WHERE sid64 = '" ..ply:sid64.."'")
            	local rounds = data2[1]["rounds"]
            	sql.Query("UPDATE infected_stats SET rounds = "..tostring(rounds+1).." WHERE sid64 = '"..ply:sid64.."'")
            end
            
            players = team.GetPlayers(winningteam)
            if winningteam == TEAM_SURVIVOR then
              	for k,ply in ipairs(players) do
                	local data3 = sql.Query("SELECT swin FROM infected_stats WHERE sid64 = '"..ply:sid64.."'")
                	local swin = data3[1]["swin"]
                	sql.Query("UPDATE infected_stats SET swin = "..tostring(swin+1).." WHERE sid64 = '"..ply:sid64.."'")
            	end
			end
            
            if winningteam == TEAM_INFECTED then
            	for k,ply in ipairs(players) do
                	local data4 = sql.Query("SELECT iwin FROM infected_stats WHERE sid64 = '"..ply:sid64.."'")
                	local iwin = data4[1]["iwin"]
                	sql.Query("UPDATE infected SET iwin = "..tostring(iwin+1).." WHERE sid64 = '"..ply:sid64.."'")
                end
            end
		end
              
          
	end)
end
