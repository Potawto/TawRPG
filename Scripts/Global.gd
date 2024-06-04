extends Node

@export var debug_elements_start_visible = true
@export var save_path_format: String
@export var location_scene: PackedScene


var current_scene = null
var player: Player
var debug_elements: Array[CanvasItem] = []

var saved_player_position: Vector2

## {Vector2i tilemap coords: location resource}
var locations: Dictionary = {}

@onready var tree := get_tree()


func _input(event):
	if event.is_action_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("enter_location"):
		if not get_tree().current_scene:
			return
		# TODO unbad
		#if get_tree().current_scene.name == "Map":
		#	Global.goto_scene("Scenes/location.tscn")
		elif get_tree().current_scene.name == "Location":
			Global.goto_scene("Scenes/map.tscn")


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	#ResourceLoader.load_threaded_request("Scenes/map.tscn")
	#ResourceLoader.load_threaded_request("Scenes/overworld.tscn")
	#ResourceLoader.load_threaded_request("Scenes/location.tscn")


func goto_location(coords: Vector2i, terrains: Array) -> void:
	var location
	if not locations.has(coords):
		location = location_scene.instantiate()
		location.terrains_to_include = terrains
		print(terrains)
		locations[coords] = location
	else:
		location = locations[coords]
	call_deferred("_deferred_goto_location", location)

func _deferred_goto_location(location) -> void:
	current_scene.free()
	current_scene = location
	player = null
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func goto_scene(scene) -> void:
	save()
	#print("Leaving " + str(current_scene))
	call_deferred("_deferred_goto_scene", scene)


func save() -> void:
	# Save player data
	if is_instance_valid(player):
		saved_player_position = player.position


func _deferred_goto_scene(scene):
	current_scene.free()
	var s = ResourceLoader.load(scene)
	current_scene = s.instantiate()
	player = null
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func save_to_solofile() -> void:
	var save_data = {
		"saved_player_position_x": saved_player_position.x,
		"saved_player_position_y": saved_player_position.y,
	}
	var json = JSON.stringify(save_data)
	var save_file_path = save_path_format.format({"slot":"", "note":""})
	var save_file = FileAccess.open(save_file_path, FileAccess.WRITE)
	save_file.store_string(json)


func save_to_file(slot: int, note: String) -> void:
	var save_data = {
		"saved_player_position": saved_player_position,
	}
	var json = JSON.stringify(save_data)
	var save_file_path = save_path_format.format({"slot":slot, "note":note})
	var save_file = FileAccess.open(save_file_path, FileAccess.WRITE)
	save_file.store_string(json)


func load_from_solofile() -> void:
	var save_file_path = save_path_format.format({"slot":"", "note":""})
	if not FileAccess.file_exists(save_file_path):
		return
	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	var data_as_text = save_file.get_as_text()
	var json = JSON.new()
	var error = json.parse(data_as_text)
	
	if error != OK:
		push_warning("Load failed at JSON parse: %s\n \tin\n%s\n\tat line %s" %
				 [json.get_error_message(), data_as_text, json.get_error_line()])
		return
	if not (json.data is Dictionary):
		push_warning("Data not Dictionary: " + json.data)
		return
		
	saved_player_position = Vector2(json.data["saved_player_position_x"],
			json.data["saved_player_position_y"])
