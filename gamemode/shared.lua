GM.Name = "Infected"
GM.Author = "Meeno, Sam, Cain & Prior"

DeriveGamemode("base")
DEFINE_BASECLASS("gamemode_base")

Prefixes = {
	["Infected"] = Color( 210, 40, 0),
	["Survivors"] = Color (0, 40, 210),
}

team.SetUp( 1, "TEAM_INIT_INFECTED", Color(255,0,0) )
team.SetUp( 2, "TEAM_INFECTED", Color (60,240,20) )
team.SetUp( 3, "TEAM_SURVIVOR", Color(0,0,255) )
team.SetUp( 4, "TEAM_DEAD", Color(80,80,80) )
team.SetUp( 5, "TEAM_SPECTATOR", Color(255,255,255) )

--Setup table here for rank and prestige icons (Do it in shared so it can be used by the scoreboard too)

Rank_Icons = {
materials/blerp.png,
materials/sperp.png,
}

Prestige_Icons = {
materials/prestige1.png,
materials/prestige2.png,
} 
