extends Control

class_name In_Game_UI


@export var pause_screen : Control
@export var game_over : Control

var paused : bool = false

func _ready() -> void:
	GameManager.connect("game_over", Callable(self, "_on_game_over"))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !paused:
		GuiTransitions.go_to("Pause_Screen_UI")
		get_tree().paused = true
		paused = true
	elif event.is_action_pressed("ui_cancel") and paused:
		GuiTransitions.hide("Pause_Screen_UI")
		get_tree().paused = false
		paused = false

func _on_game_over():
	GuiTransitions.go_to("Game_Over_UI")
	get_tree().paused = true
