extends Button

@export var saved : Control
@export var saved_show_for: float

func _ready() -> void:
	saved.visible = false
	connect("pressed", _on_pressed)


func _on_pressed() -> void:
	Global.save_to_solofile()
	saved.visible = true
	await get_tree().create_timer(saved_show_for).timeout
	saved.visible = false
