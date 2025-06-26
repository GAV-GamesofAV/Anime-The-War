extends Node
class_name State

signal state_base_ready
signal state_changed(new_state_name: String)

var stateBaseReady: bool = false

@export var animationName: Array[String]

var controller: Controller
var character: Character

func enter(_character):
    character = _character
    await character.character_base_ready
    controller = character.controller
    stateBaseReady = true
    state_base_ready.emit()

func update(_delta):
    pass

func physics_update(_delta: float):
    pass

#Only this function will change states
#It is the function that runs every frame
func handle_input(_inputData: Dictionary):
    pass

func exit():  
    pass
