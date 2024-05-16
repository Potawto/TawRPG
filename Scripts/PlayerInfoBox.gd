class_name PlayerInfoBox
extends InfoBox

@onready var player: Player = Global.player


func _process(delta: float) -> void:
	super(delta)
	if not player:
		player = Global.player
	if is_instance_valid(player):
		var map_coords = player.get_coords()
		var terrain_id = player.get_terrain_of_tile()
		var terrain_name = player.TERRAIN_TYPE_NAMES[terrain_id]
		var terrain_info = "%s (id: %s)" % [terrain_name, terrain_id] as String
		set_line(0, map_coords)
		set_line(1, terrain_info)
	else:
		set_line(0, "Saved: %s" % Global.saved_player_position)
		set_line(1, "No terrain on this screen actually")
