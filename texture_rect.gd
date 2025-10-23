extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(end_startup)


func end_startup():
	if Global.message:
		$"../../..".new_message()
