extends Label

func _process(delta: float) -> void:
	text = "%s" % Global.player.gold
