extends CharacterBody3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var NAME:String
@onready var head_attachment = $extra_workers/Armature_001/Skeleton3D/BoneAttachment3D
@onready var body = $extra_workers/Armature_001/Skeleton3D/kulak_001
@export var texture:String
@export var color_hands:Color
@export var pants_texture: String
@export var pants_color: Color
@export var skin_color: Color
@export var hands_texture: String
func _ready() -> void:

	for i in $ATTACHMENTS.get_children():
		if i.name == NAME:
			i.show()
			$extra_workers/AnimationPlayer.play(NAME+"/"+NAME)
	#$extra_workers/AnimationPlayer.play("Armature_001|sitting")
	for i in head_attachment.get_children():
		if i.name == NAME:
			print(i.name)
			i.show()
			textures()

func textures():
	var mesh = $extra_workers/Armature_001/Skeleton3D/kulak_001
	var image_path = texture
	#var texture = ImageTexture.new()
	#texture.resource_path = image_path
	var material_buff = mesh.get_surface_override_material(0).duplicate()
	material_buff.set_shader_parameter("texture_albedo",load(image_path))
	mesh.set_surface_override_material(0, material_buff)
	material_buff = mesh.get_surface_override_material(2).duplicate()
	if not (hands_texture == "NO"):
		print(hands_texture)
		material_buff.set_shader_parameter("texture_albedo",load(hands_texture))
		material_buff.set_shader_parameter("albedo",Color.WHITE)
	if (hands_texture == "NO"):
		material_buff.set_shader_parameter("albedo",hands_texture)
	mesh.set_surface_override_material(2, material_buff)
	material_buff = mesh.get_surface_override_material(1).duplicate()
	if pants_texture == "NO":
		material_buff.set_shader_parameter("albedo",pants_color)
	if not pants_texture == "NO":
		material_buff.set_shader_parameter("texture_albedo",load(pants_texture))
		material_buff.set_shader_parameter("albedo",Color.WHITE)
	mesh.set_surface_override_material(1, material_buff)
	material_buff = mesh.get_surface_override_material(3).duplicate()
	material_buff.set_shader_parameter("albedo",skin_color)
	mesh.set_surface_override_material(3, material_buff)
