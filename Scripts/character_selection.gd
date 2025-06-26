extends Control

var playerSelected: bool = false #False is selecting true otherwise true

#Paths
var playerScene: String
var enemyScene: String 

func _on_confirm_button_pressed() -> void:
    if not playerSelected:
        playerSelected = true
    elif playerScene and enemyScene:
        Global.playerScene = load(playerScene)
        Global.enemyScene = load(enemyScene)

        get_tree().change_scene_to_file(Data.SCENE.get("1vBot Mode"))
    
    