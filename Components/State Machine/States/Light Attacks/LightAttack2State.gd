extends State
class_name LightAttack2State

func enter(_character):
    super(_character)

    attackState = true

    character.play_animation(animationName)
    character.comboManager.continue_combo("light")

func update(_delta):

    super(_delta)
    

    if character.is_animation_finished():
        character.comboManager.allow_chain("light")
    
    if Input.is_action_pressed("attack 1") and character.comboManager.is_chaining_allowed("light"):
        character.change_state(character.lightAttackComboStatesNames[2])
    
    if character.is_animation_finished() and character.is_on_floor():
        character.change_state(character.idleStateName)
    elif character.is_animation_finished() and not character.is_on_floor():
        character.change_state(character.fallStateName)