extends MeshInstance3D
var speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = Global.speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z-=delta*Global.speed
	if position.z<-10:
		self.queue_free()
