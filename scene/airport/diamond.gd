extends Node3D
signal Collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("updown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		emit_signal("Collected")
		self.queue_free()
