extends Node

signal game_ready

var gameReady: bool = false

var playerScene: PackedScene #The scene of the selected player  
var enemyScene: PackedScene #The scene of the selected enemy

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func set_gravity(g = 980):
    gravity = g if g != 980 else ProjectSettings.get_setting("physics/2d/default_gravity")
