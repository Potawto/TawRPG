extends Node

@export var size := 16

var _cells := []

@onready var tile_map := $TileMap as TileMap
@onready var player := $Player as CharacterBody2D

func _ready() -> void:
	_cells.resize(size * size)
	var k = 0
	for i in range(size):
		for j in range(size):
			#tile_map.set_cell(0, Vector2i(i, j), 0, Vector2i(0, 0), 0)
			_cells[k] = Vector2i(i, j)
			k += 1
	tile_map.set_cells_terrain_connect(0, _cells, 0, 0, false)
	
	var tilemap := $TileMap as TileMap
	var tilesize = tilemap.tile_set.tile_size
	
	player.position.x = (size * tilesize.x) / 2 
	player.position.y = (size * tilesize.y) / 2
