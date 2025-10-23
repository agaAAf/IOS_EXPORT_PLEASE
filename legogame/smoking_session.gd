extends State
class_name  smoking_session
var time: float = 0
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."

# Called when the node enters the scene tree for the first time.
func enter():
	player.velocity = Vector3.ZERO
	animation_player.set("parameters/smoke/blend_amount",1)
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D3/blunt".show()
	animation_player.set("parameters/smoke_player/seek_request",0)

func exitt():
	emit_signal("Done_state_",[self.name])
	animation_player.set("parameters/smoke/blend_amount",0)
	Transitioned.emit(self, "movement")
