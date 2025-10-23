extends Area3D
signal Enter
var active: bool = false
var ONGOING: bool = false

func interact():
	if active:
		$"../CharacterBody3D/State machine/movement".change_mop(true)
		emit_signal("Enter",0)
		$"../trash_points".spawn()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active and not ONGOING:
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active and not ONGOING:
		emit_signal("Enter",0)
