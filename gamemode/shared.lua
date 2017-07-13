GM.Name = "Infected"
GM.Author = "Meeno, Sam, Cain & Prior"

DeriveGamemode("base")
DEFINE_BASECLASS("gamemode_base")

team.SetUp( 1, "TEAM_INIT_INFECTED", Color(255,0,0) )
team.SetUp( 2, "TEAM_INFECTED", Color (60,240,20) )
team.SetUp( 3, "TEAM_SURVIVOR", Color(0,0,255) )
team.SetUp( 4, "TEAM_DEAD", Color(80,80,80) )
team.SetUp( 5, "TEAM_SPECTATOR", Color(255,255,255) )
