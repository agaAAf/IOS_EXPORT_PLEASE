extends State
class_name taxi
@onready var animation_player: AnimationTree =$"../../AnimationTree"
var time:float = 1.5
@onready var player = $"../../"
@onready var look_at = $"../../../cartaxi_newrig4/target"
@onready var area_get = $"../../../cartaxi_newrig4/target/Area3D"
@onready var anim_taxi = $"../../../cartaxi_newrig4/AnimationPlayer"
@onready var anim_taxi1 = $"../../../taxi_player"
var angle 
var rotation_speed = 2
var input_dir
var acceleration = 10
var smooth:Vector2
var active = false
var stop = true
const SPEED = 2
var acceleration1 = 10
var param_left_right = 0
var rotating = false
var transition = 0
			#if _camera_input_direction.x>0:
				#transition +=delta*acceleration2 
				#param_left_right+=delta*acceleration1
				#param_left_right= clamp(param_left_right,-1,1)
				#animation_player.set("parameters/INPLACE/blend_position", param_left_right)
			#if _camera_input_direction.x<0:
				#transition +=delta*acceleration2 
				#param_left_right-=delta*acceleration1
				#param_left_right= clamp(param_left_right,-1,1)
				#animation_player.set("parameters/INPLACE/blend_position", param_left_right)


func enter():
	rotating = true
	player.rotation 
	player.velocity = Vector3.ZERO
	angle = player.basis.y.angle_to(player.global_position.direction_to(look_at.global_position))
	print(angle)
	active = true
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(player, "rotation", Vector3(player.rotation.x, angle, player.rotation.z), 1)
	tween.tween_callback(TRUE_ROTATE)
func Update(_delta:float):
	#$"../../CameraPivot/SpringArm3D".rotation.y = lerp_angle($"../../CameraPivot/SpringArm3D".rotation.y, angle, rotation_speed * _delta)
	#smooth = smooth.move_toward(Vector2(input_dir.x, input_dir.z),acceleration/2*_delta)
	if not stop:
		player.velocity = player.velocity.move_toward(input_dir*Vector3(1,0,1)*SPEED,acceleration*_delta)
	if angle > 0 and rotating:
		transition +=_delta*acceleration1
		param_left_right+=_delta*acceleration1
		param_left_right= clamp(param_left_right,-1,1)
		animation_player.set("parameters/INPLACE/blend_position", param_left_right)
	if angle < 0 and rotating:
		transition +=_delta*acceleration1
		param_left_right-=_delta*acceleration1
		param_left_right= clamp(param_left_right,-1,1)
		animation_player.set("parameters/INPLACE/blend_position", param_left_right)
	if rotating:
		transition = clamp(transition,0,1)
		animation_player.set("parameters/Blend2/blend_amount", transition)
func TRUE_ROTATE():
	rotating = false
	$"../../CameraPivot/SpringArm3D/Camera3D".camera_around = 1
	input_dir = player.global_position.direction_to(look_at.global_position)
	area_get.monitoring = true
	stop = false
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		stop = true
		player.velocity = Vector3.ZERO
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(player, "rotation", Vector3(0, deg_to_rad(180), 0), 1)
		tween.tween_callback(start_anims)


func start_anims():
		anim_taxi.play("open")
		animation_player.set("parameters/taxi_blend/blend_amount",1)
		animation_player.set("parameters/taxi_player/seek_request",0)
		


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name =="opentaxi/Armature_001|Armature|open_taxii|Anima_Layer":
		anim_taxi1.play("go")
