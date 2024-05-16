extends Node
class_name State
 
signal transitioned(new_state_name: StringName, _msg: Dictionary)


func enter(_msg := {}) -> void:
	pass


func exit() -> void:
	pass


#_unhandled_input(_event: InputEvent) -> void:
func handle_input(_event: InputEvent) -> void:
	pass


#  _process(_delta: float) -> void:
func update(_delta: float) -> void:
	pass
 

#  _physics_process(_delta: float) -> void:
func physics_update(_delta: float) -> void:
	pass

