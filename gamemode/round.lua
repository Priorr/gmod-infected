Round = {}
Round.State = nil -- use tables to store variables, less memory

CreateConVar( "infected_preround_time", "60", 0, "Set the length of a pre-round in Infected." ) -- Creates a in-game command so that users can change the time, default 1 minute. ~Prior
CreateConVar( "infected_round_time", "720", 0, "Set the length of a round in Infected." ) -- Creates a in-game command so that users can change the time, default 12 minutes.~Prior
CreateConVar( "infected_postround_time", "30", "Set the legnth of the post-round in Infected." )-- Creates a in-game command so that users can change the time, default 1 minute.~Prior
  
WIN_SURVIVOR = TEAM_SURVIVOR
WIN_INFECTED = TEAM_INFECTED

function RoundTimers()
timer.Create("PreRound", GetConVarNumber("infected_preround_time"), 1, RoundStart()) -- Need to change GetConvarNumber too GetConvsr and ConVar:GetInt due to GetConVarNumber being deprecated
timer.Create( "RoundLength", GetConVarNumber("infected_round_time"), 1, RoundEnd() ) -- Need to change GetConvarNumber too GetConvsr and ConVar:GetInt due to GetConVarNumber being deprecated
timer.Create( "PostRound", GetConVarNumber("infected_postround_time"), 1, RoundStart() ) -- Need to change GetConvarNumber too GetConvsr and ConVar:GetInt due to GetConVarNumber being deprecated
end
local amountinfected = 0
function RoundStart()
    Round.State = RoundStarted
    local allply = player.GetAll()
    local totalply = #allply
    local amountinfected = math.Clamp(math.ceil(#player.GetAll() / 5), 1, 5)

    while amountinfected ~= 0 do -- Put all players in a loop.
        local randnumber = math.random(0, totalply)
        allply[randnumber]:SetTeam(TEAM_INIT_INFECTED) -- Change loadout based on GM:SetTeam()
        amountinfected = amountinfected - 1
    end
end

function RoundSetup( ply )
    local allply = player.GetAll()
    Round.State = RoundSetUp
    game.CleanUpMap()
    SpawnPlayers()
    print("Spawning Players.")
    for k, v in pairs(allply) do
        v:SetTeam(TEAM_SURVIVOR)
    end
end

function RoundActive()
    local allply = player.GetAll()
    Round.State = RoundActive
    local infected = {}
    local survivors = {}  
    for k,v in pairs( allply ) do
        if v:Alive() then
            if v:Team() == TEAM_SURVIVOR then
                table.insert(survivors, v)
                return
            end
            
            if v:Team() == TEAM_INFECTED then
                table.insert(infected, v)
                print("Selecting somebody to become Infected.")
                return
            end
            -- What about TEAM_INIT_INFECTED?
        end
    end

    if timer.Exists("RoundLength") then -- This returns a boolean, it wont work unless you add "== true" ~ Prior
        if(#survivors == 0) then
            RoundEnd(WIN_INFECTED)
            return
        end

        if (#survivors >= 1 and timer.TimerLeft("RoundLength") == 0) then -- It shouldn't be less than one, it should be more then one?
            RoundEnd(WIN_SURVIVOR)
        end
    end
end

function RoundEnd(winningteam)
    Round.State = RoundEnd
    if table.sort( team.GetPlayers(TEAM_SURVIVOR) ) == 0 then -- What is this even checking? Doesnt make any sense to me.
        -- something goes here
    end  
  
    hook.Call("InfectedRoundWin", nil, winningteam)
end
