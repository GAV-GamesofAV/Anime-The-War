extends Node

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func set_gravity(g = 980):
    gravity = g if g != 980 else ProjectSettings.get_setting("physics/2d/default_gravity")
