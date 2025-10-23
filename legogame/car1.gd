extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../car1/AnimationPlayer".play("jam")




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(4.0).timeout
	print("zzz")
	$"../car1/AnimationPlayer".play("RESET")
	$"../car1/AnimationPlayer".play("jam")
