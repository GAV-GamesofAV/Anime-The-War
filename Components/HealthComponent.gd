extends Node
class_name HealthComponent

signal health_depleted
signal health_healed

@export var health: int

func heal(amount: int):
    health += amount
    health_healed.emit()

func damage(amount: int):
    health -= amount
    health_depleted.emit()
    print(get_parent().name + "Health : " + str(health))