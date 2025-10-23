extends NinePatchRect
var i: int =0 
var _default_size: Vector2
signal LAYER
var IDs:int = 0
#var prints: Array =  [
#Image.load_from_file("res://legogame/ui/prints/BULL BLUE.png"),
#Image.load_from_file("res://legogame/ui/prints/BULL.png"),
#Image.load_from_file("res://legogame/ui/prints/DEF JAM BLUE LOGO.png"),
#Image.load_from_file("res://legogame/ui/prints/DEF JAM RED LOGO.png"),
#Image.load_from_file("res://legogame/ui/prints/DEF JAM WHITE LOGO.png"),
#Image.load_from_file("res://legogame/ui/prints/NOTE LOGO BLACK.png"),
#Image.load_from_file("res://legogame/ui/prints/NOTE LOGO RED.png"),
#Image.load_from_file("res://legogame/ui/prints/ONE WORLD.png"),
#Image.load_from_file("res://legogame/ui/prints/PHAT FARM LOGO WHITE.png"),
#Image.load_from_file("res://legogame/ui/prints/PHAT FARM LOGO.png"),
#Image.load_from_file("res://legogame/ui/prints/PHAT FARM RED LOGO.png"),
#Image.load_from_file("res://legogame/ui/prints/RUSH MEDIA.png")
#]
var prints: Array =  []
var names:Array =  [
"BULL LOGOE",
"BULL RED",
"BULL",
"DEF JAM2000",
"DEF JAM LOGO",
"DEF PICTURES2",
"DEF PICTURES",
"NOTE BLACK",
"ONE WORLD",
"PF LOGO",
"PHAT FARM LOGO",
"RUSH MEDIA"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prints= [
load("res://legogame/ui/prints/prints2/BULL LOGO.png"),
load("res://legogame/ui/prints/prints2/BULL RED.png"),
load("res://legogame/ui/prints/prints2/BULL.png"),
load("res://legogame/ui/prints/prints2/DEF JAM2000.png"),
load("res://legogame/ui/prints/prints2/DEF JAM LOGO.png"),
load("res://legogame/ui/prints/prints2/DEF PICTURES2.png"),
load("res://legogame/ui/prints/prints2/DEF PICTURES.png"),
load("res://legogame/ui/prints/prints2/NOTE.png"),
load("res://legogame/ui/prints/prints2/NOTE_BLACK.png"),
load("res://legogame/ui/prints/prints2/ONE WORLD.png"),
load("res://legogame/ui/prints/prints2/PF LOGO.png"),
load("res://legogame/ui/prints/prints2/PHAT FARM LOGO.png"),
load("res://legogame/ui/prints/prints2/RUSH MEDIA.png")
]
	#var dir := DirAccess.open("res://legogame/ui/prints/")
	#if dir == null: printerr("Could not open folder"); return
	#dir.list_dir_begin()
	#for file: String in dir.get_files():
		#if not str(file).right(6)=="import":
			#names.append(str(file).left(-4))
			#var resource := load(dir.get_current_dir() + "/" + file)
			#prints.append(resource)
	_default_size = $Control/print2.size/prints[0].get_size()

func _on_left_print_button_down() -> void:
	print(i)
	if i<0 or i ==0 :
		i= prints.size()-1
	else:
		i-=1
	var imagee = prints[i]
	$Control/print2.texture = imagee
	$Control/print2.size.x = 247*(imagee.get_size().x/imagee.get_size().y)
	#if $Control/print2.size.x>378:
		#$Control/print2.size.x = 30*(imagee.get_size().x/imagee.get_size().y)
		#$Control/print2.size.y = 30
	print($Control/print2.size/Vector2(2,2))
	$Control/print2.pivot_offset =$Control/print2.size/Vector2(2,2)
	$Control/print2.set_position($".".size/2-$Control/print2.pivot_offset)
	print($Control/print2.position)


func get_print_name():
	return names[i]

func _on_right_print_button_down() -> void:
	print(i)
	if i>prints.size()-1 or i == prints.size()-1:
		i=0
	else:
		i+=1
	var imagee = prints[i]
	$Control/print2.texture = imagee
	$Control/print2.size.x = 247*(imagee.get_size().x/imagee.get_size().y)
	#if $Control/print2.size.x>378:
		#$Control/print2.size.x = 30*(imagee.get_size().x/imagee.get_size().y)
		#$Control/print2.size.y = 30
	print($Control/print2.size/Vector2(2,2))
	$Control/print2.pivot_offset =$Control/print2.size/Vector2(2,2)
	$Control/print2.set_position($".".size/2-$Control/print2.pivot_offset)
	print($Control/print2.position)


func _on_add_layer_button_down() -> void:
	emit_signal("LAYER",IDs)
	IDs+=1
