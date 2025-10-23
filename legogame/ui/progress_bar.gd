extends Control
signal punish
var tween: Tween
var NAME:String

# Called when the node enters the scene tree for the first time.
func start(time_to_finish):
	tween= create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($ProgressBar, "value",100, time_to_finish)
	tween.tween_callback(finish)

func finish():
	emit_signal("punish")

func success():
	tween.kill()
	queue_free()
