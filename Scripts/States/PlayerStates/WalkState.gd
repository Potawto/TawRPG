extends State

@export_group("SFX")
## The default walking speed the sound effect is roughly tuned to
@export var tuned_speed: int = 64
## When shortening the loop for higher speeds,
## how much to shorten the beginning vs end of the loop
@export_range(0.0, 1.0) var loop_shortening_ratio: float = 0.3
## Minimum loop length
@export_range(0.0, 1.0) var min_loop_percent: float = 0.2

@export_group("VFX")
## The default walking speed number of particles
@export var tuned_particles: int = 20
## particles amount = tuned_particles * speed increase% * this
@export var particles_speed_multiplier: float = 50.0

@onready var player := $"../.." as CharacterBody2D
## VFX
@onready var dust_left_particles := $"../../VFX/LeftDust" as GPUParticles2D
@onready var dust_right_particles := $"../../VFX/RightDust" as GPUParticles2D
## SFX
@onready var walk_sfx_player := $"../../SFX/WalkSFX" as AudioStreamPlayer2D
@onready var walk_sfx_stream := walk_sfx_player.stream as AudioStreamWAV
@onready var loop_begin := walk_sfx_stream.loop_begin as int
@onready var loop_end := walk_sfx_stream.loop_end as int
@onready var loop_length := loop_end - loop_begin

func enter(_msg := {}) -> void:
	dust_left_particles.emitting = true
	dust_right_particles.emitting = true
	walk_sfx_player.play()


func exit() -> void:
	dust_left_particles.emitting = false
	dust_right_particles.emitting = false
	walk_sfx_player.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):
		player.speed = player.sprint_speed
	if event.is_action_released("sprint"):
		player.speed = player.default_speed

func update(_delta:float) -> void:
	pass

func physics_update(_delta: float) -> void:
	owner.velocity.x = Input.get_axis("left", "right")
	owner.velocity.y = Input.get_axis("up", "down")
	owner.velocity = owner.velocity.normalized() * owner.speed
	
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("JumpState")
		return
				
	if owner.velocity == Vector2.ZERO:
		transitioned.emit("IdleState")
		return
		
	if owner.velocity.y > 0:
		owner.animation_player.play("walk_down")
	elif owner.velocity.y < 0:
		owner.animation_player.play("walk_up")
	elif owner.velocity.x > 0:
		owner.sprite.flip_h = false
		owner.animation_player.play("walk_right")
	elif owner.velocity.x < 0:
		owner.sprite.flip_h = true
		owner.animation_player.play("walk_right")
		
	owner.move_and_slide()


func _on_player_speed_changed(_old_value: float, new_value: float) -> void:
	var speed_coefficient: float = new_value / tuned_speed
	var new_length: float = max(
			loop_length / speed_coefficient, 
			min_loop_percent * loop_length
	)
	var truncate_amount: int = floor(loop_length - new_length)
	var truncate_begin_amount: int = floor(truncate_amount * loop_shortening_ratio)
	var truncate_end_amount: int = floor(truncate_amount - truncate_begin_amount)
	
	walk_sfx_stream.loop_begin = truncate_begin_amount
	walk_sfx_stream.loop_end = loop_length - truncate_end_amount
	
	owner.animation_player.speed_scale = speed_coefficient
	
	var speed_increase = new_value / player.default_speed
	#var particles_amount = tuned_particles * speed_increase * particles_speed_multiplier
	dust_left_particles.amount_ratio = speed_increase * particles_speed_multiplier
	dust_right_particles.amount_ratio = speed_increase * particles_speed_multiplier
