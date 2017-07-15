-- Levels 1-80
-- Prestige 1-20
xp4levels = {
800,
1100,
1200, 
1800, 
2200,
2500,
2800,
3200,
3600,
4000,
4400,
4900,
5400,
5900,
6400,
6900,
7400,
7900,
8400,
9400,
9900,
10400,
10900,
11400,
11900,
12400,
12900,
13400,
14000,
14600,
15200,
15800,
16400,
17000,
17600,
18200,
18800,
19400,
20000,
20600,
21200,
21800,
22400,
23000,

}    --can this not be done cleaner? 
Filename = xpsystem
function ply:SavingStats()
    self:SetPData( "Level", self;GetNWInt( "Level" ) )
	self:SetPData( "XP", self;GetNWInt( "XP" ) )

function LoadingStats(ply)
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
      	self:SetNWInt( "XP", Self:GetPData( "XP") )
    end
    if( self:GetPData( "Prestige" ) == nil ) then
        self:SetPData( "Prestige", 0 )
       	self:SetNWInt( "Prestige", 0 )
    else
      	self:SetNWInt( "Prestige", Self:GetPData( "Prestige") )
    end
end

function StatsAddXP( self, n )
        self:SetNWInt( "XP", self:GetNWInt( "XP" ) + n )
        if( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber ( self:GetNWInt( "Level" ) ) < 80 ) then
          	local tempxp = self:GetNWInt( "XP" ) - 100
          	self:StatsLevelsUp()
            self:SetNWInt( "XP", tempxp )
          	print( "Level Up" )
        elseif( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber( self:GetNWInt( "Level" ) ) == 80 ) then
          	local templvl = self:GetNWInt( "Level" ) - 80
        	local tempxpp = self:GetNWInt( "XP" ) - 100
        	self:PrestigeLevelsUp()
        	self:SetNWInt( "Level", templvl )
        	self:SetNWInt( "XP", tempxpp )
        	print( "Prestige up" )
        elseif( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber( self:GetNWInt( "Level" ) ) == 80 && tonumber( self:GetNWInt( "Prestige" ) ) == 20 ) then
        	self:SetNWInt( "XP", 100 )
        	print( "WOW! You reached the max level. That is truly amazing." )
        end
end

function StatsLevelsUp()
		self:SetPData( "XP", 0 )
        self:SetNWInt( "Level", self:GetNWInt( "Level" ) + 1 )
end

function PrestigeLevelsUp()
		self:SetPData( "XP", 0 )
        self:SetPData( "Level", 0 )
        self:SetNWInt( "Prestige", self:GetNWInt( "Prestige" ) + 1 )
end
      
function xpscale( c, n )
        return c * math.pow( n, 2.3 )
end
