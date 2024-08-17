extends Control

var score = 0
@onready var scoreLabel = $Score

func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	score += 0.5
	scoreLabel.text = "Score: %dm" % score
