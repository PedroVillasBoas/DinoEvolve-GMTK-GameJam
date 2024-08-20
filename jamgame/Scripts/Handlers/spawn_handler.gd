extends Node

class_name Spawn_Handler

# Spawns
@export_category("Spawns")
@export var top_obstacle_spawn_pos : Node2D
@export var projectile_spawns_pos : Array[Node2D]
@export var ground_obstacle_spawn_pos : Node2D

### Interval
@export_category("Dino Interval")
## Dino
# Minimum time between spawns
@export var dino_min_spawn_interval: float = 1.0  
# Maximum time between spawns
@export var dino_max_spawn_interval: float = 3.0

@export_category("Chicken Interval")
## Chicken
# Minimum time between spawns
@export var chicken_min_spawn_interval: float = 0.5
# Maximum time between spawns
@export var chicken_max_spawn_interval: float = 2.0

## Timers
@export_category("Timers")
# Dino Timer
@export var dino_spawn_timer : Timer
# Chicken Timer
@export var chicken_spawn_timer : Timer

## Biomes
var current_biome : String = "EnvironmentCave"
var biomes_data : Dictionary = {}

func _ready() -> void:
	load_biomes_data()
	start_dino_spawn_cycle()

# Add the Biomes Data to the Dictionary
func load_biomes_data() -> void:
	# Preloading the Resources we created
	var environment_cave_data = preload("res://Scenes/Resources/Envionments/environment_cave_obstacles.tres")
	var stone_ruins_data = preload("res://Scenes/Resources/Envionments/stone_ruins_obstacles.tres")
	var super_mountain_dusk_data = preload("res://Scenes/Resources/Envionments/super_mountain_dusk_obstacles.tres")
	var swamp_game_data = preload("res://Scenes/Resources/Envionments/projectiles_obstacles.tres")

	biomes_data["EnvironmentCave"] = {
		"ground_obstacles" : environment_cave_data.obstacles_array
		# "top_obstacles": environment_cave_data.obstacles_array,
		# "projectile_obstacles": environment_cave_data.obstacles_array
	}
	biomes_data["StoneRuins"] = {
		"ground_obstacles" : stone_ruins_data.obstacles_array
		# "top_obstacles": environment_cave_data.obstacles_array,
		# "projectile_obstacles": environment_cave_data.obstacles_array
	}
	biomes_data["SuperMountainDusk"] = {
		"ground_obstacles" : super_mountain_dusk_data.obstacles_array
		# "top_obstacles": environment_cave_data.obstacles_array,
		# "projectile_obstacles": environment_cave_data.obstacles_array
	}
	biomes_data["SwampGame"] = {
		# "ground_obstacles" : swamp_game_data.obstacles_array
		# "top_obstacles": environment_cave_data.obstacles_array,
		"projectile_obstacles": swamp_game_data.obstacles_array
	}
	# Setting default/first Environment
	current_biome = "EnvironmentCave"

# After the Signal from the Game Manager to start the game [Ainda não criamos o Game Manager, ok?]
func start_dino_spawn_cycle() -> void:
	# Random time for next spawn within range
	var time_to_next_spawn = randf_range(dino_min_spawn_interval, dino_max_spawn_interval)
	dino_spawn_timer.start(time_to_next_spawn)

# After the Signal from the Game Manager to start the Chicken Spawn Timer [Ainda não criamos o Game Manager, ok?]
func start_chicken_spawn_cycle() -> void:
	# Random time for next spawn within range
	var time_to_next_spawn = randf_range(chicken_min_spawn_interval, chicken_max_spawn_interval)
	dino_spawn_timer.start(time_to_next_spawn)

# Spawn Ground or top Obstacle
func spawn_obstacle(obstacle_list: Array[PackedScene], spawn_position: Vector2) -> void:
	if obstacle_list.size() > 0:
		var obstacle_scene = obstacle_list[randi() % obstacle_list.size()]
		var obstacle_instance = obstacle_scene.instantiate() as RigidBody2D
		obstacle_instance.position = spawn_position
		add_child(obstacle_instance)

# Spawn Projectile
func spawn_projectile(obstacle_list: Array[PackedScene]) -> void:
	if obstacle_list.size() > 0 and projectile_spawns_pos.size() > 0:
		var spawn_pos = projectile_spawns_pos[randi() % projectile_spawns_pos.size()]
		var projectile_scene = obstacle_list[randi() % obstacle_list.size()]
		var projectile_instance = projectile_scene.instantiate() as RigidBody2D
		projectile_instance.position = spawn_pos.position
		add_child(projectile_instance)

func change_biome(environment_name: String) -> void:
	if environment_name in biomes_data:
		current_biome = environment_name
		print("Environment changed to: ", environment_name)
	else:
		print("Unknown environment: ", environment_name)

# Spawn Timer Timeout
func _on_dino_spawn_obstacle_timer_timeout() -> void:
	# Randomly deciding which type of obstacle to spawn
	var obstacle_type = randi() % 3
	
	# Ground
	if obstacle_type == 0:
		spawn_obstacle(biomes_data[current_biome]["ground_obstacles"], ground_obstacle_spawn_pos.position)
	# Top
	elif obstacle_type == 1:
		# Checking to see if current environment has the Top obstacle
		if "top_obstacles" in biomes_data[current_biome] and biomes_data[current_biome]["top_obstacles"].size() > 0:
			spawn_obstacle(biomes_data[current_biome]["top_obstacles"], top_obstacle_spawn_pos.position)
		else:
			spawn_obstacle(biomes_data[current_biome]["ground_obstacles"], ground_obstacle_spawn_pos.position)
	# Projectile
	elif obstacle_type == 2:
		# Checking to see if current environment has the Projectile obstacle
		if "projectile_obstacles" in biomes_data[current_biome] and biomes_data[current_biome]["projectile_obstacles"].size() > 0:
			spawn_projectile(biomes_data[current_biome]["projectile_obstacles"])
		else:
			spawn_obstacle(biomes_data[current_biome]["ground_obstacles"], ground_obstacle_spawn_pos.position)
	
	# Start the next spawn cycle
	start_dino_spawn_cycle()


func _on_chicken_spawn_obstacle_timer_timeout() -> void:
	if "projectile_obstacles" in biomes_data[current_biome] and biomes_data[current_biome]["projectile_obstacles"].size() > 0:
		spawn_projectile(biomes_data[current_biome]["projectile_obstacles"])
	
	# Start the next spawn cycle
	start_chicken_spawn_cycle()
