@tool
extends Credits

@export_file("*.tscn") var main_menu_scene : String

func _end_reached():
	%EndMessagePanel.show()
	super._end_reached()

func _on_MenuButton_pressed():
	GuiTransitions.go_to("MainMenuButtons")

func _on_ExitButton_pressed():
	GuiTransitions.go_to("MainMenuButtons")

func _ready():
	if main_menu_scene.is_empty():
		%MenuButton.hide()
	if OS.has_feature("web"):
		%ExitButton.hide()
	super._ready()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if not %EndMessagePanel.visible:
			_end_reached()
		else:
			GuiTransitions.go_to("MainMenuButtons")

func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		reset()
	else:
		%EndMessagePanel.hide()
