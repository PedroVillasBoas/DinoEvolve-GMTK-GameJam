extends Node

class_name Changer_Handler

@onready var map_environment_cave : PackedScene = preload("res://Scenes/Maps/Environments/envionment_envionment_cave.tscn")
@onready var map_stone_ruins : PackedScene = preload("res://Scenes/Maps/Environments/envionment_stone_ruins.tscn")
@onready var map_super_mountain_dusk : PackedScene = preload("res://Scenes/Maps/Environments/environment_super_mountain_dusk.tscn")
@onready var map_swamp_game : PackedScene = preload("res://Scenes/Maps/Environments/environment_swamp_game.tscn")


@export var score_handler : Score_Handler
@export var spawn_handler : Spawn_Handler

var environment_list : Array[PackedScene]
var current_environment_index : int = 0
var current_environment_instance : Node

signal fall_down
signal change_environment
signal chicken_time
signal dino_time

func _ready() -> void:
	environment_list = [
		map_environment_cave,
		map_stone_ruins,
		map_super_mountain_dusk,
		map_swamp_game
	]
	
	score_handler.connect("score_changed", Callable(self, "_on_score_changed"))
	
	load_environment(environment_list[current_environment_index])

func _on_score_changed(new_score: int) -> void:
	# Checking if the score is about to trigger an environment change (exact multiple of 2000)
	if new_score % 2000 == 0:
		# If the current environment is Super Mountain Dusk, emit fall_down before changing (METEOR TIME BABYYYY)
		if environment_list[current_environment_index] == map_super_mountain_dusk:
			emit_signal("fall_down")
			get_tree().paused = true
			await get_tree().create_timer(8.2).timeout
			emit_signal("chicken_time")
			get_tree().paused = false
		
		# Calculating the next environment
		current_environment_index = (current_environment_index + 1) % environment_list.size()
		load_environment(environment_list[current_environment_index])

func load_environment(environment_scene: PackedScene) -> void:
	if current_environment_instance:
		current_environment_instance.queue_free()
	
	# Instantiating and adding the new environment
	current_environment_instance = environment_scene.instantiate()
	add_child(current_environment_instance)
	
	# Emitting the signal to notify other Handlers
	emit_signal("change_environment", environment_scene.resource_name)

	# Updating the Spawn Handler to match the new environment
	spawn_handler.change_biome(environment_scene.resource_name)
