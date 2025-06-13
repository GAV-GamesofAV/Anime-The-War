extends Node
class_name State

signal state_changed(new_state_name: String)

@export var animationName: String


var character: Character

func enter(_character): 
    character = _character

func update(_delta):
    pass

func physics_update(_delta):
    pass

func exit():  
    pass
