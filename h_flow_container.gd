extends HFlowContainer
var text1:String = "BEN: YO! COULD YOU DROP DOWN A SODA AT MY DESK?"
var text2:String = "WILLIAM: HEY! I NEED SOME PHAT FARM SAMPLES FROM THE STOREHOUSE"
var text3:String = "JOHN: YOOO, WE GOT A MEETING THIS AFTERNOON AND OUR CLEANER CALLED IN SICK. PLEASE MOP THE FLOOR IN THE OFFICE FLOOR!"
var array_text= [text1,text2,text3]
var text_get:String
var objtext:String 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".hide()
	
func _END_OFF_PENDING():
			for i in self.get_children():
				i.queue_free()
			position.x = 125
			var label_inst = Label.new()
			label_inst.set("theme_override_fonts/font", load("res://LcdSolid-VPzB.ttf"))
			#label_inst.set("custom_fonts/font",load("res://legogame/ui/text16bit.tres"))
			label_inst.set("custom_colors/font_color",Color(1, 1, 1))
			label_inst.set("theme_override_font_sizes/font_size", 120)
			label_inst.text = "NO NEW MESSAGES"
			$"../Label".text = ""
			$".".size.x += label_inst.get_minimum_size().x*10
			add_child(label_inst)

func add(text_get):
	if is_instance_valid(get_node("../../../../NOTIF/"+text_get["NAME"])):
		get_node("../../../../NOTIF/"+text_get["NAME"]).start()
	$"../../../..".tween_active_message = true
	for i in self.get_children():
		i.queue_free()
	position.x = 906.996
	size.x = 1017
	$"..".show()
	var text_array = text_get["text"].split(" ")
	for i in text_array:
			var label_inst = Label.new()
			label_inst.set("theme_override_fonts/font", load("res://LcdSolid-VPzB.ttf"))
			#label_inst.set("custom_fonts/font",load("res://legogame/ui/text16bit.tres"))
			label_inst.set("custom_colors/font_color",Color(1, 1, 1))
			label_inst.set("theme_override_font_sizes/font_size", 120)
			label_inst.text = " "
			$".".size.x += label_inst.get_minimum_size().x*10
			add_child(label_inst)
			label_inst = Label.new()
			label_inst.set("theme_override_fonts/font", load("res://LcdSolid-VPzB.ttf"))
			#label_inst.set("custom_fonts/font",load("res://legogame/ui/text16bit.tres"))
			label_inst.set("theme_override_colors/font_color",Color(0,0,0))
			label_inst.set("theme_override_font_sizes/font_size", 82)
			label_inst.text = i
			$".".size.x += label_inst.get_minimum_size().x*6
			add_child(label_inst)
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", done)
	tween.tween_property(self, "position" , Vector2(position.x-size.x,position.y), size.x/600)


func done():
	$"../../../..".tween_active_message = false
	$"../../../.."._show_queue(true)
