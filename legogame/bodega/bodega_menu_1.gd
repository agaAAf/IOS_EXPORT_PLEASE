extends Control

signal GOT
var player:CharacterBody3D
var mouse_still = false
signal NEXT_PAGE_GO
var textures_up_down_checker = {"ent" = false, "phat_farm" = false, "bull" = false}
var PLAYER_CUSTOM = {"texture" = "user://texture_create/check.png","Color_hands"=Color(1, 1, 1),"pants"=load("res://character/materials/legs.png"), "texture_hands" = "user://texture_create/check_hands.png"}
func _ready() -> void:
	for n in $TextureRect1.get_children():
			if n.get_class()=="Button":
				n.connect("button_down", _on_button_pressed.bind(n.name))
	for i in get_tree().get_nodes_in_group("player"):
		player = i
# Called when the node enters the scene tree for the first time.
func _on_button_pressed(button_name):
	print(button_name + " PRESSED")
	if button_name == "ramen":
		#player.change(skins[3])
		$"../..".end()
	if button_name == "burger":
		#player.change(skins[0])
		$"../..".end()
