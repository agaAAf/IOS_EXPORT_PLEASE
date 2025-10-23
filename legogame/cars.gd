extends Node3D
var timer
var timer_reset
var finish:bool

func _ready() -> void:
	if name =="car1" or name =="car2":
		$AnimationPlayer.play("jam")
	if name =="car3" or name =="car4":
		await get_tree().create_timer(4.5).timeout
		$AnimationPlayer.play("jam")
	if name =="car5" or name =="car6":
		$AnimationPlayer.play("jam")
	if name =="car7" or name =="car8":
		await get_tree().create_timer(4.5).timeout
		$AnimationPlayer.play("jam")
		
