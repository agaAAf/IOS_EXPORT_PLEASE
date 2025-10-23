extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await RenderingServer.frame_post_draw
	var img = $SubViewportContainer/SubViewport.get_texture().get_data()
	img.save_png("check.png")
