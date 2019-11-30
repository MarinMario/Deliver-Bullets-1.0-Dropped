extends Node2D

var weapon_state: String
var fire_timer := 0.0
var target: Vector2
var fire_rate: float

func _process(delta):
	weapon_state = get_parent().get_parent().weapon_state
	
	if weapon_state == "pistol":
		fire_rate = 1.0
	elif weapon_state == "machine_gun":
		fire_rate = 0.25
	else:
		fire_rate = 0
	
	if get_parent().get_parent().can_shoot:
		fire_timer += delta
		if fire_timer > fire_rate:
			target = get_parent().get_parent().target
			fire_timer = 0
			#yield(get_tree().create_timer(0.5), "timeout")
			shoot()

func shoot():
	var bullet = global.MOB_BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = target
	bullet.bullet_type = weapon_state
	get_parent().get_parent().get_parent().add_child(bullet)