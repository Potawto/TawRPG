extends Button

@onready var _menu_panels := $"../../MenuPanels" as MainMenuPanelContainer

func _ready() -> void:
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	_menu_panels.enable_panel(name)
