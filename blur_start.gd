extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_loops(0)
	tween.tween_property(material, "shader_parameter/blur_power", 0, 0.3) # value, time
	tween.tween_property(material, "shader_parameter/blur_power", 0.01, 0.4) # go back
