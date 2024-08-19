extends Resource

class_name ObstacleData

@export var environment_name : String = "default"
@export var obstacles_array : Array[PackedScene] = []
@export var obstacle_type : Obstacle_Type = Obstacle_Type.GROUND

enum Obstacle_Type {
	TOP = 1,
	GROUND = 2,
	PROJECTILE = 3,
}
