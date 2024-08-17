extends Control

var score = 0
@onready var score1 = $ScoreperTime

func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	score1 += 0.5
	score1.text = "ScoreperTime: %dm" % score1

#falta colocar no label o score por coletáveis, não sei como colocar :(
