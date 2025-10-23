extends Area3D
signal Enter
@onready var event_handler = $"../event_handler"
@onready var ui_handler = $"../CharacterBody3D/Control"
@onready var boxes = $"../BOXES"
@onready var state_machine = $"../CharacterBody3D/State machine"
var active = false
signal Transitionned
signal Done_state_
var once = true
var not_done = true
var movement_bookcarry = State.get
func interact():
	if active:
		print("interact")
		if not event_handler.uslovia.BOX:
			if once:
				ui_handler.shortmessge_id = 0
				ui_handler.short_message()
				once = false
		else:
			emit_signal("Enter",0)
			active = false 
			emit_signal("Done_state_","BOX")
			emit_signal("Transitionned", state_machine.states.get("movement_bookcarry"),"movement")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		print("got")
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",0)
