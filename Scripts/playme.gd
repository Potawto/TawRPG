extends RichTextLabel

@export var _scene: String

func _on_meta_clicked(meta: Variant) -> void:
	Global.goto_scene(_scene)
