extends Area3D
signal Enter
@onready var event_handler = $"../../event_handler"
@onready var ui_handler = $"../../CharacterBody3D/Control"
@onready var wending = $"../../soda/WENDING"
var active = false
signal Done_state_
var once = true
var not_done = true
var active_ramen = false

func interact():
	if active:
		$hadn/AnimationPlayer.play("Armature_001|run_001")
		active = false 
		emit_signal("Done_state_","SODA")
	if active_ramen:
		$hadn/AnimationPlayer.play("Armature_001|run_001")
		active_ramen = false 
		emit_signal("Done_state_","RAMEN")
	emit_signal("Enter",0)
func _on_body_entered(body: Node3D) -> void:
	print(str(active_ramen)+" RAMEN")
	if body.is_in_group("player") and (active or active_ramen):
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and (active or active_ramen):
		emit_signal("Enter",0)
