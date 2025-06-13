extends Area2D
class_name HitBox

#We can change the size of the collider of the hitbox at every state in order to polish the game

@export var damage: int 
@export var xOffset: float

#var colliderShape: RectangleShape2D #used to change it's size during melee attack 

var enemy: Character
func _ready() -> void:
	area_entered.connect(apply_damage)
	collision_layer = 4
	collision_mask = 5
	#colliderShape = $CollisionShape2D.shape

func apply_damage(area: Area2D):
	if area is HurtBox and area.get_parent() == enemy:
		print(str(get_parent()) + " HitBox collided")
		area.take_damage(damage)
		set_deferred("monitoring", false)
