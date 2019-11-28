extends Camera2D

func _process(delta):
	global.camera = self

func camera_shake():
	randomize()
	
	var shake_amount = 10
	for i in 10:
		yield(get_tree().create_timer(0.01), "timeout")
		self.set_offset(Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
			))
	self.set_offset(Vector2(0,0))
