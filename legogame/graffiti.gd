extends Decal
@onready var state_machine = $"../CharacterBody3D/State machine"
@onready var graffiti = $graffiti_can
signal Transitionned


func _start():
	$Area3D.active = true
	graffiti.show()
	$graffiti_can/AnimationPlayer.play("start")
	
func end():
	$Area3D.active = false
	graffiti.hide()
func go():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($SmokeParticle2, "amount_ratio", 1, 1)
	tween.tween_interval(2)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	tween.tween_property($SmokeParticle2, "amount_ratio", 0, 1.2)
	tween.tween_callback(exit)

func exit():
	emit_signal("Transitionned", state_machine.states.get("paint"),"movement")
