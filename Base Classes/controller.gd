extends Node
class_name Controller

var character: Character

var moveKey: String = "move"
var jumpKey: String = "jump"
var lightAttackKey: String = "lightattack"

func get_input() -> Dictionary:
    return {}