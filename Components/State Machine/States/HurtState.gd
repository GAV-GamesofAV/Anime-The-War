extends State
class_name HurtState

func enter(_character):
    super(_character)
    character.play_animation(animationName[randi() % animationName.size()])
    
func update(_delta):
    if not character.enemy.stateMachine.currentState is MeleeAttackState:
        character.change_state(character.idleStateName)