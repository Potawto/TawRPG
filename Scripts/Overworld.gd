extends Node

@onready var player = $Player as CharacterBody2D


func _ready() -> void:
	Global.player = self.player
	if Global.saved_player_position:
		player.position = Global.saved_player_position


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	pass

