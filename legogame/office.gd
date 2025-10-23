extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer3.play("ss/KOLONKI")
	$AnimationPlayer2.stop(1)
	$AnimationPlayer2.play_backwards("ss/1to2")
