extends TextureRect
var is_dragging = false #state management
var mouse_offset #center mouse on click
var delay = .2
var ID:int 
@onready var ADD_BUTTON = $"../../../../../print_selector/add_layer"
@onready var LAYER_CONTROLLER = $"../../../../../layers/SCROLL/LAYER_CONTROLLER"
@onready var MOVES = $"../../../../../move"
@onready var SIZE = $"../../../../../size"
var mouse_enter = false
var drag = false
var direction = Vector2.ZERO
var dir_scale = Vector2(1,1)

func _ready() -> void:
	MOVES.connect("MOVE_signal",moving)
	MOVES.connect("STOP_signal",STOP)
	SIZE.connect("MOVE_signal",SCALE)
	SIZE.connect("STOP_signal",STOP_SCALE)
	LAYER_CONTROLLER.connect("Layer_change", check_id)

func _process(delta: float) -> void:
	position+=direction
	scale=scale*dir_scale

func check_id(id):
	print("here")
	print(id)
	print(ID)
	if ID == id:
		print("yes")
		is_dragging = true
	else:
		print("no")
		is_dragging = false

func moving(move):
	if is_dragging:
		direction=move

func STOP():
	if is_dragging:
		direction = Vector2.ZERO

func SCALE(scale_param):
	print(scale_param)
	if is_dragging:
		dir_scale = scale_param

func STOP_SCALE():
	if is_dragging:
		dir_scale= Vector2(1,1)
