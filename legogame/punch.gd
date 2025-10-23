extends State
class_name player_punch
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."
var SPEED = 10
var acceleration = 10
var animation_end:bool = true
func enter():
	animation_player.set("parameters/idle_attack/blend_amount",1)
	animation_player.set("parameters/TimeSeek/seek_request",0)
	animation_player.set("parameters/OneShot_PUNCH/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	animation_end = false
	print("kicking")
	$"../../CameraPivot/SpringArm3D/Camera3D".camera_around = 1

func Physics_Update(delta):
	player.velocity =player.velocity.move_toward(Vector3(0,0,0),acceleration*delta)
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") and animation_end:
		animation_player.set("parameters/OneShot_PUNCH/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
		Transitioned.emit(self, "movement")
		print("transition+movement")
	if Input.is_action_just_pressed("attack") and animation_end:
		var random = randf_range(1,100)
		if random>50.0:
			animation_player.set("parameters/OneShot_PUNCH/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
			Transitioned.emit(self, "kick")
			animation_end = false
		#else:
			#animation_player.set("parameters/TimeSeek/seek_request",0.1)
			#animation_player.set("parameters/OneShot_PUNCH/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			#animation_end = false

func exit():
	animation_end = true

func can_go():
	animation_end = true
	if  $"../../persik/collision".get_overlapping_areas():
		for i in $"../../persik/collision".get_overlapping_areas():
			if i.is_in_group("Killable"):
				i.kick()

func idle():
	Transitioned.emit(self, "kick_idle")
