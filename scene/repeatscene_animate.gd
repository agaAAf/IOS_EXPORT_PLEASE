extends Node3D
var speed = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = Global.speed
	$prep/PREPATSTVIE_move/AnimationPlayer.play("go")
func _physics_process(delta: float) -> void:
	position.z-=delta*speed
	if position.z<-10:
		self.queue_free()
