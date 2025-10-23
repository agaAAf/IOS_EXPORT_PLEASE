extends Area3D
@onready var player_camera = $"../CharacterBody3D/CameraPivot/SpringArm3D/Camera3D"
@onready var player = $"../CharacterBody3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body == player:
		$Camera3D.current = true


func _on_body_exited(body: Node3D) -> void:
	if body == player:
		player_camera.current = true 
