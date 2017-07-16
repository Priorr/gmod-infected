function SavingStats(ply)
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
        local xprequirement = tonumber( self:GetNWInt( "Level" ) * 300
        if( tonumber( self:GetNWInt( "XP" ) ) > xprequirement - 1 && tonumber ( self:GetNWInt( "Level" ) ) < 80 ) then
          	local tempxp = self:GetNWInt( "XP" ) - xprequirement
          	self:StatsLevelsUp()
            self:SetNWInt( "XP", tempxp )
          	print( "Level Up" )
        elseif( tonumber( self:GetNWInt( "XP" ) ) > xprequirement - 1 && tonumber( self:GetNWInt( "Level" ) ) == 80 ) then
          	local templvl = self:GetNWInt( "Level" ) - 80
        	local tempxpp = self:GetNWInt( "XP" ) - xprequirement
        	self:PrestigeLevelsUp()
        	self:SetNWInt( "Level", templvl )
        	self:SetNWInt( "XP", tempxpp )
        	print( "Prestige up" )
        elseif( tonumber( self:GetNWInt( "XP" ) ) > xprequirement - 1 && tonumber( self:GetNWInt( "Level" ) ) == 80 && tonumber( self:GetNWInt( "Prestige" ) ) == 20 ) then
        	self:SetNWInt( "XP", xprequirement )
        	print( "WOW! You reached the max level. get a fuken life m8" )
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
	
hook.Add("PlayerInitialSpawn", "UpdatePlayerInfo", function(ply)
		local sid64 = ply:SteamID64()
		
		-- check if there steamid64 is in the table if not add it
		local res = sql.Query( "SELECT * FROM infected_stats WHERE UID = '"..sid64.."'")
		if not res then
			res = sql.Query( "INSERT INTO infected_stats VALUES( '"..sid64.."', '"..ply:Nick().."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')" )
		else
			--update their nickname when they join no point updating this real time becuase it doesn't really do anything more for manual editing
			res = sql.Query( "UPDATE infected_stats SET Player = '"..ply:Nick().."' WHERE UID64 = '"..sid64.."' " )
		end
	end)  
