extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material = get_surface_override_material(0)
	if material == null:
		material = load("res://legogame/case_1.tres")
		set_surface_override_material(0, material)
