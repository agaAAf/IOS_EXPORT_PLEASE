extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../bodega_doors".connect("enter_player", play_front)
	$"../bodega_doors".connect("exit_player",  play_back)

func play_front():
	play("spin")

func play_back():
	play("spin_2")
