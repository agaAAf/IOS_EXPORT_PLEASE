extends Node3D

func _ready() -> void:
	$Timer.connect("timeout", spawn)
	$"../CharacterBody3D/State machine/movement_mop".connect("Done_state_", done)
func start_timer():
	$Timer.start()
	print("GPGPGPGPG")

func spawn():
	var arr:Array
	for i in get_children():
		if i.get_class() =="Node3D":
			if i.has_trash:
				pass
			else:
				arr.append(i)
	var inst = arr.pick_random()
	if is_instance_valid(inst):
		inst.spawn()

func done():
	$Timer.stop()
	for i in get_children():
		if i.get_class() =="Node3D":
			if i.has_trash:
				i.get_children()[0].queue_free()
