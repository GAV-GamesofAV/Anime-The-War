extends Node
class_name StateMachine

var character: Character #Set by Character
var states = {}
var currentState: State = null

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
		elif child.name == "LightAttack":
			for c in child.get_children():
				if c is State:
					states[c.name] = c
		
func change_state(newStateName: String):
	if currentState:
		currentState.exit()
	currentState = states.get(newStateName)
	if currentState:
		currentState.enter(character)
		currentState.state_changed.emit(newStateName)

		if currentState.attackState:
			Global.gravity = 0
			character.velocity = Vector2.ZERO
		else:
			Global.set_gravity()



func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)

func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_update(delta)
