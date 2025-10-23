extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("idle_lean")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if randf_range(0,100)>80:
		$AnimationPlayer.play("idle_lean_variation")
	else:
		$AnimationPlayer.play("idle_lean")
