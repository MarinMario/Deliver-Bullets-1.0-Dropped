extends Area2D

var init_pos: Vector2
var target: Vector2
var direction: Vector2
var motion: Vector2
var speed := 1000

func _ready():
	#init_pos = global.player_shoot_point
	position = init_pos
	direction = (target - self.position).normalized()

func _process(delta):
	motion = direction * speed * delta
	position += self.motion