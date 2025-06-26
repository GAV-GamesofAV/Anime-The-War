extends State
class_name MeleeAttackState

@export var controllerKey: String #The key that triggers this state or attack
@export var comboName: String

var characterComboStateNames: Array

# @export var actionName: StringName
#@export var hitBoxColliderSize: float #To manually set the size of the hitbox at different attacks

func enter(_character):
	super(_character)
	character.play_animation(animationName[randi() % animationName.size()])

	#Set the name of the combos
	if comboName == "light":
		characterComboStateNames = character.lightAttackComboStatesNames

	if character.comboManager.get_stage(comboName) == 0:
		character.comboManager.start_combo(comboName)
	else:
		character.comboManager.continue_combo(comboName)
	
	character.hitbox.monitoring = true
	#character.hitbox.colliderShape.size.x = hitBoxColliderSize	

func update(_delta):
	super(_delta)
	
	
	#previous code
	# if character.isPlayer:
	# 	if Input.is_action_pressed(actionName) and character.comboManager.is_chaining_allowed(comboName) and not character.comboManager.max_stage_reached(comboName):
	# 		#Add elif and compare it to the name of the combo such as heavy and then change state
	# 		if comboName == "light":
	# 			character.change_state(character.lightAttackComboStatesNames[character.comboManager.get_stage(comboName)])
	# 		# elif comboName == "heavy":
	# 		#     character.change_state(character.heavyAttackComboStatesNames[character.comboManager.get_stage(comboName)])
	

func handle_input(_inputData: Dictionary):
	
	if character.is_animation_finished():
		character.comboManager.allow_chain(comboName)


	if _inputData[controllerKey]:
		if character.comboManager.is_chaining_allowed(comboName):
			character.change_state(characterComboStateNames[character.comboManager.get_stage(comboName)])
		
	
	if character.is_animation_finished() and character.is_on_floor():
		character.change_state(character.idleStateName)
	if character.is_animation_finished() and not character.is_on_floor():
		character.change_state(character.fallStateName)
