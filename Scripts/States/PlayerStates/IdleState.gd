extends State


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		transitioned.emit("WalkState", {"pos": event.position})


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
	if Input.is_action_just_pressed("dig"):
		transitioned.emit("DigState")
		return
	
	owner.animation_player.play("idle")

