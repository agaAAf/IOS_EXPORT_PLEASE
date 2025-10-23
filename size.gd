extends NinePatchRect
signal MOVE_signal
signal STOP_signal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		i.connect("button_down", move.bind(i.name))
		i.connect("button_up", stop)

func move(name):
	if name == "UP":
		emit_signal("MOVE_signal", Vector2(1.05,1.05))
	if name == "DOWN":
		emit_signal("MOVE_signal", Vector2(0.95,0.95))

func stop():
	emit_signal("STOP_signal")
