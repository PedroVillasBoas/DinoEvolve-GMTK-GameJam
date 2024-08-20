extends Node

class_name DinoEvolveGameManager

# Player Reference
var player : Player

# Player Dino Skin
var player_dino_skin : PackedScene
# Player Chicken Skin
var player_chicken_skin : PackedScene
# Player Dino Default skin
@onready var player_dino_default_skin : PackedScene = preload("res://Scenes/Player/Dinos/Female/loki_female.tscn")
# Player Chicken Default skin
@onready var player_chicken_default_skin : PackedScene = preload("res://Scenes/Player/Chicken/chicken.tscn")

## Checks
# When the game starts
var game_started : bool = false

# Give the skin to the player when the game starts
signal give_skin
# Give the chicken to the player when the game starts
signal give_chicken
# signal to let everything know to start the game
signal start_game
# Signal to let everything know the game ended
signal game_over

func _ready() -> void:
	player_dino_skin = player_dino_default_skin
	player_chicken_skin = player_chicken_default_skin

# Change scene to game
func start_button_game():
	await get_tree().change_scene_to_file("res://Scenes/Maps/MainGame/world.tscn")
	await get_tree().create_timer(0.3).timeout
	for child in get_tree().root.get_child(-1).get_children():
		if child.is_in_group("Player"):
			player = child
	give_dino_skin_to_player()
	give_chicken_to_player()
	player.connect("dead", Callable(self, "_on_player_dead"))

# Add Child Player Dino Skin In Game
func give_dino_skin_to_player() -> void:
	var skin_instance = player_dino_skin.instantiate()
	player.add_child(skin_instance)
	skin_instance.global_position = player.global_position

# Add Child Player Chicken Skin In Game
func give_chicken_to_player():
	var chicken_instance = player_chicken_default_skin.instantiate()
	player.add_child(chicken_instance)
	chicken_instance.global_position = player.position

# Set Player Dino Skin in Skins Menu
func set_player_dino_skin(skin : PackedScene) -> void:
	player_dino_skin = skin

# Set Player Chicken Skin in Skins Menu
func set_player_chicken_skin(skin : PackedScene) -> void:
	player_chicken_skin = skin

func _on_player_dead():
	emit_signal("game_over")
