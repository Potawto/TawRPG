class_name Location
extends Node

@export var size: int = 16
@export var main_terrain_type: int = 0
@export var border_terrain_type: int = 1
@export var terrains_to_include: Array

var _cells_main := []
var _cells_border := []

@onready var tile_map := $TileMap as TileMap
@onready var player := $Player as CharacterBody2D

# This is not needed atm
# _init with parameters can be used with new()
# _init without parameters (or default) is automatically used with instance
# leaving in for learning
#func _init(terrains: Array[int] = []) -> void:
	#if terrains and terrains.size() > 0:
		#terrains_to_include = terrains
	#else:
		#terrains_to_include = [main_terrain_type]
	#pass

func _ready() -> void:
	_cells_main.resize(size * size)
	_cells_border.resize(4 * (size + 1))
	var k = 0 #number of main cells
	var l = 0 #number of border cells
	for i in range(-1, size+1):
		for j in range(-1, size+1):
			var cell = Vector2i(i, j)
			if i == -1 or i == size or j == -1 or j == size:
				_cells_border[l] = cell
				l += 1
			else:
				_cells_main[k] = cell
				k += 1
				
	tile_map.set_cells_terrain_connect(0, _cells_main, 0, main_terrain_type, false)
	tile_map.set_cells_terrain_connect(0, _cells_border, 0, border_terrain_type, false)
	
	for i in range(_cells_main.size()):
		var r = randi() % terrains_to_include.size()
		tile_map.set_cells_terrain_connect(1, [_cells_main[i]], 0, terrains_to_include[r], false)
	
	var tilesize = tile_map.tile_set.tile_size
	
	player.position.x = (size * tilesize.x) / 2 
	player.position.y = (size * tilesize.y) / 2
