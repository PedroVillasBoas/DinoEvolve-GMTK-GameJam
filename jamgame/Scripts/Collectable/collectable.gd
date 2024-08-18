extends Area2D

class_name Collectable

@export var move_speed : float = 200

func _ready() -> void:
	var parent = get_parent()
	parent.linear_velocity = Vector2(-move_speed, 0)
	
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("Player"):
		body.emit_signal("collectable")
		queue_free()
