extends CharacterBody2D
class_name Character

signal character_base_ready
signal died

var characterBaseReady: bool = false

var map: Map

@export var isPlayer: bool
@export var speed: int = 200
@export var jumpVelocity: int = 400

@export var sprite: AnimatedSprite2D
@export var stateMachine: StateMachine
@export var comboManager: ComboManager
@export var healthComponent: HealthComponent
@export var hurtbox: HurtBox
@export var hitbox: HitBox

var camera: Camera2D
var controller: Controller
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
	await Global.game_ready
	stateMachine.character = self
	stateMachine.change_state(idleStateName)
	
	hurtbox.took_damage.connect(_on_hurtbox_damage)
	healthComponent.died.connect(_health_component_died)

	collision_mask = 1

	if isPlayer:
		collision_layer = 2
		hitbox.enemy = enemy
		controller = PlayerController.new()
		camera = Camera2D.new()
		camera.position_smoothing_enabled = true
		add_child(camera)

		
	else:
		collision_layer = 3
		enemy = get_parent().player
		hitbox.enemy = enemy
		controller = AIController.new()
		controller.player = enemy #Set the player of the controller to real player, i.e enemy of this 
		print("Is enemy")
	
	controller.character = self

	add_child(controller)

	characterBaseReady = true
	character_base_ready.emit()

func _physics_process(delta: float) -> void:
	if characterBaseReady:
		stateMachine._physics_process(delta)

		var inputData: Dictionary = controller.get_input()
		stateMachine.currentState.handle_input(inputData)

		#Apply Gravity
		if not is_on_floor():
			velocity.y += Global.gravity * delta
		
		position = position.clamp(map.minWorldLimit, map.maxWorldLimit)

		move_and_slide()

func _process(delta: float) -> void:
	if characterBaseReady:
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

func _health_component_died():
	Global.call_deferred("game_over")