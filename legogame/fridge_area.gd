extends Area3D
var player
signal Enter
var player_in_doors = false
var opened_door = false

@onready var anim_player = $"../bodega1/open/fridge_player"
func interact():
	if player_in_doors and not opened_door:
		anim_player.play("fridge_open")
		emit_signal("Enter",0)
		opened_door = true
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and not opened_door:
		player = body
		print("got")
		emit_signal("Enter",1)
		player_in_doors = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		emit_signal("Enter",0)
		opened_door = false
		anim_player.play("fridge_close")
