extends Node3D
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	if randf_range(1,100)>50:
		animation.play("train_go1")
	else:
		animation.play("train_go_2")
