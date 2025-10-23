extends State
class_name stop
@onready var animation_player: AnimationTree =$"../../AnimationTree"
var time:float = 1.5
@onready var player = $"../.."
var deadd = 0.0
var SPEED = 5.0
var vector = Vector2.ZERO
const GRAVITY: float = 24.0  # Gravity strength
var starty:Vector2
const MOVE_SPEED: float = 8.0


func enter():
	print("DEEAD")
	Global.dead = true
	player.velocity = Vector3.ZERO
	starty = animation_player.get("parameters/RUNWALK/blend_position")
	animation_player.set("parameters/Blend_dead/blend_amount",0)

func Physics_Update(delta):
		if player.is_on_floor():
			animation_player.set("parameters/Blend_jump/blend_amount",0)
		Global.speed = lerp(Global.speed, 0.0, SPEED * delta)
		starty.y = lerp(starty.y,0.0,SPEED *2* delta)
		starty.x = lerp(starty.x,0.0,SPEED *4* delta)
		animation_player.set("parameters/RUNWALK/blend_position",Vector2(starty.x,starty.y))
		player.velocity += player.get_gravity() * delta
