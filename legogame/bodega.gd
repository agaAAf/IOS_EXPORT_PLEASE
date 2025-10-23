extends State
class_name bodega_check
@onready var animation_player: AnimationTree =$"../../AnimationTree"
@onready var player = $"../.."
@onready var GoTo = $"../../../position_bodega"
@onready var look_at = $"../../../look_at_camera_bodega"
var t:float = 0 
var time:float = 1.5
var rotate = false
var angle = 0
var target_angle
var rotation_speed = 2

func Update(_delta:float):
	$"../../CameraPivot/SpringArm3D".rotation.y = lerp_angle($"../../CameraPivot/SpringArm3D".rotation.y, angle+deg_to_rad(90), rotation_speed * _delta)
	#$"../../CameraPivot".rotate(Vector3.UP, -angle)
	#if not rotate:
		#if t==1:
			#walk()
			#rotate = true 
		#else:
			#t += _delta*2
			#$"../../CameraPivot/SpringArm3D/Camera3D"._camera_pivot.rotation.y.lerp(player.global_position.direction_to(GoTo.global_position), t)
	#if rotate: 
		#if t==1:
			#walk()
			#rotate = true 
		#else:
			#t += _delta*2
			#player.velocity.lerp(0,player.global_position.direction_to(GoTo.global_position), t) 
			#animation_player.set("parameters/RUNWALK/blend_position",player.velocity)
	if Input.is_action_just_pressed("interact"):
		for i in $"../../persik/collision".get_overlapping_areas():
			if i.is_in_group("interactable"):
				i.interact()

func enter():
	t = 0 
	player.velocity = Vector3.ZERO
	animation_player.set("parameters/RUNWALK/blend_position",player.velocity)
	$"../../AnimationTree".set("parameters/Blend2/blend_amount",0)
	$"../../CameraPivot/SpringArm3D/Camera3D".create =true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	animation_player.set("parameters/idle_attack/blend_amount",0)
	#player.global_position = GoTo.global_position
	angle = player.basis.y.angle_to($"../../CameraPivot/SpringArm3D".global_position.direction_to(look_at.global_position))
	print(angle)
	#$"../../CameraPivot".rotation = $"../../CameraPivot".rotation*Vector3(0,1,0)

func exit():
	$"../../CameraPivot/SpringArm3D/Camera3D".create =false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	time = 1.5
