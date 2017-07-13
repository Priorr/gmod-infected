function RoundSetup()
game.CleanUpMap() 
timer.Create( "PreRound", GetConvar("infected_preround_time"):GetInit(), 1, RoundStart() )
SpawnPlayers()
end

function RoundStart()
timer.Create( "RoundLength", GetConvar("infected_round_time"):GetInit(), 1, RoundEnd() )
playercount = player.GetCount()

for k, v in pairs(player.GetAll())
    math.random( 0, playercount ) = whoitgonbe
    whoitgonbe:SetTeam(TEAM_INIT_INFECTED) -- This shit wont work, just leaving it like this till I figure it out.
    end
end

function RoundActive()
    
  local players = player.GetAll()
    
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
  
  if timer.Exists("PreRound") then
 		if(#survivors == 0 and timer.TimerLeft <= 1) then
      RoundEnd(
	
    	
      

--define who wonned
end
      
function RoundEnd(winningteam)
if table.sort( team.GetPlayers(TEAM_SURVIVOR) ) == 0 then
      RoundEnd()
			timer.Create( "PostRound", GetConvar("infected_postround_time"):GetInit(), 1, RoundStart() )
			chat.AddText( team.GetColor(winningteam), Color(0, 100, 255), "have won!" )
end
