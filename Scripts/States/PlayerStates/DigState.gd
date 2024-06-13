extends State

@export var dig_speed: float = 1
@export var finish_position: float = 0.7
var _planted = false

@onready var dig_sfx := $"../../SFX/JumpSFX" as AudioStreamPlayer2D


func enter(_msg := {}) -> void:
	dig_sfx.play()
	_planted = false
	owner.animation_player.play("attack_right", -1, dig_speed)

func update(_delta: float) -> void:
	if owner.animation_player.current_animation_position >= finish_position and not _planted:
		_planted = true
		owner.dig_here(what_to_plant)
	
	if not owner.animation_player.is_playing():
		transitioned.emit("IdleState")

