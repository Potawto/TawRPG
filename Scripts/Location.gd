extends Node

@export var size: int = 16
@export var main_terrain_type: int = 0
@export var border_terrain_type: int = 1

var _cells_main := []
var _cells_border := []

@onready var tile_map := $TileMap as TileMap
@onready var player := $Player as CharacterBody2D

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
	
	
	var tilemap := $TileMap as TileMap
	var tilesize = tilemap.tile_set.tile_size
	
	player.position.x = (size * tilesize.x) / 2 
	player.position.y = (size * tilesize.y) / 2
