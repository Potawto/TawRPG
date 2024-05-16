extends State

# with animation length 0.5s, this should be 2
const animation_speed_coefficient = 2

@export var jump_speed: float = 1

var _start_position: Vector2
var _tile_center: Vector2
var _t: float

@onready var jump_sfx := $"../../SFX/JumpSFX" as AudioStreamPlayer2D


func enter(_msg := {}) -> void:
	_t = 0
	_start_position = owner.position
	_tile_center = owner.get_world_coords()
	jump_sfx.play()
	owner.animation_player.play("jump", -1, jump_speed)


func update(delta: float) -> void:
	_t += delta * animation_speed_coefficient * jump_speed
	owner.position = _start_position.lerp(_tile_center, _t)
	if _t >= 1:
		transitioned.emit("IdleState")
		return

