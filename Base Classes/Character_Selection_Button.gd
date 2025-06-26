extends TextureButton
class_name CharacterSelectionButton

var parent: Control

@export var characterName: String

func _ready() -> void:
    parent = get_parent().get_parent()

func _pressed():
    if not parent.playerSelected:
        parent.playerScene = Data.CHARACTERS[characterName].get("scene")
    else:
        parent.enemyScene = Data.CHARACTERS[characterName].get("scene")