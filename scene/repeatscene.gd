extends Node3D
var speed = 0.2
var rng = RandomNumberGenerator.new()
var random = [1,2,3]
@onready var level = $"../../"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = Global.speed
	rng.randomize()
	var name_one = random.pick_random()
	random.erase(name_one)
	rng.randomize()
	if randf_range(0,100)>70:
		var name_two = random.pick_random()
		random.erase(name_two)
	for i in $prep.get_children():
		if not random.has(((i.get_name().to_int()- 1)% 3)+ 1):
			i.queue_free()

func _physics_process(delta: float) -> void:
	position.z-=delta*Global.speed
	if position.z<-10:
		#level.spawn_module(position.z +(level.amnt*level.offset))
		self.queue_free()
