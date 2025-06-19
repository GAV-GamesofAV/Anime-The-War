extends CharacterBody2D
class_name Character

@export var isPlayer: bool
@export var speed: int = 200
@export var jumpVelocity: int = 400

@export var sprite: AnimatedSprite2D
@export var stateMachine: StateMachine
@export var comboManager: ComboManager
@export var healthComponent: HealthComponent
@export var hurtbox: HurtBox
@export var hitbox: HitBox

var enemy: Character

#Name of states
var idleStateName: String = "IdleState"
var runStateName: String = "RunState"
var jumpStateName: String = "JumpState"
var fallStateName: String = "FallState"
var hurtStateName: String = "HurtState"
#Attacks
@export var lightAttackComboStatesNames: Array[String] = [
	"LightAttack1State",
	"LightAttack2State",
	"LightAttack3State",
	"LightAttack4State"
]

func _ready() -> void:
	stateMachine.character = self
	stateMachine.change_state(idleStateName)
	
	hurtbox.took_damage.connect(_on_hurtbox_damage)

	collision_mask = 1

	if isPlayer:
		collision_layer = 2
	else:
		collision_layer = 3

	if isPlayer:
		enemy = get_tree().get_first_node_in_group("Enemy")
		hitbox.enemy = enemy
	else:
		enemy = get_tree().get_first_node_in_group("Player")
		hitbox.enemy = enemy

func _physics_process(delta: float) -> void:
	stateMachine._physics_process(delta)

	#Apply Gravity
	if not is_on_floor():
		velocity.y += Global.gravity * delta

	move_and_slide()

func _process(delta: float) -> void:
	stateMachine._process(delta)
	if comboManager:
		comboManager.update(delta)

func change_state(newStateName: String):
	stateMachine.change_state(newStateName)

func play_animation(animationName: String):
	sprite.play(animationName)

func is_animation_finished():
	return !sprite.is_playing()

func move(dir):
	velocity.x = dir * speed

func jump():
	velocity.y = -jumpVelocity

func _on_hurtbox_damage():
	change_state(hurtStateName)