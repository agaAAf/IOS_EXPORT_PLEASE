extends Area3D
@onready var player = $"../../CharacterBody3D"
@onready var ui_notific = $"../../CharacterBody3D/Control/Collection"
@export var health = 50
var onetime = true
var active = false 

# Called when the node enters the scene tree for the first time.
func kick():
	if active:
		if health>0: 
			health+=-10
			$wending/AnimationPlayer.play("hit")
		if health<0 or health == 0:
			$wending/AnimationPlayer.play("open")
			if onetime:
				$"../../event_handler".uslovia.SODA = true
				$"../../event_handler".SODA()
				onetime = false
				ui_notific.notif("SODA")
	else:
		$wending/AnimationPlayer.play("hit")
