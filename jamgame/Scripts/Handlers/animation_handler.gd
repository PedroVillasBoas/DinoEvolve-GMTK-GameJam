extends Node2D

class_name Animation_Handler

@onready var player : CharacterBody2D = self.get_parent()

@export var animated_sprite : AnimatedSprite2D
@export var dino_collision_handler : Area2D

var anim_finished : bool = false

func _ready() -> void:
	animated_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	player.connect("dead", Callable(self, "_on_dead"))

func _process(_delta: float) -> void:
	if !anim_finished:
		spawn_dino()
	else:
		if !player.is_dead and !player.is_chicken:
			handle_animation()

func handle_animation() -> void:
	if player.is_on_floor():
		animated_sprite.play("movement")
	else:
		animated_sprite.play("jump")

func spawn_dino() -> void:
	animated_sprite.play("spawn")

func _on_animation_finished() -> void:
	if animated_sprite.animation.get_basename().begins_with("spawn"):
		anim_finished = true
		player.can_move = true

func _on_dead():
	animated_sprite.play("dead")
