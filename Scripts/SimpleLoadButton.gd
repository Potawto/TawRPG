extends Button

@export var loaded : Control
@export var loaded_show_for: float

func _ready() -> void:
	loaded.visible = false
	connect("pressed", _on_pressed)


func _on_pressed() -> void:
	Global.load_from_solofile()
	loaded.visible = true
	await get_tree().create_timer(loaded_show_for).timeout
	loaded.visible = false
