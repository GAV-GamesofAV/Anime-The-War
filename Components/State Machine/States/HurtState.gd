extends State
class_name HurtState

func enter(_character):
    super(_character)
    if character.sprite.sprite_frames.has_animation(animationName[randi() % animationName.size()]): #Temp
        character.play_animation(animationName[randi() % animationName.size()])
    
func update(_delta):
    if not character.enemy.stateMachine.currentState is MeleeAttackState:
        character.change_state(character.idleStateName)