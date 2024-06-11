extends GPUParticles2D

@export var colors: Dictionary

var _last_terrain: int = -1

@onready var player := owner as Player


func _process(_delta: float) -> void:
	var terrain = player.current_terrain
	if terrain != _last_terrain:
		if colors.has(terrain):
			self_modulate = colors[terrain]
			
		_last_terrain = terrain
