class_name StateMachine
extends Node

@export var initial_state: State

@onready var state: State = initial_state

var states = {}


func _init() -> void:
	add_to_group("state_machine")

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine (", name, ") " \
					+ "has non-State child (", child.name, ")")
	
	state.enter()


func _process(delta) -> void:
	state.update(delta)


func _physics_process(delta) -> void:
	state.physics_update(delta)


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func on_child_transitioned(new_state_name: StringName, msg: Dictionary = {}) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != state:
			state.exit()
			new_state.enter(msg)
			state = new_state
	else:
		push_warning("Tried to transition to a nonexistent state.",
				" From: ", state," To: ", new_state)

