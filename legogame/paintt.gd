extends Area3D
signal Enter
var active = false
@onready var state_machine = $"../../CharacterBody3D/State machine"
# Called when the node enters the scene tree for the first time.

signal Transitionned

func interact() -> void:
	if active:
		emit_signal("Transitionned", state_machine.states.get("movement"),"paint")
		$"../".go()
		active = false
		emit_signal("Enter",0)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		print("got")
		emit_signal("Enter",0)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		print("got")
		emit_signal("Enter",1)
