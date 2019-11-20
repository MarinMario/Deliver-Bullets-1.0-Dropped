extends Area2D

var init_pos: Vector2
var target: Vector2
var direction: Vector2
var motion: Vector2
var speed := 1000
var weapon_state: String

func _ready():
	#init_pos = global.player_shoot_point
	position = init_pos
	direction = (target - self.position).normalized()
	look_at(target)

func _process(delta):
	if weapon_state == "pistol":
		speed = 500
	elif weapon_state == "machine_gun":
		speed = 1000
	
	motion = direction * speed * delta
	position += motion

func _on_bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	self.queue_free()
