extends Area3D
func interact():
	$"../../CharacterBody3D/State machine".current_state.change_boxes(false)
