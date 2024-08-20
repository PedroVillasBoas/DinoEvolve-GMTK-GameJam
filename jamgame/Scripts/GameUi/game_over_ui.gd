extends Control

class_name Game_Over_UI


func _ready() -> void:
	GameManager.connect("game_over", Callable(self, "_on_game_over"))
	

func _on_game_over():
	get_tree().paused = true
	GuiTransitions.show("Game_Over_UI")

func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
