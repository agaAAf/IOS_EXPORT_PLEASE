extends Control
signal floor_one
@export var path:String
@export var path2:String
var text_parsed
var arrrayindex= [3,1,6,0,4,5,2]
var i  = 0 
@onready var event_handler = get_node("../../event_handler") 
@onready var state_handler = get_node("../State machine") 
var shortmessage = false
var shortmessge_id: int = 0 
@onready var FlowContainerr = $SubViewport/get_mission/Control/HFlowContainer
@onready var labell = $SubViewport/get_mission/Control/Label
@onready var objectivee = $SubViewport/get_mission/time_objective/objective
@onready var timee = $SubViewport/get_mission/time_objective/TIME
@onready var timee_objective = $SubViewport/get_mission/time_objective
@onready var new_messagee = $SubViewport/get_mission/new_message
@onready var badass_meter = $Badass_meter
@export var next_level_path:String
var tween_active_message = false
var message_counter:int = 0
var pending_messges = []
var pending_messges_names = []
var score_runner = 0 
var tasks_counter = 0

func _ready() -> void:
	$TRANSITON.material.set_shader_parameter("circle_size",-0.025)
	level_change_fade(1.385)
	for i in state_handler.get_children():
		i.connect("Done_state_", endstate)
	for i in get_tree().get_nodes_in_group("interactable"):
		i.connect("Enter", enter)
		print(i.name)
	for i in get_tree().get_nodes_in_group("STATE_END"):
		i.connect("Done_state_", endstate)
	for i in get_tree().get_nodes_in_group("FLIPFLOP"):
		i.connect("open_flip_flop", _show_queue)
func get_file(shortmessage):
	if not shortmessage:
		var file = FileAccess.open(path,FileAccess.READ)
		if file:
			print(file.get_as_text())
			var test_json_conv = JSON.new()
			test_json_conv.parse(file.get_as_text())
			text_parsed =  test_json_conv.get_data()
	else:
		var file = FileAccess.open(path2,FileAccess.READ)
		if file:
			print(file.get_as_text())
			var test_json_conv = JSON.new()
			test_json_conv.parse(file.get_as_text())
			text_parsed =  test_json_conv.get_data()
			print(text_parsed)
func make_event():
		get_file(shortmessage)
		if not shortmessage and tasks_counter<=3:
			if arrrayindex == null:
				pass
			else:
				if arrrayindex.is_empty():
					pass
				else:
					i = arrrayindex[0]
					print(text_parsed[i])
					pending_messges.append({"text": text_parsed[i].text,"NAME": text_parsed[i].NAMEOFACTION})
					message_counter+=1
					$Label.text = str(message_counter)+" NEW MESSAGES"
					objective_update()
		if shortmessage:
			i = shortmessge_id
			var message_text = text_parsed[i].text
			FlowContainerr.add(message_text)
			labell.text = text_parsed[i].name

func _show_queue(flipflop):
	if flipflop:
		if pending_messges.is_empty():
			FlowContainerr._END_OFF_PENDING()
		else:
			FlowContainerr.add(pending_messges[0])
			labell.text = text_parsed[0].name
			pending_messges.remove_at(0)
			message_counter-=1
			$Label.text = str(message_counter)+" NEW MESSAGES"
func objective_update():
	timee_objective.show()
	if not shortmessage:
		tasks_counter+=1
		var message_text = text_parsed[i].text
		var obj_text = text_parsed[i].objtext
		var obj_location = text_parsed[i].where
		var obj_time = int(text_parsed[i].time)
		var objective_inst = load("res://legogame/ui/objcectivenew.tscn").instantiate()
		objectivee.add_child(objective_inst)
		objective_inst.NAME = text_parsed[i].NAMEOFACTION
		objective_inst.start(obj_text,obj_location)
		var timer_inst = load("res://legogame/ui/progress_bar.tscn").instantiate()
		timee.add_child(timer_inst)
		timer_inst.NAME = text_parsed[i].NAMEOFACTION
		timer_inst.start(obj_time)
		$call_new_event.wait_time = randf_range(3,4)
		arrrayindex.erase(i)
		print(arrrayindex)
		$call_new_event.start()
		event_handler.call(text_parsed[i].NAMEOFACTION)
		#event_handler.uslovia[text_parsed[i].NAMEOFACTION] = true
	if shortmessage:
		shortmessage = false

func new_message():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR).set_loops(4)
	tween.connect("finished", make_event)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,1), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,0), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,1), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,0), 0.1)
func fade(variant):
	var tween_fade = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween_fade.tween_property($"lift selector","modulate", Color(1,1,1,variant),1.0)
	if variant == 0:
		for i in $"lift selector".get_children():
			i.disabled = true
	if variant == 1:
		for i in $"lift selector".get_children():
			i.disabled = false

func _on_button_pressed() -> void:
	emit_signal("floor_one",1)


func _on_button_2_pressed() -> void:
	emit_signal("floor_one",2)


func _on_button_3_pressed() -> void:
	emit_signal("floor_one",3)


func _on_call_new_event_timeout() -> void:
	if not shortmessage and not tween_active_message and Global.message:
		new_message()
	else:
		$call_new_event.start(7)


func enter(value):
	print(str(value)+ "gotalpha")
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($pressE, "modulate", Color(1,1,1,value),1)

func endstate(nameee):
		var namee = nameee[0]
		for i in objectivee.get_children():
			print(i.NAME)
			if i.NAME == namee:
				i.queue_free()
		for i in timee.get_children():
			print(i.NAME)
			if i.NAME == namee:
				i.queue_free()
		if ["smoking_session", "paint"].has(namee):
			badass_meter.value+=10
		else:
			badass_meter.value-=10
func short_message():
	shortmessage = true
	$get_mission/time_objective.hide()
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR).set_loops(4)
	tween.connect("finished", make_event)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,1), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,0), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,1), 0.1)
	tween.tween_property(new_messagee, "modulate", Color(1,1,1,0), 0.1)


func _on_button_4_pressed() -> void:
	emit_signal("floor_one",4)

func Runner():
	$Infinite_Runner.show()
	$Badass_meter.hide()
	$Label.hide()
	for i in get_tree().get_nodes_in_group("Diamond"):
		if not i.is_connected("Collected",change_amount):
			i.connect("Collected",change_amount)

func change_amount():
	score_runner+=1
	$Infinite_Runner/diamond_counter.text = str(score_runner)

func next_lvl():
	var next_level_inst : PackedScene = load(next_level_path)
	get_tree().change_scene_to_packed(next_level_inst)

func level_change_fade(variant):
	if variant == -0.025:
		var tween_fade = create_tween().set_trans(Tween.TRANS_BACK)
		tween_fade.tween_property($TRANSITON,"material:shader_parameter/circle_size", variant,3.0)
		tween_fade.tween_callback(next_lvl)
	else:
		var tween_fade = create_tween().set_trans(Tween.TRANS_BACK)
		tween_fade.tween_property($TRANSITON,"material:shader_parameter/circle_size", variant,3.0)
