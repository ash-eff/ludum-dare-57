class_name StateMachine
extends Node2D

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	states = {
		"Space" : $SpaceState,
		"UI" : $UIState,
		"Dead" : $DeadState,
	}
	
	for state in states.values():
		state.ship = get_parent()
	change_state("Space")
	
func change_state(new_state_name: String) -> void:
	if not states.has(new_state_name):
		print("Warning: Tried to change to an unknown state:", new_state_name)
		return 
	if current_state:
		current_state.exit()
	
	current_state = states[new_state_name]
	current_state.enter()
