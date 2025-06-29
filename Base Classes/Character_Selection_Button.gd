extends TextureButton
class_name CharacterSelectionButton

var parent: Control

@export var characterName: String

func _ready() -> void:
	parent = get_parent().get_parent()

func _pressed():
	if not parent.playerSelected:
		parent.playerScene = Data.CHARACTERS[characterName].get("scene")

		if get_tree().get_node_count_in_group("PlayerDisplay") > 0:
			parent.playerDisplay.remove_from_group("PlayerDisplay")
			get_tree().current_scene.get_node(parent.playerDisplay.get_path()).queue_free()
			print(str(parent.playerDisplay))
			

		parent.playerDisplay = load(parent.playerScene).instantiate()
		get_tree().current_scene.add_child(parent.playerDisplay)
		parent.playerDisplay.position = get_tree().current_scene.get_node("PlayerDisplayPoint").position

		parent.playerDisplay.add_to_group("PlayerDisplay")
		

	else:
		parent.enemyScene = Data.CHARACTERS[characterName].get("scene")

		if get_tree().get_node_count_in_group("EnemyDisplay") != 0:
			parent.enemyDisplay.remove_from_group("EnemyDisplay")
			get_tree().current_scene.get_node(parent.enemyDisplay.get_path()).queue_free()

		parent.enemyDisplay = load(parent.enemyScene).instantiate()
		get_tree().current_scene.add_child(parent.enemyDisplay)
		parent.enemyDisplay.position = get_tree().current_scene.get_node("EnemyDisplayPoint").position

		parent.enemyDisplay.add_to_group("EnemyDisplay")
