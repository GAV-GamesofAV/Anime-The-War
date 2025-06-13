extends State
class_name FallState

func enter(_character):
    super(_character)
    character.play_animation(animationName)
    
func update(_delta):
    super(_delta)
    if character.is_on_floor() or character.velocity.y == 0:
        character.velocity = Vector2.ZERO
        character.change_state(character.idleStateName)