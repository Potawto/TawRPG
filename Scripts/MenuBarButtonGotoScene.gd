class_name MenuBarButtonToggleVisible
extends MenuBarButton

@export var _goto_scene: String


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#var mouse_event = event as InputEventMouseButton
		Global.goto_scene(_goto_scene)
