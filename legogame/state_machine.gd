extends Node


@export var initial_state: State
var current_state:State
var states: Dictionary= {}

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("state_changer"):
		i.Transitionned.connect(on_child_transition)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			print(child)
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state= initial_state


func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state!= current_state:
		return
	var new_state= states.get(new_state_name.to_lower())
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
