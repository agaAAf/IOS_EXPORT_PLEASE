extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered", trash)

func trash(body):
	print(body)
	if body.is_in_group("TRASH"):
		body.dead()
		$"../../../../../State machine/movement_mop".go+=0.2
