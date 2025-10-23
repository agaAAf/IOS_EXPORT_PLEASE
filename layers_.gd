extends VFlowContainer
var buttons:Array = [0]
signal Layer_change
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../../print_selector".connect("LAYER", add_layer)

func add_layer(ID):
	custom_minimum_size+=Vector2(0,70)
	var button = Button.new()
	buttons.append(ID)
	buttons[ID] = button
	button.connect("button_down", call_button.bind(ID))
	self.add_child(button)
	button.custom_minimum_size = Vector2(500,70)
	button.clip_children = CanvasItem.CLIP_CHILDREN_ONLY
	var layer_inst = load("res://legogame/ui/layer.tscn").instantiate()
	button.add_child(layer_inst)
	layer_inst.start($"../../../print_selector/Control/print2".texture, $"../../../print_selector".get_print_name())
	layer_inst.show_behind_parent = true
	layer_inst.ID = ID
	ID+=1

func call_button(ID):
	print("go")
	emit_signal("Layer_change",ID)
