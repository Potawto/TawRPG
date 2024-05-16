class_name Player
extends CharacterBody2D

signal speed_changed(old_value: float, new_value: float)

const TERRAIN_TYPE_NAMES: Array[StringName] = [
	&"grass",
	&"water",
	&"path", 
	&"deep water",
	&"shallow water",
	&"cliff near",
	&"cliff far",
	&"mountain grey",
	&"mountain brown",
	&"forest",
]

@export var default_speed: float = 64.0
@export var sprint_speed: float = 128.0

var current_terrain: int
var speed := default_speed :
	set(new_value):
		if new_value != speed:
			var old_value = speed
			speed = new_value
			speed_changed.emit(old_value, new_value)

var _last_warning: String;

@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var sprite := $Sprite2D as Sprite2D
@onready var tilemap := %TileMap as TileMap
@onready var tile_outline := $TileOutline as Sprite2D


func _process(_delta: float) -> void:
	tile_outline.position = get_world_coords()


func _physics_process(_delta: float) -> void:
	pass

func get_terrain_of_tile() -> int:
	var coords := get_coords()
	
	var terrains_here: Array = []
	
	for i in range(tilemap.get_layers_count()):
		var data = tilemap.get_cell_tile_data(i, coords)
		if data:
			var t = data.terrain
			if t != -1:
				terrains_here.append(t)
	
	if terrains_here.is_empty():
		push_warning("No terrain here: ", coords)
		return -1
	elif terrains_here.size() == 1:
		return terrains_here[0]
	else:
		var warning = "Multiple terrains here: %s %s" % [coords, terrains_here]
		if warning != _last_warning:
			push_warning(warning)
			_last_warning = warning
		return terrains_here[-1]


func get_coords() -> Vector2i:
	return tilemap.local_to_map(tilemap.to_local(position))

func get_world_coords() -> Vector2:
	var map_coords = get_coords()
	var local_coords = tilemap.map_to_local(map_coords)
	var world_coords = tilemap.to_global(local_coords)
	return world_coords


func enter_tile() -> void:
	pass
