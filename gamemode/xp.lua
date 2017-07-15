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

function ply:StatsAddXP( n )
        self:SetNWInt( "XP", self:GetNWInt( "XP" ) + n )
        if( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber ( self:GetNWInt( "Level" ) ) < 10 ) then
          	local tempxp = self;GetNWInt( "XP" ) - 100
          	self:StatsLevelsUp()
            self:SetNWInt( "XP", tempxp )
          	print( "Level Up" )
        elseif( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber( self:GetNWInt( "Level" ) ) == 10 ) then
          	self:SetNWInt( "XP", 100)
        end
end

function ply:StatsLevelsUp()
		self:SetPData( "XP", 0 )
        self:SetNWInt( "Level", self:GetNWInt( "Level" ) + 1 )
end
