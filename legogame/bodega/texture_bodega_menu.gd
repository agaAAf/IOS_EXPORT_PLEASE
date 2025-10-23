extends TextureRect
var mouse_still = false
var up
var down
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up = self.position + Vector2(0,10)
	down = self.position
	for i in $"..".get_children():
		if i.get_class()=="Button":
			i.connect("mouse_entered", mouse_entered_button.bind(i.name))
			i.connect("mouse_exited", mouse_exited_button.bind(i.name))


func mouse_entered_button(Caller_Name):
	if Caller_Name == name.left(-8):
		mouse_still = true
		tween()

func mouse_exited_button(Caller_Name):
	print(name.left(-8))
	print(Caller_Name)
	if Caller_Name == name.left(-8):
		mouse_still = false

func _on_tween_completed():
	if mouse_still:
		tween()

func tween():
		var tween_bodega = create_tween().set_trans(Tween.TRANS_LINEAR)
		var texturee = self;
		tween_bodega.tween_property(texturee, "modulate", Color(1,1,1,0.8), 0.5)
		tween_bodega.parallel().tween_property(texturee, "position", up, 0.5)
		tween_bodega.chain().tween_property(texturee, "position", down, 0.5)
		tween_bodega.parallel().tween_property(texturee, "modulate", Color(1,1,1,1), 0.5)
		tween_bodega.finished.connect(_on_tween_completed)
