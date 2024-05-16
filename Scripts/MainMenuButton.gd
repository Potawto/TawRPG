extends Button

@export var my_panel: PanelContainer

func _on_pressed() -> void:
	my_panel.visible = not my_panel.visible
