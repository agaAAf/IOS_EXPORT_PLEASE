extends Node3D
var offset = 5.8
var amnt = 23
@export var modules: Array[PackedScene] = []
@export var start_module: Array[PackedScene] = []
var rng = RandomNumberGenerator.new()

var first_position
var first_rotation 

@onready var camera = $"Camera3D2"
@onready var player_camera = $"CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
@onready var player_ui = $"CharacterBody3D/Control"
func _ready() -> void:
	$CharacterBody3D.hide()
	first_position = camera.position
	first_rotation = camera.rotation
	$taxi_player.play("Start")
	$camera_anim.play("camera_ani ")
	$CharacterBody3D.level_run_camera()
	for i in get_tree().get_nodes_in_group("DEAD_EMITTER"):
		i.connect("DEAD", RESET)
	for i in amnt:
		spawn_module(i*offset+5.6)
	player_ui.Runner()
	Global.message = false
func spawn_module(n):
	rng.randomize()
	var num = rng.randi_range(0, modules.size()-1)
	var instance = modules[num].instantiate()
	instance.position.z = n
	$planes.add_child(instance)

func _physics_process(delta: float) -> void:
	if not Global.dead:
		Global.speed = lerp(Global.speed, 5.0, 2 * delta)
	$MOVE.position.z-=delta*Global.speed


func _on_taxi_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Start":
		$CharacterBody3D/persik/Armature_001/Skeleton3D/kulak_001.show()
		$taxi_player.play("go")
		$"CharacterBody3D/State machine/runner_infinite".start_running()

func RESET():
	for i in $planes.get_children():
		i.queue_free()
	var instance = start_module[0].instantiate()
	instance.position.z = 0
	$planes.add_child(instance)
	for i in amnt:
		spawn_module(i*offset+5.6)
	$MOVE.position.z = 0
	$CharacterBody3D.hide()
	first_position = camera.position
	first_rotation = camera.rotation
	$taxi_player.play("Start")
	$camera_anim.play("camera_ani ")
	$CharacterBody3D.level_run_camera()
	player_ui.Runner()
	$"CharacterBody3D/State machine/dead".collisions_ready()
	Global.message = false 
