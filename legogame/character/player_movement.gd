extends State
class_name player_movement
var friction = 20
var friction_start = 400
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."
@onready var beeper = $"../../Node3D/CameraPivot2/beeper"
@onready var anim_beep = $"../../Node3D/CameraPivot2/AnimationPlayer"
const SPEED = 2
var acceleration = 10
var speed_interval = 0
const JUMP_VELOCITY = 4.5
var direction: Vector3
var direction_proxy
var smooth: Vector2
var rotating:bool = true
var param_left_right:float = 0
var acceleration2 = 1
var transition:float=0
var time:float = 1
var flipflop:bool = true 
signal open_flip_flop
var transition_:float

func enter():
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D4/graffiti_can".hide()
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D5/graffiti_can".hide()
	print("entermovement")
	transition_ = animation_player.get("parameters/paint_blend/blend_amount")
	print("parameters/paint_blend/blend_amount")
	$"../../CameraPivot/SpringArm3D/Camera3D".camera_around = -1
	$"../../CameraPivot/SpringArm3D/Camera3D".create = false
	time = animation_player.get("parameters/idle_attack/blend_amount")
	animation_player.set("parameters/RUNWALK/blend_position",Vector2(remap(player.velocity.x,0,SPEED,0,1),remap(player.velocity.z,0,SPEED,0,1)))

func Physics_Update(delta):
	if transition_ >0: 
		transition_-=0.02
		transition_ = clamp(transition_,0,1)
		animation_player.set("parameters/paint_blend/blend_amount", transition_)
	time = animation_player.get("parameters/idle_attack/blend_amount")
	time+=-10*delta
	time = clamp(time,0,1)
	animation_player.set("parameters/idle_attack/blend_amount",time)
	var camera = Vector2.ZERO
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		#Transitioned.emit(self, "jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	smooth = smooth.move_toward(input_dir,acceleration/2*delta)
	animation_player.set("parameters/RUNWALK/blend_position",smooth)
	direction= ($"../../CameraPivot/SpringArm3D/Camera3D".basicss * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction*Vector3(1,0,1)
	direction_proxy = direction
	$"../../CameraPivot/SpringArm3D/Camera3D".input= false
	if input_dir.length() == 0:
		$"../../CameraPivot/SpringArm3D/Camera3D".input= true
	if direction.length()>0.2:
		direction_proxy = direction
	if not direction_proxy == direction:
		speed_interval =0
	direction_proxy=direction
	player.velocity = player.velocity.move_toward(direction*SPEED,acceleration*delta)
	if Input.is_action_just_pressed("attack") and time == 0:
		animation_player.set("parameters/RUNWALK/blend_position",Vector2.ZERO)
		Transitioned.emit(self, "punch")
	#if Input.is_action_just_pressed("jump"):
		#Transitioned.emit(self, "jump")
	if Input.is_action_just_pressed("interact"):
		for i in $"../../persik/collision".get_overlapping_areas():
			if i.is_in_group("interactable"):
				i.interact()
	#if Input.is_action_just_pressed("box_carry"):
		#animation_player.set("parameters/Balance_blend/blend_amount",1)
		#Transitioned.emit(self, "movement_bookcarry")
	if Input.is_action_just_pressed("change_outfit"):
		$"../..".change()
	if Input.is_action_just_pressed("2way"):
		emit_signal("open_flip_flop", flipflop)
		if flipflop:
			flipflop = false
			anim_beep.play("beeper")
		else:
			anim_beep.play_backwards("beeper")
			flipflop = true


func exit():
	pass
func change_boxes(start):
		if start:
			Transitioned.emit(self, "movement_bookcarry")

func change_mop(start):
		if start:
			Transitioned.emit(self, "movement_mop")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if flipflop == true:
		beeper.hide()
