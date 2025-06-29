extends Node2D

var player: Character
var bot: Character

func _ready() -> void:
    player = Global.playerScene.instantiate()
    bot = Global.enemyScene.instantiate()

    player.isPlayer = true
    player.enemy = bot
    bot.enemy = player
    bot.isPlayer = false
    add_child(player)
    add_child(bot)
    bot.position.x += 20 #Temp
    
    player.map = get_node("Map1")
    bot.map = get_node("Map1")

    Global.game_ready.emit()
    Global.gameReady = true