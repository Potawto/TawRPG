class_name MainMenuPanelContainer
extends Container

func enable_panel(panel_name: String) -> void:
	for p in get_children():
		if p.name == panel_name:
			p.visible = true
		else:
			p.visible = false
