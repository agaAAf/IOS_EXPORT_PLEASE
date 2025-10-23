extends MeshInstance3D
var floor = 1
var buf_floor = 1 
var start = true
var player = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("ui"):
		i.connect("floor_one",move)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	start = false
	print("LIFT")
	print(floor)
	print(body)
	if body.is_in_group("player"):
		player = true
		#for i in get_tree().get_nodes_in_group("ui"):
			#i.fade(1.0)
		if floor ==1:
			$"../AnimationPlayer2".play("ss/Armature_004Action_001")
		else:
			$"../AnimationPlayer2".play("ss/Armature_004Action")


func _on_area_3d_body_exited(body: Node3D) -> void:
	print(body)
	if body.is_in_group("player"):
		#player = false
		#for i in get_tree().get_nodes_in_group("ui"):
			#i.fade(0.0)
		if floor ==1:
			$"../AnimationPlayer2".play_backwards("ss/Armature_004Action_001")
		else:
			$"../AnimationPlayer2".play_backwards("ss/Armature_004Action")

func move(flooor):
	print("movee")
	if floor == 1:
		$"../AnimationPlayer2".play_backwards("ss/Armature_004Action_001")
		buf_floor = flooor
	if floor == 2:
		$"../AnimationPlayer2".play_backwards("ss/Armature_004Action")
		buf_floor = flooor
	if floor == 3:
		$"../AnimationPlayer2".play_backwards("ss/Armature_004Action")
		buf_floor = flooor
	if floor == 4:
		$"../AnimationPlayer2".play_backwards("ss/Armature_004Action")
		buf_floor = flooor

func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	print(str(player)+ "inside?")
	if anim_name == "ss/Armature_004Action_001" or anim_name == "ss/Armature_004Action" and not start:
		if floor == 1:
			if buf_floor == 3:
				$"../AnimationPlayer2".play("ss/1to3")
			if buf_floor == 4:
				$"../AnimationPlayer2".play("ss/1to4")
			if buf_floor == 2:
				$"../AnimationPlayer2".play("ss/1to2")
		if floor == 2:
			if buf_floor == 4:
				$"../AnimationPlayer2".play("ss/2to4")
			if buf_floor == 3:
				$"../AnimationPlayer2".play("ss/2to3")
			if buf_floor == 1:
				$"../AnimationPlayer2".play_backwards("ss/1to2")
		if floor == 3:
			if buf_floor == 1:
				$"../AnimationPlayer2".play_backwards("ss/1to3")
			if buf_floor == 2:
				$"../AnimationPlayer2".play_backwards("ss/2to3")
			if buf_floor == 4:
				$"../AnimationPlayer2".play("ss/3to4")
		if floor == 4:
			if buf_floor == 1:
				$"../AnimationPlayer2".play_backwards("ss/1to4")
			if buf_floor == 2:
				$"../AnimationPlayer2".play_backwards("ss/2to4")
			if buf_floor == 3:
				$"../AnimationPlayer2".play_backwards("ss/3to4")
		floor = buf_floor
	else:
		if floor ==1 and player:
			$"../AnimationPlayer2".play("ss/Armature_004Action_001")
		elif player:
			$"../AnimationPlayer2".play("ss/Armature_004Action")


func _on_inside_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		for i in get_tree().get_nodes_in_group("ui"):
			i.fade(1.0)


func _on_inside_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		for i in get_tree().get_nodes_in_group("ui"):
			i.fade(0.0)
