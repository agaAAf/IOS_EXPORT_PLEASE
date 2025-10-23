extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	$"../car2/AnimationPlayer".play("jam")




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(2.0).timeout
	print("zzz")
	$"../car2/AnimationPlayer".play("RESET")
	$"../car2/AnimationPlayer".play("jam")
