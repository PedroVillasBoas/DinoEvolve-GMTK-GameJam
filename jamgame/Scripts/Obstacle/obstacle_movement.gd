extends RigidBody2D


@export var move_speed : float = 500.0

func _ready() -> void:
	linear_velocity = Vector2(-move_speed, 0)
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))

func on_body_entered(body : Node2D) -> void:
	if body.is_in_group("Player"):
		body.emit_signal("dead")
	elif body.is_in_group("Destroyer"):
		get_parent().queue_free()
