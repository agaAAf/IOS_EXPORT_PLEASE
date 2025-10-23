extends Node3D
@export var health = 50

# Called when the node enters the scene tree for the first time.
func kick():
	if not health>0: 
		health+=-10
		$wending/AnimationPlayer.play("Armature|hit")
	if health<0:
		$wending/AnimationPlayer.play("Armature|hit")
