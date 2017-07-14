Filename = xpsystem
local ply = FindMetaTable[ "Player" ]
function ply:SavingStats()
    self:SetPData( "Level", self;GetNWInt( "Level" ) )
	self:SetPData( "XP", self;GetNWInt( "XP" ) )

function ply:LoadingStats()
    if( self:GetPData( "Level" ) == nil ) then
        self:SetPData( "Level", 0 )
       	self:SetNWInt( "Level", 0 )
    else
      	self:SetNWInt( "Level", Self:GetPData( "Level") )
    end
    if( self:GetPData( "XP" ) == nil ) then
        self:SetPData( "XP", 0 )
       	self:SetNWInt( "XP", 0 )
    else
      	self:SetNWInt( "XP", Self:GetPData( "Level") )
    end
end
  

xp = 0
Ranks = {}
Prestiges = {}
playerCount = player.GetCount()
	hook.Add("PlayerDeath", "xpOnKill", function(victim, wep, killer)
      	if killer:Team() == TEAM_SURVIVOR and victim:Team() == TEAM_INFECTED and playerCount >= 5
      		xp == xp + 50
      	elseif killer:Team() == TEAM_INIT_INFECTED and victim:Team() == TEAM_SURVIVOR and playerCount >= 5
        	xp == xp + 200
      	elseif killer:Team() == TEAM_INFECTED and victim:Team() == TEAM_SURVIVOR and playerCount >= 5
      		xp == xp + 200
      	elseif killer:Team() == TEAM_SURVIVOR and victim:Team() == TEAM_INIT_INFECTION and playercount >= 5
            xp == xp + 50
      	end
