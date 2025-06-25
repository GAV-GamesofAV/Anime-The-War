extends Controller
class_name PlayerController

func get_input() -> Dictionary:
    return {
        moveKey : Input.get_axis("move left", "move right"),
        jumpKey : Input.is_action_just_pressed("jump"),
        lightAttackKey : Input.is_action_just_pressed("attack 1")
    }