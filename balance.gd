extends NinePatchRect

func start():
	var self_position = position
	var tween_show = create_tween().set_trans(Tween.TRANS_EXPO)
	tween_show.tween_property(self, "position", self_position - Vector2(0,300), 3)
	tween_show.connect("finished", _animate)
func _animate():
	if self.name =="BALANCE":
		var tween_show = create_tween().set_trans(Tween.TRANS_LINEAR).set_loops(3)
		var texturee_mod = $NinePatchRect/TextureRect;
		var balance_bar = $NinePatchRect/TextureRect/balance_bar;
		var Q = $NinePatchRect/Label;
		var R = $NinePatchRect/Label2;
		var initial_Q = Q.position
		var initial_R = R.position
		tween_show.tween_property(texturee_mod, "modulate", Color.RED, 2)
		tween_show.parallel().tween_property(balance_bar, "rotation", deg_to_rad(-30.6), 2)
		tween_show.chain().tween_property(R, "position", initial_R+Vector2(0,10), 0.5)
		tween_show.parallel().tween_property(balance_bar, "rotation", deg_to_rad(0), 2)
		tween_show.parallel().tween_property(texturee_mod, "modulate", Color.WHITE, 2)
		tween_show.chain().tween_property(R, "position", initial_R-Vector2(0,10), 0.5)
		tween_show.chain().tween_property(texturee_mod, "modulate", Color.RED, 2)
		tween_show.parallel().tween_property(balance_bar, "rotation", deg_to_rad(30.6), 2)
		tween_show.chain().tween_property(Q, "position", initial_Q+Vector2(0,10), 0.5)
		tween_show.parallel().tween_property(balance_bar, "rotation", deg_to_rad(0), 2)
		tween_show.parallel().tween_property(texturee_mod, "modulate", Color.WHITE, 2)
		tween_show.chain().tween_property(Q, "position", initial_Q-Vector2(0,10), 0.5)
		tween_show.connect("finished", exit)
	if self.name =="MOP":
		var tween_show = create_tween().set_trans(Tween.TRANS_LINEAR)
		var texturee_mod = $"../MOP/NinePatchRect/TextureRect";
		var balance_bar = $"../MOP/NinePatchRect/TextureRect/balance_bar";
		tween_show.tween_property(balance_bar, "rotation", deg_to_rad(79), 4)
		tween_show.connect("finished", exit)
	if self.name =="WENDING":
		var tween_show = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween_show.tween_interval(4)
		tween_show.connect("finished", exit)

func exit():
	var self_position = position
	var tween_show = create_tween().set_trans(Tween.TRANS_EXPO)
	tween_show.tween_property(self, "position", self_position + Vector2(0,300), 3)
