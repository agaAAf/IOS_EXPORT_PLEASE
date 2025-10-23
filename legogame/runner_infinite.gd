extends State
class_name player_infinite
var friction = 20
var friction_start = 400
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."
@onready var beeper = $"../../Node3D/CameraPivot2/beeper"
@onready var anim_beep = $"../../Node3D/CameraPivot2/AnimationPlayer"
const SPEED = 2
var acceleration = 10
var speed_interval = 0
const JUMP_VELOCITY = 7
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
const MOVE_SPEED: float = 8.0
var Lean_amount = 2

var Lean_x:float
var lean_y:float
var jump:float
var jump_variant:float 

const GRAVITY: float = 24.0  # Gravity strength
const LANES: Array = [1.5, 0, -1.5]  # Lane positions on x-axis
const LEAN_RETURN_SPEED = 5

var starting_point: Vector3 = Vector3.ZERO
var current_lane: int = 1  # Start at lane index 1 (x = 0)
var target_lane: int = 1
var previous_lane
var hit_trans = 0.0
var dead_blend = 0.0

var sidehit_death = false

var is_jumping: bool = false
var is_dead: bool = false
func enter():
	target_lane = 1
	player.position.y = 0
	player.position.z=-3.462
	player.global_transform.origin.x=0 
	Global.speed = 0
	Global.dead = true
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D4/graffiti_can".hide()
	$"../../persik/Armature_001/Skeleton3D/BoneAttachment3D5/graffiti_can".hide()
	transition_ = animation_player.get("parameters/paint_blend/blend_amount")
	$"../../CameraPivot/SpringArm3D/Camera3D".camera_around = 1
	time = animation_player.get("parameters/idle_attack/blend_amount")
	animation_player.set("parameters/RUNWALK/blend_position",Vector2(0,-1))
	animation_player.set("parameters/Blend_dead/blend_amount",0)
func start_running():
	Global.speed = 1
	Global.dead = false
func Physics_Update(delta):
	if not Global.dead:
		if player.Raycast.is_colliding() and not player.Raycast.get_collider().is_in_group("Diamond"):
			$"../dead".vector = Vector2(0,1)
			player.Raycast.enabled = false
			death()
		if player.Raycast_left.is_colliding() and not player.Raycast_left.get_collider().is_in_group("Diamond"):
			if sidehit_death:
				$"../dead".vector = Vector2(-1,0)
				player.Raycast.enabled = false
				death()
			if not sidehit_death:
				dead_blend = 1.0
				hit_trans = 1.0
				animation_player.set("parameters/Blend_hitordeath/blend_amount",1)
				animation_player.set("parameters/Blend_dead/blend_amount",1)
				animation_player.set("parameters/Blendspace_firsthit/blend_position",hit_trans)
				animation_player.set("parameters/Dead_play/seek_request",0)
				$hit_side.start()
				target_lane = previous_lane
				sidehit_death = true
		if player.Raycast_right.is_colliding() and not player.Raycast_right.get_collider().is_in_group("Diamond"):
			if sidehit_death:
				$"../dead".vector = Vector2(1,0)
				player.Raycast.enabled = false
				death()
			if not sidehit_death:
				dead_blend = 1.0
				hit_trans = -1.0
				animation_player.set("parameters/Blend_hitordeath/blend_amount",1)
				animation_player.set("parameters/Blend_dead/blend_amount",1)
				animation_player.set("parameters/Blendspace_firsthit/blend_position",hit_trans)
				animation_player.set("parameters/Dead_play/seek_request",0)
				$hit_side.start()
				target_lane = previous_lane
				sidehit_death = true
		var direction: Vector3 = Vector3.ZERO
		# Handle lane switching
		if Input.is_action_just_pressed("ui_left") and target_lane > 0:
			previous_lane = target_lane
			target_lane -= 1
			Lean_x = -Lean_amount
			lean_y = -0.2
		if Input.is_action_just_pressed("ui_right") and target_lane < LANES.size() - 1:
			previous_lane = target_lane
			target_lane += 1
			Lean_x = Lean_amount
			lean_y = -0.2
		# Move towards the target lane
		var target_x: float = LANES[target_lane]
		var current_x: float = player.global_transform.origin.x
		player.global_transform.origin.x = lerp(current_x, target_x, MOVE_SPEED * delta)
		dead_blend = lerp(dead_blend, 0.0, SPEED/2 * delta)
		Lean_x = lerp(Lean_x, 0.0, LEAN_RETURN_SPEED * delta)
		lean_y = lerp(lean_y, -1.0, LEAN_RETURN_SPEED * delta)
		jump = lerp(jump, jump_variant, LEAN_RETURN_SPEED*2 * delta)
		if not player.is_on_floor() and not Global.dead:
			player.velocity.y -= GRAVITY * delta
		else:
			player.velocity.y = 0  # Reset vertical velocity when on the floor
		# Jumping logic
		if player.is_on_floor():
			animation_player.set("parameters/Blend_jump/blend_amount",0)
			jump_variant = 0
		if player.is_on_floor() and Input.is_action_pressed("ui_up"):
			player.velocity.y = JUMP_VELOCITY  # Apply jump velocity
			animation_player.set("parameters/Blend_jump/blend_amount",1)
			animation_player.set("parameters/Jump_anim_play/seek_request",0)
			jump_variant = 1
		# Apply the velocity and move the character
		# Play animations based on movement
		animation_player.set("parameters/RUNWALK/blend_position",Vector2(Lean_x,lean_y))
		animation_player.set("parameters/Blend_jump/blend_amount",jump)
		if not Global.dead:
			animation_player.set("parameters/Blend_dead/blend_amount",dead_blend)
func death():
	Global.speed = 0
	Transitioned.emit(self, "dead")


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


func _on_hit_side_timeout() -> void:
	sidehit_death = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Transitioned.emit(self, "stop")
