extends Camera2D


func _ready() -> void:
	var tilemap := $"../TileMap" as TileMap
	var tilesize = tilemap.tile_set.tile_size
	
	position.x = (get_parent().size * tilesize.x) / 2 
	position.y = (get_parent().size * tilesize.y) / 2
