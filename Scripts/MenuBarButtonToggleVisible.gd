class_name MenuBarButtonGotoScene
extends MenuBarButton

@export var _element: Control


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		#var mouse_event = event as InputEventMouseButton
		_element.visible = not _element.visible
