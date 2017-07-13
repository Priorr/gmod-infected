Round = {}
Round.State = nil -- use tables to store variables, less memory
--ROUNDSTATE = ROUND_PREP
  
function RoundStart()
	timer.Create( "RoundLength", GetConvar("infected_round_time"):GetInit(), 1, RoundEnd() )
    local totalply = #player.GetAll()

	for k, v in pairs(totalply) -- Put all players in a loop.
    	local randnumber = math.random(0, totalply) -- Get a random player from everybody that is online.
    	v[randnumber]:SetTeam(TEAM_INIT_INFECTED) -- Set that random player to the initial infected.
    end
end

function RoundSetup()
	game.CleanUpMap() 
	timer.Create("PreRound", GetConvar("infected_preround_time"):GetInit(), 1, RoundStart())
	SpawnPlayers()
end

function RoundActive()
    hook.Add("PlayerDeath", "InfectedStats", function(vic, inf, killer )
        if timer.Exists("RoundLength") then

        end
    end)
    
    local infected = {}
    local survivors = {}
    
    for k,v ipairs( players ) do
        if v:Alive() then
            if v:Team() == TEAM_SURVIVOR then
                table.insert(survivors, v )
            elseif v:Team() == TEAM_INFECTED then
                table.insert(infected, v )
            end
        end
    end
  
    if timer.Exists("RoundLength") then
        if(#survivors == (0) then
            RoundEnd(WIN_INFECTED)
        elseif(#survivors <=1 and timer.TimerLeft("RoundLength") == 0) then -- dont pause you fucking cunt
            RoundEnd(WIN_SURVIVOR)
        end
--define who wonned
end
      
function RoundEnd(winningteam)
    if table.sort( team.GetPlayers(TEAM_SURVIVOR) ) == 0 then
        timer.Create( "PostRound", GetConvar("infected_postround_time"):GetInit(), 1, RoundStart() )
        RoundWin(winningteam)
    end  
end
    	
      

--define who wonned
end
      
function RoundEnd(winningteam)
if table.sort( team.GetPlayers(TEAM_SURVIVOR) ) == 0 then
      RoundEnd()
			timer.Create( "PostRound", GetConvar("infected_postround_time"):GetInit(), 1, RoundStart() )
			chat.AddText( team.GetColor(winningteam), Color(0, 100, 255), "have won!" )
end
