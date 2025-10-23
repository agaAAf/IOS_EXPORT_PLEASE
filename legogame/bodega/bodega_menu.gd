extends Control
var ent300 = {"texture" = "res://cell/300.png","Color_hands"=Color(0.078, 0.078, 0.078),"pants" = "res://character/materials/legs.png","texture_hands" =""}
var phat_farm = {"texture" = "res://character/13.png","Color_hands"=Color(0.086, 0.129, 0.235),"pants"="res://character/materials/legs.png","texture_hands" =""}
var bull = {"texture" = "res://cell/2.png","Color_hands"=Color(0.498, 0.173, 0.173),"pants"="res://character/materials/legs.png","texture_hands" =""}
var default = {"texture" = "res://character/materials/1.png","Color_hands"=Color.WHITE,"pants"="res://cell/sneaker22222.png","texture_hands" =""}
var bape_camo1 = {"texture" = "res://cell/04.jpg","Color_hands"=Color.WHITE,"pants"="res://cell/s222neaker.png","texture_hands" ="res://cell/hands/r-04.jpg"}
var bape_camo2 = {"texture" = "res://cell/05.jpg","Color_hands"=Color.WHITE,"pants"="res://cell/s222neaker.png","texture_hands" ="res://cell/hands/r-05.jpg"}
var bape_black = {"texture" = "res://cell/02.jpg","Color_hands"=Color.WHITE,"pants"="res://cell/s222neaker.png","texture_hands" ="res://cell/hands/r-02.jpg"}
var bape_white = {"texture" = "res://cell/01.jpg","Color_hands"=Color.WHITE,"pants"="res://cell/s222neaker.png","texture_hands" ="res://cell/hands/r-01.jpg"}
var bape_burgundy = {"texture" = "res://cell/03.jpg","Color_hands"=Color.WHITE,"pants"="res://cell/s222neaker.png","texture_hands" ="res://cell/hands/r-03.jpg"}

var skins:Array = [phat_farm, bull, default, ent300, bape_camo1, bape_camo2, bape_black, bape_white, bape_burgundy]
var player:CharacterBody3D
var mouse_still = false
signal NEXT_PAGE_GO
var textures_up_down_checker = {"ent" = false, "phat_farm" = false, "bull" = false}
var PLAYER_CUSTOM = {"texture" = "user://texture_create/check.png","Color_hands"=Color(1, 1, 1),"pants"=load("res://character/materials/legs.png"), "texture_hands" = "user://texture_create/check_hands.png"}
func _ready() -> void:
	for n in get_children():
		for i in n.get_children():
			if i.get_class()=="Button":
				i.connect("button_down", _on_button_pressed.bind(i.name))
				#i.connect("mouse_entered", mouse_entered_button.bind(i.name))
				#i.connect("mouse_exited", mouse_exited_button.bind(i.name))
			if i.get_class()=="TextureButton":
				if i.name =="NEXT_SLIDE":
					i.connect("button_down", _on_next_button.bind(i))
				if i.name =="PREVIOUS_SLIDE":
					i.connect("button_down", _on_previous_button.bind(i))
	for i in get_tree().get_nodes_in_group("player"):
		player = i
# Called when the node enters the scene tree for the first time.
func _on_button_pressed(button_name):
	if button_name == "ent":
		player.change(skins[3])
	if button_name == "phat_farm":
		player.change(skins[0])
	if button_name == "bull":
		player.change(skins[1])
	if button_name == "default":
		player.change(skins[2])
	if button_name == "bape_camo1":
		player.change(skins[4])
	if button_name == "bape_camo2":
		player.change(skins[5])
	if button_name == "bape_black":
		player.change(skins[6])
	if button_name == "bape_white":
		player.change(skins[7])
	if button_name == "bape_burgundy":
		player.change(skins[8])
#func mouse_entered_button(button_name):
		#mouse_still = true
		#var texturee = get_node("TextureRect/"+button_name+"_texture")
		#var tween_bodega = create_tween().set_trans(Tween.TRANS_BOUNCE)
		#tween_bodega.tween_property(texturee, "modulate", Color(1,1,1,0.8), 1.0)
		#tween_bodega.parallel().tween_property(texturee, "position", texturee.position + Vector2(0,10), 1.0)
		#tween_bodega.chain().tween_property(texturee, "position", texturee.position - Vector2(0,10), 1.0)
		#tween_bodega.parallel().tween_property(texturee, "modulate", Color(1,1,1,1), 1.0)
		#tween_bodega.tween_callback(animation_startover(button_name))
#func animation_startover(button_name):
	#if mouse_still:
		#var texturee = get_node("TextureRect/"+button_name+"_texture")
		#var tween_bodega = create_tween().set_trans(Tween.TRANS_BOUNCE)
		#tween_bodega.tween_property(texturee, "modulate", Color(1,1,1,0.8), 1.0)
		#tween_bodega.parallel().tween_property(texturee, "position", texturee.position + Vector2(0,10), 1.0)
		#tween_bodega.chain().tween_property(texturee, "position", texturee.position - Vector2(0,10), 1.0)
		#tween_bodega.parallel().tween_property(texturee, "modulate", Color(1,1,1,1), 1.0)
		#tween_bodega.tween_callback(animation_startover(button_name))

#func mouse_exited_button(button_name):
		#mouse_still = false
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_next_button(button):
	var parent = button.get_parent()
	var next_page
	var texture_number = int((parent.name).right(-11))+1
	for i in parent.get_children():
		if i.get_class()=="Button":
			i.disabled = true
			i.MOUSE_FILTER_IGNORE
	for n in get_children():
		print("printtt " +str(get_child_count()))
		print("check "+ parent.name)
		print("TextureRect"+str(int((parent.name).right(-11))+1))
		print("PLEAAASEEE "+str(texture_number))
		if n.name == "TextureRect"+str(int((parent.name).right(-11))+1):
				next_page = n
	if texture_number>get_child_count():
		next_page = $TextureRect1
	parent.hide()
	next_page.show()
	for z in next_page.get_children():
		if z.get_class()=="Button":
			z.disabled = false
			z.MOUSE_FILTER_STOP
	#for i in get_children():
		#if i.name == name_of_texture:
			#previous_page = i
	#if int(name_of_texture.left(-11))+1 < get_child_count() or int(name_of_texture.left(-11))+1 == get_child_count(): 
		#var new_page = get_node(name_of_texture.right(-1) + str(int(name_of_texture.left(-11))+1))
		#new_page.show()
		#for i in get_node(name_of_texture).get_children():
			#if i.get_class()=="Button":
				#i.disabled = true
			#i.MOUSE_FILTER_IGNORE
		#for n in new_page.get_children():
			#if n.get_class()=="Button":
				#n.disabled = false
			#n.MOUSE_FILTER_STOP
	#else:
		#var new_page = get_node("TextureRect1")
		#new_page.show()
		#for i in get_node(name_of_texture).get_children():
			#if i.get_class()=="Button":
				#i.disabled = true
			#i.MOUSE_FILTER_IGNORE
		#for n in new_page.get_children():
			#if n.get_class()=="Button":
				#n.disabled = false
			#n.MOUSE_FILTER_STOP

func _on_previous_button(button):
	var buffer = 0
	var biggest: TextureRect
	for i in get_children():
		if int((i.name).right(-11))>buffer:
			buffer = int((i.name).right(-11))
			biggest = i
	var parent = button.get_parent()
	var next_page
	var texture_number = int((parent.name).right(-11))-1
	for i in parent.get_children():
		if i.get_class()=="Button":
			i.disabled = true
			i.MOUSE_FILTER_IGNORE
	for n in get_children():
		print("printtt " +str(get_child_count()))
		print("check "+ parent.name)
		print("TextureRect"+str(int((parent.name).right(-11))-1))
		print("PLEAAASEEE "+str(texture_number))
		if n.name == "TextureRect"+str(int((parent.name).right(-11))-1):
				next_page = n
	if texture_number<0 or texture_number == 0:
		next_page = $TextureRect2
	parent.hide()
	next_page.show()
	for z in next_page.get_children():
		if z.get_class()=="Button":
			z.disabled = false
			z.MOUSE_FILTER_STOP
