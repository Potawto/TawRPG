extends State

@export var dig_speed: float = 1
@export var finish_position: float = 0.7

@onready var dig_sfx := $"../../SFX/JumpSFX" as AudioStreamPlayer2D


func enter(_msg := {}) -> void:
	dig_sfx.play()
	owner.animation_player.play("attack_right", -1, dig_speed)

func update(_delta: float) -> void:
	if owner.animation_player.current_animation_position >= finish_position:
		owner.dig_here()
	
	if not owner.animation_player.is_playing():
		transitioned.emit("IdleState")

