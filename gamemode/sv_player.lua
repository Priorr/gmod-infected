function PlayerInititialSetup( ply )
	ply:SetTeam( TEAM_SPECTATOR )
	PlayerLoadout( ply ) 
end
SurvivorModels = 
{
  "models/player/Group01/Male_01.mdl",
  "models/player/Group01/Male_02.mdl",
  "models/player/Group01/Male_03.mdl",
  "models/player/Group01/Male_04.mdl",
  "models/player/Group01/Male_05.mdl",
  "models/player/Group01/Male_06.mdl",
  "models/player/Group01/Male_07.mdl",
  "models/player/Group01/Female_01.mdl",
  "models/player/Group01/Female_02.mdl",
  "models/player/Group01/Female_03.mdl",
  "models/player/Group01/Female_04.mdl",
  "models/player/Group01/Female_05.mdl",
  "models/player/Group01/Female_06.mdl",
  "models/player/Group01/Female_07.mdl"
}

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
    	ply:SetModel(table.Random(SurvivorModels))
        ply:SetRunSpeed(250)
    	ply:SetWalkSpeed(120)
    end 

	if GetTeamName == TEAM_INFECTED then
    	for _, v in pairs(infectedweps) do
     	 	ply:Give(v)
    	end
		
    	local randolol = math.random(1, 6)
    	ply:SetModel("infected_0" .. randomise .. ".mdl")
        ply:SetRunSpeed(280)
    	ply:SetWalkSpeed(150)
	end

    if GetTeamName == TEAM_INIT_INFECTED then
    	for _, v in pairs(infectedweps) do
     	 	ply:Give(v)
    	end
        ply:SetRunSpeed(300)
    	ply:SetWalkSpeed(170)
        ply:SetModel("initinfected.mdl")
	end

end

function GM:PlayerSpray(ply)
  return true -- Returning true means that its disabled, weird // Sam
end
