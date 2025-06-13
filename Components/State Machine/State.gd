extends Node
class_name State

signal state_changed(new_state_name: String)

@export var animationName: String

var attackState: bool = false
var character: Character

func enter(_character): 
    character = _character
    print("Entered " + str(self.name))

func update(_delta):
    pass

func physics_update(_delta):
    pass

func exit():  
    pass
