extends Node2D

class_name Chicken_Collision_Handler

@onready var player : CharacterBody2D = self.get_parent()

@export var animated_sprite : AnimatedSprite2D
@export var chicken_collision_handler : Area2D

func _ready() -> void:
	player.connect("dead", Callable(self, "_on_dead"))
	chicken_collision_handler.connect("area_entered", Callable(self, "_on_chicken_collision_handler_area_entered"))

func _process(delta: float) -> void:
	if player.is_chicken and !player.is_dead:
		handle_animation()

func handle_animation():
	animated_sprite.play("fly")

func _on_dead():
	if !player.is_on_floor():
		animated_sprite.play("dead_fly")
		# Colocar o babado pra ligar a gravidade de novo
	else:
		animated_sprite.play("dead_ground")

func _on_chicken_collision_handler_area_entered(area : Area2D) -> void:
	if area.is_in_group("Obstacle") and player.is_chicken:
		player.dead.emit()
