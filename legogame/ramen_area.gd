extends Area3D
var player
@onready var state_machine = $"../../CharacterBody3D/State machine"
#@onready var player_camera = $"../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
signal Transitionned
signal Done_state_
signal STOP
signal Enter
@onready var camera = $"../../Camera3D_RAMEN_BUY"
@onready var bodega_menu_player = $AnimationPlayer
@onready var player_camera = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
var flip_flop:int = 1
var flip_avaliable = true
var first_position
var first_rotation
var player_inside = false
func _ready() -> void:
	first_position = camera.position
	first_rotation = camera.rotation

func interact():
	print("interact")
	if player_inside:
		print("interact2")
		if flip_avaliable:
			print("interact3")
			if flip_flop ==-1:
				print("back")
				$"../../CharacterBody3D/Control".show()
				var tween_camera = create_tween().set_trans(Tween.TRANS_CUBIC)
				var new_camera_position = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_position 
				var new_camera_rotation = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_rotation 
				var initial_camera_position = camera.global_position
				var initial_camera_rotation = camera.global_rotation
				camera.global_position = initial_camera_position
				camera.global_rotation = initial_camera_rotation
				camera.current = true
				tween_camera.tween_property(camera, "position", new_camera_position, 2.0)
				tween_camera.parallel().tween_callback(animation_menu_back)
				tween_camera.parallel().tween_property(camera, "rotation", new_camera_rotation, 2.0)
				tween_camera.chain().tween_callback(player_camera_go)
			if flip_flop == 1:
				print("flow")
				#emit_signal("Done_state_","CREATE")
				if not DisplayServer.is_touchscreen_available():
					$"../../CharacterBody3D/Control".hide()
				emit_signal("Transitionned", state_machine.states.get("movement"),"bodega")
				var tween_camera = create_tween().set_trans(Tween.TRANS_CUBIC)
				var new_camera_position = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_position 
				var new_camera_rotation = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_rotation 
				var initial_camera_position = first_position
				var initial_camera_rotation = first_rotation
				camera.global_position = new_camera_position
				camera.global_rotation = new_camera_rotation
				camera.current = true
				tween_camera.tween_property(camera, "position", initial_camera_position, 2.0)
				tween_camera.parallel().tween_property(camera, "rotation", initial_camera_rotation, 2.0)
				tween_camera.chain().tween_callback(animation_menu_play)
			flip_flop=flip_flop*-1
			flip_avaliable = false
			$Timer.start()


func animation_menu_play():
	bodega_menu_player.play("FLIP_BODEGA")
	
func animation_menu_back():
	$"../../Node3D21/Node3D20".hide()
	bodega_menu_player.play_backwards("FLIP_BODEGA")

func player_camera_go():
	player_camera.current = true
	emit_signal("Transitionned", state_machine.states.get("bodega"),"movement")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		print("got")
		emit_signal("Enter",1)
		player_inside = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		emit_signal("Enter",0)
		player_inside = false

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	emit_signal("STOP")


func _on_timer_timeout() -> void:
	print("avaliabl;e")
	flip_avaliable = true
