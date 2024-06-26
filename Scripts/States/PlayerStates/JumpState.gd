extends State

# with animation length 0.5s, this should be 2
const animation_speed_coefficient = 2

@export var jump_speed: float = 1

#var _start_position: Vector2
#var _tile_center: Vector2
#var _t: float

@onready var jump_sfx := $"../../SFX/JumpSFX" as AudioStreamPlayer2D


func enter(_msg := {}) -> void:
	#_t = 0
	#_start_position = owner.position
	#_tile_center = owner.get_world_coords()
	jump_sfx.play()
	owner.animation_player.play("jump", -1, jump_speed)
	
	#if not get_tree().current_scene:
		#return
	#
	## TODO unbad
	#if get_tree().current_scene.name == "Map":
		#Global.goto_scene("Scenes/location.tscn")
	#elif get_tree().current_scene.name == "Location":
		#Global.goto_scene("Scenes/map.tscn")


func update(_delta: float) -> void:
	#_t += delta * animation_speed_coefficient * jump_speed
	#owner.position = _start_position.lerp(_tile_center, _t)
	#if _t >= 1:
		#transitioned.emit("IdleState")
		#return
	if not owner.animation_player.is_playing() :
		transitioned.emit("IdleState")
		return

