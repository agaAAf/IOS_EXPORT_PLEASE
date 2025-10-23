extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material = get_surface_override_material(1)
	if material == null:
		material = StandardMaterial3D.new()
		set_surface_override_material(1, material)
	material.set("shading_mode", "Unshaded")
	material.set("albedo_texture", $"../../../../Control/SubViewport".get_texture())
	material.set("uv1_scale", Vector3(1.195,1.515,1))
	material.set("uv1_offset", Vector3(-0.078,-0.211,0))
	material = get_surface_override_material(0)
	if material == null:
		material = load("res://legogame/case_1.tres")
		set_surface_override_material(0, material)
