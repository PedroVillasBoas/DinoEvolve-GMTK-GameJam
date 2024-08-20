extends Node

class_name GameManager

# Player Reference
var player : Player

# Player Skin
var player_skin : PackedScene

## Checks
# When the game starts
var game_started : bool = false

# Give the skin to the player when the game starts
signal give_skin
# Give the chicken to the player when the game starts
signal give_chicken
# signal to let everything know to start the game
signal start_game


func give_skin_to_player() -> void:
	var skin_instance = player_skin.instantiate()
	player.add_child(skin_instance)
	skin_instance.global_position = player.global_position

func give_chicken_to_player():
	var chicken_scene = preload("res://Scenes/Player/Chicken/chicken.tscn")
	var chicken_instance = chicken_scene.instantiate()
	player.add_child(chicken_instance)
	chicken_instance.global_position = player.position

func set_player_skin(skin : PackedScene) -> void:
	player_skin = skin
