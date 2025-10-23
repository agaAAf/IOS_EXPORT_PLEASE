extends Area3D

var active = false
@onready var event_handler = $"../event_handler"
@onready var ui_handler = $"../CharacterBody3D/Control"
@onready var boxes = $"../BOXES"
@onready var state_machine = $"../CharacterBody3D/State machine"

@onready var player_camera = $"../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
@onready var camera = $"../Camera3D3"
signal Enter
signal Transitionned
signal Done_state_

func interact():
	if active:
			emit_signal("Enter",0)
			active = false 
			emit_signal("Transitionned", state_machine.states.get("movement"),"smoking_session")
			var tween_camera = create_tween().set_trans(Tween.TRANS_CUBIC)
			var new_camera_position = $"../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_position 
			var new_camera_rotation = $"../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_rotation 
			var initial_camera_position = camera.global_position
			var initial_camera_rotation = camera.global_rotation
			camera.global_position = new_camera_position
			camera.global_rotation = new_camera_rotation
			camera.current = true
			tween_camera.tween_property(camera, "position", initial_camera_position, 1.0)
			tween_camera.parallel().tween_property(camera, "rotation", initial_camera_rotation, 1.0)
			tween_camera.chain().tween_interval(4)
			tween_camera.tween_property(camera, "position", new_camera_position, 1.0)
			tween_camera.parallel().tween_property(camera, "rotation", new_camera_rotation, 1.0)
			tween_camera.chain().tween_callback(player_camera_go)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",0)

func player_camera_go():
	player_camera.current = true
