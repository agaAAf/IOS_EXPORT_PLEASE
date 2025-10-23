extends Area3D
@onready var player = $"../CharacterBody3D"
var active = false 
signal Enter

func interact():
	if active:
		$"../CharacterBody3D/State machine".current_state.change_boxes(true)
		Input.action_press("camera_around")
		active = false
		$"../event_handler".uslovia.BOX = true
		$"../event_handler".BOX()
		emit_signal("Enter",0)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",0)
