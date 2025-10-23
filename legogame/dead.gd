extends State
class_name dead
@onready var animation_player: AnimationTree =$"../../AnimationTree"
var time:float = 1.5
@onready var player = $"../.."
var deadd = 0.0
var SPEED = 5.0
var vector = Vector2.ZERO
const GRAVITY: float = 24.0  # Gravity strength
const LANES: Array = [1.5, 0, -1.5]  # Lane positions on x-axis
const MOVE_SPEED: float = 8.0

signal DEAD
func enter():
	print("DEEAD")
	Global.dead = true
	player.velocity = Vector3.ZERO
	animation_player.set("parameters/Blend_hitordeath/blend_amount",0)
	animation_player.set("parameters/Blend_dead/blend_amount",1)
	animation_player.set("parameters/Blendspace_hit/blend_position",vector)
	animation_player.set("parameters/Blend_dead/blend_amount",1)
	animation_player.set("parameters/Dead_play/seek_request",0)
	$Dead_timer.start()
	

func Physics_Update(delta):
	if $"../runner_infinite".sidehit_death:
		var target_x: float = LANES[$"../runner_infinite".previous_lane]
		var current_x: float = player.global_transform.origin.x
		player.global_transform.origin.x = lerp(current_x, target_x, MOVE_SPEED * delta)


func _on_dead_timer_timeout() -> void:
	emit_signal("DEAD")

func collisions_ready():
	Transitioned.emit(self, "runner_infinite")
