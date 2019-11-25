extends Sprite

var target: Vector2
var motion: Vector2
var speed: int = 200
var acc: int = 1
var max_pos: int = 1
var max_scale := 0.1
var blood_color := 900000

func _ready():
	randomize()
	target.x = rand_range(-max_pos, max_pos)
	target.y = rand_range(-max_pos, max_pos)
	scale.x = rand_range(0, max_scale)
	scale.y = scale.x
	self.modulate = "#" + str(blood_color)

func _process(delta):
	if speed > 0:
		speed -= acc
	else:
		speed = 0
	
	motion = target * speed * delta
	position += motion
	


func spawn_blood(pos ,b_speed, b_acc, b_max_scale):
		self.global_position = pos
		self.speed = rand_range(0, b_speed)
		self.acc = b_acc
		self.max_scale = b_max_scale



