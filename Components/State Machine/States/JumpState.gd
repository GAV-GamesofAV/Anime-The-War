extends State
class_name JumpState

func enter(_character):
    super(_character)
    character.play_animation(animationName[randi() % animationName.size()])

    #Make the character Jump 
    character.jump()

func update(_delta):
    super(_delta)
    if character.velocity.y > 0:
        character.change_state(character.fallStateName)
    elif Input.is_action_just_pressed("attack 1") and character.isPlayer:
        if character.comboManager.is_chaining_allowed("light"):
            character.change_state(character.lightAttackComboStatesNames[character.comboManager.get_stage("light")])
        else:
            character.change_state(character.lightAttackComboStatesNames[0])