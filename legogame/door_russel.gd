extends Area3D
var active = true
@onready var event_handler = $"../../../event_handler"
@onready var ui_handler = $"../../../CharacterBody3D/Control"
@onready var state_machine = $"../../../CharacterBody3D/State machine"

@onready var player_camera = $"../../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
@onready var camera = $"../Camera3D"
signal Enter
signal Transitionned
signal Done_state_

func interact():
	print(str(active)+ " RUSS")
	if active:
			emit_signal("Enter",0)
			active = false 
			var tween_camera = create_tween().set_trans(Tween.TRANS_CUBIC)
			var new_camera_position = $"../../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_position 
			var new_camera_rotation = $"../../../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D".global_rotation
			var initial_camera_position = camera.global_position
			initial_camera_position.x = -2.095
			initial_camera_position.y = 5.307
			initial_camera_position.z = -6.138
			var initial_camera_rotation = camera.global_rotation
			camera.global_position = new_camera_position
			camera.global_rotation = new_camera_rotation
			camera.current = true
			tween_camera.tween_property(camera, "position", initial_camera_position, 1.0)
			tween_camera.parallel().tween_property(camera, "rotation", initial_camera_rotation, 1.0)
			tween_camera.chain().tween_callback(player_camera_go)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",1)


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and active:
		emit_signal("Enter",0)

func player_camera_go():
	$"../../officeRussel/russel_animation".play("go_around")


func _on_russel_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name =="go_around":
		player_camera.current = true

func anim_end():
	pass
