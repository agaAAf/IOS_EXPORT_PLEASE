extends Node3D


func _process(delta: float) -> void:
	translate(Vector3(0,delta,0))
	##global_position = $"../BoneAttachment3D2/mop/Node3D".global_position*Vector3(1,0,1)
	##global_rotation= $"../BoneAttachment3D2/mop/Node3D".global_rotation*Vector3(0,1,0)
	pass
