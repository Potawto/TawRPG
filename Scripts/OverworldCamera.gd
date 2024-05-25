extends Camera2D

@export var _player_check_frequency: float
#@export var _camera_area: Area2D

# Time since last check
var _player_check_timer = 0.0

@onready var _player = $"../Player" as Player

func _process(delta: float) -> void:
	_player_check_timer += delta
	
	if _player_check_timer > _player_check_frequency and is_instance_valid(_player):
		while not _is_player_visible():
			if _player.position.y < position.y - get_viewport_rect().size.y/2:
				position.y -= get_viewport_rect().size.y
		#		print("UP")
			elif _player.position.y > position.y + get_viewport_rect().size.y/2:
				position.y += get_viewport_rect().size.y
		#		print("DOWN")
			if _player.position.x < position.x - get_viewport_rect().size.x/2:
				position.x -= get_viewport_rect().size.x
		#		print("RIGHT")
			elif _player.position.x > position.x + get_viewport_rect().size.x/2:
				position.x += get_viewport_rect().size.x
		#		print("LEFT")
		_player_check_timer = 0


func _is_player_visible() -> bool:
	if _player.position.y > position.y - get_viewport_rect().size.y/2 and \
			_player.position.y < position.y + get_viewport_rect().size.y/2 and \
			_player.position.x > position.x - get_viewport_rect().size.x/2 and \
			 _player.position.x < position.x + get_viewport_rect().size.x/2:
		return true
	return false



func _on_viewport_area_body_exited(body: Node2D) -> void:
	# TODO check if body is player at least
	# TODO all camera movement should probably be modulo math based or something
	if body.position.y < position.y - get_viewport_rect().size.y/2:
		position.y -= get_viewport_rect().size.y
#		print("UP")
	elif body.position.y > position.y + get_viewport_rect().size.y/2:
		position.y += get_viewport_rect().size.y
#		print("DOWN")
	if body.position.x < position.x - get_viewport_rect().size.x/2:
		position.x -= get_viewport_rect().size.x
#		print("RIGHT")
	elif body.position.x > position.x + get_viewport_rect().size.x/2:
		position.x += get_viewport_rect().size.x
#		print("LEFT")

