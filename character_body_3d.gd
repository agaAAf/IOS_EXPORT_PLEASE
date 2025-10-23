extends CharacterBody3D
signal graffiti_start

@onready var animation_player: AnimationPlayer = $persik/AnimationPlayer
@onready var Raycast = $RayCast3D
@onready var Raycast_right = $right
@onready var Raycast_left= $left

var counter:int = 0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var ent300 = {"texture" = "res://cell/300.png","Color_hands"=Color(0.078, 0.078, 0.078),"pants" = "res://character/materials/legs.png","texture_hands" =""}
var phat_farm = {"texture" = "res://character/13.png","Color_hands"=Color(0.086, 0.129, 0.235),"pants"="res://character/materials/legs.png","texture_hands" =""}
var bull = {"texture" = "res://cell/2.png","Color_hands"=Color(0.498, 0.173, 0.173),"pants"="res://character/materials/legs.png","texture_hands" =""}
var default = {"texture" = "res://character/materials/1.png","Color_hands"=Color.WHITE,"pants"="res://character/materials/legs.png","texture_hands" =""}
var skins:Array = [phat_farm, bull, default, ent300]
var objective = false

func _physics_process(delta: float) -> void:
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	#if not is_on_floor():
		#animation_player.play("Armature|"+"jump")
	#else:
		#animation_player.play("Armature|"+"run")

func change_created(skin):
	print(skin)
	var mesh = $persik/Armature_001/Skeleton3D/kulak_001
	var image_path = skin.texture
	var image = Image.load_from_file(image_path)
	var texture = ImageTexture.create_from_image(image)
	var material_buff = mesh.get_surface_override_material(0)
	print(material_buff)
	material_buff.set_shader_parameter("texture_albedo",texture)
	mesh.set_surface_override_material(0, material_buff)
	material_buff = mesh.get_surface_override_material(2)
	var Color_hands = skin.Color_hands
	material_buff.set_shader_parameter("albedo",Color_hands)
	#if skin.texture_hands == "":
		#material_buff.set_shader_parameter("albedo",Color_hands)
	#else:
	image_path = skin.texture_hands
	image = Image.load_from_file(image_path)
	texture = ImageTexture.create_from_image(image)
	material_buff.set_shader_parameter("texture_albedo",texture)
	material_buff = mesh.get_surface_override_material(1)
	if not (skin.pants == ""):
		material_buff.set_shader_parameter("texture_albedo",load(skin.pants))
		material_buff.set_shader_parameter("albedo",Color.WHITE)
	mesh.set_surface_override_material(1, material_buff)

func change(skin):
	print(skin)
	var mesh = $persik/Armature_001/Skeleton3D/kulak_001
	var material_buff = mesh.get_surface_override_material(0)
	print(material_buff)
	material_buff.set_shader_parameter("texture_albedo",load(skin.texture))
	mesh.set_surface_override_material(0, material_buff)
	material_buff = mesh.get_surface_override_material(2)
	if skin.texture_hands == "":
		material_buff.set_shader_parameter("albedo",skin.Color_hands)
	if not (skin.texture_hands == ""):
		material_buff.set_shader_parameter("texture_albedo",load(skin.texture_hands))
		material_buff.set_shader_parameter("albedo",Color.WHITE)
	mesh.set_surface_override_material(2, material_buff)
	material_buff = mesh.get_surface_override_material(1)
	if not (skin.pants == ""):
		material_buff.set_shader_parameter("texture_albedo",load(skin.pants))
		material_buff.set_shader_parameter("albedo",Color.WHITE)
	mesh.set_surface_override_material(1, material_buff)

func boxes():
	$"State machine".current_state.Transitioned.emit(self, "movement_bookcarry")

func graffiti():
	emit_signal("graffiti_start")

func level_run_camera():
	Raycast.enabled= true
	Raycast_left.enabled=true
	Raycast_right.enabled= true
	#$CameraPivot/SpringArm3D.rotation.x = -20
	#$CameraPivot/SpringArm3D.position.z = -1
	#$CameraPivot/SpringArm3D/Camera3D.fov = 100
