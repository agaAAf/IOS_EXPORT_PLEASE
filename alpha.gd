extends TextureRect
var active_id:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../../../print_selector".connect("LAYER",add_layer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_layer(ID):
	var layer_inst = load("res://legogame/ui/print.tscn").instantiate()
	add_child(layer_inst)
	layer_inst.texture =  $"../../../../print_selector/Control/print2".texture
	layer_inst.size = texture.get_size()/Vector2(2,2)
	print(layer_inst.pivot_offset)
	layer_inst.pivot_offset =layer_inst.size/Vector2(2,2)
	print(layer_inst.pivot_offset)
	layer_inst.ID = ID

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("interact"):
		#await RenderingServer.frame_post_draw
		#var img = $SubViewportContainer/SubViewport.get_texture().get_image()
		#img.save_png("check.png")
