extends Control

class_name Score_Handler

@export var score_rich_text : RichTextLabel
@export var collectables_rich_text : RichTextLabel
@export var player : CharacterBody2D

var score_amount : int = 0
var collectables_amount : int = 0

signal score_changed

func _ready() -> void:
	collectables_rich_text.text = "Artifacts: %s" % collectables_amount
	score_rich_text.text = "Score: %s" % score_amount
	player.connect("collectable", Callable(self, "_on_collectable"))

func _process(delta: float) -> void:
	update_score()

func _physics_process(delta) -> void:
	set_score_amount(score_amount + 0.5 / delta * 0.05)

func _on_collectable():
	collectables_amount += 1
	collectables_rich_text.text = "Artifacts:[shake rate=20 level=5 connected=1] %c [/shake]" % collectables_amount
	await get_tree().create_timer(1).timeout
	collectables_rich_text.text = "Artifacts: %s" % collectables_amount

func update_score() -> void:
	score_rich_text.text = "Score: %s" % score_amount

func set_score_amount(value: int) -> void:
	if round(score_amount / 2000) < round(value / 2000):
		emit_signal("score_changed", value)
	
	score_amount = value
