extends State
class_name player_movement_mop
var friction = 20
var friction_start = 400
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."
@onready var bar = $"../../Control/ui_balance/balance_bar"
@onready var bar_parent = $"../../Control/ui_balance"
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
var go:Vector2 = Vector2.ZERO
var sides= 0
var input_sides = 0
func enter():
	bar_parent.show()
	animation_player.set("parameters/Balance_blend/blend_amount",1)
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D/Node3D".show()
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time =2
	timer.start()
	timer.connect("timeout", add)
	time = animation_player.get("parameters/idle_attack/blend_amount")
	animation_player.set("parameters/RUNWALK/blend_position",Vector2(remap(player.velocity.x,0,SPEED,0,1),remap(player.velocity.z,0,SPEED,0,1)))
	animation_player.set("parameters/BlendSpace2D/blend_position",Vector2(0,remap(player.velocity.x,0,SPEED,0,1)))
func Physics_Update(delta):
	input_sides =0 
	if Input.is_action_pressed("boxcarry_axisQ"):
		input_sides =-0.007
	if Input.is_action_pressed("boxcarry_axisR"):
		input_sides =0.007
	go += Vector2(input_sides+0.005*sides,0)
	animation_player.set("parameters/BlendSpace2D/blend_position",go)
	go.x = clamp(go.x,-1,1)
	bar.rotation = 22
	bar.rotation = remap(go.x,-1,1,-1,1)
	bar_parent.modulate = Color.WHITE-(Color.GREEN+Color.BLUE)*abs(go.x)+Color(0,0,0,10)
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
	if Input.is_action_just_pressed("interact"):
		for i in $"../../persik/collision".get_overlapping_areas():
			if i.is_in_group("interactable"):
				i.interact()

func exit():
	emit_signal("Done_state_",[self.name])
	bar_parent.hide()
	animation_player.set("parameters/Balance_blend/blend_amount",0)
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D/Node3D".hide()

func add():
	var arra = [-1,1,0]
	sides = arra.pick_random()
	
func change_boxes(start):
		if not start:
			Transitioned.emit(self, "movement")
