extends Control
var printt = false
@onready var state_machine = $"../CharacterBody3D/State machine"
@onready var player = $"../CharacterBody3D"
@onready var event_handler = $"../event_handler"
signal Transitionned
var img_hands
var img
var PLAYER_CUSTOM
signal Enter
func _on_done_button_down() -> void:
	DirAccess.make_dir_recursive_absolute("user://texture_create")
	emit_signal("Transitionned", state_machine.states.get("create"),"movement")
	event_handler.uslovia["CREATE"] = true
	event_handler.CREATE()
	await RenderingServer.frame_post_draw
	img = $tshirt_hoodie_sleeves/Control/SubViewportContainer/SubViewport.get_texture().get_image()
	img.save_png("user://texture_create/check.png")
	img_hands = $tshirt_hoodie_sleeves/Control/hands/SubViewport.get_texture().get_image()
	img_hands.save_png("user://texture_create/check_hands.png")
	await get_tree().create_timer(1).timeout
	#var PLAYER_CUSTOM = {"texture" = img,"Color_hands"=Color(1, 1, 1),"pants"=load("res://character/materials/legs.png"), "texture_hands" = img_hands}
	PLAYER_CUSTOM = {"texture" = "user://texture_create/check.png","Color_hands"=Color(1, 1, 1),"pants"="res://cell/sneaker22222.png", "texture_hands" = "user://texture_create/check_hands.png"}
	#PLAYER_CUSTOM = {"texture" = ResourceLoader.load("character/materials/check.png","",0),"Color_hands"=Color(1, 1, 1),"pants"=load("res://character/materials/legs.png"), "texture_hands" = ResourceLoader.load("character/materials/check_hands.png","",0)}
	player.change_created(PLAYER_CUSTOM)
	emit_signal("Enter",0)
	self.hide()
