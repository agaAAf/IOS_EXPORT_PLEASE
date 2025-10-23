extends TextureRect

func notif(Name):
	if Name == "SODA":
		self.show()
		$TextureRect.texture = load("res://legogame/ui/notif/sodacan.png")
		$RichTextLabel.text = "Soda collected!"
	if Name == "RAMEN":
		self.show()
		$TextureRect.texture = load("res://legogame/ui/notif/sodacan.png")
		$RichTextLabel.text = "Ramen collected!"
	var tween_bodega = create_tween().set_trans(Tween.TRANS_ELASTIC)
	var texturee = self;
	position.y = 1098
	var up = Vector2(position.x,912)
	var up_away =Vector2(position.x,-251)
	tween_bodega.tween_property(texturee, "modulate", Color(1,1,1,1), 1)
	tween_bodega.set_ease(Tween.EASE_OUT).parallel().tween_property(texturee, "position", up, 2)
	tween_bodega.tween_interval(1)
	tween_bodega.set_ease(Tween.EASE_IN_OUT).chain().tween_property(texturee, "position", up_away, 2)
	tween_bodega.parallel().tween_property(texturee, "modulate", Color(1,1,1,0), 1)
