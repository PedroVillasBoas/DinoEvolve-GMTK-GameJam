extends Node2D

class_name Meteor

@export var animated_sprite : AnimatedSprite2D
@export var vfx : GPUParticles2D
@export var animation_player : AnimationPlayer
@export var changer_handler : Changer_Handler

func _ready() -> void:
	await get_tree().create_timer(1).timeout 
	changer_handler.connect("fall_down", Callable(self, "_on_fall_down"))

func explode():
	animated_sprite.play("explode")

func activate_vfx():
	vfx.emitting = true

func despawn():
	self.hide()

func hide_meteor():
	animated_sprite.hide()

func _on_fall_down():
	self.show()
	animation_player.play("meteor")
