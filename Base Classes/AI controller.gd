extends Controller
class_name AIController

var player: Character #Referring to the real player

#Probabilities
var probabilities: Dictionary = {
	"move probability" : 0.3,
	"jump probability" : 0.4,
	"attack probabilty" : 0.5,
}

func get_input() -> Dictionary:
	var direction: int = 0
	var lightAttack: bool = false

	var distance = abs(character.position.x - player.position.x)
	#Decision making
	if distance <= 30:
		lightAttack = should_attack()
	else:
		direction = get_direction()
		

	return{
		moveKey: direction,
		jumpKey: false,
		lightAttackKey: lightAttack
	}
	

func get_direction() -> int:
	if randf() < probabilities["move probability"]:
		return randi_range(-1, 1)
	else:
		return 0

func should_attack() -> bool:
	return (
		randf() < probabilities["run probability"]
	)
