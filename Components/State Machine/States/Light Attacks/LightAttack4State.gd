extends State
class_name LightAttack4State

func enter(_character):
    super(_character)


    character.play_animation(animationName)
    character.comboManager.continue_combo("light")

func update(_delta):
    super(_delta)

    if character.is_animation_finished():
        character.comboManager.reset_combo("light")

    if character.is_animation_finished() and character.is_on_floor():
        character.change_state(character.idleStateName)
    elif character.is_animation_finished() and not character.is_on_floor():
        character.change_state(character.fallStateName)