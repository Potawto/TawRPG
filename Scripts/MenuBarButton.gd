class_name MenuBarButton
extends PanelContainer

@export var _menu_bar: Container
@export var _goto_scene: String

@export_group("Hover Style")
@export var _style_box_empty: StyleBoxEmpty
@export var _style_box_hover: StyleBoxFlat


func _ready() -> void:
	_menu_bar.connect("mouse_entered", _on_menu_bar_mouse_entered)
	_menu_bar.connect("mouse_exited", _on_menu_bar_mouse_exited)
	self.connect("mouse_entered",_on_mouse_entered)
	self.connect("mouse_exited", _on_mouse_exited)
	self.connect("gui_input", _on_gui_input)
	

func _on_menu_bar_mouse_entered() -> void:
		Global.tree.set_group("menu_bar_expands", "visible", true)


func _on_menu_bar_mouse_exited() -> void:
		Global.tree.set_group("menu_bar_expands", "visible", false)


func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", _style_box_hover)

func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", _style_box_empty)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#var mouse_event = event as InputEventMouseButton
		Global.goto_scene(_goto_scene)
