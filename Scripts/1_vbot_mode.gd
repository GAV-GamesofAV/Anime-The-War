extends Node2D

var player: Character
var bot: Character

func _ready() -> void:
    player = get_tree().get_first_node_in_group("Player")
    bot = get_tree().get_first_node_in_group("Enemy")
    Global.game_ready.emit()
    Global.gameReady = true