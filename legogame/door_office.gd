extends Area3D
var player
signal Enter
var player_in_doors = false

func interact():
	print(player.global_position.z,$front_back.global_position.z)
	if player.global_position.z<$front_back.global_position.z:
		$"../doors_anim_player".play("Openclose_out")
		emit_signal("Enter",0)
		$closetimer.start(2)
	if player.global_position.z>$front_back.global_position.z:
		$"../doors_anim_player".play("Openclose_in")
		emit_signal("Enter",0)
		$closetimer.start(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		print("got")
		emit_signal("Enter",1)
		player_in_doors = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		emit_signal("Enter",0)
		player_in_doors = false

func _on_closetimer_timeout() -> void:
	if not player_in_doors:
		if player.global_position.z>$front_back.global_position.z:
			$"../doors_anim_player".play_backwards("Openclose_out")
			emit_signal("Enter",0)
		elif player.global_position.z<$front_back.global_position.z:
			$"../doors_anim_player".play_backwards("Openclose_in")
			emit_signal("Enter",0)
	else:
		$closetimer.start(2)
