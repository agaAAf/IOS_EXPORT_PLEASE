extends Node3D
signal GOT
# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null
# The time of the last event in seconds since engine start.
var last_event_time: float = -1.0

@onready var node_viewport = $SubViewport
@onready var node_quad = $MeshInstance3D
@onready var node_area = $MeshInstance3D/Area3D

func end():
	print("hello")
	$"../../../../event_handler".uslovia.RAMEN = true
	$"../../../../event_handler".RAMEN()

func _ready():
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)

	# If the material is NOT set to use billboard settings, then avoid running billboard specific code
	if node_quad.get_surface_override_material(0).billboard_mode == BaseMaterial3D.BillboardMode.BILLBOARD_DISABLED:
		set_process(false)


func _process(_delta):
	# NOTE: Remove this function if you don't plan on using billboard settings.
	rotate_area_to_billboard()


func _mouse_entered_area():
	is_mouse_inside = true


func _mouse_exited_area():
	is_mouse_inside = false


func _unhandled_input(event):
	# Check if the event is a non-mouse/non-touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via Physics Picking.
			return
	node_viewport.push_input(event)


func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	var quad_mesh_size = node_quad.mesh.size
	var event_pos3D = node_quad.global_transform.affine_inverse() * event_position

	var now: float = Time.get_ticks_msec() / 1000.0
	var event_pos2D := Vector2.ZERO

	if is_mouse_inside:
		event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)
		event_pos2D.x = (event_pos2D.x / quad_mesh_size.x + 0.5) * node_viewport.size.x
		event_pos2D.y = (event_pos2D.y / quad_mesh_size.y + 0.5) * node_viewport.size.y
	elif last_event_pos2D != null:
		event_pos2D = last_event_pos2D

	# assign viewport-coordinates to event
	event.position = event_pos2D
	if event is InputEventMouse:
		event.global_position = event_pos2D

	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		if last_event_pos2D == null:
			event.relative = Vector2.ZERO
			event.velocity = Vector2.ZERO
		else:
			event.relative = event_pos2D - last_event_pos2D
			var diff := now - last_event_time
			if diff > 0:
				event.velocity = event.relative / diff

	last_event_pos2D = event_pos2D
	last_event_time = now

	if event is InputEventScreenTouch and not event.pressed:
		# finger released
		last_event_pos2D = null

	node_viewport.push_input(event)



func rotate_area_to_billboard():
	var billboard_mode = node_quad.get_surface_override_material(0).params_billboard_mode

	# Try to match the area with the material's billboard setting, if enabled.
	if billboard_mode > 0:
		# Get the camera.
		var camera = get_viewport().get_camera_3d()
		# Look in the same direction as the camera.
		var look = camera.to_global(Vector3(0, 0, -100)) - camera.global_transform.origin
		look = node_area.position + look

		# Y-Billboard: Lock Y rotation, but gives bad results if the camera is tilted.
		if billboard_mode == 2:
			look = Vector3(look.x, 0, look.z)

		node_area.look_at(look, Vector3.UP)

		# Rotate in the Z axis to compensate camera tilt.
		node_area.rotate_object_local(Vector3.BACK, camera.rotation.z)
