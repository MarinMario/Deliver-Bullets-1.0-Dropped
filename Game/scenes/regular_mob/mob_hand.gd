extends Node2D

var weapon_state: String
var fire_timer := 0.0
var target: Vector2
var fire_rate: float
var can_shoot := true
var weapon_dropped := false
onready var mob := get_parent().get_parent()

func _process(delta):
	weapon_state = mob.weapon_state
	
	if weapon_state == "pistol":
		fire_rate = 1.0
	elif weapon_state == "machine_gun":
		fire_rate = 0.25
	else:
		can_shoot = false
	
	if mob.can_shoot:
		fire_timer += delta
		if fire_timer > fire_rate and can_shoot:
			target = mob.target
			self.look_at(target)
			fire_timer = 0
			#yield(get_tree().create_timer(0.5), "timeout")
			shoot()
	
	if mob.health <= 0:
		if not weapon_dropped:
			drop_weapon()
			weapon_dropped = true

func shoot():
	var bullet = global.MOB_BULLET.instance()
	bullet.init_pos = $shoot_point.global_position
	bullet.target = target
	bullet.bullet_type = weapon_state
	get_parent().get_parent().get_parent().add_child(bullet)


func drop_weapon():
	var weapon_item = global.WEAPON_ITEM.instance()
	var random_pos = rand_range(30,70)
	weapon_item.weapon_state = weapon_state
	mob.weapon_state = "nothing"
	weapon_item.global_position = self.global_position + Vector2(random_pos, random_pos)
	mob.get_parent().add_child(weapon_item)













