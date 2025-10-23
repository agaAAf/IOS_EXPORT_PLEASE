extends GridContainer
var password:String

signal OPEN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_IGNORE
	for i:Button in get_children():
		i.disabled = true
		i.mouse_filter = i.MOUSE_FILTER_IGNORE
	hide()

func _show_start():
	if not $"1".is_connected("button_down", BUTTON_PLUS):
		for i:TextureButton in get_children():
			i.pressed.connect(BUTTON_PLUS.bind(i.name))
func BUTTON_PLUS(name):
	password+=name
	if password == "235674":
		emit_signal("OPEN")
	elif password.length()>6:
		password = ""
		for i:Button in get_children():
			i.disabled = true
			i.mouse_filter = i.MOUSE_FILTER_IGNORE
		hide()
