function PlayerInititialSetup( ply )
	ply:SetTeam( TEAM_SPECTATOR )
    PlayerLoadout( ply )
end

infectedweps = {weapon_knife, weapon_pistol}
survivorweps = {weapon_knife, weapon_assaultrifleshit, weapon_pistol}
infectedinitweps = {weapon_knife, weapon_pistol}
local randomise = 0

function GM:PlayerLoadout( ply ) 
  	local GetTeamName = ply:Team()

    if GetTeamNameTeam == TEAM_SURVIVOR then 
		for _, v in pairs(infectedweps) do
     		ply:Give(v)
       	end
    
    	local randolol = math.random(1, 6)
    	ply:SetModel("survivor_0" .. randomise .. ".mdl")
  		return
    end
  
	if GetTeamName == TEAM_INFECTED then
    	for _, v in pairs(infectedweps) do
     	 	ply:Give(v)
    	end
		
    	local randolol = math.random(1, 6)
    	ply:SetModel("infected_0" .. randomise .. ".mdl")
  		return
	end

    if GetTeamName == TEAM_INIT_INFECTED then
    	for _, v in pairs(infectedweps) do
     	 	ply:Give(v)
    	end

    	ply:SetModel("initinfected.mdl")
  		return
	end

end

function GM:PlayerSpray(ply)
  return true -- Returning true means that its disabled, weird // Sam
end
