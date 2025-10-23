extends State
class_name paint
@onready var animation_player: AnimationTree =$"../../AnimationTree"
var time:float = 1.5
@onready var player = $"../.."

func enter():
	player.velocity = Vector3.ZERO
	animation_player.set("parameters/paint_blend/blend_amount",1)
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D3/blunt".show()
	animation_player.set("parameters/paint_player/seek_request",0)

func exit():
	emit_signal("Done_state_",[self.name])
