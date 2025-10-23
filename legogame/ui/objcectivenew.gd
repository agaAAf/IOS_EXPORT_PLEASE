extends VBoxContainer
var NAME:String 

# Called when the node enters the scene tree for the first time.
func start(objtext, location):
	$objective.text = objtext
	$where.text = "LOCATION "+location
