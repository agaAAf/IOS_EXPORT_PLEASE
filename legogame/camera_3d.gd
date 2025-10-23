extends Camera3D
var camera_around:int = -1

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25
@export var tilt_upper_limit := PI / 3.0
@export var tilt_lower_limit := -PI / 6.0
var acceleration1:float = 10
var acceleration2:float = 2
var transition: float = 0 
var param_left_right:float = 0
var _camera_input_direction := Vector2.ZERO
@onready var animation_player: AnimationTree = $"../../../AnimationTree"
var basicss: Basis
var input = false
var create:bool = false
@onready var _camera_pivot: Node3D = $".."
@onready var beeper_pivot:Node3D = $"../../../Node3D"
var offsett
var first_pos

func _ready() -> void:
	offsett = global_transform.origin - $"../../../Node3D/CameraPivot2".global_transform.origin
	first_pos = [position, rotation]
func _input(event: InputEvent) -> void:
	if not create:
		if event.is_action_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif event.is_action_pressed("left_click"):
			#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			pass


func _unhandled_input(event: InputEvent) -> void:
	# Handle mouse motion for desktop
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	# Handle touch drag for mobile
	var is_touch_drag := (
		event is InputEventScreenDrag and
		not create
	)
	
	if (is_camera_motion or is_touch_drag) and not create:
		_camera_input_direction = event.relative * mouse_sensitivity
	
	if Input.is_action_just_pressed("camera_around"):
		camera_around = camera_around * -1
func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, tilt_lower_limit, tilt_upper_limit)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	beeper_pivot.rotation = _camera_pivot.rotation
	if not camera_around == 1:
		basicss = _camera_pivot.transform.basis
		$"../../../persik".rotation.y = _camera_pivot.rotation.y+deg_to_rad(180)
		if input:
			animation_player.set("parameters/Blend2/blend_amount", transition)
			if _camera_input_direction.x>0:
				transition +=delta*acceleration2 
				param_left_right+=delta*acceleration1
				param_left_right= clamp(param_left_right,-1,1)
				animation_player.set("parameters/INPLACE/blend_position", param_left_right)
			if _camera_input_direction.x<0:
				transition +=delta*acceleration2 
				param_left_right-=delta*acceleration1
				param_left_right= clamp(param_left_right,-1,1)
				animation_player.set("parameters/INPLACE/blend_position", param_left_right)
			if _camera_input_direction.x==0:
				transition-=delta*acceleration1 
				animation_player.set("parameters/Blend2/blend_amount", transition)
			transition = clamp(transition,0.16,1)
		if not input:
			transition-=delta*acceleration1
			transition = clamp(transition,0,1)
			animation_player.set("parameters/Blend2/blend_amount", transition)
	_camera_input_direction = Vector2.ZERO

#func animation_infront():
	#create = true
	#var tween_cam = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	#tween_cam.tween_property($"../..","position", Vector3(-0.803,-0.289,1.249),0.5)
	#tween_cam.parallel().tween_property($"../..","rotation", Vector3(deg_to_rad(5),deg_to_rad(145.5),0),0.5)
	#tween_cam.tween_interval(6.5)
	#tween_cam.tween_property($"../../../Control/CanvasLayer/ColorRect","modulate", Color(1,1,1,1),2)
	#tween_cam.chain().parallel().tween_property($"../..","position", Vector3(0,0,0),2)
	#tween_cam.chain().parallel().tween_property($"../..","rotation", Vector3(0,0,0),2)
	#tween_cam.parallel().tween_callback(change_camera)
	#
func change_camera():
	create = false
