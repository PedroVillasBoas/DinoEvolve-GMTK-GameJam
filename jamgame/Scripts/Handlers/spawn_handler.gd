extends Node

class_name Spawn_Handler


@export var top_obstacle_spawn_pos : Node2D
@export var ground_obstacle_spawn_pos : Node2D

@export var top_obstacle_scene : PackedScene
@export var ground_obstacle_scene : PackedScene


func _on_SpawnObstacle_timeout():
	# Spawn ground obstacle
	var ground_obstacle = ground_obstacle_scene.instantiate()
	ground_obstacle.position = Vector2(get_viewport().size.x, ground_obstacle_spawn_pos.y)
	add_child(ground_obstacle)
	ground_obstacle.set_linear_velocity(Vector2(-200, 0))

	# Spawn top obstacle
	var top_obstacle = top_obstacle_scene.instantiate()
	top_obstacle.position = Vector2(get_viewport().size.x, top_obstacle_spawn_pos.y)
	add_child(top_obstacle)
	top_obstacle.set_linear_velocity(Vector2(-200, 0))
