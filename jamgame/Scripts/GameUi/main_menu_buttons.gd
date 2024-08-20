extends Control

class_name MainMenuButtons




func _on_start_button_pressed() -> void:
	GameManager.start_button_game()


func _on_skins_button_pressed() -> void:
	GuiTransitions.go_to("Skins_UI")


func _on_credits_button_pressed() -> void:
	GuiTransitions.go_to("EndCredits")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
