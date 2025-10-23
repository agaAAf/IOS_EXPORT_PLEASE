extends Node3D
@onready var chipsi = preload("res://legogame/optimised/opti4/chipsik.tscn")
var has_trash:bool = false



func spawn():
	var chips = chipsi.instantiate()
	add_child(chips)
	has_trash = true
