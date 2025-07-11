extends Area2D
class_name HurtBox

signal took_damage

@export var healthComponent: HealthComponent

func _ready() -> void:
    collision_layer = 5
    collision_mask = 4
func take_damage(amount):
    healthComponent.damage(amount)
    took_damage.emit()
    print(str(get_parent()) + "hurtbox took damage")