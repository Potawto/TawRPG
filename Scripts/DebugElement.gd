extends CanvasItem

@export var is_debug_element := true

func _ready() -> void:
	visible = Global.debug_elements_start_visible

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_info") and not event.is_echo():
		visible = not visible
