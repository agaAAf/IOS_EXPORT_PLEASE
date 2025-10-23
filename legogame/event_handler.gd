extends Node
var marker 
@onready var state_handler = get_node("../CharacterBody3D/State machine") 
@onready var ui_handler = get_node("../CharacterBody3D/Control") 
var uslovia = {"MOP": false, "BOX": false, "SODA": false, "CREATE": false,"RAMEN": false}
var correct:int 

func _ready() -> void:
	for i in state_handler.get_children():
		i.connect("Done_state_", endstate)
	for i in get_tree().get_nodes_in_group("STATE_END"):
		i.connect("Done_state_", endstate)

func MOP():
	$"../MOP".active = true
	marker = $"../MOP_MARKER"
	marker.show()

func BOX():
	if uslovia["BOX"] == false:
		$"../BOX_MARKER".show()
		$"../BOXES".active = true
	if uslovia["BOX"] == true:
		$"../BOX_AREA".active = true 
		#get_node("../CharacterBody3D/Control/NOTIF/BALANCE").start()

func RAMEN():
	if uslovia["RAMEN"] == false:
		print("GOT_RAMEN")
		$"../RAMEN_MARKER".show()
		#$"../ramen_area/RAMEN".active = true
	if uslovia["RAMEN"] == true:
		$"../just_office3/Area3D".active_ramen = true

func SODA():
	if uslovia["SODA"] == false:
		$"../SODA_MARKER".show()
		for i in $"../soda".get_children():
			i.active = true
	if uslovia["SODA"] == true:
		#get_node("../CharacterBody3D/Control/NOTIF/WENDING").start()
		$"../just_office3/Area3D".active = true

func CREATE():
	if uslovia["CREATE"] == false:
		$"../CREATE_MARKER".show()
		$"../CREATE_AREA".active = true
	if uslovia["CREATE"] == true:
		$"../CREATE_MARKER".hide()
		$"../CREATE_AREA".active = false

func smoking_session():
	$"../SmokeAblunt".active = true

func paint():
	$"../Decal10"._start()

func endstate(NAME):
	ui_handler.tasks_counter-=1
	if typeof(NAME) == TYPE_ARRAY:
		NAME = NAME[0]
	print(NAME)
	if NAME == "MOP":
		correct=correct-1
		$"../MOP_MARKER".hide()
		$"../trash_points/Timer".stop()
	if NAME == "SODA":
		print("SODAadadadadadada")
		$"../SODA_MARKER".hide()
		correct=correct+1
	if NAME == "BOX":
		$"../BOX_MARKER".hide()
	if NAME== "smoking_session":
		correct=correct-1
	if NAME == "paint":
		correct=correct-1
		$"../Decal10".end()
	if NAME == "RAMEN":
		print("rameafafafarfafan")
		correct=correct+1
		$"../RAMEN_MARKER".hide()
	print(str(correct) + "DONE")
	if correct ==2:
		#$"../cartaxi_newrig4/Area3D".start()
		print("activeee")
		$"../just_office3/officeRussel/DOOR_RUSSEL".active = true
		get_node("../CharacterBody3D/Control").pending_messges.append({"text":"Alright, alright, Russel is waiting for you on the 3rd floor","NAME": "RUSSEL MEETING"})
		get_node("../CharacterBody3D/Control").message_counter+=1
func next_level():
	get_node("../CharacterBody3D/Control").level_change_fade(-0.025)
