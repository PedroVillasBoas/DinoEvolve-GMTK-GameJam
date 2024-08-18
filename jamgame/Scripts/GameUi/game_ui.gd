extends Control

@onready var score1 = $Score

var score : float = 0


func _process(delta):
	score += 0.5
	score1.text = "ScoreperTime: %dm" % score

#falta colocar no label o score por coletáveis, não sei como colocar :(
