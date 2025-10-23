extends State
class_name player_kick_idle
@onready var animation_player: AnimationTree =$"../../AnimationTree"
var time:float = 1.5
func enter():
	animation_player.set("parameters/idle_attack/blend_amount",1)

func Physics_Update(delta):
	time+=-2*delta
	time = clamp(time,0,1)
	animation_player.set("parameters/idle_attack/blend_amount",time)
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "punch")
	if time ==0.0:
		Transitioned.emit(self, "movement")

func exit():
	time = 1.5
	print("end")
