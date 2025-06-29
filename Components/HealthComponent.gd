extends Node
class_name HealthComponent

signal health_depleted
signal health_healed
signal died

@export var maxHealth: int
@export var health: int:
	set(value):
		_health = value
		if healthBar:
			healthBar.value = health
	get():
		return _health
var _health: int


var healthBar: ProgressBar

func _ready() -> void:
	await get_parent().character_base_ready
	if not maxHealth:
		maxHealth = health
	healthBar = get_parent().get_node("HealthBar/ProgressBar")

	healthBar.max_value = maxHealth
	healthBar.value = health

func heal(amount: int):
	health += amount
	health = min(health, maxHealth)
	health_healed.emit()

func damage(amount: int):
	health -= amount
	health = max(0, health)
	health_depleted.emit()
	if health == 0:
		died.emit()
