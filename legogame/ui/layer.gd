extends Control
var ID: int = 0
signal Layer_change
func start(texture, textLabel):
	$layer/print3.texture =texture
	$layer/Label.text = textLabel
