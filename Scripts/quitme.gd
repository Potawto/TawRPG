extends RichTextLabel


func _on_meta_clicked(_meta: Variant) -> void:
	get_tree().quit()
