extends Control

class_name In_Game_UI

var paused : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !paused:
		get_tree().paused = true
		GuiTransitions.go_to("Pause_Screen_UI")
	elif event.is_action_pressed("ui_cancel") and paused:
		GuiTransitions.hide("Pause_Screen_UI")
		get_tree().paused = false
