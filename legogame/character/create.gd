extends State
class_name player_create
@onready var animation_player: AnimationTree =$"../../AnimationTree"
@onready var player = $"../.."
var time:float = 1.5
func enter():
	$"../../CameraPivot/SpringArm3D/Camera3D".create =true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	animation_player.set("parameters/idle_attack/blend_amount",0)
	player.velocity = Vector3.ZERO

func exit():
	$"../../CameraPivot/SpringArm3D/Camera3D".create =false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	time = 1.5
	print("end")
