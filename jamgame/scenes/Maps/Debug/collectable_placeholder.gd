extends Area2D

@export var score_value: int = 1
signal collected(value)

func _on_coin_body_entered(body: Node) -> void:
	if body.name == "LokiFemale": #não sei exatamente como eu deveria colocar, to testando com a Loki
		emit_signal("collected", score_value)
		queue_free()

func _ready() -> void:
	connect("body_entered", _on_coin_body_entered)
