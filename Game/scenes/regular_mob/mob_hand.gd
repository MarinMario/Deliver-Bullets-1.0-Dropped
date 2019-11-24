extends Node2D

var weapon_state: String
var fire_timer := 0.0
var target: Vector2

func _process(delta):
	fire_timer += delta
	if fire_timer > 2 and get_parent().get_parent().can_shoot:
		target = get_parent().get_parent().target
		fire_timer = 0
		shoot()

func shoot():
	var bullet = global.BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = target
	get_parent().get_parent().get_parent().add_child(bullet)