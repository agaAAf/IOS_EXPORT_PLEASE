extends Area3D
signal Enter
@onready var event_handler = $"../../event_handler"
@onready var ui_handler = $"../../CharacterBody3D/Control"
@onready var wending = $"../../soda/WENDING"
var active = false
signal Done_state_
var once = true
var not_done = true
func interact():
	if active:
		$hadn/AnimationPlayer.play("Armature_001|run_001")
		active = false 
		emit_signal("Done_state_","SODA")
	elif not active and wending.active: 
		if once:
			ui_handler.shortmessge_id = 3
			ui_handler.short_message()
			once = false
