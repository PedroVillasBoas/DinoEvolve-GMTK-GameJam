extends Area2D

@export var score_value: int = 10
signal collected(value)

func _ready() -> void:
	connect("body_entered", _on_item_body_entered)

func _on_item_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("collected", score_value)
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.score += 1
		self.queue_free()
		print(body.score)
