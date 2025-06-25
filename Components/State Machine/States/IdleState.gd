extends State
class_name IdleState

func enter(_character):
	super(_character)
	character.play_animation(animationName[randi() % animationName.size()])

#Previous code
# func update(_delta):
# 	if character.isPlayer:
# 		if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
# 			character.change_state(character.runStateName)
# 		elif Input.is_action_pressed("jump"):
# 			character.change_state(character.jumpStateName)
# 		elif Input.is_action_just_pressed("attack 1"):
# 			if character.comboManager.is_chaining_allowed("light"):
# 				character.change_state(character.lightAttackComboStatesNames[character.comboManager.get_stage("light")])
# 			else:
# 				character.change_state(character.lightAttackComboStatesNames[0])

func handle_input(_inputData: Dictionary):
	if stateBaseReady:
		if _inputData[controller.moveKey]: 
			character.change_state(character.runStateName)
		if _inputData[controller.jumpKey]:
			character.change_state(character.jumpStateName)
		#For light attack
		if _inputData[controller.lightAttackKey]:
			if character.comboManager.is_chaining_allowed("light"):
				character.change_state(character.lightAttackComboStatesNames[character.comboManager.get_stage("light")])
			else:
				character.change_state(character.lightAttackComboStatesNames[0])
