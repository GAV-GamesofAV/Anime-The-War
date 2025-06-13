extends State
class_name RunState

var direction = 0

func enter(_character):
    super(_character)
    character.play_animation(animationName)

func update(_delta):
    
    if character.isPlayer:
        direction = Input.get_axis("move left", "move right")
        character.move(direction)

    #Character flipping
    if direction == 0:
        character.sprite.flip_h = character.sprite.flip_h
    elif direction > 0:
        character.sprite.flip_h = false
    elif direction < 0:
        character.sprite.flip_h = true

    #Change States
    if direction == 0:
        character.change_state(character.idleStateName)
    if Input.is_action_pressed("jump"):
        character.change_state(character.jumpStateName)
    elif Input.is_action_just_pressed("attack 1"):
        if character.comboManager.is_chaining_allowed("light"):
            character.change_state(character.lightAttackComboStatesNames[character.comboManager.get_stage("light")])
        else:
            character.change_state(character.lightAttackComboStatesNames[0])
    
