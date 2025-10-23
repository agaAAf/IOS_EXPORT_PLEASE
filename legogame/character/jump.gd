extends State
class_name player_jump
@onready var animation_player: AnimationPlayer = $"../../persik"/AnimationPlayer
@onready var player = $"../.."
const SPEED = 10
const JUMP_VELOCITY = 4.5
var direction: Vector3
var double: bool
func enter():
	animation_player.play("Armature_001|"+"Jump")
	player.velocity.y = JUMP_VELOCITY
	double = true 

func Physics_Update(delta):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	if Input.is_action_just_pressed("jump") and not player.is_on_floor() and double:
		player.velocity.y = JUMP_VELOCITY
		double = false
	if player.is_on_floor():
		Transitioned.emit(self, "Movement")


func exit():
	pass
