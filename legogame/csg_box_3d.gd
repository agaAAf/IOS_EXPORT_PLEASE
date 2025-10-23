extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".connect("visibility_changed", change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = $"../BoneAttachment3D2/mop/Node3D".global_position*Vector3(1,0,1)+Vector3(0,2.721,0)
	global_rotation= $"../BoneAttachment3D2/mop/Node3D".global_rotation*Vector3(0,1,0)

func change():
	if self.visible:
		$SmokeParticle2.emitting = true
	else:
		$SmokeParticle2.emitting = false
