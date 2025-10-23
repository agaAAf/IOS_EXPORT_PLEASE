extends Area3D
var killablee = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$trash.get_children().pick_random().show()
	$AnimationPlayer.play("fall")

func dead():
	if killable:
		$"../../".start_timer()
		$"../".has_trash = false
		call_deferred("queue_free")

func killable():
	killablee = true
