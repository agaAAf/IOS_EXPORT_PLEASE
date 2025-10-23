extends Area3D

@onready var event_handler = $"../../event_handler"
@onready var ui_handler = $"../../CharacterBody3D/Control"
@onready var state_machine = $"../../CharacterBody3D/State machine"
@onready var camera = $"../../Camera3D2"
@onready var bodega_menu_player = $"../../Node3D21/AnimationPlayer"
@onready var player_camera = $"../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
var active = true
signal Transitionned
signal Done_state_
var once = true
var not_done = true
var movement= State.get
signal Enter
var first_rotation
var first_position

func start():
	$"..".show()
	first_position = camera.position
	first_rotation = camera.rotation
	$"../../taxi_player".play("Start")

func interact():
	if active:
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
			emit_signal("Enter",0)
			active = false 
			emit_signal("Transitionned", state_machine.states.get("movement"),"taxi")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		print("got")
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",0)
