extends State
class_name player_kick
@onready var animation_player: AnimationTree = $"../../AnimationTree"
@onready var player = $"../.."
var animation_end:bool = true
var animation_end_end:bool = false
func enter():
	animation_player.set("parameters/OneShot_KICK/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	animation_end = false

func Physics_Update(delta):
	if Input.is_action_just_pressed("attack") and animation_end:
		animation_player.set("parameters/TimeSeek/seek_request",0.2)
		animation_player.set("parameters/OneShot_KICK/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
		Transitioned.emit(self, "punch")
		animation_end = false

func exit():
	animation_end = true

func can_go():
	animation_end = true
	for i in $"../../persik/collision".get_overlapping_areas():
		if i.is_in_group("Killable"):
			i.kick()
func idle():
	Transitioned.emit(self, "kick_idle")
