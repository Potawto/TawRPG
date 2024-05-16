extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO


func update(_delta: float) -> void:
	var x_input = Input.get_axis("left", "right")
	var y_input = Input.get_axis("up", "down")
	
	if x_input != 0 or y_input != 0:
		transitioned.emit("WalkState")
		return
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("JumpState")
		return
	
	owner.animation_player.play("idle")

