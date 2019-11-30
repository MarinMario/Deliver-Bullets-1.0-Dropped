extends Camera2D

var motion: Vector2
var speed = 10

func _process(delta):
	global.camera = self
	
	motion = Vector2(0,0)
	
	if Input.is_action_pressed("move_camera"):
		if Input.is_action_pressed("ui_right"):
			motion.x += 1
		if Input.is_action_pressed("ui_left"):
			motion.x -= 1
		if Input.is_action_pressed("ui_down"):
			motion.y += 1
		if Input.is_action_pressed("ui_up"):
			motion.y -= 1
		
		self.position += motion.normalized() * speed
	else:
		position = Vector2(0,0)
	

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
